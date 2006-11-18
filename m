Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753189AbWKRRtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbWKRRtD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 12:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbWKRRtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 12:49:01 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:21867 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753189AbWKRRtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 12:49:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=vZUJkvJCkoLJd/KeQEv2d/qzMp/dSnbP7E86W1ofQhyQYmEryYVF2zumTFu4bvjhg3fMjrOayadGumgm5jdUZaYkBBUu9Wv6CTEoUJb++uqBkLcyjQ+0NlR4j5qHHPjm0kwfwImE2e5k1m7y26M+lAhHepqFINfnMWFUniHXjN0=  ;
X-YMail-OSG: SgzwRjAVM1mjlBMLAo7MlP8v_ONSXOvkfBTrI_P7aMnsJ5AQh8xsIjzv4QKSm6yPfLEdtagva80SKgO5evGNLRk9PQrt4Wo_W12pgnKYWMo.Zq.SK.GLQP27J_jmjm2HcJzSSBGLMmL8owi1ZmRkFBT09L.jQMN.I7A-
Date: Sat, 18 Nov 2006 09:48:55 -0800
From: David Brownell <david-b@pacbell.net>
To: joakim.tjernlund@transmode.se
Subject: Re: FW: RTC, ds1307 I2C driver and NTP does not work.
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, galak@kernel.crashing.org
References: <007801c70af4$53afb2f0$1e67a8c0@Jocke>
In-Reply-To: <007801c70af4$53afb2f0$1e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061118174855.ABBB31E071A@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Of course you can't do that.  You're calling rtc_set_time(), which
> > requires a task/sleeping context, from an atomic can't-sleep context
> > (timer irq handler in this case).
> > 
> > Whatever your rtc_class_hookup() is doing, it's clearly wrong.
>
> It isn't my rtc_class_hookup(), it is in arch/powerpc/kernel/time.c
> and I am only using it the only way I can:
>
>  #ifdef CONFIG_RTC_CLASS
>  late_initcall(rtc_class_hookup);
>  #endif

Yeah, and that routine is clearly a bug.  The mechanism has only been
there about six weeks; 7a69af63e788a324d162201a0b23df41bcf158dd should
be reverted ASAP, it's braindead by design:

  - the issue noted above, calling rtc_set_time() from irq context
    ... so it BUG()s with NTP clock synch

  - wrongly assumes CONFIG_RTC_CLASS implies CONFIG_RTC_HCTOSYS_DEVICE
    ... so it will cause build errors when the latter isn't present

  - makes system time be set TWICE from that RTC, given HCTOSYS_DEVICE
    ... once from the powerpc time_init(), once from rtc class setup

The second would be trivially fixed (it's just #ifdeffed wrong), but the
other points aren't.  It would however be good to see someone make sure
that the RTC class code works with NTP synch, and sort out some of those
arch specific clock setup issues.


> > You're on the right track that the RTC class code needs to hook up
> > to NTP, but you can't do it that way.
>
> Clearly, but where should it be fixed in RTC CLASS or in ds1307 driver?

Neither:  arch/powerpc/kernel/time.c should revert the patch referenced
above.  No need to ship 2.6.19 with such a regression, and 2.6.20 could
ship with working code.

- Dave


> > > BUG: scheduling while atomic: swapper/0x00010000/0
> > > Call Trace:
> > > [C0245C80] [C000860C] show_stack+0x48/0x194 (unreliable)
> > > [C0245CB0] [C01BEFF4] schedule+0x5d4/0x618
> > > [C0245CF0] [C01BF9C8] schedule_timeout+0x70/0xd0
> > > [C0245D30] [C014416C] i2c_wait+0x164/0x1d8
> > > [C0245D80] [C0144490] mpc_xfer+0x2b0/0x3a8
> > > [C0245DD0] [C01423E8] i2c_transfer+0x58/0x7c
> > > [C0245DF0] [C0141124] ds1307_set_time+0x1bc/0x234
> > > [C0245E00] [C013F82C] rtc_set_time+0xb0/0xb8^M
> > > [C0245E20] [C000BFC4] set_rtc_class_time+0x34/0x58
> > > [C0245E40] [C000C8D0] timer_interrupt+0x5a0/0x5fc
> > > [C0245EE0] [C000F7B0] ret_from_except+0x0/0x14
> > > --- Exception: 901 at cpu_idle+0xc8/0xf0
> > >     LR = cpu_idle+0xec/0xf0
> > > [C0245FC0] [C000388C] rest_init+0x28/0x38
> > > [C0245FD0] [C01F36E0] start_kernel+0x1d8/0x228
> > > [C0245FF0] [00003438] 0x3438
