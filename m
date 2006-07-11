Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbWGKFLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWGKFLN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 01:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWGKFLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 01:11:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:44631 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965116AbWGKFLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 01:11:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=uhJThhrHo0t3OFsqxsGcReEWFhgp8dfnL1j6a/BCF1eG3dLjMhpDc0Ulfo7S1LDy2RYawfjOBbDcelo0/xvqNJFd60dd3y2cUIgLCbHVaJVB90TovocFfxItVDsmT/OQ+3ginOwlHvicRLIiEL8vmLFTJl/dg8+1dayeDfyV8oQ=
Date: Tue, 11 Jul 2006 01:11:08 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Joseph Fannin <jfannin@gmail.com>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: [LOCKDEP] 2.6.18-rc1: inconsistent {hardirq-on-W} -> {in-hardirq-W} usage
Message-ID: <20060711051108.GA13574@nineveh.rivenstone.net>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, Joseph Fannin <jfannin@gmail.com>,
	linux-kernel@vger.kernel.org, arjan@infradead.org,
	John Stultz <johnstul@us.ibm.com>
References: <20060709050525.GA1149@nineveh.rivenstone.net> <20060708232512.12b59269.akpm@osdl.org> <20060709074543.GA4444@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709074543.GA4444@elte.hu>
User-Agent: Mutt/1.5.11
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 09:45:44AM +0200, Ingo Molnar wrote:
>
> * Andrew Morton <akpm@osdl.org> wrote:
>
> > yup, thanks, bug.
> >
> > --- a/arch/i386/kernel/time.c~get_cmos_time-locking-fix
> > +++ a/arch/i386/kernel/time.c
> > @@ -206,15 +206,16 @@ irqreturn_t timer_interrupt(int irq, voi
> >  unsigned long get_cmos_time(void)
> >  {
> >  	unsigned long retval;
> > +	unsigned long flags;
> >
> > -	spin_lock(&rtc_lock);
> > +	spin_lock_irqsave(&rtc_lock, flags);
>
> Acked-by: Ingo Molnar <mingo@elte.hu>
>
> this bug has been in the upstream kernel for a couple of years: it was
> apparently introduced as part of HPET support, via the late_time_init()
> hook/hack in init/main.c. The lockup window is open once, during bootup.


    2.6.18-rc1-mm1, which includes this change, is printing this at
the same point I used to get the lockdep message:

[   25.628000] BUG: warning at kernel/lockdep.c:1803/trace_hardirqs_on()
[   25.628000]  [<c0104a18>] show_trace_log_lvl+0x148/0x170
[   25.628000]  [<c0105cab>] show_trace+0x1b/0x20
[   25.628000]  [<c0105cd4>] dump_stack+0x24/0x30
[   25.628000]  [<c014af4e>] trace_hardirqs_on+0xce/0x200
[   25.628000]  [<c036cf21>] _spin_unlock_irq+0x31/0x70
[   25.628000]  [<c0296584>] rtc_get_rtc_time+0x44/0x1a0
[   25.628000]  [<c01198bb>] hpet_rtc_interrupt+0x21b/0x280
[   25.628000]  [<c0161141>] handle_IRQ_event+0x31/0x70
[   25.628000]  [<c0162d37>] handle_edge_irq+0xe7/0x210
[   25.628000]  [<c0106192>] do_IRQ+0x92/0x120
[   25.628000]  [<c0104121>] common_interrupt+0x25/0x2c
[   25.628000]  [<b7f15410>] 0xb7f15410


    Updated dmesg and .config:

http://home.columbus.rr.com/jfannin3/dmesg-2.6.18-rc1-mm1
http://home.columbus.rr.com/jfannin3/config-2.6.18-rc1-mm1

--
Joseph Fannin
jhf@rivenstone.net

