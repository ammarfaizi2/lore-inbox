Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWDWHAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWDWHAo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 03:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWDWHAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 03:00:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53721 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751352AbWDWHAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 03:00:43 -0400
From: Arjan van de Ven <arjan@linux.intel.com>
To: n1gp@hotmail.com, vojtech@suse, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1145721854.2882.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Subject: FIx oops on mk712 load
Date: Sun, 23 Apr 2006 09:00:41 +0200
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below fixes an oops I got when loading mk712; I don't have the
hardware so there is a goto to the cleanup part of the function. The
goto however went to then input_free_device() of a pointer that only
gets initialized to a real value 3 lines lower, much to the unhappiness
of the code in question. Fix is just to make a stacked-label sequence
for it instead.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>


--- linux-2.6.17-rc2-lockdep/drivers/input/touchscreen/mk712.c.org	2006-04-22 17:56:44.000000000 +0200
+++ linux-2.6.17-rc2-lockdep/drivers/input/touchscreen/mk712.c	2006-04-22 17:57:23.000000000 +0200
@@ -170,7 +170,7 @@ static int __init mk712_init(void)
 	    (inw(mk712_io + MK712_STATUS) & 0xf333)) {
 		printk(KERN_WARNING "mk712: device not present\n");
 		err = -ENODEV;
-		goto fail;
+		goto fail_release;
 	}
 
 	if (!(mk712_dev = input_allocate_device())) {
@@ -204,6 +204,7 @@ static int __init mk712_init(void)
 	return 0;
 
  fail:	input_free_device(mk712_dev);
+ fail_release:	
 	release_region(mk712_io, 8);
 	return err;
 }


