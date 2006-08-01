Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWHASdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWHASdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWHASdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:33:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:34646 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750954AbWHASdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:33:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=na2y0/CBwtvQBL9taK1S+yM3E6fTwgp038IUlMmT5NsAXJh1kNQLCcmjE4bIxgrfDVMQp8x0Or3M+ZdVAqHIBBhUb1rqbMkGTGxSl+shq5hHLVfbeYhkQPWuFHDL6rNYcOfE3KxgnPC8OAA64n+7yxGL4jtfuovlnQuOJ2oVz/Q=
Message-ID: <41b516cb0608011133r2332161dx4b43a845bfa74062@mail.gmail.com>
Date: Tue, 1 Aug 2006 11:33:02 -0700
From: "Chris Leech" <christopher.leech@intel.com>
Reply-To: chris.leech@gmail.com
To: "David Miller" <davem@davemloft.net>
Subject: [PATCH] I/OAT: remove CPU hotplug lock from net_dma_rebalance
Cc: dan.j.williams@intel.com, linux-kernel@vger.kernel.org, neilb@suse.de,
       galak@kernel.crashing.org, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 339b86ac2c90747c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the lock_cpu_hotplug()/unlock_cpu_hotplug() calls from net_dma_rebalance

The lock_cpu_hotplug()/unlock_cpu_hotplug() sequence in net_dma_rebalance
is both incorrect (as pointed out by David Miller) because lock_cpu_hotplug()
may sleep while the net_dma_event_lock spinlock is held, and unnecessary (as
pointed out by Andrew Morton) as spin_lock() disables preemption which
protects from CPU hotplug events.

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

  net/core/dev.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4d2b516..780d770 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3429,12 +3429,9 @@ static void net_dma_rebalance(void)
        unsigned int cpu, i, n;
        struct dma_chan *chan;

-       lock_cpu_hotplug();
-
        if (net_dma_count == 0) {
                for_each_online_cpu(cpu)

rcu_assign_pointer(per_cpu(softnet_data.net_dma, cpu), NULL);
-               unlock_cpu_hotplug();
                return;
        }

@@ -3454,8 +3451,6 @@ static void net_dma_rebalance(void)
                i++;
        }
        rcu_read_unlock();
-
-       unlock_cpu_hotplug();
 }

 /**
