Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTELU1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbTELU1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:27:48 -0400
Received: from palrel10.hp.com ([156.153.255.245]:13473 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262636AbTELU1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:27:47 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16064.1726.440360.935187@napali.hpl.hp.com>
Date: Mon, 12 May 2003 13:40:30 -0700
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: davidm@hpl.hp.com, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: Improved DRM support for cant_use_aperture
	platforms
In-Reply-To: <1052768911.10752.268.camel@thor>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	<1052653415.12338.159.camel@thor>
	<16062.37308.611438.5934@napali.hpl.hp.com>
	<20030511195543.GA15528@suse.de>
	<1052690133.10752.176.camel@thor>
	<16063.60859.712283.537570@napali.hpl.hp.com>
	<1052768911.10752.268.camel@thor>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, could you try with this patch applied on top of my previous patch?
Checking against KERNEL_VERSION(2,5,68) ensures that we have the new
(4-wargument) vmap() call and the "#ifndef PAGE_AGP" part ensures that
things will compile fine until the kernel's asm/agp.h gets updated.

	--david

===== drivers/char/drm/drm_memory.h 1.16 vs edited =====
--- 1.16/drivers/char/drm/drm_memory.h	Sat May 10 01:32:08 2003
+++ edited/drivers/char/drm/drm_memory.h	Mon May 12 13:37:57 2003
@@ -42,7 +42,12 @@
  */
 #define DEBUG_MEMORY 0
 
-#if __REALLY_HAVE_AGP
+/* Need at least kernel v2.5.68 to get the 4-argument version of vmap().  */
+#if __REALLY_HAVE_AGP && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,68))
+
+#ifndef PAGE_AGP
+# define PAGE_AGP	PAGE_KERNEL_NOCACHE
+#endif
 
 /*
  * Find the drm_map that covers the range [offset, offset+size).
@@ -127,7 +132,7 @@
 {
 	int remap_aperture = 0;
 
-#if __REALLY_HAVE_AGP
+#if __REALLY_HAVE_AGP && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,68))
 	if (dev->agp->cant_use_aperture) {
 		drm_map_t *map = drm_lookup_map(offset, size, dev);
 
@@ -146,7 +151,7 @@
 {
 	int remap_aperture = 0;
 
-#if __REALLY_HAVE_AGP
+#if __REALLY_HAVE_AGP && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,68))
 	if (dev->agp->cant_use_aperture) {
 		drm_map_t *map = drm_lookup_map(offset, size, dev);
 
@@ -163,7 +168,7 @@
 static inline void drm_ioremapfree(void *pt, unsigned long size, drm_device_t *dev)
 {
 	int unmap_aperture = 0;
-#if __REALLY_HAVE_AGP
+#if __REALLY_HAVE_AGP && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,68))
 	/*
 	 * This is a bit ugly.  It would be much cleaner if the DRM API would use separate
 	 * routines for handling mappings in the AGP space.  Hopefully this can be done in

