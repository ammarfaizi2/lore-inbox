Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWEPPJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWEPPJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWEPPJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:09:56 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:37004 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932077AbWEPPJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:09:49 -0400
Date: Tue, 16 May 2006 17:09:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Brownell <david-b@pacbell.net>
Cc: jffs-dev@axis.com, dwmw2@infradead.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: Re: jffs2 build fixes
Message-ID: <20060516150928.GC11656@wohnheim.fh-wedel.de>
References: <200604010831.57875.david-b@pacbell.net> <200605160755.38606.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200605160755.38606.david-b@pacbell.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006 07:55:37 -0700, David Brownell wrote:
> On Saturday 01 April 2006 8:31 am, David Brownell wrote:
> > against today's GIT; there's a section error and
> > several printk format warnings.  x86_64.
> 
> I see that Andrew also got tired of such printk warnings, so his
> fix is now in the kernel.org tree ... here's a resend of this
> patch, updated against today's GIT by removing two of the printk
> warning fixes.

jffs-dev@axis.com is practically dead.  Iirc, the list was used for
the old jffs[1] code.  Jffs2 is usually discussed on
linux-mtd@lists.infradead.org (added to Cc:).

> Resolve some JFFS2 build problems:
>   (a) section mismatch error
>   (b) wrong printk format warnings
> 
> The section mismatch issue was fixed by making a few more routines as
> belonging in init or exit sections, but there are more routines that
> could (should!) get such annotations.

Patch looks sane.  Does it still apply against dwmw2's latest tree?
http://git.infradead.org/?p=mtd-2.6.git

[ Patch kept for the benefit of linux-mtd ]

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> Index: g26/fs/jffs2/compr.c
> ===================================================================
> --- g26.orig/fs/jffs2/compr.c	2006-05-12 18:48:21.000000000 -0700
> +++ g26/fs/jffs2/compr.c	2006-05-12 19:40:08.000000000 -0700
> @@ -412,7 +412,7 @@ void jffs2_free_comprbuf(unsigned char *
>                  kfree(comprbuf);
>  }
>  
> -int jffs2_compressors_init(void)
> +int __init jffs2_compressors_init(void)
>  {
>  /* Registering compressors */
>  #ifdef CONFIG_JFFS2_ZLIB
> @@ -440,7 +440,7 @@ int jffs2_compressors_init(void)
>          return 0;
>  }
>  
> -int jffs2_compressors_exit(void)
> +int __exit jffs2_compressors_exit(void)
>  {
>  /* Unregistering compressors */
>  #ifdef CONFIG_JFFS2_RUBIN
> Index: g26/fs/jffs2/compr_zlib.c
> ===================================================================
> --- g26.orig/fs/jffs2/compr_zlib.c	2006-05-12 18:48:21.000000000 -0700
> +++ g26/fs/jffs2/compr_zlib.c	2006-05-12 19:40:08.000000000 -0700
> @@ -60,7 +60,7 @@ static int __init alloc_workspaces(void)
>  	return 0;
>  }
>  
> -static void free_workspaces(void)
> +static void __exit free_workspaces(void)
>  {
>  	vfree(def_strm.workspace);
>  	vfree(inf_strm.workspace);
> @@ -216,7 +216,7 @@ int __init jffs2_zlib_init(void)
>      return ret;
>  }
>  
> -void jffs2_zlib_exit(void)
> +void __exit jffs2_zlib_exit(void)
>  {
>      jffs2_unregister_compressor(&jffs2_zlib_comp);
>      free_workspaces();
> Index: g26/fs/jffs2/readinode.c
> ===================================================================
> --- g26.orig/fs/jffs2/readinode.c	2006-05-12 18:48:21.000000000 -0700
> +++ g26/fs/jffs2/readinode.c	2006-05-12 19:40:08.000000000 -0700
> @@ -204,7 +204,7 @@ static inline int read_dnode(struct jffs
>  
>  	tn = jffs2_alloc_tmp_dnode_info();
>  	if (!tn) {
> -		JFFS2_ERROR("failed to allocate tn (%d bytes).\n", sizeof(*tn));
> +		JFFS2_ERROR("failed to allocate tn (%zd bytes).\n", sizeof(*tn));
>  		return -ENOMEM;
>  	}
>  
> @@ -434,7 +434,7 @@ static int read_more(struct jffs2_sb_inf
>  	}
>  
>  	if (retlen < len) {
> -		JFFS2_ERROR("short read at %#08x: %d instead of %d.\n",
> +		JFFS2_ERROR("short read at %#08x: %zu instead of %d.\n",
>  				offs, retlen, len);
>  		return -EIO;
>  	}
> @@ -542,7 +542,8 @@ static int jffs2_get_inode_nodes(struct 
>  		}
>  
>  		if (retlen < len) {
> -			JFFS2_ERROR("short read at %#08x: %d instead of %d.\n", ref_offset(ref), retlen, len);
> +			JFFS2_ERROR("short read at %#08x: %zd instead of %d.\n",
> +					ref_offset(ref), retlen, len);
>  			err = -EIO;
>  			goto free_out;
>  		}


Jörn

-- 
They laughed at Galileo.  They laughed at Copernicus.  They laughed at
Columbus. But remember, they also laughed at Bozo the Clown.
-- unknown
