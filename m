Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262679AbSJWCTQ>; Tue, 22 Oct 2002 22:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbSJWCTP>; Tue, 22 Oct 2002 22:19:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26159 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262679AbSJWCTO>; Tue, 22 Oct 2002 22:19:14 -0400
To: erich@uruk.org
Cc: landley@trommello.org, Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <E1841sp-000270-00@trillium-hollow.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Oct 2002 20:23:28 -0600
In-Reply-To: <E1841sp-000270-00@trillium-hollow.org>
Message-ID: <m1wuo9sxjz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

erich@uruk.org writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> > In the process of setting up hooks, I have run across a very interesting
> > data point.  If I load %ds, %es, %ss in my hook the problem goes away.
> > But I must load all 3.
> > 
> > Given that the code sequence that is executed if my hook is not run is:
> > 
> > 	cld
> > 	cli
> > 	movl $(__KERNEL_DS),%eax
> > 	movl %eax,%ds
> > 	movl %eax,%es
> > 	movl %eax,%fs
> > 	movl %eax,%gs
> > 
> > 	lss stack_start,%esp
> > 
> > I am rather confused.  I am not changing the gdt or anything like that so it
> > appears I may have found a way to tickle a processor errata.
> 
> I kind of doubt you found an errata... 

Me too but the number of remaining possibilities is quite small.

>  the mode switch combinations in most
> of the modern x86-variants has been tested pretty exhaustively because
> people use so many variations on it.
> 
> Let's see:
> 
> %ds and %es are implicit operands for the source and destination of a
> MOVS operation, so if you or the Linux kernel performs a MOVS copy
> before that point, that is likely the problem there.

Nope.  In fact on a another 2.4.17 kernel built with slightly different
options the code works.
 
> The requirement of %ss is a bit more puzzling, but are you 100% sure
> you don't reference the stack anywhere?  Else it may blow up.

Absolutely.
 
> For example, the start sequence calls "cli", but do you have interrupts
> disabled before that point?  Maybe you have a stray interrupt catching
> you there...

Yep.  In fact last I checked I had interrupts disabled at the interrupt
controller as well, but that may not be a certaintly.  But it doesn't matter
as I also have nmi disabled at that point.

> I had to deal with these problems, and had exactly something like the
> last case, in my early work on the GRUB bootloader.

I will certainly take any help people can give.  But I am tickling some
very weird things in there.

Eric
