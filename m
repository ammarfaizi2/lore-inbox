Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVCPTfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVCPTfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVCPTep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:34:45 -0500
Received: from [205.233.219.253] ([205.233.219.253]:28812 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S262767AbVCPTbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:31:19 -0500
Date: Wed, 16 Mar 2005 14:28:59 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       willy@debian.org, nathans@sgi.com
Subject: Re: [PATCH, RFC 3/4] Use sem_getcount in XFS
Message-ID: <20050316192859.GB1111@conscoop.ottawa.on.ca>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca> <20050310205503.6151ab83.akpm@osdl.org> <20050311053144.GP1111@conscoop.ottawa.on.ca> <20050310215652.76c47856.akpm@osdl.org> <20050311122747.GL21986@parcelfarce.linux.theplanet.co.uk> <20050311170449.GS1111@conscoop.ottawa.on.ca> <20050316192709.GZ1111@conscoop.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316192709.GZ1111@conscoop.ottawa.on.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert XFS to use sem_getcount instead of nasty hack.  Fixes warning
with XFS debugging on parisc (untested since I can't find an obvious way
to enable XFS debugging) as well as the valusema macro, used in two places
in XFS.

Tested on i386, ia64, parisc.

Signed-off-by: Jody McIntyre <scjody@modernduck.com>

Index: 1394-dev/fs/xfs/linux-2.6/xfs_buf.c
===================================================================
--- 1394-dev.orig/fs/xfs/linux-2.6/xfs_buf.c	2005-03-15 17:45:47.000000000 -0500
+++ 1394-dev/fs/xfs/linux-2.6/xfs_buf.c	2005-03-15 17:52:39.000000000 -0500
@@ -976,7 +976,7 @@ int
 pagebuf_lock_value(
 	xfs_buf_t		*pb)
 {
-	return(atomic_read(&pb->pb_sema.count));
+	return(sem_getcount(&pb->pb_sema));
 }
 #endif
 
Index: 1394-dev/fs/xfs/linux-2.6/sema.h
===================================================================
--- 1394-dev.orig/fs/xfs/linux-2.6/sema.h	2005-03-15 17:59:50.000000000 -0500
+++ 1394-dev/fs/xfs/linux-2.6/sema.h	2005-03-15 18:16:00.000000000 -0500
@@ -48,7 +48,7 @@ typedef struct semaphore sema_t;
 #define initnsema(sp, val, name)	sema_init(sp, val)
 #define psema(sp, b)			down(sp)
 #define vsema(sp)			up(sp)
-#define valusema(sp)			(atomic_read(&(sp)->count))
+#define valusema(sp)			(sem_getcount(sp))
 #define freesema(sema)
 
 /*
