Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVG0V2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVG0V2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVG0VXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:23:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262183AbVG0VU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:20:58 -0400
Date: Wed, 27 Jul 2005 14:16:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2 doesn't boot
Message-Id: <20050727141646.1852a505.akpm@osdl.org>
In-Reply-To: <20050727203527.GA3679@stusta.de>
References: <20050727024330.78ee32c2.akpm@osdl.org>
	<20050727203527.GA3679@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
>  2.6.13-rc3-mm2 doesn't boot on my computer:
>    Badness in nr_blockdev_pages at fs/block_dev.c:399
>    ...
>    kmem_cache_create: Early error in slab inet_peer_cache
> 
>  A screenshot is available at [1].
> 
>  My .config is attached.
> 
>  2.6.13-rc3-mm1 boots and works without problems.
> 
>  cu
>  Adrian
> 
>  [1] http://www.fs.tum.de/~bunk/kernel/boot_failure.jpg

I'd be suspecting there's been a huge preempt_count() windup and the kernel
thinks that it's running in_interrupt(), so various checks are triggering.

Please try this one:

--- devel/net/netlink/af_netlink.c~netlink-locking-fix	2005-07-27 14:10:07.000000000 -0700
+++ devel-akpm/net/netlink/af_netlink.c	2005-07-27 14:10:16.000000000 -0700
@@ -349,12 +349,12 @@ static int netlink_create(struct socket 
 
 	netlink_table_grab();
 	if (!nl_table[protocol].hash.entries) {
-		netlink_table_ungrab();
 #ifdef CONFIG_KMOD
 		/* We do 'best effort'.  If we find a matching module,
 		 * it is loaded.  If not, we don't return an error to
 		 * allow pure userspace<->userspace communication. -HW
 		 */
+		netlink_table_ungrab();
 		request_module("net-pf-%d-proto-%d", PF_NETLINK, protocol);
 		netlink_table_grab();
 #endif
_


And if that doesn't fix, enable CONFIG_DEBUG_PREEMPT and see if the
sub_preempt_count() check triggers.

