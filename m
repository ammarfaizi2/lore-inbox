Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267071AbSKMAmZ>; Tue, 12 Nov 2002 19:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267073AbSKMAmZ>; Tue, 12 Nov 2002 19:42:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:23254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267071AbSKMAmX>;
	Tue, 12 Nov 2002 19:42:23 -0500
Subject: Re: Kexec for v2.5.47 (test feedback)
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
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
In-Reply-To: <m1isz39rrw.fsf@frodo.biederman.org>
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp> 
	<m1isz39rrw.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Nov 2002 16:48:30 -0800
Message-Id: <1037148514.13280.97.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 23:22, Eric W. Biederman wrote:
> > On Mon, 2002-11-11 at 10:15, Eric W. Biederman wrote:
> > > kexec is a set of system calls that allows you to load another kernel
> > > from the currently executing Linux kernel.
> > 

> > Results on my usual problem machine:
> > 
> > # ./kexec-1.5 ./kexec_test-1.5
> > Shutting down devices
> > Debug: sleeping function called from illegal context at include/asm/semaphore.h9
> > 
> > Call Trace: [<c011a698>] [<c0216193>] [<c012b165>] [<c0132dec>] [<c0140357>
> 
> Hmm. I wonder what is doing that.  Do you have the semaphore problem on a normal reboot?

No clue as of yet.  I do not see this information during a normal
reboot.


> > Starting new kernel
> > 
> > kexec_test 1.5 starting...
> > eax: 0E1FB007 ebx: 00001078 ecx: 00000000 edx: 00000000
> > esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
> > idt: 00000000 C0000000
> > gdt: 00000000 C0000000
> > Switching descriptors.
> > Descriptors changed.
> > Legacy pic setup.
> > In real mode.
> > <hang>
> 
> Yep it works until it runs into your apics that are not shutdown.
> That looks like one of the next things to tackle.

I used the linux-2.5.44.x86kexec-hwfixes.diff (it applied cleanly to
pure 2.5.47 + kexec); I'll try your updated version soon if there are
any major differences.

> The challenge is with the apic shutdown is that currently the apics are not
> in the device tree so that needs to happen before I can submit a good version
> for 2.5.x
>  
> 
> > Confirming some earlier suspicions:
> > CONFIG_SMP=y
> > CONFIG_X86_GOOD_APIC=y
> > CONFIG_X86_LOCAL_APIC=y
> > CONFIG_X86_IO_APIC=y
> > 
> > Last time I tried to run a UP kernel (and no APIC support) on this system
> > it wasn't pretty.  I'll add that to my list of combinations to try.

On this same system, I reconfigured and tried this:
    # CONFIG_SMP is not set
    CONFIG_X86_GOOD_APIC=y
    # CONFIG_X86_UP_APIC is not set
    # CONFIG_X86_LOCAL_APIC is not set
    # CONFIG_X86_IO_APIC is not set
    
None of the "ordinary" APIC initialization messages were output during
the regular BIOS->LILO boot of this kernel.

Using kexec on this kernel to run kexec_test-1.5 stops in the same way:
    # ./kexec-1.5 --debug ./kexec_test-1.5
    Shutting down devices
    Debug: sleeping function called from illegal context at
    include/asm/semaphore.h9Call Trace: [<c0113f7c>]  [<c01ec123>] 
    [<c0120af2>]  [<c0130d5d>]  [<c0130d5d> Starting new kernel
    kexec_test 1.5 starting...
    eax: 0E1FB007 ebx: 00001078 ecx: 00000000 edx: 00000000
    esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
    idt: 00000000 C0000000
    gdt: 00000000 C0000000
    Switching descriptors.
    Descriptors changed.
    Legacy pic setup.
    In real mode.
    <hang>

So, does this information suggest looking somewhere other than APIC
shutdown?

Andy


