Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVG1Rpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVG1Rpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVG1Rnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:43:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261609AbVG1RmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:42:17 -0400
Date: Thu, 28 Jul 2005 10:41:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2
Message-Id: <20050728104116.26fb7bb2.akpm@osdl.org>
In-Reply-To: <93600000.1122562877@[10.10.2.4]>
References: <20050727024330.78ee32c2.akpm@osdl.org>
	<93600000.1122562877@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> Seems to have some odd problem on PPC64 - crashes on boot.
>  Seems to affect power 4 boxes, both LPAR and bare metal.
> 
>  raid5: using function: 32regs (4524.000 MB/sec)
>  md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
>  md: bitmap version 3.38
>  oprofile: using ppc64/power4 performance monitoring.
>  NET: Registered protocol family 2
>  IP route cache hash table entries: 2097152 (order: 12, 16777216 bytes)
>  Badness in nr_blockdev_pages at fs/block_dev.c:399

This should fix:

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

