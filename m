Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315812AbSEJFf0>; Fri, 10 May 2002 01:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315814AbSEJFfZ>; Fri, 10 May 2002 01:35:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15112 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315812AbSEJFfZ>;
	Fri, 10 May 2002 01:35:25 -0400
Message-ID: <3CDB5CC5.2621C68C@zip.com.au>
Date: Thu, 09 May 2002 22:38:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org
Subject: Re: maximum block size in buffer_head
In-Reply-To: <E1762h0-00086K-00@wailua.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> 
> The current Linux kernel (both 2.4.xx and 2.5.xx) declare the b_size
> member in struct buffer_head as an "unsigned short".  This obviously
> limits the maximum block size to something less than 65536.  This is
> bad because on some platforms (e.g., ia64), the page size can be up to
> 64KB large.
> 
> Two questions:
> 
>  - does anyone object to widening b_size to "unsigned int"?

Sounds OK to me for 2.5.

I do have vague plans to remove b_data and to replace all instances
with buffer_data(), which would kmap the page and calculate the address.
Not that I've really thought this through...

This may lead to the introduction of a `b_offset'.  Which would be 16
bits, which would snuggle in with the 16-bit b_size.   But I would
scale both these values by 256 or 512,  for the reasons which you
identify.

For 2.4, a 32-bit b_size would push sizeof(buffer_head) from 96 up
to 100 bytes, which does not pack as well into the slab.  This would
be an intensely unpopular move.  So you'd have to ifdef it.  Which
makes it an ia64-only problem, which greatly improves your merge
chances ;)

>  - does anyone know of any other code paths where the block
>    size is assumed to fit into 16 bits?

Not off the top, but they're probably there.

-
