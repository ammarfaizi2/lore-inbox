Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSIDUPz>; Wed, 4 Sep 2002 16:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSIDUPz>; Wed, 4 Sep 2002 16:15:55 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:4414 "EHLO
	shaggy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S315370AbSIDUPv>; Wed, 4 Sep 2002 16:15:51 -0400
From: Dave Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200209042018.g84KI6612079@shaggy.austin.ibm.com>
Subject: Re: [PATCH] sparc32: wrong type of nlink_t
To: szepe@pinerecords.com (Tomas Szepe)
Date: Wed, 4 Sep 2002 15:18:05 -0500 (CDT)
Cc: davem@redhat.com (David S. Miller), marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com
In-Reply-To: <20020901094416.GF32122@louise.pinerecords.com> from "Tomas Szepe" at Sep 01, 2002 11:44:16 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >    Against 2.4.20-pre5 - fix up the type of nlink_t. This makes jfs and
> >    reiserfs stop complaining about comparisons always turning up false
> >    due to limited range of data type.
> >
> > If you change this, you change the types exported to userspace
> > which will break everything.
> 
> Right.  Here's a corresponding reiserfs/jfs fix, then.  I've checked the
> constants aren't used for anything else except nlink overflow alerts.

I don't like this fix.  I know 32767 is a lot of links, but I don't like
artificially lowering a limit like this just because one architecture
defines nlink_t incorrectly.  I'd rather get rid of the compiler warnings
with a cast in the few places the limit is checked, even though that is
a little bit ugly.

> diff -urN linux-2.4.20-pre5/fs/jfs/jfs_filsys.h linux-2.4.20-pre5.n/fs/jfs/jfs_filsys.h
> --- linux-2.4.20-pre5/fs/jfs/jfs_filsys.h	2002-09-01 11:31:44.000000000 +0200
> +++ linux-2.4.20-pre5.n/fs/jfs/jfs_filsys.h	2002-09-01 11:30:13.000000000 +0200
> @@ -125,7 +125,8 @@
>  #define MAXBLOCKSIZE		4096
>  #define	MAXFILESIZE		((s64)1 << 52)
> 
> -#define JFS_LINK_MAX		65535	/* nlink_t is unsigned short */
> +/* the shortest nlink_t there is is sparc's signed short */
> +#define JFS_LINK_MAX		32767
> 
>  /* Minimum number of bytes supported for a JFS partition */
>  #define MINJFS			(0x1000000)
> diff -urN linux-2.4.20-pre5/include/linux/reiserfs_fs.h linux-2.4.20-pre5.n/include/linux/reiserfs_fs.h
> --- linux-2.4.20-pre5/include/linux/reiserfs_fs.h	2002-09-01 11:31:45.000000000 +0200
> +++ linux-2.4.20-pre5.n/include/linux/reiserfs_fs.h	2002-09-01 11:23:30.000000000 +0200
> @@ -1185,10 +1185,12 @@
>  #define MAX_B_NUM  MAX_UL_INT
>  #define MAX_FC_NUM MAX_US_INT
> 
> -
> -/* the purpose is to detect overflow of an unsigned short */
> -#define REISERFS_LINK_MAX (MAX_US_INT - 1000)
> -
> +/* the original purpose was to detect a possible overflow
> + * of an unsigned short nlink_t. However, there are archs
> + * that only provide a signed short nlink_t, so this will
> + * have to start ringing a wee bit earlier.
> + */
> +#define REISERFS_LINK_MAX (0x7fff - 1000)
> 
>  /* The following defines are used in reiserfs_insert_item and reiserfs_append_item  */
>  #define REISERFS_KERNEL_MEM		0	/* reiserfs kernel memory mode	*/

Thanks,
Shaggy

-- 
David Kleikamp
IBM Linux Technology Center
