Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSJOUoQ>; Tue, 15 Oct 2002 16:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbSJOUoP>; Tue, 15 Oct 2002 16:44:15 -0400
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:58014 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S264724AbSJOUoO>; Tue, 15 Oct 2002 16:44:14 -0400
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200210152046.WAA17684@faui11.informatik.uni-erlangen.de>
Subject: Re: s390x build warnings from <linux/module.h>
To: kai@tp1.ruhr-uni-bochum.de
Date: Tue, 15 Oct 2002 22:46:48 +0200 (MET DST)
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:

>Makes me wonder how you deal with function pointers, where the functions 
>are possibly in a module - guess you have to use full 64 bit there? 

Indirect calls on s390x go like this: load 64-bit target address
into a register, call to the address in that register.

Direct calls go like this: call to the address that results from
adding this immediate 32-bit offset to the current instruction
address.

So function pointers are no problem, calls via the GOT are also no
problem (as the GOT basically just holds function pointers), but
direct calls without -fpic can't span more than 4 GB.

>Doesn't it possibly make sense to hack module loading to put modules into 
>< 4 GB as well, so you can use 32bit everywhere?

Possibly; but just using -fpic was simple and worked ...

I'm not quite sure how to muck with the initial memory mapping
to free up a suitable range of addresses where to place the modules.
What happens to the physical memory that is already there?

>I still don't see why someone would want to muck with modifying .text in a
>shared lib, and I'm pretty sure that __ksymtab  ***apart from the initial
>relocation*** should not need further modification

Well, modified is modified, even if only once ;-)  If the section
were mapped read-only, the dynamic linker couldn't apply the relocation.
(At least on some platforms I guess; on Linux it would actually work
because ld.so is playing mprotect games in such cases.)

B.t.w. .text is still read-only (because there are no relocation to
the .text section of proper -fpic code).

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
