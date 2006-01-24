Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWAXTKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWAXTKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 14:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWAXTKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 14:10:53 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:4839 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161030AbWAXTKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 14:10:52 -0500
Subject: Re: [PATH/RFC] minix filesystem Update to V3 for 2.6.x.y revised
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Daniel =?ISO-8859-1?Q?Aragon=E9s?=" <danarag@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43D676A9.5030304@gmail.com>
References: <43D676A9.5030304@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 24 Jan 2006 21:10:47 +0200
Message-Id: <1138129847.8653.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, 2006-01-24 at 19:49 +0100, Daniel Aragonés wrote:
> According to your suggestions, I have modified the patch for better
> formatting and other. Testing is going on fine. Here comes the patch
> attached as textfile V3_2dot6_patch3.txt

Looks much better! Thanks for doing this. Few comments below. Perhaps
you should send this to Andrew for inclusion in -mm after that?

> @@ -107,15 +112,23 @@
>  		p = kaddr+offset;
>  		limit = kaddr + minix_last_byte(inode, n) - chunk_size;
>  		for ( ; p <= limit ; p = minix_next_entry(p, sbi)) {
> +			minix3_dirent *de3 = (minix3_dirent *)p;
>  			minix_dirent *de = (minix_dirent *)p;
> -			if (de->inode) {
> +			if (sbi->s_version == MINIX_V3) {
> +				name_ptr = de3->name;
> +				inode_ptr = de3->inode;
> +	 			} else {
> +				name_ptr = de->name;
> +				inode_ptr = de->inode;
> +			}

Some formatting issues above.

> @@ -157,9 +170,11 @@
>  	unsigned long n;
>  	unsigned long npages = dir_pages(dir);
>  	struct page *page = NULL;
> +	struct minix3_dir_entry *de3;
>  	struct minix_dir_entry *de;
> -
>  	*res_page = NULL;
> +	char *name_ptr;
> +	__u32 inode_ptr;

Minor nitpick, I think you can omit the "ptr" prefix.

> @@ -301,11 +348,15 @@
>  	memset(kaddr, 0, PAGE_CACHE_SIZE);
>  
>  	de = (struct minix_dir_entry *)kaddr;
> +	de3 = (struct minix3_dir_entry *)kaddr;
>  	de->inode = inode->i_ino;
> -	strcpy(de->name,".");
> +	de3->inode = inode->i_ino;
> +	(sbi->s_version == MINIX_V3) ? strcpy(de3->name,".") : strcpy(de->name,".");
>  	de = minix_next_entry(de, sbi);
> +	de3 = minix_next_entry(de3, sbi);
>  	de->inode = dir->i_ino;
> -	strcpy(de->name,"..");
> +	de3->inode = dir->i_ino;
> +	(sbi->s_version == MINIX_V3) ? strcpy(de3->name,"..") : strcpy(de->name,"..");

if-else is preferred.

> @@ -322,9 +373,12 @@
>  	struct page *page = NULL;
>  	unsigned long i, npages = dir_pages(inode);
>  	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
> +	char *name_ptr;
> +	__u32 inode_ptr;

Same nitpick as above.

> +/*
> + * V3 minix super-block data on disk
> + */
> +struct minix3_super_block {
> +	__u16 s_ninodes;
> +	__u16 s_nzones;
> +	__u16 s_pad0;
> +	__u16 s_imap_blocks;
> +	__u16 s_zmap_blocks;
> +	__u16 s_firstdatazone;
> +	__u16 s_log_zone_size;
> +	__u16 s_pad1;
> +	__u32 s_max_size;
> +	__u32 s_zones;
> +	__u16 s_magic;
> +	__u16 s_pad2;
> +	__u16 s_blocksize;
> +	__u8  s_disk_version;
> +};

I am wondering, doesn't minix filesystems have on-disk byteorder
defined? That is, would __le32 or __be32 be better here?


