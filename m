Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbSI3N60>; Mon, 30 Sep 2002 09:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262093AbSI3N50>; Mon, 30 Sep 2002 09:57:26 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:40594 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262076AbSI3NuI>; Mon, 30 Sep 2002 09:50:08 -0400
Message-ID: <3D9852D7.C723BCC9@us.ibm.com>
Date: Mon, 30 Sep 2002 08:34:15 -0500
From: Jon Grimm <jgrimm2@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>,
       Thomas Molina <tmolina@cox.net>,
       lksctp-developers@lists.sourceforge.net,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Lksctp-developers] Re: (more) Sleeping function called from illegal 
 context...
References: <20020927233044.GA14234@kroah.com> <3D94EEBF.D6328392@digeo.com> <3D94FB89.40400@easynet.be> <3D950590.1F9FBDC6@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See Patch below to stop any bleeding.   I'll feed the patch in through
DaveM.  

Thanks, Jon  

Andrew Morton wrote:
> 
> Luc Van Oostenryck wrote:
> >

> >
> 
> sctp_v4_get_local_addr_list():
> 
>                 /* XXX BUG: sleeping allocation with lock held -DaveM */
>                 addr = t_new(struct sockaddr_storage_list, GFP_KERNEL);
> 
> Is true.  We're holding dev_base_lock, inetdev_lock and in_dev->lock
> here.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.655   -> 1.656  
#	 net/sctp/protocol.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/30	jgrimm@touki.austin.ibm.com	1.656
# sctp:  Fix GFP_KERNEL allocation with lock held. 
# --------------------------------------------
#
diff -Nru a/net/sctp/protocol.c b/net/sctp/protocol.c
--- a/net/sctp/protocol.c	Mon Sep 30 08:20:55 2002
+++ b/net/sctp/protocol.c	Mon Sep 30 08:20:55 2002
@@ -119,8 +119,7 @@
 
 	for (ifa = in_dev->ifa_list; ifa; ifa = ifa->ifa_next) {
 		/* Add the address to the local list.  */
-		/* XXX BUG: sleeping allocation with lock held -DaveM */
-		addr = t_new(struct sockaddr_storage_list, GFP_KERNEL);
+		addr = t_new(struct sockaddr_storage_list, GFP_ATOMIC);
 		if (addr) {
 			INIT_LIST_HEAD(&addr->list);
 			addr->a.v4.sin_family = AF_INET;
@@ -157,8 +156,7 @@
 	read_lock_bh(&in6_dev->lock);
 	for (ifp = in6_dev->addr_list; ifp; ifp = ifp->if_next) {
 		/* Add the address to the local list.  */
-		/* XXX BUG: sleeping allocation with lock held -DaveM */
-		addr = t_new(struct sockaddr_storage_list, GFP_KERNEL);
+		addr = t_new(struct sockaddr_storage_list, GFP_ATOMIC);
 		if (addr) {
 			addr->a.v6.sin6_family = AF_INET6;
 			addr->a.v6.sin6_port = 0;
