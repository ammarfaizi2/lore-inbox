Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIWdT>; Tue, 9 Jan 2001 17:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129859AbRAIWdA>; Tue, 9 Jan 2001 17:33:00 -0500
Received: from ns.sysgo.de ([213.68.67.98]:57591 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S129383AbRAIWcv>;
	Tue, 9 Jan 2001 17:32:51 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: Anybody got 2.4.0 running on a 386 ?
Date: Tue, 9 Jan 2001 23:17:11 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <01010922090000.02630@rob> <01010922264400.02737@rob> <3A5B86C1.41DDB11B@didntduck.org>
In-Reply-To: <3A5B86C1.41DDB11B@didntduck.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01010923324500.02850@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 09 Jan 2001 you wrote:
> Robert Kaiser wrote:
> > 
> > On Die, 09 Jan 2001 you wrote:
> > > Robert Kaiser wrote:
> > > > I can't seem to get the new 2.4.0 kernel running on a 386 CPU.
> > > > The kernel was built for a 386 Processor, Math emulation has been enabled.
> > > > I tried three different 386 boards. Execution seems to get as far as
> > > > pagetable_init() in arch/i386/mm/init.c, then it falls back into the BIOS as
> > > > if someone had pressed the reset button. The same kernel boots fine on
> > > > 486 and Pentium Systems.
> >  ..... The last thing I see is
> > "Uncompressing Linux... Ok, booting the kernel." I have added some
> > quick and dirty debug code that writes messages directly to the VGA
> > screen buffer. According to that, execution seems to get as far as the
> > statement
> > 
> >         *pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
> > 
> 
> Could it be possible that memory size is being misdetected?  Try mem=8M
> (or less) on the command line.  Try to catch the value of pte when it
> crashes.

I tried "mem=4M" -- no effect. The value of pte is 0xc0001000, so it seems
to be the first invocation of that statement in the for() loop.

Now comes the amazing (to me) part: I split the above statement up into:

	temp = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
	*pte = temp;

where temp is declared "volatile pte_t". I inserted test-prints between the
above two lines. Accoding to that, the _first_ line , i.e. the evaluation of the
mk_pte_phys() macro is causing the crash!

I am still trying to figure out what mk_pte_phys() does. Apparently it involves
an access to the kernel's data section. My current guess is that the data
section is not correctly mapped at this point. Would that be possible ?



----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
