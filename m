Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268942AbTBZVYG>; Wed, 26 Feb 2003 16:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268944AbTBZVYF>; Wed, 26 Feb 2003 16:24:05 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:52164 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S268942AbTBZVXz>; Wed, 26 Feb 2003 16:23:55 -0500
Subject: Re: Invalid compilation without -fno-strict-aliasing
From: Albert Cahalan <albert@users.sf.net>
To: root@chaos.analogic.com
Cc: Daniel Jacobowitz <dan@debian.org>, jt@hpl.hp.com,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Jouni Malinen <jkmaline@cc.hut.fi>
In-Reply-To: <Pine.LNX.3.95.1030226151646.5261A-100000@chaos>
References: <Pine.LNX.3.95.1030226151646.5261A-100000@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 26 Feb 2003 16:30:29 -0500
Message-Id: <1046295029.1090.122.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 15:19, Richard B. Johnson wrote:
> On Wed, 26 Feb 2003, Daniel Jacobowitz wrote:

>>> It was supposed to force x, which may be cached in a register,
>>> to be written to memory __now__. It doesn't seem to do anything.
>>> I think FORCE_TO_MEM() needs to claim that it uses most all the
>>> registers. That will make sure that any register values get
>>> written to their final memory locations.
>>
>> If so it wouldn't be inside the #APP/#NOAPP markers.  You didn't
>> answer my other question: was X in memory at the time?
>
> It was in %ebx register and didn't go back to NNN(%esp) where
> it came from. Like I said, it did do anything.
>
>> You should be using something like __asm__ __volatile__ (""::"m"(x))
>> anyway.
>
> Yep. Probably.

I wrote that from my memory and gcc documentation. With none
of my 3 compilers did I see the sample code failing, so I
wasn't able to perform a useful test. There may be some little
detail I missed.

I've had the code working, with gcc 3.0 I'd guess, on both
PowerPC and something strange. The code relies on "r" being
a suitable register; this might only be true for common RISC
architectures. So this is semi-portable code, able to be used
where the gcc porter followed the suggestion to use "r" as
the normal sort of register. Since x86 is notably lacking in
the concept of general purpose registers, the above might not
apply.

Add :"memory" (a clobber) on the end if you want to be brutal.
This may produce slower code though.

The basic idea is to convince gcc that some assembly code
will access the data via a pointer. Probably somebody else
has already posted a fixed version.

With a recent gcc, look into the __may_alias__ attribute.

This kind of stuff sure is poorly documented, isn't it?
Has anybody ever seen a reasonable explanation of the new
C99 restrict keyword, including scope interactions? How
about a list of gcc bugs in this area? Even with a recent
gcc, control over aliasing is really crude. I ought to be
able to specify a list of types and objects that do or do
not alias, with each other or with the first one specified.



