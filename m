Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbTI3W0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTI3W0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:26:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21447 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261736AbTI3WZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:25:58 -0400
Date: Tue, 30 Sep 2003 23:25:56 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Arun Sharma <arun.sharma@intel.com>, linux-kernel@vger.kernel.org,
       kevin.tian@intel.com, Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] incorrect use of sizeof() in ioctl definitions
Message-ID: <20030930222556.GG24824@parcelfarce.linux.theplanet.co.uk>
References: <3F79ED60.2030207@intel.com> <20030930140805.0e3158e7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930140805.0e3158e7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 02:08:05PM -0700, Andrew Morton wrote:
> Arun Sharma <arun.sharma@intel.com> wrote:
> >
> > Some drivers seem to use macros such as _IOR/_IOW in a way that ends up calling the sizeof() operator twice. For eg:
> > 
> > -#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, sizeof(__u32*))
> > +#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, __u32*)

The real problem is that ia64 doesn't have the typechecking ioctl
definitions yet.  Here's what I committed for parisc recently (it applies
to ia64 too):

+++ include/asm-parisc/ioctl.h  21 Sep 2003 01:01:38 -0000      1.2
@@ -44,11 +44,21 @@
         ((nr)   << _IOC_NRSHIFT) | \
         ((size) << _IOC_SIZESHIFT))
 
+/* provoke compile error for invalid uses of size argument */
+extern int __invalid_size_argument_for_IOC;
+#define _IOC_TYPECHECK(t) \
+       ((sizeof(t) == sizeof(t[1]) && \
+         sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
+         sizeof(t) : __invalid_size_argument_for_IOC)
+
 /* used to create numbers */
 #define _IO(type,nr)           _IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)     _IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)     _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)    _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(siz
e))
+#define _IOR(type,nr,size)     _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)
))
+#define _IOW(type,nr,size)     _IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size
)))
+#define _IOWR(type,nr,size)    _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPE
CHECK(size)))
+#define _IOR_BAD(type,nr,size) _IOC(_IOC_READ,(type),(nr),sizeof(size))
+#define _IOW_BAD(type,nr,size) _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOWR_BAD(type,nr,size)        _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),si
zeof(size))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)           (((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)

> Matthew Wilcox fixed all except one of these a while back.  What is left
> over is this chunk:
> 
> 
> diff -puN drivers/video/aty/aty128fb.c~sizeof-in-ioctl-fix drivers/video/aty/aty128fb.c
> --- 25/drivers/video/aty/aty128fb.c~sizeof-in-ioctl-fix	Tue Sep 30 14:04:12 2003
> +++ 25-akpm/drivers/video/aty/aty128fb.c	Tue Sep 30 14:04:12 2003
> @@ -2041,9 +2041,9 @@ aty128fb_setcolreg(u_int regno, u_int re
>  #define ATY_MIRROR_CRT_ON	0x00000002
>  
>  /* out param: u32*	backlight value: 0 to 15 */
> -#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, sizeof(__u32*))
> +#define FBIO_ATY128_GET_MIRROR	_IOR('@', 1, __u32*)
>  /* in param: u32*	backlight value: 0 to 15 */
> -#define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, sizeof(__u32*))
> +#define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, __u32*)
>  
>  static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
>  			  u_long arg, struct fb_info *info)
> 
> 
> Matthew's conversion mainly converted things to size_t, but from the looks
> of it, __u32* is the right thing to use in this case, I think?

I think so, given:

radeonfb.h:#define FBIO_RADEON_GET_MIRROR       _IOR('@', 3, size_t)
radeonfb.h:#define FBIO_RADEON_SET_MIRROR       _IOW('@', 4, size_t)

Though we can also change it to _IOR_BAD and _IOW_BAD.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
