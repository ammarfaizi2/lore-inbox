Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSGYUqz>; Thu, 25 Jul 2002 16:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSGYUqz>; Thu, 25 Jul 2002 16:46:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:58610 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316088AbSGYUqy> convert rfc822-to-8bit; Thu, 25 Jul 2002 16:46:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Mikael Pettersson <mikpe@csd.uu.se>, zwane@linuxpower.ca
Subject: Re: 2.4.19-rc3-ac2 SMP
Date: Thu, 25 Jul 2002 13:48:26 -0700
User-Agent: KMail/1.4.1
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <200207241728.TAA28800@harpo.it.uu.se>
In-Reply-To: <200207241728.TAA28800@harpo.it.uu.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207251348.26136.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 July 2002 10:28 am, Mikael Pettersson wrote:
> On Wed, 24 Jul 2002 17:26:49 +0200 (SAST), Zwane Mwaikambo wrote:
> >i'd vote for that =) except for one thing.
> >
> >+       /* APICs tend to spasm when they get errors.  Disable the error
> > intr. */ +       apic_write_around(APIC_LVTERR, ERROR_APIC_VECTOR |
> > APIC_LVT_MASKED);
> >
> >Isn't that a bit drastic?
>
> Drastic is an understatement. Try "gross". Sane machines running correct
> code shouldn't throw local APIC errors. If something's causing errors,
> that something should be fixed, not hidden.
>
> I hope that was just a temporary debug hack and not part of the design...
>
> /Mikael

On the contrary, when Intel moved the local APIC from a separate chip onto the 
CPU around the time of the P54C, they hobbled it.  Formerly, it could accept 
and latch any number of interrupts because it contained three bit vectors 
that could store all the necessary state info.  The P54C (and later) version 
had two latches per interrupt level.  The level was defined as the top nibble 
of the interrupt vector.  So, P54Cs could only latch two interrupts for, say, 
the 0x31-0x3F range for ISA IRQs.  Too bad if three 0x3X interrupts arrive.  
Number 3 cannot be latched.

Intel added new error states to the local APIC and the bus protocol to allow 
for interrupts to _not_ be delivered, thanks to the latch limit.  On a busy 
system with lots of interrupts, you will sometimes see several of these 
receive accept errors per day.  There is nothing you can do to fix the 
condition, aside from processing all .  It really is more of a warning than 
an error.

On our NUMA P6 box, we found that the local APICs would occasionally start 
spasming with error interrupts.  An APIC bus analyzer didn't show any kind of 
errors on the APIC bus.  They would just weird out and all attempts to clear 
the error had no effect.  We never did find a solution to that one or get an 
adequate explanation from Intel.  The only kludge that worked was to turn off 
the APIC error interrupt.

Naturally, the cleaned up version of the apic_state_dump patch wouldn't do 
that, or would make it an option.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

