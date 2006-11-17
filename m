Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753013AbWKQUIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbWKQUIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbWKQUIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:08:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13294 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753003AbWKQUIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:08:54 -0500
Date: Fri, 17 Nov 2006 20:08:47 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: linux-fbdev-devel@lists.sourceforge.net
cc: Andrew Morton <akpm@osdl.org>, Tero Roponen <teanropo@jyu.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] fb: modedb uses wrong default_mode
In-Reply-To: <20061115234456.GB3674@cosmic.amd.com>
Message-ID: <Pine.LNX.4.64.0611171919090.9851@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
 <20061115152952.0e92c50d.akpm@osdl.org> <20061115234456.GB3674@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > It seems that default_mode is always overwritten in
> > > fb_find_mode() if caller gives its own modedb; this
> > > patch should fix it.
> 
> > Sigh.
> > 
> > 2.6.19-rc5 has:
> > 
> >     if (!default_mode)
> > 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> > 
> > and Jordan changed it to
> > 
> >     if (!default_mode && db != modedb)
> > 	default_mode = &db[0];
> >     else
> > 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> 
> 
> > and you want to change it to
> > 
> >     if (!default_mode && db != modedb)
> > 	default_mode = &db[0];
> >     else if (!default_mode)
> > 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> > 
> > which is actually a complicated way of doing
> > 
> >     if (!default_mode)
> > 	default_mode = &db[DEFAULT_MODEDB_INDEX];
> 
> Unless DEFAULT_MODEDB_INDEX for some reason gets set to non-zero, then
> it could be dangerous. If we agree that the default entry should aways be 
> at 0, then nuke the define and hard code the zero.  That way, nobody will be 
> tempted to change it.

Taking a look at modedb.c and neofb.c I noticed the bug is in the neofb.c 
driver. The problem is the confusion with the fb_find_mode function 
itself.

int fb_find_mode(struct fb_var_screeninfo *var,
                 struct fb_info *info, const char *mode_option,
                 const struct fb_videomode *db, unsigned int dbsize,
                 const struct fb_videomode *default_mode,
                 unsigned int default_bpp)

db is the database but default_mode is the mode we want to run. As you 
can see neofb.c does

	if (!fb_find_mode(&info->var, info, mode_option, NULL, 0,
                        info->monspecs.modedb, 16)) {
                printk(KERN_ERR "neofb: Unable to find usable video mode.\n");
                goto err_map_video;
        }


it should be
	if (!fb_find_mode(&info->var, info, mode_option, info->monspecs.modedb,
			0, NULL, 16)) {
		
Who knows how many drivers get this wrong. BTW Jordan is right. 
DEFAULT_MODEDB_INDEX is unless. Also we don't need dbsize anymore. 
Jordan did point out a error in fb_find_mode. It should be

	if (!db)
	    db = modedb;
	dbsize = ARRAY_SIZE(modedb);

	if (!default_mode)
	    default_mode = &db[DEFAULT_MODEDB_INDEX];
	if (!default_bpp)
	    default_bpp = 8;

db will always be set.


 
