Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264037AbTCXQcX>; Mon, 24 Mar 2003 11:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264270AbTCXQbU>; Mon, 24 Mar 2003 11:31:20 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:33514 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264271AbTCXQat>; Mon, 24 Mar 2003 11:30:49 -0500
Message-Id: <200303241641.h2OGfx35008214@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:46 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: plug DRM memory leak on exit paths.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted by Oleg Drokin

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/drm/drm_drv.h linux-2.5/drivers/char/drm/drm_drv.h
--- bk-linus/drivers/char/drm/drm_drv.h	2003-03-08 09:56:59.000000000 +0000
+++ linux-2.5/drivers/char/drm/drm_drv.h	2003-03-17 23:42:16.000000000 +0000
@@ -581,8 +581,10 @@ static int __init drm_init( void )
 		init_timer( &dev->timer );
 		init_waitqueue_head( &dev->context_wait );
 
-		if ((DRM(minor)[i] = DRM(stub_register)(DRIVER_NAME, &DRM(fops),dev)) < 0)
-			return -EPERM;
+		if ((DRM(minor)[i] = DRM(stub_register)(DRIVER_NAME, &DRM(fops),dev)) < 0) {
+			retcode = -EPERM;
+			goto fail_reg;
+		}
 		dev->device = MKDEV(DRM_MAJOR, DRM(minor)[i] );
 		dev->name   = DRIVER_NAME;
 
@@ -591,9 +593,8 @@ static int __init drm_init( void )
 #if __MUST_HAVE_AGP
 		if ( dev->agp == NULL ) {
 			DRM_ERROR( "Cannot initialize the agpgart module.\n" );
-			DRM(stub_unregister)(DRM(minor)[i]);
-			DRM(takedown)( dev );
-			return -ENOMEM;
+			retcode = -ENOMEM;
+			goto fail;
 		}
 #endif
 #if __REALLY_HAVE_MTRR
@@ -609,9 +610,7 @@ static int __init drm_init( void )
 		retcode = DRM(ctxbitmap_init)( dev );
 		if( retcode ) {
 			DRM_ERROR( "Cannot allocate memory for context bitmap.\n" );
-			DRM(stub_unregister)(DRM(minor)[i]);
-			DRM(takedown)( dev );
-			return retcode;
+			goto fail;
 		}
 #endif
 		DRM_INFO( "Initialized %s %d.%d.%d %s on minor %d\n",
@@ -626,6 +625,15 @@ static int __init drm_init( void )
 	DRIVER_POSTINIT();
 
 	return 0;
+
+fail:
+	DRM(stub_unregister)(DRM(minor)[i]);
+	DRM(takedown)( dev );
+
+fail_reg:
+	kfree (DRM(device));
+	kfree (DRM(minor));
+	return retcode;
 }
 
 /* drm_cleanup is called via cleanup_module at module unload time.
