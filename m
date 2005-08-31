Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVHaKO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVHaKO1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVHaKO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:14:27 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:33150 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750751AbVHaKO0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:14:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KsPtjB8UXdmi9wv4VUxYOhmugcaox4PxcZRnqlB3NBYFJo42OVCrcNauSduwfNMP/lq/B7Rr730hkVgdsJRfDZ5io8KcwCqIgbwMEvcR6gWGfZStbGiYP8aysJqbsyrLbGuh/WdYf6CiWpZHhW3DT4pAgF2iznXjjzP1mZBlASI=
Message-ID: <84144f0205083103142faaf076@mail.gmail.com>
Date: Wed, 31 Aug 2005 13:14:22 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #3
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <43156963.8020203@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>
	 <874q979qdj.fsf@devron.myhome.or.jp> <43156963.8020203@sm.sony.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/31/05, Machida, Hiroyuki <machida@sm.sony.co.jp> wrote:
> 
> Sorry, I send out wrong version. I attached the latest patch to 2.6.13.
> 
> OGAWA Hirofumi wrote:
> > "Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:
> >
> >
> >>Here is a revised version of dirent scan patch,  mentioned at
> >>following E-mail.
> >>
> >>This patch addresses performance damages on "ls | xargs xxx" and
> >>reverse order scan which are reported to the previous patch.
> >>
> >>With this patch, fat_search_long() and fat_scan() use hint value
> >>as start of scan. For each directory holds multiple hint value entries.
> >>The entry would be selected by hash value based on scan target name and
> >>PID. Hint value would be calculated based on the entry previously found
> >>entry, so that the hint can cover backward neighborhood.
> >
> >
> > This patch couldn't compile. I assume you post a wrong patch...?
> >
> > The code is strange... Is the hint value related to the previously
> > accessed entry?
> >
> > This seems to be randomly cacheing the recent access position...  Is
> > it your intention of this patch?
> 
> Right, it looks like TLB, which holds cache "Physical addres"
> correponding to "Logical address". In this case, PID and file name
> to be looked up, perform role of "Logical address".
> 
> I prepared vfat16 fs where over 4000 files in /foo
> and 200 files in root, then checked with following cases;
> 
> 
>                                 without patch   with patch
> ls-vfat                         59.0            2.49
> xargs-vfat                      61.3            11.9
> stat-vfat                       41              17
> stat-vfat-reverse               56              32
> 
> ls-msdos                        14.2            0.62
> xargs-msdos                     16.8            16.7
> stat-msdos                      21              15
> stat-msdos-reverse              22              16
>                                         - all valuses have sec unit
> 
> 1-1 ls-vat)
> mount vfat to /a
> /usr/bin/time -p sh -c "/usr/bin/ls -Rl /a > /dev/null"
> umount /a
> 
> 1-2 ls-msdos)
> mount msdos to /a
> /usr/bin/time -p sh -c "/usr/bin/ls -Rl /a > /dev/null"
> umount /a
> 
> 2-1 xargs-vfat)
> mount vfat to /a
> cd /a/foo
> /usr/bin/time -p sh -c "(/usr/bin/ls | /usr/in/xargs stat) > /dev/null"
> umount /a
> 
> 2-2 xargs-msdos)
> mount msdos to /a
> cd /a/foo
> /usr/bin/time -p sh -c "(/usr/bin/ls | /usr/in/xargs stat) > /dev/null"
> umount /a
> 
> 3-1 stat-vfat)
> mount vfat to /a
> cd /a/foo
> repeat stat files which have located in the last 1024 dir entries
>    with incremental order.
> umount /a
> 
> 3-2 stat-vfat-reverse)
> do 3-1 with decremental order
> 
> 3-3 stat-msdos)
> do 3-1 with msdos fs
> 
> 3-4 stat-msdos-reverse)
> do 3-2 with msdos fs
> 
> 
> --
> Hiroyuki Machida
> 
> 
> This patch enables using hint information on scanning dir.
> It achieves excellent performance with "ls -l" for over 1000 entries.
> 
> * fat-dirscan-with-hint_3.patch for linux 2.6.13
> 
>  fs/fat/dir.c             |  130 ++++++++++++++++++++++++++++++++++++++++++++---
>  fs/fat/inode.c           |   13 ++++
>  include/linux/msdos_fs.h |    2
>  3 files changed, 137 insertions(+), 8 deletions(-)
> 
> Signed-off-by: Hiroyuki Machida <machida@sm.sony.co.jp> for CELF
> 
> * modified files
> 
> 
> --- linux-2.6.13/fs/fat/dir.c   2005-08-29 08:41:01.000000000 +0900
> +++ linux-2.6.13-work/fs/fat/dir.c      2005-08-31 13:48:01.001119437 +0900
> @@ -201,6 +201,88 @@ fat_shortname2uni(struct nls_table *nls,
>   * Return values: negative -> error, 0 -> not found, positive -> found,
>   * value is the total amount of slots, including the shortname entry.
>   */
> +
> +#define FAT_SCAN_SHIFT 4                       /* 2x8 way scan hints  */
> +#define FAT_SCAN_NWAY  (1<<FAT_SCAN_SHIFT)
> +
> +inline
> +static int hint_allocate(struct inode *dir)
> +{
> +       loff_t *hints;
> +       int err = 0;
> +
> +       if (!MSDOS_I(dir)->scan_hints) {

Please consider moving this check to callers. Conditional allocation
makes this bit strange API-wise. Or alternatively, give
hint_allocate() a better name.

> --- linux-2.6.13/fs/fat/inode.c 2005-08-29 08:41:01.000000000 +0900
> +++ linux-2.6.13-work/fs/fat/inode.c    2005-08-31 12:59:54.292274060 +0900
> @@ -242,6 +242,8 @@ static int fat_fill_inode(struct inode *
>         inode->i_version++;
>         inode->i_generation = get_seconds();
> 
> +       init_MUTEX(&MSDOS_I(inode)->scan_lock);
> +       MSDOS_I(inode)->scan_hints = 0;

Please use NULL.

>         if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
>                 inode->i_generation &= ~1;
>                 inode->i_mode = MSDOS_MKMODE(de->attr,
> @@ -345,6 +347,15 @@ static void fat_delete_inode(struct inod
>  static void fat_clear_inode(struct inode *inode)
>  {
>         struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
> +       loff_t *hints;
> +
> +       down(&MSDOS_I(inode)->scan_lock);
> +       hints = (MSDOS_I(inode)->scan_hints);

Pleas drop redundant parenthesis.

> +       if (hints) {
> +               MSDOS_I(inode)->scan_hints = NULL;
> +       }
> +       up(&MSDOS_I(inode)->scan_lock);
> +       kfree(hints);

Why can't you do kfree() under scan_lock?

> @@ -1011,6 +1022,8 @@ static int fat_read_root(struct inode *i
>         struct msdos_sb_info *sbi = MSDOS_SB(sb);
>         int error;
> 
> +       init_MUTEX(&MSDOS_I(inode)->scan_lock);
> +       MSDOS_I(inode)->scan_hints = 0;

Please use NULL here.

                             Pekka
