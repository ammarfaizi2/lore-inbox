Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267217AbTAAKbm>; Wed, 1 Jan 2003 05:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbTAAKbm>; Wed, 1 Jan 2003 05:31:42 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:5641 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267217AbTAAKbk>; Wed, 1 Jan 2003 05:31:40 -0500
Date: Wed, 1 Jan 2003 10:40:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: RFC/Patch - Implode devfs
Message-ID: <20030101104005.A19168@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
References: <20021231182422.A4160@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021231182422.A4160@baldur.yggdrasil.com>; from adam@yggdrasil.com on Tue, Dec 31, 2002 at 06:24:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2002 at 06:24:22PM -0800, Adam J. Richter wrote:
> 	The following patch replaces devfs with a ramfs-derived
> implementation which is under one quarter the size although it
> eliminates certain functionality.
> 
> 		wc -l *.c Makefile	size (text + data + bss)
> 
> devfs		3614 lines		25,863 bytes
> mini-devfs       629 lines		 5,367 bytes
> Reduction	 5.7x			4.8x

Wow, that looks really cool!  I just wonder where viro is hiding the last
weeks, he promised more devfs API cleanups that likely clash with
your changes.

> 	3. devfs_handle_t is now a synonym for struct dentry*.

I wonder whether some code uses struct devfs_entry * directly, at least
I was tempted to do so in the scsi midlayer.

> 	4. A lot of the devfs routines are unimplemented.  I haven't
> noticed much code that uses them, and I'm not sure that any code
> really should.  I think arch/ia64/sn uses devfs_get_first_child,
> devfs_get_next_sibling.  I need to understand what if any of the
> other routines are really necessary and why (for example, why can't
> we use struct dentry).  My computer seems to run fine without them.

The hcl code in arch/ia64/sn/ is supposed to get replaced by a filesystem
on it's own once the sn port is properly updated for 2.5/2.6.

> 	First of all, I'd like to debug this code and I'd welcome any
> help.

Is it supposed to work out of the box on previously (and for 2.4 use)
non-devfs systems?  I still don't plan to use devfs, but such an effort
is really worth some debugging help..

> 	I think I'd like to change fs/super.c slightly to make it
> easier to statically allocate the struct super_block for filesystems
> that can have only one instance even if they are mounted in multiple
> locations (devfs, procfs, sysfs, usbdevfs, etc.).

Why do you want to allocate it statically?

> @@ -24,7 +24,11 @@
>  #define DEVFS_SPECIAL_CHR     0
>  #define DEVFS_SPECIAL_BLK     1
>  
> +#ifdef CONFIG_DEVFS_SMALL
> +typedef struct dentry * devfs_handle_t;
> +#else
>  typedef struct devfs_entry * devfs_handle_t;
> +#endif

Do you really need to keep both around?

> +/* On success, returns with (*parent_inode)->i_sem taken. */
> +static int devfs_decode(devfs_handle_t dir, const char *name, int is_dir,
> +			struct inode **parent_inode, struct dentry **dentry)

Do we really have to support this?

> +++ linux/fs/devfs2/numspace.c	2002-12-25 17:44:14.000000000 -0800
> @@ -0,0 +1,76 @@
> +#include <linux/module.h>
> +#include <linux/vmalloc.h>
> +#include <linux/devfs_fs_kernel.h>
> +
> +/**
> + *	devfs_alloc_unique_number - Allocate a unique (positive) number.
> + *	@space: The number space to allocate from.
> + *
> + *	Returns the allocated unique number, else a negative error code.
> + *	This routine is thread safe and may block.
> + */
> +
> +int devfs_alloc_unique_number (struct unique_numspace *space)

Remove the devfs_ prefix here (it's not devfs-specific at all) and
convert to sane indentation?

