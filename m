Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317643AbSGXWsY>; Wed, 24 Jul 2002 18:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317806AbSGXWsY>; Wed, 24 Jul 2002 18:48:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:1710 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317643AbSGXWsW> convert rfc822-to-8bit;
	Wed, 24 Jul 2002 18:48:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: 2.4.19-rc3-ac2 SMP
Date: Wed, 24 Jul 2002 15:50:25 -0700
User-Agent: KMail/1.4.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207241643010.17209-100000@linux-box.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0207241643010.17209-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207241550.25413.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 July 2002 08:26 am, Zwane Mwaikambo wrote:
> On Tue, 23 Jul 2002, James Cleverdon wrote:
> > Drat!  I thought I had all the logical vs. physical stuff straightened
> > out. Could you give this patch a try?  It dumps all kinds of APIC state
> > info. You'll need to put a call to apic_state_dump() into check_timer()
> > just after the TIMER: printk.
>
> ID=0x02000000, LVR=0x00170011, TPR=0x00000000, ARB=0x00000002,
> PROCPRI=0x000000F0 DFR=0x0FFFFFFF, LDR=0x01000000, ICR=0x00088500,
> SPIV=0x000001FF, ICR=0x00088500, ICR2=0x03000000, LVTT=0x00000000,
> LVTPC=0x00000000
> LVT0=0x00010700, LVT1=0x00000400, LVTERR=0x000000FE
> ISR: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 TMR: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 IRR: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000 clustered_apic_mode=0, esr_disable=0,
> target_cpus=0x00 apic_broadcast_id=0x0F raw_phys_apicid[]=       00 01 02
> 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00
> cpu_2_logical_apicid[]=  01 01 02 08 FF FF FF FF FF FF FF FF FF FF FF FF FF
> FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF

The logical numbers are bad.  They should go 01 02 04 08... on a flat box.  
(NUMA boxes are different.)  I'll double check the code; am probably making 
stupid assumptions, especially given the physical IDs below.

> cpu_2_physical_apicid[]= 02 00 01 03 FF FF FF FF FF FF FF FF FF FF FF FF FF
> FF F F FF FF FF FF FF FF FF FF FF FF FF FF FF
> I/O APIC # 0:
> 00: 00000931:04000000 00010939:02000000 00010000:00000000 00000941:0F000000
> 04: 00000949:0F000000 00000951:0F000000 00010959:02000000 00000961:0F000000
> 08: 00000969:0F000000 00000971:0F000000 00000979:0F000000 00000981:0F000000
> 0C: 00000989:0F000000 00000991:0F000000 00000999:0F000000 000009A1:0F000000
> 10: 00010000:00000000 00010000:00000000 00010000:00000000 00010000:00000000
> 14: 00010000:00000000 00010000:00000000 00010000:00000000 00010000:00000000
>
> > (Hmmm....  Must clean up this patch and submit it to kdb as two new
> > commands, one for I/O APICs and one for local APICs....)
>
> i'd vote for that =) except for one thing.
>
> +       /* APICs tend to spasm when they get errors.  Disable the error
> intr. */ +       apic_write_around(APIC_LVTERR, ERROR_APIC_VECTOR |
> APIC_LVT_MASKED);
>
> Isn't that a bit drastic?

No.   ;^) 

When a local APIC weirds out and starts spewing interrupts as fast as it can 
generate them, it can completely paralyze the system.  I suspect that the 
APIC error states aren't as well tested as I'd like.  Anyway, turning off the 
error interrupt is the only way to make enough forward progress to get a 
clean shutdown.  We had these problems with NUMA P6 boxes.  Despite an APIC 
bus analyzer pod on the logic analyzers, we never could find out what was 
making them spasm or find any other halfway satisfactory solution, other than 
to turn off the error interrupt.

> Regards,
> 	Zwane

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

