Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbULQO6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbULQO6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 09:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbULQO6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 09:58:51 -0500
Received: from alog0049.analogic.com ([208.224.220.64]:32384 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261236AbULQO6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 09:58:38 -0500
Date: Fri, 17 Dec 2004 09:56:52 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: firnnauriel <rinoa012000@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: bcopy and page faults 
In-Reply-To: <200412171353.iBHDrueP007296@laptop11.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.61.0412170942590.19463@chaos.analogic.com>
References: <200412171353.iBHDrueP007296@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004, Horst von Brand wrote:

> firnnauriel <rinoa012000@yahoo.com> said:
>> In general, is there a correlation between the number
>> of page faults occurred in the system and bcopy's
>> performance?
>
> No.
>
>>               If the page fault is high, will the
>> bcopy's performance become slower? Kindly enlighten me
>> on this. If you can provide a URL that will support
>> your answer, I will really appreciate it. Thank you
>> very much!
>
> bcopy(3) copies stuff inside a process. If the memory areas copied from/to
> are available in RAM, the copy will go at full speed. If not, there will be
> delays (due to paging, etc). Now, the system might be paging like mad, but
> the memory _this_ process requires is available (== full speed bcopy), or
> there might be almost no paging activity, but the pages required for the
> copy aren't in RAM (== slowest possible).
>
> PS: Consider using memcpy(3), bcopy is non-standard.
> -- 
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

FYI `bcopy()` can copy overlapping buffers. It does this by
determining if the destination buffer is higher or lower than
the source buffer. If it's higher, it's an ordinary memcpy()
if it's lower, it copies backwards so that it doesn't end up
copying what was just copied, etc., the result being junk.

Both can cause page-faulting if the buffers are not in
memory. Because bcopy() has some additional starting logic,
it might be slower. Some POSIX man-pages claim that it's
deprecated and one should use memmove() instead. The Linux
man page claims one should use memcpy(), but this is wrong
because memcpy cannot successfully copy overlapping buffers.

So, if the buffers overlap, use memmove(). If not use memcpy().
This different usage might alert people who look at the code
in the future that there was some special reason for using
memmove().

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
