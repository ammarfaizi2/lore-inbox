Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVAJTuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVAJTuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVAJTsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:48:21 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:26051 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S262445AbVAJTj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:39:58 -0500
Date: Mon, 10 Jan 2005 21:39:57 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vfat unlink latency 54.6ms for 128MB files
Message-ID: <20050110193957.GB5561@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050110012330.GA10846@m.safari.iki.fi> <878y71xh7b.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878y71xh7b.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 03:38:32AM +0900, OGAWA Hirofumi wrote:
> Sami Farin <7atbggg02@sneakemail.com> writes:
> 
> > Just wondering, when I remove a 128MB file on vfat partition
> > (usb-storage, memcard reader), it causes 54.6ms latency
> > in rtc_latencytest...  latency seems to increase linearly
> > as the filesize grows.  I calculated 1s would be reached with
> > 2344MB file but I didn't bother trying that yet.
> > Are there any possible fixes for fat fs so
> > that it doesn't disable interrupts for that long a time?
> 
> The fatfs itself doesn't disable any interrupt.  I guess the thing
> depending on file size is the fat_free().
> 
> So, the following patch may change the behavior...
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
> diff -up linux-2.6.10/fs/fat/cache.c.orig linux-2.6.10/fs/fat/cache.c
> --- linux-2.6.10/fs/fat/cache.c.orig	2004-12-25 06:35:24.000000000 +0900
> +++ linux-2.6.10/fs/fat/cache.c	2005-01-11 03:34:54.000000000 +0900
> @@ -491,6 +491,8 @@ int fat_free(struct inode *inode, int sk
>  		if (MSDOS_SB(sb)->free_clusters != -1)
>  			MSDOS_SB(sb)->free_clusters++;
>  		inode->i_blocks -= MSDOS_SB(sb)->cluster_size >> 9;
> +
> +		cond_resched();
>  	} while (nr != FAT_ENT_EOF);
>  	fat_clusters_flush(sb);
>  	nr = 0;

Oh yeah, now max latency is around 1.5ms.
Thanks for the patch.

-- 
