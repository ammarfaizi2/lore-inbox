Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTKYM5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 07:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTKYM5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 07:57:18 -0500
Received: from 0x50a144f4.albnxx15.adsl-dhcp.tele.dk ([80.161.68.244]:4612
	"EHLO 0x50a144f4.albnxx15.adsl-dhcp.tele.dk") by vger.kernel.org
	with ESMTP id S262427AbTKYM5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 07:57:16 -0500
Date: Tue, 25 Nov 2003 13:57:14 +0100
From: Rask Ingemann Lambertsen <rask@sygehus.dk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH/CFT] de2104x fixes
Message-ID: <20031125135713.A9450@sygehus.dk>
References: <200311212051.32352.russell@coker.com.au> <3FBE5E70.9060102@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FBE5E70.9060102@pobox.com>; from jgarzik@pobox.com on Fri, Nov 21, 2003 at 01:50:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 21, 2003 at 01:50:24PM -0500, Jeff Garzik wrote:
> So, can people give this a test?  It includes a change that, I hope, 
> addresses Russell's problem, as well as a patch from Rask.

I have attached a patch which fixes two problems I found during compilation:
1) de_open() no longer uses the flags variable because the spinlocking is
   gone, but I forgot to remove the variable.
2) __de_set_settings() now references dev which is undefined.

The patch should be applied on top of your patch, Jeff.

-- 
Regards,
Rask Ingemann Lambertsen

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="de2104x-fix-for-jeff.patch"

--- linux-2.6.0-test8/drivers/net/tulip/de2104x.c-orig	Tue Nov 25 13:20:25 2003
+++ linux-2.6.0-test8/drivers/net/tulip/de2104x.c	Tue Nov 25 13:20:25 2003
@@ -1384,7 +1384,6 @@ static int de_open (struct net_device *d
 {
 	struct de_private *de = dev->priv;
 	int rc;
-	unsigned long flags;
 
 	if (netif_msg_ifup(de))
 		printk(KERN_DEBUG "%s: enabling interface\n", dev->name);
@@ -1601,7 +1600,7 @@ static int __de_set_settings(struct de_p
 	    (ecmd->advertising == de->media_advertise))
 		return 0; /* nothing to change */
 	    
-	if (netif_running(dev)) {
+	if (netif_running(de->dev)) {
 		de_link_down(de);
 		de_stop_rxtx(de);
 	}
@@ -1610,7 +1609,7 @@ static int __de_set_settings(struct de_p
 	de->media_lock = media_lock;
 	de->media_advertise = ecmd->advertising;
 
-	if (netif_running(dev))
+	if (netif_running(de->dev))
 		de_set_media(de);
 	
 	return 0;

--uAKRQypu60I7Lcqm--
