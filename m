Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422628AbWCIEds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422628AbWCIEds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422630AbWCIEds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:33:48 -0500
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:20136 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1422628AbWCIEds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:33:48 -0500
Date: Wed, 8 Mar 2006 20:33:47 -0800 (PST)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: filldir[64] oddness
In-Reply-To: <20060309042744.GA23148@redhat.com>
Message-ID: <Pine.LNX.4.58.0603082030570.19079@shell3.speakeasy.net>
References: <20060309042744.GA23148@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006, Dave Jones wrote:

> I'm puzzled by an aparent use of uninitialised memory
> that coverity's checker picked up.
>
> fs/readdir.c
>
> #define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
> #define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
>
> 140  	static int filldir(void * __buf, const char * name, int namlen, loff_t offset,
> 141  			   ino_t ino, unsigned int d_type)
> 142  	{
> 143  		struct linux_dirent __user * dirent;
> 144  		struct getdents_callback * buf = (struct getdents_callback *) __buf
> 145  		int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);
>
> How come that NAME_OFFSET isn't causing an oops when
> it dereferences stackjunk->d_name ?

If I had to guess...

Because NAME_OFFSET(de) is essentially doing
	de->d_name - de
which should be equivalent to just the static offset of d_name within
struct linux_direct. Which should be constant, no? Why does it need to
pass a pointer to compute this? Who knows.

> 		Dave
>
> --
> http://www.codemonkey.org.uk

- Vadim Lobanov
