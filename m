Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266462AbUAIJrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 04:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUAIJrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 04:47:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39124 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266462AbUAIJrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 04:47:01 -0500
Date: Fri, 9 Jan 2004 04:46:46 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] variable size and signedness issues in ldt.c -
 potential problem?
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BC074AFBC9@difpst1a.dif.dk>
Message-ID: <Pine.LNX.4.58.0401090440180.27298@devserv.devel.redhat.com>
References: <8A43C34093B3D5119F7D0004AC56F4BC074AFBC9@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Jan 2004, Jesper Juhl wrote:

> I'm hunting the kernel source for any potential problem I can find (and
> hopefully fix), and I've come across something that looks like a
> possible problem in arch/i386/kernel/ldt.c
> 
> First thing that looks suspicious is this bit in read_ldt() :
> 
>         for (i = 0; i < size; i += PAGE_SIZE) {
> 		...
> 	}
> 
> 'i' is a plain int while 'size' is an 'unsigned long' leaving the
> possibility that if size contains a value greater than what a signed int
> can hold then this code won't do the right thing, either 'i' will wrap
> around to zero and the loop will never exit or something "unknown" will
> happen (as far as I know, what happens when an int overflows is
> implementation defined). [...]

but the user does not control 'newsize'. Can you outline a scenario in 
where the value could overflow?

> The second thing is that in the body of the 'for' loop there is this
> comparison :
> 
> if (bytes > PAGE_SIZE)

no, the value of bytes is really limited. Again, can you suggest a
scenario in where this could overflow?

> I know that the only user of read_ldt() and write_ldt() is
> sys_modify_ldt() , and the arguments for read_ldt and write_ldt thus
> have to match sys_modify_ldt, but why is the 'bytecount' argument for
> sys_modify_ldt an 'unsigned long' and the return type an 'int' ? The
> signedness of the return type makes sense given that it't supposed to
> return -1 on error. But on success, in the case where it calls read_ldt,
> it's supposed to return the actual number of bytes read. But if the
> number of bytes to read is given as an unsigned long, and the number
> actually read exceeds the size of a signed int then the return value
> will get truncated upon return - how can that be right? [...]

LDT size is limited by LDT_ENTRY_SIZE*LDT_ENTRIES. We explicitly truncate
bytecount to this range so unsigned vs. signed makes no difference.

> [...] And if the return value can never exceed what a signed int can
> hold, then why is it possible to request an unsigned long amount of
> bytes to read in the first place?

that's quite common for the interface definitions. Since we are on x86
unsigned long == unsigned int.

> and finally a purely style related thing (sure, call me pedantic); in both
> read_ldt() and write_ldt() 'mm' is declared as
> 
> struct mm_struct * mm = current->mm;

yep, you are right, this is the wrong style.

	Ingo
