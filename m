Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVAaRbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVAaRbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVAaRbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:31:53 -0500
Received: from [195.23.16.24] ([195.23.16.24]:20126 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261275AbVAaRbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:31:09 -0500
Message-ID: <41FE6B42.7010807@grupopie.com>
Date: Mon, 31 Jan 2005 17:30:42 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
References: <2.416337461@selenic.com> <1107191783.21706.124.camel@winden.suse.de>
In-Reply-To: <1107191783.21706.124.camel@winden.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:
> [...]
> 
> static inline void swap(void *a, void *b, int size)
> {
>         if (size % sizeof(long)) {
>                 char t;
>                 do {
>                         t = *(char *)a;
>                         *(char *)a++ = *(char *)b;
>                         *(char *)b++ = t;
>                 } while (--size > 0);
>         } else {
>                 long t;
>                 do {
>                         t = *(long *)a;
>                         *(long *)a = *(long *)b;
>                         *(long *)b = t;
>                         size -= sizeof(long);
>                 } while (size > sizeof(long));

You forgot to increment a and b, and this should be "while (size);", no?

>         }
> }

Or better yet,

static inline void swap(void *a, void *b, int size)
{
	long tl;
         char t;

	while (size >= sizeof(long)) {
                 tl = *(long *)a;
                 *(long *)a = *(long *)b;
                 *(long *)b = tl;
		a += sizeof(long);
		b += sizeof(long);
                 size -= sizeof(long);
	}
	while (size) {
                 t = *(char *)a;
                 *(char *)a++ = *(char *)b;
                 *(char *)b++ = t;
		size--;
         }
}

This works better if the size is not a multiple of sizeof(long), but is 
bigger than a long.

However it seems that this should be put in a generic library function...

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
