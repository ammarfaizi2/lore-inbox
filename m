Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268454AbTBNPuZ>; Fri, 14 Feb 2003 10:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268455AbTBNPuZ>; Fri, 14 Feb 2003 10:50:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31018 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268454AbTBNPuX>; Fri, 14 Feb 2003 10:50:23 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: suparna@in.ibm.com, fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KEXEC][PATCH] Modified (smaller) x86 kexec hwfixes patch
References: <20030213161014.A14361@in.ibm.com>
	<m1heb8w737.fsf@frodo.biederman.org> <20030214085915.A1466@in.ibm.com>
	<51710000.1045205264@[10.10.2.4]> <m165rn8dpz.fsf@frodo.biederman.org>
	<53360000.1045236737@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Feb 2003 09:00:16 -0700
In-Reply-To: <53360000.1045236737@[10.10.2.4]>
Message-ID: <m1k7g27sz3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> >> Running on my 4-way P3 test box (just SMP, not NUMA) kexec_test
> >> prints this:
> >> 
> >> Synchronizing SCSI caches: 
> >> Shutting down devices
> >> Starting new kernel
> >> kexec_test 1.8 starting...
> >> eax: 0E1FB007 ebx: 0000011C ecx: 00000000 edx: 00000000
> >> esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
> >> idt: 00000000 C0000000
> >> gdt: 0000006F 000000A0
> >> Switching descriptors.
> >> Descriptors changed.
> >> Legacy pic setup.
> >> In real mode.
> >> 
> >> Without that I just get:
> >> 
> >> Synchronizing SCSI caches: 
> >> Shutting down devices
> >> Starting new kernel
> >> 
> >> Can someone interpret?
> > 
> > Besides the fact that you cannot make BIOS calls, and kexec is working
> > there is not much to say.  You cannot kexec another kernel?
> 
> Nope, if I just kexec the same 2.5.59 kernel+kexec patches that I'm booted
> on it says: 
> 
> Synchronizing SCSI caches: 
> Shutting down devices
> Starting new kernel
> 
> Could you give me a high-level sketch of what you're doing? kexec -l loads
> the new kernel, then what do you do? Drop back into real mode and jump to
> the normal kernel entry point? Or decompress by hand, do some alternate
> setup of the early page tables and try to jump in at the 32-bit entry point?

With Interrupts disabled.
machine_kexec switch the cpu to physical address mode (it turns the mmu off).
Copies the kernel to where it needs to run.
Then it jumps to an entry point.

kexec has put in a stub piece of code, and pointed the entry point at that location.
The stub code setups of a gdt, the kernel can cope with.
The stub code setups a parameter table just like the real mode code generates.
The stub code jumps in at the 32bit entry point.

[There is another stub that will attempt to start the kernel at the 16bit entry
 point but it is not used by default].

Interrupts are off the entire time.

> Is all I can assume from the above that I crash in the new kernel before
> console_init()?

Yes.

> Or should I expect something from the decompress code?

It is not hard to patch the decompression code to display a message, but
by default it does not output to serial...

You might want to run mkelfImage on a vmlinux so you can skip the decompression
step.  It adds a stub to the elf file that gets passed to kexec so that
you can skip the decompression.

ftp://ftp.lnxi.com/pub/src/mkelfImage/mkelfImage-2.x

Also I have some assembly language macros that display text out the serial port, if you want
to instrument up the kernel you are booting.

Eric
