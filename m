Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266577AbRHAKlH>; Wed, 1 Aug 2001 06:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbRHAKk5>; Wed, 1 Aug 2001 06:40:57 -0400
Received: from fungus.teststation.com ([212.32.186.211]:44813 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S266469AbRHAKko>; Wed, 1 Aug 2001 06:40:44 -0400
Date: Wed, 1 Aug 2001 12:40:36 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.8-pre3 NTFS update (1.1.16)
In-Reply-To: <E15Rn2h-0000E5-00@virgo.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.30.0108011135300.9860-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Anton Altaparmakov wrote:

> - Simplified time conversion functions drastically without
> sacrificing accuracy, now the offending function is 3 lines instead of
> two pages of code. (-8

Does this mean I have to change the code I borrowed?
(Never mind ... :)


> -/* Converts a single wide character to a sequence of utf8 bytes.
> +/*
> + * Converts a single wide character to a sequence of utf8 bytes.
>   * The character is represented in host byte order.
> - * Returns the number of bytes, or 0 on error. */
> -static int to_utf8(ntfs_u16 c, unsigned char* buf)
> + * Returns the number of bytes, or 0 on error.
> + */
> +static int to_utf8(ntfs_u16 c, unsigned char *buf)

How is this different from utf8_wctomb in fs/nls/nls_base.c?
(in purpose)


If it is to allow ntfs_dupuni2utf8 to count the new string length, could
that be done differently? If there is a max allowed length of filenames
the "double parsing" can be avoided.

ntfs_printcb -> ntfs_encodeuni -> ntfs_dupuni2utf8 -> to_utf8

ntfs_dupuni2utf8 does a kmalloc, which is later free'd by ntfs_printcb.
Which in turn is called once for each entry read by ntfs_readdir.

Wouldn't it be nicer to allocate one 255*max_utf8_size buffer in
ntfs_readdir and use that for all entries. Assuming 255 is the upper limit
on NTFS filename length, as I read somewhere.


smbfs does something like this, except it allocates a buffer at mount time
(which works since it is only used while protected by a per-mount lock).

/Urban

