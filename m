Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131437AbQLVOmM>; Fri, 22 Dec 2000 09:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131516AbQLVOmD>; Fri, 22 Dec 2000 09:42:03 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30336 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131437AbQLVOlt>; Fri, 22 Dec 2000 09:41:49 -0500
Date: Fri, 22 Dec 2000 09:11:07 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Referencing PHYSICAL (what you see on the bus) memory?
Message-ID: <Pine.LNX.3.95.1001222090540.9114A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am finishing up a memory-test program. I want to get the
true linear address of some failing memory. I have obtained
the virtual (user-space) address.

Since going through all the PTEs seems to be a bitch, I thought
it would be easier to do the following:

(1)	Mark the bad RAM with magic (0xdeadface).
(2) 	mmap() some low physical RAM where there is a 1:1 virt/phy
	translation.
(2)	Make an ioctl() to a module that copies some code to
	the mmap()ed RAM.
(3)	Call a procedure in that code living below 1 megabyte
	from the module in kernel space.
	So far this all ** works **. The code functions and
	returns, when executed in the mmaped (.data) area.
	The physical address chosen was 0x90000.

(4)	The procedure is supposed to do:

	Make a long-jump to its physical address so it's
	CS:EIP is referencing the physical address.

	Disable paging. You need 1:1 phys/virt before you do this.

	Do a linear scan of all memory, looking for magic.
	I need paging off so I can look at flat-model physical RAM.

	Re-enable paging.

	Make a long-jump to its virtual address.
	Return to caller.


(5)	So far, the code looks like:

LOAD_ADDRESS = 0x90000

	pushl	%registers_destroyed.
	movl	%cr0,%ebx		# Save original.
	ljmp	$(__KERNEL_DS,$1f - PAGE_OFFSET + LOAD_ADDRESS
					# Should now be 1:1
1:	movl	%ebx,%eax
	andl	$~0x80000000,%eax	# Mask paging bit
	movl	%eax,%cr0		# Turn off paging

	do_memory_scan

	movl	%ebx,%cr0		# Turn back on paging
	ljmp	$(__KERNEL_CS),%1f + PAGE_OFFSET + LOAD_ADDRESS 
					# Back to virtual address
1:
	popl	%registers_destroyed


(6)	This obviously fails. It fails at the first 'ljmp'. This
	seems to be because __KERNEL_DS doesn't reference the 1:1
	stuff. Note, the code is executing out of allocated
	(mmaped()) .data. I have played with __KERNEL_CS. This
	produces an 'access violation', i.e., I wasn't even allowed
	to try to execute something there.

	Using __KERNEL_DS, the errors were related to executing
	junk since I didn't jump to where I thought I should have
	gone.

(7)	So the question is: What executable segment will reference,
	with a 1:1 virtual:physical relationship, stuff that has
	already successfully been copied to low memory? 

	I can 'prove' that the code I want executed does actually
	live at 0x90000, and if I don't do anything exciting,
	I can call it (via pointer), it executes, and properly
	returns to my module.

 
Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
