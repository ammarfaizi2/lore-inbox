Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVCIUBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVCIUBW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVCIT7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:59:48 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:6668 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262188AbVCITdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:33:14 -0500
Date: Wed, 9 Mar 2005 20:33:17 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: linux1394-devel@lists.sourceforge.net, video4linux-list@redhat.com,
       sensors@Stimpy.netroedge.com
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime
Message-Id: <20050309203317.64916119.khali@linux-fr.org>
In-Reply-To: <200503090243.06270.gene.heskett@verizon.net>
References: <200503082326.28737.gene.heskett@verizon.net>
	<20050308224441.2e29f895.akpm@osdl.org>
	<200503090243.06270.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__9_Mar_2005_20_33_17_+0100_6keH1tl5j.I1_Ilk"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__9_Mar_2005_20_33_17_+0100_6keH1tl5j.I1_Ilk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Gene, Andrew, all,

(Gene, note that I cannot write to you directly because Verizon are
idiots. Let's just hope you'll read that.)

[Gene Heskett]
> /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:362:
> error: unknown field `id' specified in initializer

I've dropped the "id" member of struct i2c_client, as it were useless.
Third-party driver authors now need to do the same.

Patches to pcHDTV 1.6 and 2.0 attached (untested). Feel free to push the
latter to the author of hdPCTV. Note that the removed struct member was
really not used before, so the driver will still work with earlier
kernels.

[Andrew Morton]
> What's pcHDTV-1.6.tar.gz?  If it was merged up then these things
> wouldn't happen.

I second that, especially since the pcHDTV package is made up of
modified bttv and cx88 drivers, not an original driver. Merging the
changes into the kernel would obviously make everyone's life easier.

As a side note, I have (many) other changes to the i2c subystem in my
plans, some of them are rather intrusive, so expect pcHDTV to break
again soon, unless it gets merged until then.

[Gene Heskett]
> Third, somewhere between 2.6.11-rc5-RT-V0.39-02 and 2.6.11, I've
> lost my sensors except for one on the motherboard called THRM by
> gkrellm-2.28.  Nothing seems to be able to bring the w83627hf back
> to life.

THRM is most likely a temperature you get from /proc/acpi/thermal_zone,
and isn't related with the w83627hf driver.

I think that you are affected by recent changes made by the ACPI folks
to the way resources are reserved. See bug #4014:
  http://bugzilla.kernel.org/show_bug.cgi?id=4014

You can check /proc/ioports on the working system after loading
w83627hf, and compare with /proc/ioports on the non-working system. I'd
expect you to find that the non-working system has reserved a subrange
of what the w83627hf driver attempts to grab, making it fail.

-- 
Jean Delvare

--Multipart=_Wed__9_Mar_2005_20_33_17_+0100_6keH1tl5j.I1_Ilk
Content-Type: text/plain;
 name="pcHDTV-1.6-kill-i2c-client-id.diff"
Content-Disposition: attachment;
 filename="pcHDTV-1.6-kill-i2c-client-id.diff"
Content-Transfer-Encoding: 7bit

diff -u -rN pcHDTV-1.6/kernel-2.6.x/driver.orig/bttv-i2c.c pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c
--- pcHDTV-1.6/kernel-2.6.x/driver.orig/bttv-i2c.c	Fri Dec 10 19:42:38 2004
+++ pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c	Wed Mar  9 13:52:24 2005
@@ -359,7 +359,6 @@
 
 static struct i2c_client bttv_i2c_client_template = {
 	I2C_DEVNAME("bttv internal"),
-        .id       = -1,
 };
 
 
diff -u -rN pcHDTV-1.6/kernel-2.6.x/driver.orig/cx88-i2c.c pcHDTV-1.6/kernel-2.6.x/driver/cx88-i2c.c
--- pcHDTV-1.6/kernel-2.6.x/driver.orig/cx88-i2c.c	Fri Dec 10 19:42:39 2004
+++ pcHDTV-1.6/kernel-2.6.x/driver/cx88-i2c.c	Wed Mar  9 13:51:19 2005
@@ -136,7 +136,6 @@
 
 static struct i2c_client cx8800_i2c_client_template = {
         I2C_DEVNAME("cx88xx internal"),
-        .id   = -1,
 };
 
 /* init + register i2c algo-bit adapter */

--Multipart=_Wed__9_Mar_2005_20_33_17_+0100_6keH1tl5j.I1_Ilk
Content-Type: text/plain;
 name="pcHDTV-2.0-kill-i2c-client-id.diff"
Content-Disposition: attachment;
 filename="pcHDTV-2.0-kill-i2c-client-id.diff"
Content-Transfer-Encoding: 7bit

diff -u -rN pcHDTV-2.0.orig/bttv-i2c.c pcHDTV-2.0/bttv-i2c.c
--- pcHDTV-2.0.orig/bttv-i2c.c	Fri Feb 18 21:54:35 2005
+++ pcHDTV-2.0/bttv-i2c.c	Wed Mar  9 13:56:34 2005
@@ -317,7 +317,6 @@
 
 static struct i2c_client bttv_i2c_client_template = {
 	I2C_DEVNAME("bttv internal"),
-        .id       = -1,
 };
 
 
diff -u -rN pcHDTV-2.0.orig/cx88-i2c.c pcHDTV-2.0/cx88-i2c.c
--- pcHDTV-2.0.orig/cx88-i2c.c	Fri Feb 18 21:54:38 2005
+++ pcHDTV-2.0/cx88-i2c.c	Wed Mar  9 13:56:58 2005
@@ -142,7 +142,6 @@
 
 static struct i2c_client cx8800_i2c_client_template = {
         I2C_DEVNAME("cx88xx internal"),
-        .id   = -1,
 };
 
 static char *i2c_devs[128] = {
diff -u -rN pcHDTV-2.0.orig/dpl3518.c pcHDTV-2.0/dpl3518.c
--- pcHDTV-2.0.orig/dpl3518.c	Fri Feb 18 21:54:36 2005
+++ pcHDTV-2.0/dpl3518.c	Wed Mar  9 13:57:11 2005
@@ -374,7 +374,6 @@
 static struct i2c_client client_template =
 {
         I2C_DEVNAME("dpl3518"),
-        .id         = -1,
         .driver     = &driver
 };
 
diff -u -rN pcHDTV-2.0.orig/saa7134-i2c.c pcHDTV-2.0/saa7134-i2c.c
--- pcHDTV-2.0.orig/saa7134-i2c.c	Fri Feb 18 21:54:36 2005
+++ pcHDTV-2.0/saa7134-i2c.c	Wed Mar  9 13:57:22 2005
@@ -361,7 +361,6 @@
 
 static struct i2c_client saa7134_client_template = {
 	I2C_DEVNAME("saa7134 internal"),
-        .id        = -1,
 };
 
 /* ----------------------------------------------------------- */
diff -u -rN pcHDTV-2.0.orig/tda9875.c pcHDTV-2.0/tda9875.c
--- pcHDTV-2.0.orig/tda9875.c	Fri Feb 18 21:54:38 2005
+++ pcHDTV-2.0/tda9875.c	Wed Mar  9 13:57:42 2005
@@ -418,7 +418,6 @@
 static struct i2c_client client_template =
 {
         I2C_DEVNAME("tda9875"),
-        .id        = -1,
         .driver    = &driver,
 };
 

--Multipart=_Wed__9_Mar_2005_20_33_17_+0100_6keH1tl5j.I1_Ilk--
