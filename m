Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVH3Izs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVH3Izs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVH3Izs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:55:48 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:47476 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751286AbVH3Izs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:55:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FicIaNmfMGfMEKF8HUn35nlWogzId8RESbgZ8syzjMn2uB+FbLhlnhuHLMKlqnEsvoEZV+4Ak+pjziZju5HKASkfQ/32yz5nv7zOWGIdMSm/0XLC59hef7ursvhDjQ3LDMVy3u59bPr9JWFjF4BDcxrJDelbwvR247FMHeTQRrk=
Message-ID: <84144f02050830015523df031e@mail.gmail.com>
Date: Tue, 30 Aug 2005 11:55:46 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #2
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
In-Reply-To: <4313E578.8070100@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some more.

On 8/30/05, Machida, Hiroyuki <machida@sm.sony.co.jp> wrote:
> --- old/fs/fat/inode.c  2005-08-29 09:38:53.308587787 +0900
> +++ new/fs/fat/inode.c  2005-08-29 09:39:33.889555606 +0900
> @@ -345,6 +347,15 @@ static void fat_delete_inode(struct inod
>  static void fat_clear_inode(struct inode *inode)
>  {
>         struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
> +       void *hints;
> +
> +       down(&(MSDOS_I(inode)->scan_lock);
> +       hints = (void *)(MSDOS_I(inode)->scan_hints);
> +       if (hints) {
> +               MSDOS_I(inode)->scan_hints = 0;
> +       }
> +       up(&(MSDOS_I(inode)->scan_lock);
> +       if (hints) kfree(hints);

Please just make the local variable hints of type loff_t * to get rid
of the pointless casting.

> 
>         if (is_bad_inode(inode))
>                 return;
> @@ -1011,6 +1022,8 @@ static int fat_read_root(struct inode *i
>         struct msdos_sb_info *sbi = MSDOS_SB(sb);
>         int error;
> 
> +       init_MUTEX(&(MSDOS_I(inode)->scan_lock);
> +       MSDOS_I(inode)->scan_hints = 0;

Use NULLs instead of 0 for pointers to keep new code sparse-clean.
