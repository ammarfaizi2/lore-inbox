Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318642AbSH1DwH>; Tue, 27 Aug 2002 23:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318643AbSH1DwH>; Tue, 27 Aug 2002 23:52:07 -0400
Received: from zok.SGI.COM ([204.94.215.101]:53710 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S318642AbSH1DwF>;
	Tue, 27 Aug 2002 23:52:05 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Functions with Large Stack Usage 
In-reply-to: Your message of "27 Aug 2002 14:08:24 -0400."
             <1030471704.1610.47.camel@wiley> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Aug 2002 13:56:17 +1000
Message-ID: <4003.1030506977@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Aug 2002 14:08:24 -0400, 
Danny Cox <danscox@mindspring.com> wrote:
>	After having read of the stack overflow "issues" awhile back, a couple
>of ideas gelled, with this script as a result.  The script finds
>functions that use a large (changeable) amount of stack space.  Note:
>it's heuristic, it's static, it only looks at compiled-in functions, and
>says nothing about the dynamic system.  It DOES point out functions that
>may (MAY) need to be examined closer.
>...
>	How it works:  With Keith Owens' KDB patch, one may compile the kernel
>with frame pointers.  With the Disassemble::X86 Perl module from CPAN
>(http://search.cpan.org/author/BOBMATH/Disassemble-X86-0.12/X86.pm),
>it's easy.  It requires the vmlinux and System.map files, and for each
>function looks at the first 10 instructions for the 'sub esp,N'.  The N
>is the number of bytes of stack used.

No need for frame pointers, or Perl.  Run as

  kernel.stack vmlinux $(/sbin/modprobe -l)

#!/bin/bash
#
#	Run a compiled ix86 kernel and print large local stack usage.
#
#	/>:/{s/[<>:]*//g; h; }   On lines that contain '>:' (headings like
#	c0100000 <_stext>:), remove <, > and : and hold the line.  Identifies
#	the procedure and its start address.
#
#	/subl\?.*\$0x[^,][^,][^,].*,%esp/{    Select lines containing
#	subl\?...0x...,%esp but only if there are at least 3 digits between 0x and
#	,%esp.  These are local stacks of at least 0x100 bytes.
#
#	s/.*$0x\([^,]*\).*/\1/;   Extract just the stack adjustment
#	/^[89a-f].......$/d;   Ignore line with 8 digit offsets that are 
#	negative.  Some compilers adjust the stack on exit, seems to be related
#	to goto statements
#	G;   Append the held line (procedure and start address).
#	s/\(.*\)\n.* \(.*\)/\1 \2/;  Remove the newline and procedure start 
#	address.  Leaves just stack size and procedure name.
#	p; };   Print stack size and procedure name.
#
#	/subl\?.*%.*,%esp/{   Selects adjustment of %esp by register, dynamic 
#	arrays on stack.
#	G;   Append the held line (procedure and start address).
#	s/\(.*\)\n\(.*\)/Dynamic \2 \1/;   Reformat to "Dynamic", procedure 
#	start address, procedure name and the instruction that adjusts the
#	stack, including its offset within the proc.
#	p; };   Print the dynamic line.
#
#
#	Leading spaces in the sed string are required.
#
objdump --disassemble "$@" | \
sed -ne '/>:/{s/[<>:]*//g; h; }
 /subl\?.*\$0x[^,][^,][^,].*,%esp/{
 s/.*\$0x\([^,]*\).*/\1/; /^[89a-f].......$/d; G; s/\(.*\)\n.* \(.*\)/\1 \2/; p; };
 /subl\?.*%.*,%esp/{ G; s/\(.*\)\n\(.*\)/Dynamic \2 \1/; p; }; ' | \
sort

