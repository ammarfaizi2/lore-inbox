Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTEGFXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTEGFXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:23:44 -0400
Received: from fmr01.intel.com ([192.55.52.18]:16079 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262864AbTEGFXm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:23:42 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C8FDF53@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Gabriel Devenyi'" <devenyga@mcmaster.ca>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KernelJanitor: Convert remaining error returns to ret
	urn -E Linux 2.5.68
Date: Tue, 6 May 2003 22:36:11 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Gabriel Devenyi [mailto:devenyga@mcmaster.ca]
> 
> This patch applies to 2.5.68. It converts all the remaining error returns
to
> the new return -E form, this is in the KernelJanitor TODO list.
> 
> http://muss.mcmaster.ca/~devenyga/patch-linux-2.5.68-return-errors.patch

This patch is wrong in many areas:

For example:

diff -urN linux-2.5.68/drivers/s390/block/dasd.c
linux-2.5.68-changed/drivers/s390/block/dasd.c
--- linux-2.5.68/drivers/s390/block/dasd.c	2003-04-20
02:49:25.000000000 +0000
+++ linux-2.5.68-changed/drivers/s390/block/dasd.c	2003-04-29
21:24:16.000000000 +0000
@@ -77,21 +77,21 @@
 
 	device = kmalloc(sizeof (struct dasd_device), GFP_ATOMIC);
 	if (device == NULL)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	memset(device, 0, sizeof (struct dasd_device));

ERR_PTR is transforming an integer into a pointer; that is
on purpose, because that function only returns a pointer.
Callers can check if the return is an error with IS_ERR()
[or similar] and bail out.

So you actually need to change all that; they were right.

Another matter is the sign - I don't remember if ERR_PTR()
sets the sign to be negative or not ... just checked,
include/linux/err.h - it is not, so you always have to
do something like:

return ERR_PTR(-EWHATEVER)

because for IS_ERR() to work, the pointer casted to a
unsigned long has to be greater than -1000 casted to
unsigned long.

As a recap, in many places it seems you just went in and
blindly prefixed the return code with a minus sign. 

For example: the tulip driver drivers/net/tulip/dmfe.c:

--- linux-2.5.68/drivers/net/tulip/dmfe.c	2003-04-20
02:50:45.000000000 +0000
+++ linux-2.5.68-changed/drivers/net/tulip/dmfe.c	2003-04-29
21:24:26.000000000 +0000
@@ -1545,7 +1545,7 @@
 		ErrFlag = 1;
 	}
 
-	return ErrFlag;
+	return -ErrFlag;
 }

you are changing dmfe_sense_speed(), that returns an u8
(unsigned) to return -1 ... well, isn't this wrong?
Who is calling this function? dmfe_timer(); and what 
does it expect? just zero or not zero (meaning failure).

So in this case it does not even matter to return 
-EWHATEVER - in fact, when there are only two states:
passed and failed, and there is no good description
of the error as to pass it, then is better to do
what this guys do. 0 ok, 1 failed. No need to do
anything else (and according to the kernel janitors
howto [somewhere], unsigneds yield better code than 
signeds).

You have to really understand the code before changing
stuff like this. You need to thoroughly evaluate 
each place you change to make sure the change is right 
[and of course, report this in your patch]. And you 
definitely need to break up the patch:
one patch per driver. Then post each one for review at
the KJP mailing list and have them (ACME or whoever
feed it to each maintainer). If they cannot feed it,
you should contact each maintainer with the change).

Hope this helps,

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
