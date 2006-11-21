Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbWKUAEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbWKUAEM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966886AbWKUAEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:04:12 -0500
Received: from mout2.freenet.de ([194.97.50.155]:5253 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S966882AbWKUAEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:04:10 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.19-rc6-rt4, changed yum repository
Date: Tue, 21 Nov 2006 01:04:10 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061118163032.GA14625@elte.hu> <200611192156.39981.fzu@wemgehoertderstaat.de> <20061119211434.GA7538@elte.hu>
In-Reply-To: <20061119211434.GA7538@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611210104.11151.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 19. November 2006 22:14 schrieb Ingo Molnar:
> 
> * Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:
> 
> >  Call Trace:
> >   [<c02d320f>] do_page_fault+0x2b9/0x552
> >   [<c0102f22>] work_resched+0x6/0x20
> 
> > The  [<c0102f22>] work_resched+0x6/0x20 corresponds to
> > 	mov    $0xfffff000,%ebp
> 
> > 0x000001c1 <work_resched+1>:    call   0x1c2 <work_resched+2>
> > 0x000001c6 <work_resched+6>:    mov    $0xfffff000,%ebp
> 
> no, it's the call's return address that is work_resched+6.
> 
> to get a more usable snapshot of what this task is doing you'd need 
> something like SysRq-P output. (that works on PREEMPT_RT only if you 
> enable /proc/sys/kernel/debug_direct_keyboard - but careful, it might 
> break if you generate too many interrupts - i usually only to do the 
> SysRq-P and hope that it doesnt break then.)

Thanks. It turned out, it was me having missed to .config enable
	"Enhanced Real Time Clock Support"
. Sorry for having bothered you about this.
hwclock then couldn't open /dev/rtc, fell back to iopl(3) hw access.
And that failed sometimes ;-)

I'd still like to know, why are there the do_page_fault() SysRq+T
traces under hwclock context, while hwclock userspace is in a loop
doing iopl(3)ed io-access? 

hwclock's loop active then is:
	for (i = 0; !cmos_clock_busy(); i++)
		if (i >= 10000000)
			return 1;
with:
	int cmos_clock_busy()
	{
		return   /* poll bit 7 (UIP) of Control Register A */
	    (hclock_read(10) & 0x80);
	}
with hand interpreted:
	unsigned long hclock_read(unsigned long reg)
	{
		unsigned long v;
		__asm__ volatile ("cli");
		outb (reg, clock_ctl_addr);
		 v = inb (clock_data_addr);
		__asm__ volatile ("sti");
		return v;
	}

I guess:
SysRq+T doesn't care about userspace eip and just displays hwclock's
last used kernel stack?

      Karsten

