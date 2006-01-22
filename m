Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWAVTRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWAVTRq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWAVTRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:17:46 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:16243 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751027AbWAVTRp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:17:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=orI+EDqXX2eLwP0Gxh5fPnEDocbl2GdwCKDThBz2pky+nOg8AqfJOdBYRw+qowI9jDCp/kWzjkMV4Gw0OCxpLCecHNPnjuIeGZLqVI9pYGne977WrYOeYBxl7h/Cj2KoOiBenQy5VepzW21ClZ7zjtBJ8cBkUHmMHoXHkRbcAQQ=
Message-ID: <84144f020601221117t2c529da2xc0a14ee4322da4bf@mail.gmail.com>
Date: Sun, 22 Jan 2006 21:17:43 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
Subject: Re: [PATCH/RFC] minix filesystem: Corrected patch
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
In-Reply-To: <43D3D03C.6030504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <43D3D03C.6030504@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 1/22/06, Daniel Aragonés <danarag@gmail.com> wrote:
> Answering to the suggestion of Randy, here come the patches already corrected.
>
> This patches concern the update for Minix V3 support for both kernels 2.6.x.y and 2.4.x.
>
> Attached as text files  "V3_2dot6_patch.txt" and "V3_2dot4_patch.txt" are the corrected versions of my first post dated January 19. As I wrote there...

Please post the 2.4 and 2.6 patches as separetely and inline the patch
in the mail as per Documentation/SubmittingPatches. I am unable to
apply your patch because my mail client meshes them together.

> @@ -108,14 +111,22 @@
>                 limit = kaddr + minix_last_byte(inode, n) - chunk_size;
>                 for ( ; p <= limit ; p = minix_next_entry(p, sbi)) {
>                         minix_dirent *de = (minix_dirent *)p;
> +                       minix3_dirent *de3 = (minix3_dirent *)p;
>                         if (de->inode) {
>                                 int over;
> -                               unsigned l = strnlen(de->name,sbi->s_namelen);
> -
> -                               offset = p - kaddr;
> -                               over = filldir(dirent, de->name, l,
> -                                               (n<<PAGE_CACHE_SHIFT) | offset,
> -                                               de->inode, DT_UNKNOWN);
> +                               if (!(sbi->s_version == MINIX_V3)) {
> +                                       unsigned l = strnlen(de->name,sbi->s_namelen);
> +                                       offset = p - kaddr;
> +                                       over = filldir(dirent, de->name, l,
> +                                       (n<<PAGE_CACHE_SHIFT) | offset,
> +                                       de->inode, DT_UNKNOWN);
> +                               } else {
> +                                       unsigned l = strnlen(de3->name,sbi->s_namelen);
> +                                       offset = p - kaddr;
> +                                       over = filldir(dirent, de3->name, l,
> +                                       (n<<PAGE_CACHE_SHIFT) | offset,
> +                                       de3->inode, DT_UNKNOWN);

Hmm, strange formatting. Wouldn't it be better if you introduced a
name pointer and moved those filldir bits outside of the if-else
block? Less code duplication that way.

> -               for ( ; (char *) de <= kaddr ; de = minix_next_entry(de,sbi)) {
> -                       if (!de->inode)
> -                               continue;
> -                       if (namecompare(namelen,sbi->s_namelen,name,de->name))
> -                               goto found;
> +               for ( ; (char *) de <= kaddr ;
> +                                       de = minix_next_entry(de,sbi),
> +                                       de3 = minix_next_entry(de3,sbi)) {
> +                       if (!(sbi->s_version == MINIX_V3)) {
> +                               if (!de->inode)
> +                                       continue;
> +                               if (namecompare(namelen,sbi->s_namelen,name,de->name))
> +                                       goto found;
> +                       } else {
> +                               if (!de3->inode)
> +                                       continue;
> +                               if (namecompare(namelen,sbi->s_namelen,name,de3->name))
> +                                       goto found;
> +                       }

Same here.

> @@ -226,9 +248,16 @@
>                         if (!de->inode)
>                                 goto got_it;
>                         err = -EEXIST;
> -                       if (namecompare(namelen,sbi->s_namelen,name,de->name))
> -                               goto out_unlock;
> -                       de = minix_next_entry(de, sbi);
> +                       if (!(sbi->s_version == MINIX_V3)) {
> +                               if (namecompare(namelen,sbi->s_namelen,name,de->name))
> +                                       goto out_unlock;
> +                               de = minix_next_entry(de, sbi);
> +                       } else {
> +                               if (namecompare(namelen,sbi->s_namelen,name,de3->name))
> +                                       goto out_unlock;
> +                               de = minix_next_entry(de, sbi);
> +                               de3 = minix_next_entry(de3, sbi);

Why do you do both here?

> @@ -242,9 +271,15 @@
>         err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
>         if (err)
>                 goto out_unlock;
> -       memcpy (de->name, name, namelen);
> -       memset (de->name + namelen, 0, sbi->s_dirsize - namelen - 2);
> -       de->inode = inode->i_ino;
> +               if (!(sbi->s_version == MINIX_V3)) {
> +               memcpy (de->name, name, namelen);
> +               memset (de->name + namelen, 0, sbi->s_dirsize - namelen - 2);
> +               de->inode = inode->i_ino;
> +               } else {
> +               memcpy (de3->name, name, namelen);
> +               memset (de3->name + namelen, 0, sbi->s_dirsize - namelen - 4);
> +               de3->inode = inode->i_ino;
> +               }

Strange formatting.

> @@ -301,11 +337,13 @@
>         memset(kaddr, 0, PAGE_CACHE_SIZE);
>
>         de = (struct minix_dir_entry *)kaddr;
> -       de->inode = inode->i_ino;
> -       strcpy(de->name,".");
> +       de3 = (struct minix3_dir_entry *)kaddr;
> +       de->inode = de3->inode = inode->i_ino;
> +       (sbi->s_version == MINIX_V3) ? strcpy(de3->name,".") : strcpy(de->name,".");
>         de = minix_next_entry(de, sbi);
> -       de->inode = dir->i_ino;
> -       strcpy(de->name,"..");
> +       de3 = minix_next_entry(de3, sbi);
> +       de->inode = de3->inode = dir->i_ino;
> +       (sbi->s_version == MINIX_V3) ? strcpy(de3->name,"..") : strcpy(de->name,"..");
>         kunmap_atomic(kaddr, KM_USER0);

Formatting and please use if-else instead.

>                 while ((char *)de <= kaddr) {
>                         if (de->inode != 0) {
>                                 /* check for . and .. */
> -                               if (de->name[0] != '.')
> -                                       goto not_empty;
> -                               if (!de->name[1]) {
> -                                       if (de->inode != inode->i_ino)
> +                               if (!(sbi->s_version == MINIX_V3)) {
> +                                       if (de->name[0] != '.')
> +                                               goto not_empty;
> +                                       if (!de->name[1]) {
> +                                               if (de->inode != inode->i_ino)
> +                                               goto not_empty;
> +                                       } else if (de->name[1] != '.')
> +                                               goto not_empty;
> +                                       else if (de->name[2])
> +                                               goto not_empty;
> +                               } else {
> +                                       if (de3->name[0] != '.')
>                                                 goto not_empty;
> -                               } else if (de->name[1] != '.')
> -                                       goto not_empty;
> -                               else if (de->name[2])
> -                                       goto not_empty;
> +                                       if (!de3->name[1]) {
> +                                               if (de3->inode != inode->i_ino)
> +                                               goto not_empty;
> +                                       } else if (de3->name[1] != '.')
> +                                               goto not_empty;
> +                                       else if (de3->name[2])
> +                                               goto not_empty;
> +                               }

Formatting. Shouldn't you make that non_empty check a separate
function so you don't need to duplicate it?

> @@ -197,6 +201,23 @@
>                 sbi->s_dirsize = 32;
>                 sbi->s_namelen = 30;
>                 sbi->s_link_max = MINIX2_LINK_MAX;
> +       } else if ( *(__u16 *)(bh->b_data + 24) == MINIX3_SUPER_MAGIC) {
> +
> +               s->s_magic = MINIX3_SUPER_MAGIC;
> +               sbi->s_imap_blocks = *(__u16 *)(bh->b_data + 6);
> +               sbi->s_zmap_blocks = *(__u16 *)(bh->b_data + 8);
> +               sbi->s_firstdatazone = *(__u16 *)(bh->b_data + 10);
> +               sbi->s_log_zone_size = *(__u16 *)(bh->b_data + 12);
> +               sbi->s_max_size = *(__u32 *)(bh->b_data + 16);
> +               sbi->s_nzones = *(__u32 *)(bh->b_data + 20);

You probably want to introduce a struct minix3_super_block for this.
It's much more readable that way.

> +               sbi->s_dirsize = 64;
> +               sbi->s_namelen = 60;
> +               sbi->s_version = MINIX_V3;
> +               sbi->s_link_max = MINIX2_LINK_MAX;
> +                       if ( *(__u16 *)(bh->b_data + 28) != 1024) {
> +                               if (!sb_set_blocksize(s,( *(__u16 *)(bh->b_data + 28))))
> +                               goto out_bad_hblock;
> +               }

You're now setting the block size twice for the V3 case.

>  #define MINIX_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix_inode)))
> -#define MINIX2_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix2_inode)))
> +#define MINIX2_INODES_PER_BLOCK(b) ((b)/(sizeof (struct minix2_inode)))

Maybe this should be called minix_inodes_per_block instead and be a
static inline function?
