Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVFANwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVFANwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVFANwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:52:21 -0400
Received: from adsl-69-149-197-17.dsl.austtx.swbell.net ([69.149.197.17]:23940
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S261391AbVFANwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:52:05 -0400
Subject: Re: [PATCH 1/2] Introduce tty_unregister_ldisc()
From: Paul Fulghum <paulkf@microgate.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1117597088.5888.18.camel@at2.pipehead.org>
References: <200505312356.00853.adobriyan@gmail.com>
	 <1117578491.4627.14.camel@at2.pipehead.org>
	 <1117597088.5888.18.camel@at2.pipehead.org>
Content-Type: text/plain
Message-Id: <1117633912.2921.15.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 01 Jun 2005 08:51:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch would be more appropriate than
my last suggestion for the case of trying to register
a ldisc driver to an occupied slot.

It does not make sense to allow an existing
registered driver to be overwritten, even
if the refcount is zero.

This *should* not happen with unique ldisc numbers,
but it seems like a reasonable check. Even if
Alexey's patch is applied, this would be a
reasonable check to integrate.

-- 
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.11/drivers/char/tty_io.c	2005-03-02 01:38:10.000000000 -0600
+++ b/drivers/char/tty_io.c	2005-06-01 08:34:05.000000000 -0500
@@ -263,10 +263,14 @@ int tty_register_ldisc(int disc, struct 
 	
 	spin_lock_irqsave(&tty_ldisc_lock, flags);
 	if (new_ldisc) {
-		tty_ldiscs[disc] = *new_ldisc;
-		tty_ldiscs[disc].num = disc;
-		tty_ldiscs[disc].flags |= LDISC_FLAG_DEFINED;
-		tty_ldiscs[disc].refcount = 0;
+		if (tty_ldiscs[disc].flags & LDISC_FLAG_DEFINED)
+			ret = -EBUSY;
+		else {
+			tty_ldiscs[disc] = *new_ldisc;
+			tty_ldiscs[disc].num = disc;
+			tty_ldiscs[disc].flags |= LDISC_FLAG_DEFINED;
+			tty_ldiscs[disc].refcount = 0;
+		}
 	} else {
 		if(tty_ldiscs[disc].refcount)
 			ret = -EBUSY;


