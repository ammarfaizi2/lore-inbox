Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934264AbWKTQsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934264AbWKTQsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934270AbWKTQsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:48:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60069 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S934264AbWKTQsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:48:11 -0500
Date: Mon, 20 Nov 2006 16:48:05 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-fbdev-devel@lists.sourceforge.net, Tero Roponen <teanropo@jyu.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] fb: modedb uses wrong default_mode
In-Reply-To: <20061117124013.b6e4183d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611201643460.17639@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
 <20061115152952.0e92c50d.akpm@osdl.org> <20061115234456.GB3674@cosmic.amd.com>
 <Pine.LNX.4.64.0611171919090.9851@pentafluge.infradead.org>
 <20061117124013.b6e4183d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> James Simmons <jsimmons@infradead.org> wrote:
> 
> > Who knows how many drivers get this wrong. BTW Jordan is right. 
> > DEFAULT_MODEDB_INDEX is unless. Also we don't need dbsize anymore. 
> > Jordan did point out a error in fb_find_mode. It should be
> > 
> > 	if (!db)
> > 	    db = modedb;
> > 	dbsize = ARRAY_SIZE(modedb);
> > 
> > 	if (!default_mode)
> > 	    default_mode = &db[DEFAULT_MODEDB_INDEX];
> > 	if (!default_bpp)
> > 	    default_bpp = 8;
> > 
> > db will always be set.
> 
> I think we do need dbsize, and that the code which I have now:

I really don't trust dbsize. The driver writer can pass in the wrong 
number. Whereas ARRAY_SIZE will always be correct. Lets take the position 
that we use dbsize then we need to test if dbsize is greater than the 
really size of the modedb. The dbsize parameter was for the days before we
had ARRAY_SIZE.

> int fb_find_mode(struct fb_var_screeninfo *var,
> 		 struct fb_info *info, const char *mode_option,
> 		 const struct fb_videomode *db, unsigned int dbsize,
> 		 const struct fb_videomode *default_mode,
> 		 unsigned int default_bpp)
> {
>     int i;
> 
>     /* Set up defaults */
>     if (!db) {
> 	db = modedb;
> 	dbsize = ARRAY_SIZE(modedb);
>     }

      if (dbsize > ARRAY_SIZE(db))
	dbsize = ARRAY_SIZE(db);

>     if (!default_mode)
> 	default_mode = &db[0];
> 
>     if (!default_bpp)
> 	default_bpp = 8;
