Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266922AbUBQX2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266927AbUBQX2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:28:54 -0500
Received: from palrel12.hp.com ([156.153.255.237]:62085 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266922AbUBQX2b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:28:31 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16434.41884.249541.156083@napali.hpl.hp.com>
Date: Tue, 17 Feb 2004 15:28:28 -0800
To: torvalds@osdl.org, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: radeon warning on 64-bit platforms
In-Reply-To: <1077058106.2713.88.camel@thor.asgaard.local>
References: <16434.35199.597235.894615@napali.hpl.hp.com>
	<1077054385.2714.72.camel@thor.asgaard.local>
	<16434.36137.623311.751484@napali.hpl.hp.com>
	<1077055209.2712.80.camel@thor.asgaard.local>
	<16434.37025.840577.826949@napali.hpl.hp.com>
	<1077058106.2713.88.camel@thor.asgaard.local>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus and Michel,

Here is a proposed patch for fixing the compile-warning that shows up
when compiling radeon_state.c on a 64-bit platform (Itanium, in my
case).  According to Michel, RADEON_PARAM_SAREA_HANDLE is used only on
embedded platforms and since it is not possible to fix the problem
without breaking backwards-compatibility for those platforms, the
interim fix is to simply desupport this particular ioctl() on 64-bit
platforms (i.e., make it fail with EINVAL).

If there are no objections, please apply.

	--david

===== drivers/char/drm/radeon_state.c 1.23 vs edited =====
--- 1.23/drivers/char/drm/radeon_state.c	Tue Feb  3 21:29:26 2004
+++ edited/drivers/char/drm/radeon_state.c	Tue Feb 17 15:23:01 2004
@@ -2186,9 +2186,24 @@
 		value = dev_priv->ring_rptr_offset;
 		break;
 	case RADEON_PARAM_SAREA_HANDLE:
-		/* The lock is the first dword in the sarea. */
-		value = (int)dev->lock.hw_lock; 
-		break;	
+		/*
+		 * This ioctl() doesn't work on 64-bit platforms because hw_lock is a
+		 * pointer which can't fit into an int-sized variable.  According to
+		 * Michael Dänzer, the ioctl() is only used on embedded platforms, so not
+		 * supporting it shouldn't be a problem.  If the same functionality is
+		 * needed on 64-bit platforms, a new ioctl() would have to be added, so
+		 * backwards-compatibility for the embedded platforms can be maintained.
+		 *	--davidm 4-Feb-2004.
+		 */
+	  	if (sizeof (dev->lock.hw_lock) <= sizeof (int))
+		    /*
+		     * The lock is the first dword in the sarea.  Cast to "long" so it
+		     * compiles without warning on 64-bit platforms.
+		     */
+		    value = (long)dev->lock.hw_lock;
+		else
+		    return DRM_ERR(EINVAL);
+		break;
 	case RADEON_PARAM_GART_TEX_HANDLE:
 		value = dev_priv->gart_textures_offset;
 		break;
