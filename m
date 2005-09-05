Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVIEJMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVIEJMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVIEJMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:12:50 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:45325 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932354AbVIEJMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:12:50 -0400
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: <tachades@cecs.pdx.edu>, <linux-kernel@vger.kernel.org>,
       Wolfram.Gloger@dent.med.uni-muenchen.de
Subject: Re: kernel 2.6.13 - space not freed to kernel
References: <1125688240.4318a3b02f418@webmail.cecs.pdx.edu>
	<Pine.LNX.4.61.0509021520140.4285@chaos.analogic.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: ed  ::  20-megaton hydrogen bomb : firecracker
Date: Mon, 05 Sep 2005 10:10:50 +0100
In-Reply-To: <Pine.LNX.4.61.0509021520140.4285@chaos.analogic.com> (linux-os@analogic.com's
 message of "2 Sep 2005 20:30:03 +0100")
Message-ID: <87wtlvhobp.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Sep 2005, linux-os@analogic.com murmured woefully:
> The usual malloc() never resets the break address or remaps memory
> because it is an expensive operation. This means that when new
> data space needs to be allocated, malloc() doesn't have to get
> anything from the kernel because it already has, probably, all
> that it needs.
> 
> The only way memory will be 'returned' is when your program
> calls exit() or otherwise ceases to exist.

This is wrong and has been wrong for a very long time (at least
throughout the glibc2 and libc5 eras).

As the comments at the top of
<http://sourceware.org/cgi-bin/cvsweb.cgi/libc/malloc/malloc.c?rev=1.148&content-type=text/x-cvsweb-markup&cvsroot=glibc>
make clear, and as even the malloc documentation in glibc
says in less detail, glibc malloc() suballocates the brk area
for small chunks only, and shrinks that area when possible;
for large allocations, it uses mmap(). In that situation,
the memory can indeed be freed immediately.

(Why can't malloc allocate suballocatable heaps out of mmap() space? Why
does it use the brk area at all? I hear some of the BSDs are doing this
already, it wouldn't complicate malloc() much that I can see and might
even simplify it in some areas... is it that this would break apps? If
so, those apps are already broken if they're relying on the brk area
being used for allocations, and are definitely far too fragile to
live... I might see if I can modify malloc appropriately and do some
benchmarking.)

-- 
`... published last year in a limited edition... In one of the
 great tragedies of publishing, it was not a limited enough edition
 and so I have read it.' --- James Nicoll
