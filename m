Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWEZMBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWEZMBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 08:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWEZMAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 08:00:39 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:37355 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932410AbWEZMAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 08:00:31 -0400
Date: Fri, 26 May 2006 06:00:32 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: sho@tnes.nec.co.jp
Cc: cmm@us.ibm.com, jitendra@linsyssoft.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [UPDATE][12/24]ext3 enlarge blocksize
Message-ID: <20060526120032.GN5964@schatzie.adilger.int>
Mail-Followup-To: sho@tnes.nec.co.jp, cmm@us.ibm.com,
	jitendra@linsyssoft.com, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20060525214902sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525214902sho@rifu.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least part of this patch can be included into the patch series that
Mingming has posted to allow larger block sizes on architectures that
support it.  This doesn't need a separate COMPAT flag itself, since
older kernels will already refuse to mount a filesystem with large blocks.

On May 25, 2006  21:49 +0900, sho@tnes.nec.co.jp wrote:
> @@ -1463,11 +1463,17 @@ static int ext3_fill_super (struct super
> +	if (blocksize > PAGE_SIZE) {
> +		printk(KERN_ERR "EXT3-fs: cannot mount filesystem with "
> +		       "blocksize %u larger than PAGE_SIZE %u on %s\n",
> +		       blocksize, PAGE_SIZE, sb->s_id);
> +		goto failed_mount;
> +	}
> +
>  	if (blocksize < EXT3_MIN_BLOCK_SIZE ||
> -	    blocksize > EXT3_MAX_BLOCK_SIZE) {
> +	    blocksize > EXT3_EXTENDED_MAX_BLOCK_SIZE) {

We may as well just change EXT3_MAX_BLOCK_SIZE to be 65536, because no other
code uses this value.  It is already 65536 in the e2fsprogs.

> -		printk(KERN_ERR 
> -		       "EXT3-fs: Unsupported filesystem blocksize %d on %s.\n",
> -		       blocksize, sb->s_id);
> +		printk(KERN_ERR "EXT3-fs: Unsupported filesystem blocksize %d on %s.\n",
> +				 blocksize, sb->s_id);

I'm not sure why you changed the formatting of this message to now be longer
than 80 columns.

> diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/include/linux/ext3_fs.h linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h
> --- linux-2.6.17-rc4/include/linux/ext3_fs.h	2006-05-25 16:33:29.711659209 +0900
> +++ linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h	2006-05-25 16:33:52.247791746 +0900
> @@ -86,6 +86,7 @@ struct statfs;
>   */
>  #define EXT3_MIN_BLOCK_SIZE		1024
>  #define	EXT3_MAX_BLOCK_SIZE		4096
> +#define        EXT3_EXTENDED_MAX_BLOCK_SIZE    65536
>  #define EXT3_MIN_BLOCK_LOG_SIZE		  10
>  #ifdef __KERNEL__
>  # define EXT3_BLOCK_SIZE(s)		((s)->s_blocksize)

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

