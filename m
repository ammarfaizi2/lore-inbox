Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264785AbSLJUlO>; Tue, 10 Dec 2002 15:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSLJUlN>; Tue, 10 Dec 2002 15:41:13 -0500
Received: from [66.70.28.20] ([66.70.28.20]:6916 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S264785AbSLJUlM>; Tue, 10 Dec 2002 15:41:12 -0500
Date: Tue, 10 Dec 2002 21:50:45 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK-2.4] [Patch] Small do_mmap_pgoff correction
Message-ID: <20021210205045.GB63@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi David :)

>    + *	NOTE: in this function we rely on TASK_SIZE being lower than
>    + *	SIZE_MAX-PAGE_SIZE at least. I'm pretty sure that it is.
> This assumption is wrong.

    OK, then another way of fixing the corner case that exists in
do_mmap_pgoff is needed. You cannot mmap a chunk of memory whose size
is bigger than SIZE_MAX-PAGE_SIZE, because 'PAGE_ALIGN' will return 0
when page-aligning the size.

    Anyway you cannot use a size larger than SIZE_MAX-PAGE_SIZE even
on sparc64, since mmap will fail when page aligning such a size,
returning 0 :((( Reverting the change is worse (IMHO).

> Please revert this change, it adds absolutely nothing.

    It corrects the corner case. See below. If you have a better
solution for the corner case problem that doesn't involve limiting
the max size you can request for mmaping so it doesn't get the last
page, it is welcome, of course :))

    The code says:

    if ((len = PAGE_ALIGN(len)) == 0)

    and this returns 0 if the requested size ('len', here) is between
SIZE_MAX-PAGE_SIZE and SIZE_MAX. And this is wrong. Don't know if
under sparc64 the PAGE_ALIGN macro returns correct values, but I
don't think so, since the correct value for an address in the last
page is 0 when page aligned. The problem is that we are aligning a
SIZE, not an address :((

    Maybe a new macro needed here...

    If you want the entire explanation, just tell :) I wrote in the
past for the same patch. Anyway, nor Linus nor Alan did see anything
wrong with this :??

    Raúl
