Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268958AbTCBGCK>; Sun, 2 Mar 2003 01:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268998AbTCBGCK>; Sun, 2 Mar 2003 01:02:10 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:14347 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268958AbTCBGCJ>;
	Sun, 2 Mar 2003 01:02:09 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots) 
In-reply-to: Your message of "Thu, 27 Feb 2003 10:50:56 -0800."
             <20030227105056.3fd76ac6.rddunlap@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 02 Mar 2003 17:12:19 +1100
Message-ID: <22612.1046585539@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
> A sorted list of bad stack users (more than 256 bytes) in my default build
> follows. Anybody can create their own with something like
> 
> 	objdump -d linux/vmlinux |
> 		grep 'sub.*$0x...,.*esp' |
> 		awk '{ print $9,$1 }' |
> 		sort > bigstack
> 
> and a script to look up the addresses.
> 
> Yeah, and this assumes we don't have alloca() users or other dynamic 
> stack allocators (non-constant-size automatic arrays). I hope we don't 
> have that kind of crap anywhere..

We do.

kernel.stack identifies big offenders, dynamic stacks and tells you
which procedure is at fault.  This must be at least the fifth time I
have published this script.

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
#	/^[89a-f].......$/d;   Ignore lines with 8 digit offsets that are 
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

