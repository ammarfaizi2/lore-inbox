Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVINPic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVINPic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVINPic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:38:32 -0400
Received: from relay0.mail.ox.ac.uk ([129.67.1.161]:31465 "EHLO
	relay0.mail.ox.ac.uk") by vger.kernel.org with ESMTP
	id S1030190AbVINPi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:38:29 -0400
Date: Wed, 14 Sep 2005 16:38:28 +0100
From: Ian Collier <Ian.Collier@comlab.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: loop: auto-load crypto module [PATCH]
Message-ID: <20050914163827.B25087@pixie.comlab>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050909132725.C23462@pixie.comlab>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050909132725.C23462@pixie.comlab>; from Ian.Collier@comlab.ox.ac.uk on Fri, Sep 09, 2005 at 01:27:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems odd that "losetup -e blowfish" will auto-load the blowfish module
if it's not already loaded but it doesn't work if the cryptoloop module
isn't loaded.  It's fairly simple to amend loop so that it requests
a crypto module when required - a sample patch appears below.  Just put
"alias loop-encrypt-18 cryptoloop" in your modprobe.conf.  This currently
fails silently if the module isn't found - I don't know whether it's
worth putting a message in there.

On an unrelated note, while looking at loop.c I noticed that loop_init
contains two calls to memset for the same block of memory (one outside
the for-loop, one inside).  It seems to me that one of these isn't
necessary.  :-)

imc

--- linux-2.6.13/drivers/block/loop.c.orig	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.13/drivers/block/loop.c	2005-09-14 14:01:42.844009381 +0100
@@ -74,6 +74,7 @@
 #include <linux/completion.h>
 #include <linux/highmem.h>
 #include <linux/gfp.h>
+#include <linux/kmod.h>
 
 #include <asm/uaccess.h>
 
@@ -950,8 +951,12 @@
 		if (type >= MAX_LO_CRYPT)
 			return -EINVAL;
 		xfer = xfer_funcs[type];
-		if (xfer == NULL)
-			return -EINVAL;
+		if (xfer == NULL) {
+			request_module("loop-encrypt-%u",type);
+			xfer = xfer_funcs[type];
+			if (xfer == NULL)
+				return -EINVAL;
+		}
 	} else
 		xfer = NULL;
 
