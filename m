Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbREVRtr>; Tue, 22 May 2001 13:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbREVRth>; Tue, 22 May 2001 13:49:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:3332 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262692AbREVRt2>; Tue, 22 May 2001 13:49:28 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [patch] s_maxbytes handling
Date: 22 May 2001 10:49:12 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9ee8qo$jgk$1@penguin.transmeta.com>
In-Reply-To: <3B0A7C0F.C824FDB5@uow.edu.au> <E152Dik-00021y-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E152Dik-00021y-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> > verification tests. So unless you can cite page and paragraph from SuS and
>> > the LFS spec I think the 0 might in fact be correct..
>> 
>> I don't know the standards Alan, but returning zero
>> from write() when f_pos is at s_maxbytes will make
>> a lot of apps hang up.  dd, bash and zsh certainly do.
>
>> Are they buggy?  Should they be testing the return value
>> of write() and assuming that zero is file-full?
>
>0 is an EOF.

0 is EOF _for_reads_. For writes it is not very well defined (except for
the special case of a zero-sized write to a regular file).

For writes, 0 has historically been what Linux has returned for various
"disk full" conditions, and seems to be what programs such a "tar"
actually expected for end of disk.  Also, traditionally a lot of UNIXes
returned 0 when O_NDELAY was set and they couldn't write anything (ie
the modern EAGAIN). 

An application seeing a zero return from a write with a non-zero buffer
size cannot really assume much about what it means. The best you can
probably do is to fall back and say "no more space on device", but
obviously a lot of programmers who are used to testing only for _real_
errors will not even think about considering 0 an error value.

So returning 0 for write() is usually a bad idea - exactly because it
does not have very well-defined semantics.  So -EFBIG is certainly the
preferable return value, and seems to be what SuS wants, too. 

		Linus
