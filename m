Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTFXKOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTFXKOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:14:14 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:36838 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261808AbTFXKOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:14:12 -0400
Date: Tue, 24 Jun 2003 03:29:04 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: Provide example copy_in_user implementation
Message-Id: <20030624032904.13213eb8.akpm@digeo.com>
In-Reply-To: <20030624100610.GC159@elf.ucw.cz>
References: <20030624100610.GC159@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jun 2003 10:28:20.0683 (UTC) FILETIME=[556771B0:01C33A3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> +static inline unsigned long copy_in_user(void *dst, const void *src, unsigned size) 
>  +{ 
>  +	unsigned i, ret;
>  +	unsigned char c;
>  +	for (i=0; i<size; i++) {
>  +		if (copy_from_user(&c, src+i, 1)) 
>  +			return size-i;
>  +		if (copy_to_user(dst+i, &c, 1))
>  +			return size-i;
>  +	}
>  +	return 0;
>  +}	
>  +

I know that this is usually not performance critical, but by gawd that code
is inefficient and bloaty.

It has 18 callsites; it can be put in lib/lib.a:copy_in_user.o.  The
access_ok() checks only need to be run once.  It can copy a cacheline at a
time.
