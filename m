Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263754AbUDMVRy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 17:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUDMVRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 17:17:54 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:11149 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263754AbUDMVRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 17:17:52 -0400
Date: Tue, 13 Apr 2004 22:17:02 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix for potential integer overflow in zoran driver
Message-ID: <20040413211702.GJ6051@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <200404132107.i3DL7tdA013238@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404132107.i3DL7tdA013238@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 10:02:37PM +0000, Linux Kernel wrote:
 > ChangeSet 1.2126, 2004/04/12 15:02:37-07:00, akpm@osdl.org
 > 
 > 	[PATCH] fix for potential integer overflow in zoran driver
 > 	
 > 	From: "Ronald S. Bultje" <R.S.Bultje@students.uu.nl>
 > 	
 > 	Attached patch fixes a potential integer overflow in zoran_procs.c (part of
 > 	the zr36067 driver).  Bug was detected by Ken Ashcraft with the Stanford
 > 	checker.
 > 
 > --- a/drivers/media/video/zoran_procfs.c	Tue Apr 13 14:07:59 2004
 > +++ b/drivers/media/video/zoran_procfs.c	Tue Apr 13 14:07:59 2004
 > @@ -204,6 +204,10 @@
 >  	char *line, *ldelim, *varname, *svar, *tdelim;
 >  	struct zoran *zr;
 >  
 > +	/* Random maximum */
 > +	if (count > 256)
 > +		return -EINVAL;
 > +
 >  	zr = (struct zoran *) data;
 >  
 >  	string = sp = vmalloc(count + 1);

2.4 already had this fixed, but uses a somewhat larger value to clip at.
For uniformity sake, perhaps they should be the same ?
Patch below makes it match 2.4-bk

		Dave


--- bk-linus/drivers/media/video/zoran_procfs.c~	2004-04-13 22:15:35.000000000 +0100
+++ bk-linus/drivers/media/video/zoran_procfs.c	2004-04-13 22:15:58.000000000 +0100
@@ -204,8 +204,7 @@
 	char *line, *ldelim, *varname, *svar, *tdelim;
 	struct zoran *zr;
 
-	/* Random maximum */
-	if (count > 256)
+	if (count > 32768)	/* Stupidity filter */
 		return -EINVAL;
 
 	zr = (struct zoran *) data;
