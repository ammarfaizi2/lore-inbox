Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270212AbTG1PoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 11:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270214AbTG1PoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 11:44:07 -0400
Received: from adsl-247-226.38-151.net24.it ([151.38.226.247]:30482 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S270212AbTG1PoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 11:44:04 -0400
Date: Mon, 28 Jul 2003 17:59:17 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG SQUISHED] 2.6.0-test1 devfs question
Message-ID: <20030728155917.GA844@renditai.milesteg.arr>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Andrey Borzenkov <arvidjaar@mail.ru>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E19h2CQ-0009YQ-00.arvidjaar-mail-ru@f12.mail.ru> <20030728002216.4c3afb60.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728002216.4c3afb60.akpm@osdl.org>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.21
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 12:22:16AM -0700, Andrew Morton wrote:
> "Andrey Borzenkov" <arvidjaar@mail.ru> wrote:
> >
> > the bug is almost for sure in init/do_mount_devfs.c:read_dir; it
> >  allocates static buffer of size at most 2**MAX_ORDER and tries to
> >  read the whole dir at once.
> 
> Yes, that function is buggy.
> 
> diff -puN init/do_mounts_devfs.c~read_dir-fix init/do_mounts_devfs.c
> --- 25/init/do_mounts_devfs.c~read_dir-fix	2003-07-28 00:21:40.000000000 -0700
> +++ 25-akpm/init/do_mounts_devfs.c	2003-07-28 00:21:40.000000000 -0700
> @@ -54,7 +54,7 @@ static void * __init read_dir(char *path
>  	if (fd < 0)
>  		return NULL;
>  
> -	for (size = 1 << 9; size <= (1 << MAX_ORDER); size <<= 1) {
> +	for (size = 1 << 9; size <= (PAGE_SIZE << MAX_ORDER); size <<= 1) {
>  		void *p = kmalloc(size, GFP_KERNEL);
>  		int n;
>  		if (!p)
> 
> _

This patch solves the problem, the kernel boots fine and finds the root
device using root=/dev/md2 as boot option.

The output during boot is:

[...]
raid1: raid set md2 active with 2 out of 2 mirrors
md: ... autorun DONE.
create_dev: name=/dev/root dev=902 dname=md2
create_dev: found real device /dev/md/2
[...]

Thanks everyone, bye.

-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/

