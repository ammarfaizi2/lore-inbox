Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWDHKCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWDHKCY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 06:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWDHKCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 06:02:24 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:1500 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751412AbWDHKCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 06:02:23 -0400
Date: Sat, 8 Apr 2006 12:02:13 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Frank Pavlic <fpavlic@de.ibm.com>,
       "David S. Miller" <davem@sunset.davemloft.net>
Subject: Re: [patch] ipv4: initialize arp_tbl rw lock
Message-ID: <20060408100213.GA9412@osiris.boeblingen.de.ibm.com>
References: <20060407081533.GC11353@osiris.boeblingen.de.ibm.com> <20060407074627.2f525b2e@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407074627.2f525b2e@localhost.localdomain>
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The qeth driver makes use of the arp_tbl rw lock. CONFIG_DEBUG_SPINLOCK
> > detects that this lock is not initialized as it is supposed to be.
>
> This is a initialization order problem then, because:
> 	arp_init
> 	   neigh_table_init
> 		rwlock_init
> 
> does the initialization already. So fix the initialization sequence
> of the qeth driver or you will have other problems.
> 
> My impression was the -rt folks wanted all lock initializations t be
> done at runtime not compile time.

Ok, so the problem seems to be that inet_init gets called after qeth_init.
Looking at the top level Makefile this seems to be true for all network
drivers in drivers/net/ and drivers/s390/net/ since we have

vmlinux-main := $(core-y) $(libs-y) $(drivers-y) $(net-y)

The patch below works for me... I guess there must be a better way to make
sure that any networking driver's initcall is made before inet_init?

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b401942..c5cea07 100644
--- a/Makefile
+++ b/Makefile
@@ -567,7 +567,7 @@ #
 # System.map is generated to document addresses of all kernel symbols
 
 vmlinux-init := $(head-y) $(init-y)
-vmlinux-main := $(core-y) $(libs-y) $(drivers-y) $(net-y)
+vmlinux-main := $(core-y) $(libs-y) $(net-y) $(drivers-y)
 vmlinux-all  := $(vmlinux-init) $(vmlinux-main)
 vmlinux-lds  := arch/$(ARCH)/kernel/vmlinux.lds
 
