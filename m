Return-Path: <linux-kernel-owner+w=401wt.eu-S1754134AbWLRPXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbWLRPXj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbWLRPXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:23:39 -0500
Received: from yumi.tdiedrich.de ([85.10.210.183]:3375 "EHLO yumi.tdiedrich.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134AbWLRPXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:23:38 -0500
Date: Mon, 18 Dec 2006 16:23:34 +0100
From: Tobias Diedrich <ranma+kernel@tdiedrich.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work (was: Linux 2.6.20-rc1)
Message-ID: <20061218152333.GA2400@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma+kernel@tdiedrich.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
	Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <20061216174536.GA2753@melchior.yamamaya.is-a-geek.org> <Pine.LNX.4.64.0612160955370.3557@woody.osdl.org> <20061216225338.GA2616@melchior.yamamaya.is-a-geek.org> <20061216230605.GA2789@melchior.yamamaya.is-a-geek.org> <Pine.LNX.4.64.0612161518080.3479@woody.osdl.org> <20061217145714.GA2987@melchior.yamamaya.is-a-geek.org> <m1bqm1s5vv.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m1bqm1s5vv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Tobias Diedrich <ranma@tdiedrich.de> writes:
> 
> > Linus Torvalds wrote:
> >
> >> Your dmesg is kind of interesting:
> >> 
> >> ..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 enabled(7)APIC error on CPU0:
> > 04(40)
> >>  .. failed
> >> 
> >> where that APIC error on CPU0 seems to be a "Send accept error" and "Send 
> >> illegal vector" thing. I think we actually got the interrupt there, but 
> >> because we had some APIC setup bug, we didn't accept it properly, and it 
> >> resulted in that "APIC error" thing. Maybe. 
> >
> > I just tried changing the code so the "8259 IRQ0 enabled" case is
> > tested first and with that it boots fine.
> 
> Could you try removing the clear_IO_APIC_pin from try_io_apic_pin.
> 
> This isn't a complete fix but I believe for your hardware it will
> fix the problem and it points at what the real fix is.  
> 
> Not properly programming the io_apic for the case we want to test.

Yes, this works:

|[   27.535937] init IO_APIC IRQs
|[   27.536009]  IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
|[   27.536140] ..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 disabled<3> (clear_IO_APIC_pin not called)<3> .. failed
|[   27.569357] ..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 enabled<3> .. works
|[   27.602547] Using local APIC timer interrupts.

I can also report, that updating the BIOS to version 0609 (released
last week or so, also adds the long-missing HPET support) also makes
the problem go away since the first testcase then already works.
I'm currently running with the BIOS downgraded to version 0402.

|[   23.646371] ENABLING IO-APIC IRQs
|[   23.646477] init IO_APIC IRQs
|[   23.646479]  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
|[   23.646674] ..TIMER: trying IO-APIC=0 PIN=2 with 8259 IRQ0 disabled<3> .. works
|[   23.679872] Using local APIC timer interrupts.

Index: linux-2.6.20-rc1/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/x86_64/kernel/io_apic.c	2006-12-18 15:56:38.000000000 +0100
+++ linux-2.6.20-rc1/arch/x86_64/kernel/io_apic.c	2006-12-18 16:04:15.000000000 +0100
@@ -1586,9 +1586,11 @@
 			setup_nmi();
 			enable_8259A_irq(0);
 		}
+		apic_printk(APIC_QUIET, KERN_ERR " .. works\n");
 		return 1;
 	}
-	clear_IO_APIC_pin(apic, pin);
+	printk(KERN_ERR " (clear_IO_APIC_pin not called)");
+	/* clear_IO_APIC_pin(apic, pin); */
 	apic_printk(APIC_QUIET, KERN_ERR " .. failed\n");
 	return 0;
 }

HTH,

-- 
Tobias						PGP: http://9ac7e0bc.uguu.de
このメールは十割再利用されたビットで作られています。
