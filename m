Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTLNLSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 06:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTLNLSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 06:18:43 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:61964 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S261774AbTLNLSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 06:18:41 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Jamie Lokier <jamie@shareable.org>, forming@charter.net
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Sun, 14 Dec 2003 21:24:45 +1000
User-Agent: KMail/1.5.1
Cc: Ian Kumlien <pomac@vapor.com>, linux-kernel@vger.kernel.org
References: <200312140407.28580.ross@datscreative.com.au> <200312140949.52489.ross@datscreative.com.au> <20031214042714.GB21241@mail.shareable.org>
In-Reply-To: <20031214042714.GB21241@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312142124.45966.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 December 2003 14:27, Jamie Lokier wrote:
> Ross Dickson wrote:
> > The v1 patch ((cpu_khz >> 12)+200) gave 700ns additional delay to
> > your existing code path so I think I was being too optimistic in the
> > initial v2 timing. I made the initial timing CPU freq dependent on
> > the assumption that a faster cpu would get to the delay point
> > quicker.
> 
> Maybe it scales with bus speed, not CPU internal speed?

Very good point.

Hmmm It may well be the settling time of the cpu PLL (phase lock
loop) changing from low power disconnect speed up to bus speed -
higher speed bus on the same type of silicon may take longer? as
also it may take more power to run faster so the internal bus bit
drivers may also take more time to settle? These sorts of things are
mentioned in earlier model athlon errata. Especially if there is perhaps
a marginal northbridge timing in the area Ian has thought about?

The nforce2 ram controller is also unique and kind of predicts and caches
reads so maybe the apic timer irq code is ready to run a lot sooner than 
other chipsets so the normal delays wrt loading from memory are not there?
Are we compensating for that? We don't really know unfortunately.

> 
> -- Jamie
> 
> 
> 

Josh - Thanks very much for the patches.

The v2 io-apic mods seems OK so far.

I am not yet sure the v2 apic patch is going to be stable enough for everyone.
I suspect it is the apic reads.

Ian had problems at 600ns so now has been trying 800ns. I have yet to hear how
his machine is.

I have also gone from 600ns to 800ns and had my first hard lockup
after about 6 hrs on 800ns delay timeout. 

I am using a heavily patched 2.4.23 kern so it could be a coincidence
but I am suspicious that it may not be that safe to be reading the apic
registers at all during the delay timeout as the v2 apic patch does.

I am now going to try increasing the wait loop delay from 100ns to 400ns
in case the apic does not like being hammered repetitively during the delay
time. - It could be that the bus between the cpu core and the local apic is
marginal on either timing (PLL) or current and if we hammer it we may
be asking for incorrect reads?

I am about to recompile with the following values that differ from my
original v2 posting. 
( 800UL and the ndelay(400) )

#ifdef CONFIG_MK7 && CONFIG_BLK_DEV_AMD74XX
	/*
	 * on AMDXP & nforce2 chipset we need about 800ns?
	 * from timer irq start to apic irq ack to prevent
	 * hard lockups, use apic timer itself.
	 * C1 disconnect bit related.  Ross Dickson.
	 */
	{
		static unsigned int passno, safecnt;
		if(!passno) { /* calculate timing */
			safecnt = apic_read(APIC_TMICT) -
				( (800UL * apic_read(APIC_TMICT) ) /
				(1000000000UL/HZ) );
			printk("..APIC TIMER ack delay, reload:%u, safe:%u\n",
				apic_read(APIC_TMICT), safecnt);
			passno++;
		}
#if APIC_DEBUG
		if(passno<12) {
			unsigned int at1 = apic_read(APIC_TMCCT);
			if( passno > 1 )
				Dprintk("..APIC TIMER ack delay, predelay count:%u \n", at1 );
			passno++;
		}
# endif
		/* delay only if required */
		while( apic_read(APIC_TMCCT) > safecnt )
			ndelay(400);
	}
#endif


Regards
Ross.
