Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263340AbRF0Pym>; Wed, 27 Jun 2001 11:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263416AbRF0Pyc>; Wed, 27 Jun 2001 11:54:32 -0400
Received: from geos.coastside.net ([207.213.212.4]:51389 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S263340AbRF0PyW>; Wed, 27 Jun 2001 11:54:22 -0400
Mime-Version: 1.0
Message-Id: <p05100303b75fa2bd0b7a@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.30.0106270925540.13052-100000@biker.pdb.fsc.net>
In-Reply-To: <Pine.LNX.4.30.0106270925540.13052-100000@biker.pdb.fsc.net>
Date: Wed, 27 Jun 2001 08:54:03 -0700
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] proc_file_read() (Was: Re: proc_file_read() question)
Cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Mike Galbraith <mikeg@wen-online.de>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        <Paul.Russell@rustcorp.com.au>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:07 AM +0200 2001-06-27, Martin Wilck wrote:
>On Tue, 26 Jun 2001, Jonathan Lundell wrote:
>
>>  I use the hack myself, to implement a record-oriented file where the
>>  file position is a record number. I could probably live with
>>  PAGE_SIZE, but the current hack works fine with start bigger than
>>  that, and it's possible that someone counts on it.
>
>Ok, let's use PAGE_OFFSET instead of PAGE_SIZE, then (see new patch
>below).
>Unless I'm mislead, legitimate values of "start" as a pointer are always
>larger than that, and I can hardly imagin e a case where the "unsigned
>int" value of start must be greater than PAGE_OFFSET.


PAGE_OFFSET definitely works for me, but a quick scan of the headers 
suggests that non-sun3 m68k builds define PAGE_OFFSET as 0, as does 
s390.

Maybe you want max(PAGE_SIZE, PAGE_OFFSET).

>I insist that relying on the comparison of two pointers is the wrong
>thing. If (as you suggest) the major use of "start" has migrated from the
>original intention to that of the "hack", this should be reflected
>in the interface by making the "start" parameter to read_proc ()
>an unsigned long. Everything else is misleading and error-prone.
>For now, "start" is a char* and should be treated as such.

That's the hack, though. Rusty should chime in, but the implicit 
restriction on start in the original hack (by the time we get to the 
test we're talking about) is that it's either a pointer of the form 
page+offset, where offset < PAGE_SIZE, or it's a (relatively) small 
file offset.

That's a reasonable assumption given that the procedure is 
dynamically allocating page. After all, why would you allocate the 
buffer and then not use it?

Sure, the overloading is self-admittedly hacky, but (again I assume) 
the motivation was to avoid breaking the clients, many of which are 
not in the kernel.org tree. Your proposed change overloads a third 
interpretation on start, namely an arbitrary pointer, outside the 
page allocation.

>  > But if you're allocating your own buffer, you'd probably be better
>>  off writing your own file ops, and not using the default
>>  proc_file_read() at all. At the very least you'd save a redundant
>>  __get_free_page/free_page pair.
>
>That's right, but nevertheless (repeat) comparing "start" and "page" is
>wrong.

Not given the implied restriction that, if start is a pointer at all, 
it's a pointer within page's allocation. And after all, PAGE_OFFSET 
is effectively a pointer.
-- 
/Jonathan Lundell.
