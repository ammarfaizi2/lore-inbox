Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135550AbRDXLmu>; Tue, 24 Apr 2001 07:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135548AbRDXLmk>; Tue, 24 Apr 2001 07:42:40 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:29159 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S135550AbRDXLm2>; Tue, 24 Apr 2001 07:42:28 -0400
Message-ID: <3AE56615.C53CE33A@pp.inet.fi>
Date: Tue, 24 Apr 2001 14:40:05 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Valerio Riedel <hvr@gnu.org>
CC: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org, ak@suse.de,
        axboe@suse.de, astor@fast.no
Subject: Re: Announce: cryptoapi-2.4.3 [aka international crypto (non-)patch]
In-Reply-To: <200104231433.QAA05348@phobos.hvrlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Valerio Riedel wrote:
> short version:
>    this is the international crypto patch, which is built outside of
>    the kernel source tree. you don't even have to reboot (unless your
>    kernel didn't have loop devices enabled, or some other unthought
>    situation exists... :)
> 
> As a response to Jari's loop-AES crypto filter for the loop back
> device, which claims to be hassle free since no kernel modification is
> needed; I've repackaged the all known international crypto patch,
> which according to some people suffers from the need to patch the
> kernel in order to make use of it and thus may not be ever get into
> the kernel since there are still some countries where laws don't
> support an individuals need for privacy.
> 
> This (re)package has only one major drawback, crypto can only built as
> modules so far and it supports only kernel 2.4.3 and later so far...

linux-2.4.3-cryptoapi-hvr4/drivers/block/loop.c lines 270...279 after your
kernel patch:

static int lo_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
{
	char *kaddr;
	unsigned long count = desc->count;
	struct lo_read_data *p = (struct lo_read_data*)desc->buf;
	struct loop_device *lo = p->lo;
	unsigned long IV = loop_get_iv(lo, (page->index * PAGE_CACHE_SIZE + offset - lo->lo_offset) >> LO_IV_SECTOR_BITS);
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	if (size > count)
		size = count;

Have you tested that code with partitions or files that are larger than
4 gigs? On systems where int is 32 bits, that computation overflows.

If you want 512 byte based IV computation without modifying your kernel at
all, you can use the loop.o module from my loop-AES package. I haven't tried
using your modules based cryptoapi and my loop-AES drivers together, but I
don't see any obvious reason why they couldn't be used simultaneously.

My loop-AES package is here:

    http://members.surfeu.fi/ce6c8edf/loop-AES-v1.1b.tar.bz2
    md5sum 61e521a383ce9a90c3f7b98bcf789813

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
