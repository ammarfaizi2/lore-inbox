Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVDCNCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVDCNCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 09:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVDCNCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 09:02:08 -0400
Received: from mailfe09.swip.net ([212.247.155.1]:53244 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261720AbVDCNCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 09:02:02 -0400
X-T2-Posting-ID: dB8bZLHXm6KAmbp1mi7F+A==
Subject: Re: 2.6.12-rc1-bk does not boot x86_64
From: Alexander Nyberg <alexn@dsv.su.se>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <424FE590.5060507@gmail.com>
References: <424FE590.5060507@gmail.com>
Content-Type: text/plain
Date: Sun, 03 Apr 2005 15:02:01 +0200
Message-Id: <1112533321.2369.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried the recent 2.6.12-rc1-bk5 snapshot from kernel.org.
> When I want to boot my x86_64 system only a green line appears on screen.
> The config is the same as in 2.6.12-rc1-bk4 which works flawlessly on my
> system.
> 
> I only saw the message that CPU0 and CPU1 where initialized. And then
> there was
> Brinnging up CPUs and it stopped.
> 
> Its an Intel Pentium4 640 with (EMT64,HT,EIST,CIE enabled).
> The graphic card is an Nvidia 6600GT PCIe device.

I had the same nasty surprise this morning, this will probably help:


Well, this is a brown paper bag for someone.  The new protocol
registration locking uses a rwlock to limit access to the protocol list.
Unfortunately, the initialisation:

static rwlock_t proto_list_lock;

Only works to initialise the lock as unlocked on platforms whose unlock
signal is all zeros.  On other platforms, they think it's already locked
and hang forever.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>


===== net/core/sock.c 1.67 vs edited =====
--- 1.67/net/core/sock.c	2005-03-26 17:04:35 -06:00
+++ edited/net/core/sock.c	2005-04-02 13:37:20 -06:00
@@ -1352,7 +1352,7 @@
 
 EXPORT_SYMBOL(sk_common_release);
 
-static rwlock_t proto_list_lock;
+static DEFINE_RWLOCK(proto_list_lock);
 static LIST_HEAD(proto_list);
 
 int proto_register(struct proto *prot, int alloc_slab)


-


