Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTIZVNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 17:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbTIZVNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 17:13:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:16856 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261625AbTIZVN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 17:13:29 -0400
Subject: Re: IA32 - 6 New warnings (gcc 3.2.2)
From: John Cherry <cherry@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1064608625.10304.52.camel@cherrytest.pdx.osdl.net>
References: <200309260548.h8Q5mZt3015714@cherrypit.pdx.osdl.net>
	 <20030926155654.GO15696@fs.tum.de>
	 <1064608625.10304.52.camel@cherrytest.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1064610791.10304.75.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 26 Sep 2003 14:13:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The log for building sis_mm.c shows...

  CC      drivers/char/drm/sis_mm.o
drivers/char/drm/sis_mm.c:37:25: linux/sisfb.h: No such file or
directory
drivers/char/drm/sis_mm.c: In function `sis_fb_alloc':
drivers/char/drm/sis_mm.c:92: storage size of `req' isn't known
drivers/char/drm/sis_mm.c:98: warning: implicit declaration of function
`sis_malloc'
drivers/char/drm/sis_mm.c:105: warning: implicit declaration of function
`sis_free'
drivers/char/drm/sis_mm.c:92: warning: unused variable `req'
drivers/char/drm/sis_mm.c: In function `sis_fb_free':
drivers/char/drm/sis_mm.c:135: warning: int format, long unsigned int
arg (arg 3)
drivers/char/drm/sis_mm.c:135: warning: int format, long unsigned int
arg (arg 3)

The bug is that linux/sisfb.h should be video/sisfb.h on line 37 of
sis_m.c.  The latest linus bk tree and mm kernel seem to have it right.
The snapshot for this build last night must have been between
changesets.

And...the warning makes sense in this context because sis_memreq is
undefined if sisfb.h is not included.  :)

John

On Fri, 2003-09-26 at 13:37, John Cherry wrote:
> On Fri, 2003-09-26 at 08:56, Adrian Bunk wrote:
> > On Thu, Sep 25, 2003 at 10:48:35PM -0700, John Cherry wrote:
> > >...
> > > drivers/char/drm/sis_mm.c:92: warning: unused variable `req'
> > >...
> > 
> > Looking at the code, this seems to be a bogus warning in the gcc version
> > you are using.
> > 
> > cu
> > Adrian
> 
> Yes, this warning looks bogus.  Hard to understand why this was flagged
> as a warning by gcc 3.2.2...
> 
> int sis_fb_alloc( DRM_IOCTL_ARGS )
> {
>         drm_sis_mem_t fb;
> -->     struct sis_memreq req;
>         int retval = 0;
>                                                                                 
>         DRM_COPY_FROM_USER_IOCTL(fb, (drm_sis_mem_t *)data, sizeof(fb));
>                                                                                 
>         req.size = fb.size;
> -->     sis_malloc(&req);
>         if (req.offset) {
>                 /* TODO */
>                 fb.offset = req.offset;
>                 fb.free = req.offset;
>                 if (!add_alloc_set(fb.context, VIDEO_TYPE, fb.free)) {
>                         DRM_DEBUG("adding to allocation set fails\n");
>                         sis_free(req.offset);
>                         retval = DRM_ERR(EINVAL);
>                 }
>         } else {
>                 fb.offset = 0;
>                 fb.size = 0;
>                 fb.free = 0;
>         }
> <snip>
> 
> John
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

