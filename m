Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315994AbSEJOGr>; Fri, 10 May 2002 10:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315995AbSEJOGr>; Fri, 10 May 2002 10:06:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315994AbSEJOGn>; Fri, 10 May 2002 10:06:43 -0400
Date: Fri, 10 May 2002 10:06:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Keith Owens <kaos@ocs.com.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: spin-locks 
In-Reply-To: <30386.1021037082@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.3.95.1020510095907.2632A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, Keith Owens wrote:

> On Fri, 10 May 2002 08:58:47 -0400 (EDT), 
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >First, if I create a spin-lock in the ".data" segment it
> >doesn't work on a SMP machine with two CPUs. I know I am
> >supposed to use the macros, but I have some high-speed stuff
> >written in assembly that needs a spin-lock. The 'doesn't work'
> >is that the spin-lock seems to dead-lock, i.e., they loop
> >forever with the interrupts disabled. I think what's really
> >happening is that .data was paged and can't be paged back in
> >with the interrupts off. I don't know. This stuff used to
> >work....
> 
> Kernel .data sections are not paged.  They are identity[*] mapped along
> with the rest of the kernel text and data and are locked down.
> 
> [*] Ignoring NUMA machines which may use non-identity mappings on each
> node.
> 
> >In earlier versions of Linux, the locks were in .text_lock.
> >Now they are in : _text_lock_KBUILD_BASENAME
> 
> Not quite.  They were all in section .text.lock but that broke when
> binutils started detecting dangling references to discarded sections.
> 
> The fix was to store the lock code in the same section that called the
> lock, so .text locks are in the .text section, .text.exit locks are in
> the .text.exit section, no dangling references when .text.exit is
> discarded.
> 
> The locks are now at the end of the section that references the lock,
> preceded by a label (not a section) of _text_lock_KBUILD_BASENAME.
> 
> >So, what is special about this area that allows locks to work?
> 
> There is nothing special about the text lock code.  It is just moving
> the failure path out of line to speed up the normal case.
> 
> >And, what is special about .data that prevents them from working?
> 
> Again nothing.  The spin lock area goes in .data, the code goes in the
> relevant text section.
> 
> >Also, there is a potential bug (ducks and hides under the desk) in
> >the existing spin-lock unlocking. To unlock, the lock is simply
> >set to 1. This works if you have two CPUs, but what about more?
> >
> >Shouldn't the lock/unlock just be incremented/decremented so 'N' CPUs
> >can pound on it?
> 
> Spinlocks are single cpu.  Only one cpu at a time can modify the data
> that is being protected by obtaining the lock.
> 
> >From your description, you are confused about spinlocking.  Perhaps if
> you mailed your code instead of assuming where the error was ...

Well, here is code that worked on linux 2.2.17.  Same CPUs, same
everything... Just a different version of OS...

In this code, any CPU will modify (increment) the lock so we can
only have 255 CPUs before this fails <grin>...


#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

.section .data
lrm_tickl:	.long	0
lrm_tickh:	.long	0
lockf:		.byte	0
.section .text

#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#
#   This reads the rapidly-changing tick-value and returns it as a
#   long long. The output value is in carefully calculated miliseconds.
#
.global	lrm_tick
.type	lrm_tick,@function
.align	0x04
lrm_tick:
	pushf			# Restored at the end
	cli
	lock
	incb	(lockf)		# Bump lock-value
1:	cmpb	$1,(lockf)	# See if we own it
	jnz	1b		# Nope, spin until we do.

	pushl	%ebx		# Save non-volatile registers
	pushl	%ecx
	pushl	%esi
	pushl	%edi

#
#   Locks no longer work so I have to do this hack......
#

2:	movl	(lrm_tickl), %eax
	movl	(lrm_tickh), %edx
	cmpl	(lrm_tickl), %eax
	jnz	2b	
	cmpl	(lrm_tickh), %edx
	jnz	2b
#
#   Okay, we have a stable tick. Now, it's 2048 ticks/second instead
#   of 1,000 ticks. Therefore we have to multiply by 1,000 and and
#   divide by 2048 to get the millisecond count.
#
	xorl	%esi, %esi		# For overflow
	movl	%eax, %ebx		# Save times 1 low lword
	movl	%edx, %ecx		# Save times 1 high lword
	movl	%esi, %edi		# Save overflow
#
	shl	$1, %eax		# Times 2
	adcl	$0, %edx		# Take care of CY
	adcl	$0, %esi		# Take care of overflow
#
	shl	$1, %eax		# Times 4
	adcl	$0, %edx		# Take care of CY
	adcl	$0, %esi		# Take care of overflow
#
	addl	%ebx, %eax		# Add the times 1 low lword
	adcl	%ecx, %edx		# Add the times 1 high lword
	adcl	%edi, %esi		# Add the times 1 overflow
					# Now times 5 
#
	shl	$1, %eax		# Times 10
	adcl	$0, %edx		# Take care of CY
	adcl	$0, %esi		# Take care of overflow
#
	movl	%eax, %ebx		# Save times 10 low lword
	movl	%edx, %ecx		# Save times 10 high lword
	movl	%esi, %edi		# Save overflow
#
	shl	$1, %eax		# Times 20
	adcl	$0, %edx		# Take care of CY
	adcl	$0, %esi		# Take care of overflow
#
	shl	$1, %eax		# Times 40
	adcl	$0, %edx		# Take care of CY
	adcl	$0, %esi		# Take care of overflow
#
	addl	%ebx, %eax		# Add the times 10 low lword
	adcl	%ecx, %edx		# Add the times 10 high lword 
	adcl	%edi, %esi		# Add the times 10 overflow
					# Now times 50
#
	shl	$1, %eax		# Times 100 
	adcl	$0, %edx		# Take care of CY
	adcl	$0, %esi		# Take care of overflow
#
	movl	%eax, %ebx		# Save times 100 low lword
	movl	%edx, %ecx		# Save times 100 high lword
	movl	%esi, %edi		# Save overflow
#
	shl	$1, %eax		# Times 200 
	adcl	$0, %edx		# Take care of CY
	adcl	$0, %esi		# Take care of overflow
#
	shl	$1, %eax		# Times 400 
	adcl	$0, %edx		# Take care of CY
	adcl	$0, %esi		# Take care of overflow
#
	addl	%ebx, %eax		# Add the times 100 low lword
	adcl	%ecx, %edx		# Add the times 100 high lword 
	adcl	%edi, %esi		# Add the times 100 overflow
					# Now times 500
#
	shl	$1, %eax		# Times 1000 
	adcl	$0, %edx		# Take care of CY
	adcl	$0, %esi		# Take care of overflow
#
#    Now do the division (2^11) and yes, I do know about loops.
#
	shrl	$1, %esi
	rcrl	$1, %edx		# Div by 2
	rcrl	$1, %eax
#
	shrl	$1, %esi
	rcrl	$1, %edx		# Div by 4 
	rcrl	$1, %eax
#
	shrl	$1, %esi
	rcrl	$1, %edx		# Div by 8 
	rcrl	$1, %eax
#
	shrl	$1, %esi
	rcrl	$1, %edx		# Div by 16 
	rcrl	$1, %eax
#
	shrl	$1, %esi
	rcrl	$1, %edx		# Div by 32 
	rcrl	$1, %eax
#
	shrl	$1, %esi
	rcrl	$1, %edx		# Div by 64 
	rcrl	$1, %eax
#
	shrl	$1, %esi
	rcrl	$1, %edx		# Div by 128 
	rcrl	$1, %eax
#
	shrl	$1, %esi
	rcrl	$1, %edx		# Div by 256 
	rcrl	$1, %eax
#
	shrl	$1, %esi
	rcrl	$1, %edx		# Div by 512 
	rcrl	$1, %eax
#
	shrl	$1, %esi
	rcrl	$1, %edx		# Div by 1024 
	rcrl	$1, %eax
#
	shrl	$1, %esi
	rcrl	$1, %edx		# Div by 2048 
	rcrl	$1, %eax
#
#	Return long-long in EAX:EDX
#
	popl	%edi
	popl	%esi
	popl	%ecx			# Restore registers used
	popl	%ebx
	lock
	decb	(lockf)			# Release lock
	popf
	ret
.end
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-




Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

