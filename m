Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267144AbSKMEMq>; Tue, 12 Nov 2002 23:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267147AbSKMEMq>; Tue, 12 Nov 2002 23:12:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57420 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267144AbSKMEMo>; Tue, 12 Nov 2002 23:12:44 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: Kexec for v2.5.47 (test feedback)
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Nov 2002 21:16:42 -0700
In-Reply-To: <1037148514.13280.97.camel@andyp>
Message-ID: <m1el9q9k9h.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Mon, 2002-11-11 at 23:22, Eric W. Biederman wrote:
> > > On Mon, 2002-11-11 at 10:15, Eric W. Biederman wrote:
> > > > kexec is a set of system calls that allows you to load another kernel
> > > > from the currently executing Linux kernel.
> > > 
> 
> > > Results on my usual problem machine:
> > > 
> > > # ./kexec-1.5 ./kexec_test-1.5
> > > Shutting down devices
> > > Debug: sleeping function called from illegal context at
> include/asm/semaphore.h9
> 
> > > 
> > > Call Trace: [<c011a698>] [<c0216193>] [<c012b165>] [<c0132dec>] [<c0140357>
> > 
> > Hmm. I wonder what is doing that.  Do you have the semaphore problem on a
> normal reboot?
> 
> 
> No clue as of yet.  I do not see this information during a normal
> reboot.

Doh.   I must compile that debugging in when I am testing.  I introduced a spin lock,
and then I called a function that might sleep...  Though I am puzzled by what
in the device_shutdown and reboot notifier path is actually sleeping
but that is academic.

Next version will use a semaphore to be polite.
I should have asked where those addresses mapped to in your
system.map.

Anyway one of the reasons I grumble about splitting it, more global
variables that have to be protected, and more chances to fumble
something.  Oh, well.

> > > Starting new kernel
> > > 
> > > kexec_test 1.5 starting...
> > > eax: 0E1FB007 ebx: 00001078 ecx: 00000000 edx: 00000000
> > > esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
> > > idt: 00000000 C0000000
> > > gdt: 00000000 C0000000
> > > Switching descriptors.
> > > Descriptors changed.
> > > Legacy pic setup.
> > > In real mode.
> > > <hang>
> > 
> > Yep it works until it runs into your apics that are not shutdown.
> > That looks like one of the next things to tackle.
> 
> I used the linux-2.5.44.x86kexec-hwfixes.diff (it applied cleanly to
> pure 2.5.47 + kexec); I'll try your updated version soon if there are
> any major differences.

I don't think there is anything significant.

> > The challenge is with the apic shutdown is that currently the apics are not
> > in the device tree so that needs to happen before I can submit a good version
> > for 2.5.x
> >  
> > 
> > > Confirming some earlier suspicions:
> > > CONFIG_SMP=y
> > > CONFIG_X86_GOOD_APIC=y
> > > CONFIG_X86_LOCAL_APIC=y
> > > CONFIG_X86_IO_APIC=y
> > > 
> > > Last time I tried to run a UP kernel (and no APIC support) on this system
> > > it wasn't pretty.  I'll add that to my list of combinations to try.
> 
> On this same system, I reconfigured and tried this:
>     # CONFIG_SMP is not set
>     CONFIG_X86_GOOD_APIC=y
>     # CONFIG_X86_UP_APIC is not set
>     # CONFIG_X86_LOCAL_APIC is not set
>     # CONFIG_X86_IO_APIC is not set
>     
> None of the "ordinary" APIC initialization messages were output during
> the regular BIOS->LILO boot of this kernel.
> 
> So, does this information suggest looking somewhere other than APIC
> shutdown?

I am not certain.  All that is certain is there is an unhandled
interrupt.  

Anyway the next step will be to enter the Linux kernel in 32bit mode
so I can avoid the whole mess of getting the BIOS working again.  That
should avoid most of these complications as I will be able to skip
the whole step of enabling interrupts.

Eric

