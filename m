Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbUJ0Fm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbUJ0Fm4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUJ0Fm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:42:56 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:2723 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261652AbUJ0Fmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:42:37 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm1
Date: Wed, 27 Oct 2004 00:42:34 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20041026213156.682f35ca.akpm@osdl.org>
In-Reply-To: <20041026213156.682f35ca.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410270042.34224.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 11:31 pm, Andrew Morton wrote: 
> +remove-module_parm-from-allyesconfig-almost.patch
> 
>  Move lots of MODULE_PARMs to module_param()
> 

Please consider applying the patch below for parkbd instead of
Rusty's changes. I find parameter names in form of parkbd.parkbd
and parkbd.parkbd_mode extremely ugly.

The patch is against Linus's -bk.

-- 
Dmitry


===================================================================


ChangeSet@1.1994, 2004-10-27 00:40:17-05:00, dtor_core@ameritech.net
  Input: parkbd - switch to use module_param. Parameter names are
         parkbd.port and parkbd.mode
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 Documentation/kernel-parameters.txt |    7 +++++++
 drivers/input/serio/parkbd.c        |   19 ++++++++-----------
 2 files changed, 15 insertions(+), 11 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-10-27 00:40:58 -05:00
+++ b/Documentation/kernel-parameters.txt	2004-10-27 00:40:58 -05:00
@@ -844,6 +844,13 @@
 	panic=		[KNL] Kernel behaviour on panic
 			Format: <timeout>
 
+	parkbd.port=	[HW] Parallel port number the keyboard adapter is
+			connected to, default is 0.
+			Format: <parport#>
+	parkbd.mode=	[HW] Parallel port keyboard adapter mode of operation,
+			0 for XT, 1 for AT (default is AT).
+			Format: <mode> 
+
 	parport=0	[HW,PPT]	Specify parallel ports. 0 disables.
 	parport=auto			Use 'auto' to force the driver to use
 	parport=0xBBB[,IRQ[,DMA]]	any IRQ/DMA settings detected (the
diff -Nru a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
--- a/drivers/input/serio/parkbd.c	2004-10-27 00:40:58 -05:00
+++ b/drivers/input/serio/parkbd.c	2004-10-27 00:40:58 -05:00
@@ -37,15 +37,17 @@
 MODULE_DESCRIPTION("Parallel port to Keyboard port adapter driver");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(parkbd, "1i");
-MODULE_PARM(parkbd_mode, "1i");
+static unsigned int parkbd_pp_no;
+module_param_named(port, parkbd_pp_no, int, 0);
+MODULE_PARM_DESC(port, "Parallel port the adapter is connected to (default is 0)");
+
+static unsigned int parkbd_mode = SERIO_8042;
+module_param_named(mode, parkbd_mode, uint, 0);
+MODULE_PARM_DESC(mode, "Mode of operation: XT = 0/AT = 1 (default)");
 
 #define PARKBD_CLOCK	0x01	/* Strobe & Ack */
 #define PARKBD_DATA	0x02	/* AutoFd & Busy */
 
-static int parkbd;
-static int parkbd_mode = SERIO_8042;
-
 static int parkbd_buffer;
 static int parkbd_counter;
 static unsigned long parkbd_last;
@@ -126,12 +128,7 @@
 {
 	struct parport *pp;
 
-	if (parkbd < 0) {
-		printk(KERN_ERR "parkbd: no port specified\n");
-		return -ENODEV;
-	}
-
-	pp = parport_find_number(parkbd);
+	pp = parport_find_number(parkbd_pp_no);
 
 	if (pp == NULL) {
 		printk(KERN_ERR "parkbd: no such parport\n");
