Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSGCPuk>; Wed, 3 Jul 2002 11:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSGCPuk>; Wed, 3 Jul 2002 11:50:40 -0400
Received: from h-64-105-34-244.SNVACAID.covad.net ([64.105.34.244]:17073 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317054AbSGCPui>; Wed, 3 Jul 2002 11:50:38 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 3 Jul 2002 08:53:03 -0700
Message-Id: <200207031553.IAA04513@adam.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: Rusty's module talk at the Kernel Summit
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jul 2002 22:27:33 +1000, Keith Owens wrote:
>On Wed, 3 Jul 2002 00:31:35 -0700, 
>"Adam J. Richter" <adam@yggdrasil.com> wrote:
>>      As individual space optimizations go, 4% is respectable,
>>especially for something that has no cost

>It is not at no cost.  Getting 4% requires arch dependent code to
>handle all the tables that are affected by partial text removal.  I can
>get 2% for nothing by discarding data.init.  Discarding text.init is a
>lot harder.
[...]
>The problem is the partial removal of code when there are tables that
>point to _all_ the code.  Partial code removal requires a lot of work
>to adjust every table that refers to code and correct them.  To make it
>worse, the tables are arch specific.  Most architectures have
>__ex_table, with different formats for each arch.  Some have unwind
>data, always arch dependent format.  MIPS has dbe.

>Data is not referenced by any of these tables so a partial discard of
>data is easy, no side effects to worry about.

	OK, I agree that anyone wanting to implement discarding of
some module init sections would be best off to start with .init.data.

	I don't know enough about the formats of these tables right now
to really understand the best way to handle them, but I suspect that
the simplest approach might be a mechanism where copy_*_user and the like
could generate assembler that does a .pushsection to a different section
depending on the current section, so you could have "__ex_table" and
".init.__ex_table", etc.  Then it might be possible to deal with these
sections in a way that is not architecture specific, and be able
to discard the obselete parts of these tables after the init code
has completed.  However, this would probably require a gas or gcc
extension.

[...]
>>	As I understand it, __ex_table is just for copy_{to,from}_uesr,
>>which would almost never be done from init sections

>__ex_table is used for any code that requires recovery.  Mainly
>copy..user but not exclusively.

>>The core kernel already deals with the same issue.

>It does not.  There is no code to adjust any tables after discarding
>kernel __init sections.  We rely on the fact that the discarded kernel
>area is not reused for executable text.

	Come to think of it, if the core kernel's .text.init pages could
later be vmalloc'ed for module .text section, then I think you may have
found a potential kernel bug.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
