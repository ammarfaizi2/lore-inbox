Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWE3QJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWE3QJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWE3QJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:09:11 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:14736 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751534AbWE3QJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:09:10 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Arjan van de Ven <arjan@linux.intel.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu
In-Reply-To: <6bffcb0e0605300859x5c8f83f5w635fd25f0100fca@mail.gmail.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605300859x5c8f83f5w635fd25f0100fca@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 May 2006 18:08:49 +0200
Message-Id: <1149005329.3636.78.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 17:59 +0200, Michal Piotrowski wrote:
> Hi,
> 
> On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> >
> >
> 
> It looks like a network stack problem.
> 
> May 30 17:50:34 ltg01-fedora init: Switching to runlevel: 6
> May 30 17:50:35 ltg01-fedora avahi-daemon[1878]: Got SIGTERM, quitting.
> May 30 17:50:35 ltg01-fedora avahi-daemon[1878]: Leaving mDNS
> multicast group on interface eth0.IPv4 with address 192.168.0.
> 14.
> May 30 17:50:35 ltg01-fedora kernel:
> May 30 17:50:35 ltg01-fedora kernel: ======================================
> May 30 17:50:35 ltg01-fedora kernel: [ BUG: bad unlock ordering detected! ]
> May 30 17:50:35 ltg01-fedora kernel: --------------------------------------
> May 30 17:50:35 ltg01-fedora kernel: avahi-daemon/1878 is trying to

does this fix it for you?



Mark out of order unlocking in igmp.c as such

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 net/ipv4/igmp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17-rc5-mm1-lockdep/net/ipv4/igmp.c
===================================================================
--- linux-2.6.17-rc5-mm1-lockdep.orig/net/ipv4/igmp.c
+++ linux-2.6.17-rc5-mm1-lockdep/net/ipv4/igmp.c
@@ -1472,7 +1472,7 @@ static int ip_mc_del_src(struct in_devic
 		return -ESRCH;
 	}
 	spin_lock_bh(&pmc->lock);
-	read_unlock(&in_dev->mc_list_lock);
+	read_unlock_non_nested(&in_dev->mc_list_lock);
 #ifdef CONFIG_IP_MULTICAST
 	sf_markstate(pmc);
 #endif

