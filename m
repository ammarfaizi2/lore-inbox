Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932724AbVJ2XU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbVJ2XU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 19:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVJ2XU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 19:20:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14013 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932724AbVJ2XU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 19:20:56 -0400
Date: Sun, 30 Oct 2005 01:20:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
Subject: Re: [RFC][PATCH 3/6] swsusp: introduce the swap map structure and interface functions
Message-ID: <20051029232031.GF14209@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <200510292232.35403.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510292232.35403.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Index: linux-2.6.14-rc5-mm1/kernel/power/snapshot.c
> ===================================================================
> --- linux-2.6.14-rc5-mm1.orig/kernel/power/snapshot.c	2005-10-29 13:24:56.000000000 +0200
> +++ linux-2.6.14-rc5-mm1/kernel/power/snapshot.c	2005-10-29 14:11:17.000000000 +0200
> +
> +unsigned snapshot_pages_to_save(void)
> +{
> +	return nr_copy_pages + nr_pb_pages;
> +}
> +
> +unsigned snapshot_image_pages(void)
> +{
> +	return nr_copy_pages;
> +}
> +
> +static unsigned current_page = 0;
> +static struct pbe *current_pbe;
> +static struct pbe *current_pblist;
> +
> +void snapshot_send_init(void)
> +{
> +	current_page = 0;
> +	current_pbe = pagedir_nosave;
> +	current_pblist = NULL;
> +}
> +
> +static void prepare_next_pb_page(unsigned long *buf)
> +{
> +	struct pbe *p;
> +	unsigned n;
> +
> +	p  = current_pbe;
> +	for (n = 0; n < PAGE_SIZE/sizeof(long) && p; n++) {
> +		buf[n] = p->orig_address;
> +		p = p->next;
> +	}
> +	current_pbe = p;
> +}
> +
> +int snapshot_send_page(void *buf)
> +{
> +	if (current_page >= nr_copy_pages + nr_pb_pages)
> +		return -EINVAL;
> +	if (current_page < nr_pb_pages) {
> +		prepare_next_pb_page(buf);
> +		if (!current_pbe)
> +			current_pbe = pagedir_nosave;
> +	} else {
> +		memcpy(buf, (void *)current_pbe->address, PAGE_SIZE);
> +		current_pbe = current_pbe->next;
> +	}
> +	current_page++;
> +	return 0;
> +}
> +
> +int snapshot_recv_init(unsigned nr_pages, unsigned img_pages)
> +{
> +	struct pbe *pblist;
> +
> +	if (nr_pages <= img_pages)
> +		return -EINVAL;
> +	/* We have to create a PBE list here */
> +	pblist = alloc_pagedir(img_pages);
> +	if (!pblist)
> +		return -ENOMEM;
> +	create_pbe_list(pblist, img_pages);
> +	current_pblist = pblist;
> +	current_pbe = pblist;
> +	current_page = 0;
> +	nr_copy_pages = img_pages;
> +	nr_pb_pages = nr_pages - img_pages;
> +	return 0;
> +}
> +
> +static void load_next_pb_page(unsigned long *buf)
> +{
> +	struct pbe *p;
> +	unsigned n;
> +
> +	p  = current_pbe;
> +	for (n = 0; n < PAGE_SIZE/sizeof(long) && p; n++) {
> +		p->orig_address = buf[n];
> +		p = p->next;
> +	}
> +	current_pbe = p;
> +}
> +
> +int snapshot_recv_page(void *buf)
> +{
> +	if (!current_pblist ||
> +	    current_page >= nr_copy_pages + nr_pb_pages)
> +		return -EINVAL;
> +	if (current_page < nr_pb_pages) {
> +		load_next_pb_page(buf);
> +		if (!current_pbe) {
> +			current_pblist = relocate_pbe_list(current_pblist);
> +			if (!current_pblist) {
> +				printk(KERN_ERR "\nswsusp: Not enough memory for relocating PBEs\n");
> +				return -ENOMEM;
> +			}
> +			current_pbe = current_pblist;
> +		}
> +	} else {
> +		current_pbe->address = get_safe_page(GFP_ATOMIC);
> +		if (!current_pbe->address) {
> +			printk(KERN_ERR "\nswsusp: Not enough memory for the image\n");
> +			return -ENOMEM;
> +		}
> +		memcpy((void *)current_pbe->address, buf, PAGE_SIZE);
> +		current_pbe = current_pbe->next;
> +	}
> +	current_page++;
> +	return 0;
> +}
> +
> +int snapshot_finish(void)
> +{
> +	if (current_pbe)
> +		return -EINVAL;
> +	current_page = 0;
> +	if (current_pblist)
> +		pagedir_nosave = current_pblist;
> +	current_pblist = NULL;
> +	return 0;
> +}

No, sorry, I don't like that. I like existing interface better. It
should be something like...

system_snapshot(), returns structure to save and nr_pages.

system_restore() takes struct pbe * (or something like that) and
nr_pages, and takes care. 

snapshot_send_init()...snapshot_finish() interface is too complex in
my eyes, and will be hard to get right.
							Pavel
-- 
Thanks, Sharp!
