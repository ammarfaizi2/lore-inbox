Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTD1XDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbTD1XDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:03:08 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.36.229]:1935 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S261437AbTD1XDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:03:02 -0400
Date: Mon, 28 Apr 2003 16:55:40 -0500 (CDT)
From: Paul B Schroeder <paulsch@haywired.net>
To: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
cc: <girouard@us.ibm.com>
Subject: [PATCH 2.5] simple mwave code cleanup
Message-ID: <Pine.LNX.4.33.0304281643190.32277-100000@snafu.haywired.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch simply moves the 'nr_registered_attrs' and
'device_registered' variables in mwavedd.c into the MWAVE_DEVICE_DATA
struct which is defined in mwavedd.h..

Applies cleanly against 2.5.68..  Please apply..

Thanks...Paul...

-- 

Paul B Schroeder <paulsch at haywired dot net>

----------------------------------------------------------------------------

diff -ur linux-2.5.66.orig/drivers/char/mwave/mwavedd.c linux-2.5.66/drivers/char/mwave/mwavedd.c
--- linux-2.5.66.orig/drivers/char/mwave/mwavedd.c      2003-03-27 19:06:19.000000000 -0600
+++ linux-2.5.66/drivers/char/mwave/mwavedd.c   2003-03-27 19:16:29.000000000 -0600
@@ -502,8 +502,6 @@
        &dev_attr_uart_irq,
        &dev_attr_uart_io,
 };
-static int nr_registered_attrs;
-static int device_registered;

 /*
 * mwave_init is called on module load
@@ -518,13 +516,13 @@

        PRINTK_1(TRACE_MWAVE, "mwavedd::mwave_exit entry\n");

-       for (i = 0; i < nr_registered_attrs; i++)
+       for (i = 0; i < pDrvData->nr_registered_attrs; i++)
                device_remove_file(&mwave_device, mwave_dev_attrs[i]);
-       nr_registered_attrs = 0;
+       pDrvData->nr_registered_attrs = 0;

-       if (device_registered) {
+       if (pDrvData->device_registered) {
                device_unregister(&mwave_device);
-               device_registered = 0;
+               pDrvData->device_registered = FALSE;
        }

        if ( pDrvData->sLine >= 0 ) {
@@ -650,7 +648,7 @@

        if (device_register(&mwave_device))
                goto cleanup_error;
-       device_registered = 1;
+       pDrvData->device_registered = TRUE;
        for (i = 0; i < ARRAY_SIZE(mwave_dev_attrs); i++) {
                if(device_create_file(&mwave_device, mwave_dev_attrs[i])) {
                        PRINTK_ERROR(KERN_ERR_MWAVE
@@ -659,7 +657,7 @@
                                        mwave_dev_attrs[i]->attr.name);
                        goto cleanup_error;
                }
-               nr_registered_attrs++;
+               pDrvData->nr_registered_attrs++;
        }

        /* SUCCESS! */
diff -ur linux-2.5.66.orig/drivers/char/mwave/mwavedd.h linux-2.5.66/drivers/char/mwave/mwavedd.h
--- linux-2.5.66.orig/drivers/char/mwave/mwavedd.h      2003-03-27 19:06:19.000000000 -0600
+++ linux-2.5.66/drivers/char/mwave/mwavedd.h   2003-03-27 19:14:47.000000000 -0600
@@ -140,6 +140,8 @@
        MWAVE_IPC IPCs[16];
        BOOLEAN bMwaveDevRegistered;
        short sLine;
+       int nr_registered_attrs;
+       int device_registered;

 } MWAVE_DEVICE_DATA, *pMWAVE_DEVICE_DATA;



