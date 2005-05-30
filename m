Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVE3IJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVE3IJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 04:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVE3IJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 04:09:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:1468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261546AbVE3IJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 04:09:07 -0400
Date: Mon, 30 May 2005 01:04:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Duncan Sands <baldrick@free.fr>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: 2.6.12-rc5-mm1: drivers/usb/atm/speedtch.c: gcc 2.95 compile
 error
Message-Id: <20050530010456.242b810e.akpm@osdl.org>
In-Reply-To: <1117439106.9515.31.camel@localhost.localdomain>
References: <20050525134933.5c22234a.akpm@osdl.org>
	<20050529151231.GE10441@stusta.de>
	<1117439106.9515.31.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands <baldrick@free.fr> wrote:
>
> Hi Adrian, it looks like gcc 2.95 doesn't like this kind of macro
> 
>  #define atm_info(instance, format, arg...)	\
>  	atm_printk(KERN_INFO, instance , format , ## arg)
> 
>  being called with only two arguments.  I don't know what
>  the best fix is, but this does the trick:

Nope.  There's a bug in gcc-2.95.x macro expansion, and here it bites us in
atm_printk():

printk(level "ATM dev %d: " format , (instance)->atm_dev->number, ## arg)

the workaround is to add a space before that final comma:

diff -puN drivers/usb/atm/usbatm.h~a drivers/usb/atm/usbatm.h
--- 25/drivers/usb/atm/usbatm.h~a	2005-05-30 01:02:51.000000000 -0700
+++ 25-akpm/drivers/usb/atm/usbatm.h	2005-05-30 01:03:08.000000000 -0700
@@ -62,7 +62,8 @@
 
 /* FIXME: move to dev_* once ATM is driver model aware */
 #define atm_printk(level, instance, format, arg...)	\
-	printk(level "ATM dev %d: " format , (instance)->atm_dev->number, ## arg)
+	printk(level "ATM dev %d: " format ,		\
+	(instance)->atm_dev->number , ## arg)
 
 #define atm_err(instance, format, arg...)	\
 	atm_printk(KERN_ERR, instance , format , ## arg)
_

