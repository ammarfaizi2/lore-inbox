Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbTEOOVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTEOOVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:21:05 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:45466 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264038AbTEOOVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:21:04 -0400
Message-Id: <200305151432.h4FEW5Gi012599@locutus.cmf.nrl.navy.mil>
To: Greg KH <greg@kroah.com>, davem@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
In-reply-to: Your message of "Wed, 14 May 2003 22:20:41 PDT."
             <20030515052041.GA5995@kroah.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 15 May 2003 10:32:05 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030515052041.GA5995@kroah.com>,Greg KH writes:
>It's not really bothering me, just wondering when it will go away (I see
>it when building one of the USB ATM drivers...)

the MOD_* functions in the speedtch driver don't need to be there.  
since 2.3.something (if i remember correctly) the reference counting
has been handled by the upper layer (ala fops_get/fops_put).  the
following patch removes these extra bits:


--- linux-2.5.68/drivers/usb/misc/speedtch.c.000	Thu May 15 10:29:20 2003
+++ linux-2.5.68/drivers/usb/misc/speedtch.c	Thu May 15 10:29:32 2003
@@ -939,19 +939,15 @@
 		return -EAGAIN;
 	}
 
-	MOD_INC_USE_COUNT;
-
 	down (&instance->serialize); /* vs self, udsl_atm_close */
 
 	if (udsl_find_vcc (instance, vpi, vci)) {
 		up (&instance->serialize);
-		MOD_DEC_USE_COUNT;
 		return -EADDRINUSE;
 	}
 
 	if (!(new = kmalloc (sizeof (struct udsl_vcc_data), GFP_KERNEL))) {
 		up (&instance->serialize);
-		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 
@@ -1021,8 +1017,6 @@
 
 	up (&instance->serialize);
 
-	MOD_DEC_USE_COUNT;
-
 	dbg ("udsl_atm_close successful");
 }
 
