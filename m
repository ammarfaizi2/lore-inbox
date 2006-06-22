Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbWFVViW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbWFVViW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWFVViW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:38:22 -0400
Received: from hera.kernel.org ([140.211.167.34]:5258 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030407AbWFVViV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:38:21 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Is the x86-64 kernel size limit real?
Date: Thu, 22 Jun 2006 14:38:02 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e7f2jq$r17$1@terminus.zytor.com>
References: <20060622204627.GA47994@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1151012283 27689 127.0.0.1 (22 Jun 2006 21:38:02 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 22 Jun 2006 21:38:02 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060622204627.GA47994@dspnet.fr.eu.org>
By author:    Olivier Galibert <galibert@pobox.com>
In newsgroup: linux.dev.kernel
>
> I get bitched at by the build process because the kernel I get is
> around 4.5Mb compressed.  i386 does not have that limitation.
> Interestingly, a diff between the two build.c gives:
> 
> --- ../../../i386/boot/tools/build.c	2006-06-22 20:19:33.000000000 +0200
> +++ build.c	2006-06-22 20:19:33.000000000 +0200
> @@ -70,8 +70,7 @@
>  
>  int main(int argc, char ** argv)
>  {
> -	unsigned int i, sz, setup_sectors;
> -	int c;
> +	unsigned int i, c, sz, setup_sectors;
>  	u32 sys_size;
>  	byte major_root, minor_root;
>  	struct stat sb;
> @@ -150,8 +149,10 @@
>  	sz = sb.st_size;
>  	fprintf (stderr, "System is %d kB\n", sz/1024);
>  	sys_size = (sz + 15) / 16;
> -	if (!is_big_kernel && sys_size > DEF_SYSSIZE)
> -		die("System is too big. Try using bzImage or modules.");
> +	/* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
> +	if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
> +		die("System is too big. Try using %smodules.",
> +			is_big_kernel ? "" : "bzImage or ");
>  	while (sz > 0) {
>  		int l, n;
>  
> 
> which shows two things:
> 1- a8f5034540195307362d071a8b387226b410469f should have a x86-64 version
> 2- the limit looks entirely artificial
> 
> So, is removing the limit prone to bite me?
> 

It turns out x86-64, unlike i386, does still have a hardcoded limit,
but the limit in build.c is wrong:

kernel/head.S:
        /* 40MB kernel mapping. The kernel code cannot be bigger than that.
           When you change this change KERNEL_TEXT_SIZE in page.h too. */
        /* (2^48-(2*1024*1024*1024)-((2^39)*511)-((2^30)*510)) = 0 */

So this should be replaced by KERNEL_TEXT_SIZE in page.h, or better,
this should be done dynamically in x86-64 too.

	-hpa

