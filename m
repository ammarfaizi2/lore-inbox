Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291704AbSBHS2y>; Fri, 8 Feb 2002 13:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291707AbSBHS2p>; Fri, 8 Feb 2002 13:28:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:20864 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S291704AbSBHS22>; Fri, 8 Feb 2002 13:28:28 -0500
Date: Fri, 8 Feb 2002 13:29:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Arjan van de Ven <arjanv@redhat.com>
cc: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] larger kernel stack (8k->16k) per task
In-Reply-To: <3C640994.F3528E74@redhat.com>
Message-ID: <Pine.LNX.3.95.1020208123843.1974A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Arjan van de Ven wrote:

> Tigran Aivazian wrote:
> > 
> > On Fri, 8 Feb 2002, Arjan van de Ven wrote:
> > > If you need even more in your code (I assume you do otherwise you wouldn't
> > > have done the work) then I really suggest you take a long hard look and fix
> > > the obvious bugs or the design....
> > 
> > Arjan, I completely agree with you, but please do not overlook one obvious
> > thing -- sometimes (well, most of the time) in order to fix those stack
> > corruption issues you _first_ need to apply this patch and then it becomes
> > obvious that the reason for this "random" corruption is the stack
> 
> Well, there's also a simple script you can run on the vmlinux to catch
> big offenders....
> I can even see the point of running that at the end of "make bzImage"
> and abort or
> at least seriously warn if there are offenders that, say, allocate more
> than 2Kb of stackspace.

Could someone please tell me why you should make a function call to
allocate, and then later on free, some temporary space for variables
when allocation on the stack involves simply subtracting a value,
calculated by the compiler at compile-time, from the stack-pointer?

I think it is entirely inefficient to call an external procedure
for temporary variable space when the actual math is done by the
compiler at compile time, and the code is a simple subtraction, then
later-on a simple addition to a single register!


This is an Intel example. The same applies for other machines, but
the syntax is different. The simplified clock calculation assumes
that a long-word operation on memory uses 4 clocks and a register
operation uses 2 clocks. This is about 90 percent accurate in spite
of the many exceptions with Intel Processors.

Local variable allocation, 4 clocks.

funct:	pushl	%ebx	# Save registers that must be preserved.
	pushl	%esi
	pushl	%edi
	subl	$LOCAL_SPACE, %esp	# Allocation for local variables
					# 2 clocks.
	.......
	.......		# Do stuff.
	.......

	addl	$LOCAL_SPACE, %esp	# 2 clocks
	popl	%edi	# Restore registers that you saved
	popl	%esi
	popl	%ebx
	ret

Remote allocation:

funct:	pushl	%ebx
	pushl	%esi
	pushl	%edi
	subl	$SPACE_FOR_POINTER, %esp         # 2 clocks
	pushl	DATA_LENGTH                      # 4 clocks
	pushl	DATA_TYPE                        # 4 clocks
	call	kmalloc	                         # 8 + kmalloc clocks
	addl	$8, %esp	# Level stack    # 2 clocks
	orl	%eax,%eax	# Check for NULL # 2 clocks
	jz	failed		# kmalloc failed # Not taken
	movl	%eax, (%esp)	# Save pointer   # 4 clocks
	......
	......		# Do stuff
	......

	pushl	(%esp)		# kmalloc pointer 4 clocks
	call	kfree		# Free memory     8 + kfree clocks
	addl	$4, %esp	# Level stack     2 clocks

failed:
	addl	$SPACE_FOR_POINTER, %esp          2 clocks
	popl	%edi
	popl	%esi
	popl	%ebx
	ret

This takes 42 clocks, not including the thousands used up by kmalloc
and kfree.

If the kernel does not provide sufficient stack-space for small
buffers and structures, it is a kernel problem, not a driver-coding
problem. Competent driver (module) writers are acutely aware of the
necessity of obtaining speed and certainly would never call a
remote allocator for local variables. Global variables are often
allocated at initialization time using the appropriate kernel
allocator for the memory type required.

If you are attempting to require that good design practice be
abandoned according to this new whim, you are playing a microsoft-ism.
Please leave the drivers that work, alone.

Stack corruption has nothing to do with using the kernel stack for
local variables. It has everything to do with somebody or some thing
writing somewhere they don't own. This is what must be fixed.

That said, I certainly don't know how much stack-space should be available
and, probably, nobody else does either. After the stack corruption is
fixed, the stack should be profiled. This can be easily done from a
module if the stack gets zeroed before it's used, during the boot process.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


