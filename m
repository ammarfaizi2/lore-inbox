Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264760AbSJVQVx>; Tue, 22 Oct 2002 12:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264762AbSJVQVx>; Tue, 22 Oct 2002 12:21:53 -0400
Received: from trillium-hollow.org ([209.180.166.89]:27786 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S264760AbSJVQVw>; Tue, 22 Oct 2002 12:21:52 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
cc: landley@trommello.org, Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux) 
In-Reply-To: Your message of "22 Oct 2002 10:02:03 MDT."
             <m11y6itqbo.fsf@frodo.biederman.org> 
Date: Tue, 22 Oct 2002 09:27:55 -0700
From: erich@uruk.org
Message-Id: <E1841sp-000270-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ebiederm@xmission.com (Eric W. Biederman) wrote:

> In the process of setting up hooks, I have run across a very interesting
> data point.  If I load %ds, %es, %ss in my hook the problem goes away.
> But I must load all 3.
> 
> Given that the code sequence that is executed if my hook is not run is:
> 
> 	cld
> 	cli
> 	movl $(__KERNEL_DS),%eax
> 	movl %eax,%ds
> 	movl %eax,%es
> 	movl %eax,%fs
> 	movl %eax,%gs
> 
> 	lss stack_start,%esp
> 
> I am rather confused.  I am not changing the gdt or anything like that so it
> appears I may have found a way to tickle a processor errata.

I kind of doubt you found an errata...  the mode switch combinations in most
of the modern x86-variants has been tested pretty exhaustively because
people use so many variations on it.

Let's see:

%ds and %es are implicit operands for the source and destination of a
MOVS operation, so if you or the Linux kernel performs a MOVS copy
before that point, that is likely the problem there.

The requirement of %ss is a bit more puzzling, but are you 100% sure
you don't reference the stack anywhere?  Else it may blow up.

For example, the start sequence calls "cli", but do you have interrupts
disabled before that point?  Maybe you have a stray interrupt catching
you there...

I had to deal with these problems, and had exactly something like the
last case, in my early work on the GRUB bootloader.

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
