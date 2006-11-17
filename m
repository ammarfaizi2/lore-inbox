Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755888AbWKQUkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbWKQUkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886AbWKQUkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:40:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755888AbWKQUkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:40:31 -0500
Date: Fri, 17 Nov 2006 12:40:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Tero Roponen <teanropo@jyu.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] fb: modedb uses wrong default_mode
Message-Id: <20061117124013.b6e4183d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611171919090.9851@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
	<20061115152952.0e92c50d.akpm@osdl.org>
	<20061115234456.GB3674@cosmic.amd.com>
	<Pine.LNX.4.64.0611171919090.9851@pentafluge.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 20:08:47 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> Who knows how many drivers get this wrong. BTW Jordan is right. 
> DEFAULT_MODEDB_INDEX is unless. Also we don't need dbsize anymore. 
> Jordan did point out a error in fb_find_mode. It should be
> 
> 	if (!db)
> 	    db = modedb;
> 	dbsize = ARRAY_SIZE(modedb);
> 
> 	if (!default_mode)
> 	    default_mode = &db[DEFAULT_MODEDB_INDEX];
> 	if (!default_bpp)
> 	    default_bpp = 8;
> 
> db will always be set.

I think we do need dbsize, and that the code which I have now:

int fb_find_mode(struct fb_var_screeninfo *var,
		 struct fb_info *info, const char *mode_option,
		 const struct fb_videomode *db, unsigned int dbsize,
		 const struct fb_videomode *default_mode,
		 unsigned int default_bpp)
{
    int i;

    /* Set up defaults */
    if (!db) {
	db = modedb;
	dbsize = ARRAY_SIZE(modedb);
    }

    if (!default_mode)
	default_mode = &db[0];

    if (!default_bpp)
	default_bpp = 8;


is appropriate?


Here's the current version of this monster patch:

From: Jordan Crouse <jordan.crouse@amd.com>

If no default mode is specified, it should be grabbed from the supplied
database, not the default one.

[teanropo@jyu.fi: fix it]
[akpm@osdl.org: simplify it]
[akpm@osdl.org: remove pointless DEFAULT_MODEDB_INDEX]
Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Signed-off-by: Tero Roponen <teanropo@jyu.fi>
Cc: James Simmons <jsimmons@infradead.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/modedb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/video/modedb.c~video-get-the-default-mode-from-the-right-database drivers/video/modedb.c
--- a/drivers/video/modedb.c~video-get-the-default-mode-from-the-right-database
+++ a/drivers/video/modedb.c
@@ -34,8 +34,6 @@ const char *global_mode_option;
      *  Standard video mode definitions (taken from XFree86)
      */
 
-#define DEFAULT_MODEDB_INDEX	0
-
 static const struct fb_videomode modedb[] = {
     {
 	/* 640x400 @ 70 Hz, 31.5 kHz hsync */
@@ -505,8 +503,10 @@ int fb_find_mode(struct fb_var_screeninf
 	db = modedb;
 	dbsize = ARRAY_SIZE(modedb);
     }
+
     if (!default_mode)
-	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
+	default_mode = &db[0];
+
     if (!default_bpp)
 	default_bpp = 8;
 
_

