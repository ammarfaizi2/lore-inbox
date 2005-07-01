Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263129AbVGAAOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbVGAAOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 20:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbVGAAOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 20:14:19 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:15517 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263129AbVGAAOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 20:14:12 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Date: Fri, 1 Jul 2005 02:15:28 +0200
User-Agent: KMail/1.8.1
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org,
       Gene Heskett <gene.heskett@verizon.net>
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu> <200507010027.33079.annabellesgarden@yahoo.de>
In-Reply-To: <200507010027.33079.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507010215.28814.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 1. Juli 2005 00:27 schrieb Karsten Wiese:
> Am Donnerstag, 30. Juni 2005 22:50 schrieb Ingo Molnar:
> > 
> > * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> > 
> > > Here come some numbers to back up the usefullness of 
> > > CONFIG_X86_UP_IOAPIC_FAST. (and to show that my patch actually works 
> > > ;-)) All measurement where taken on an UP Athlon64 2Ghz running 32bit 
> > > 2.6.12-RT-50-35 PREEMPT_RT on a K8T800 mobo.
> > 
> > thanks - the numbers are pretty convincing. I've applied most of your 
> > patch (except the instrumentation bits), and it seems to work quite well 
> > - one of my testsystems that had interrupt storms before can now run 
> > IOAPIC_FAST. (i also enabled the option to be selectable for SMP kernels 
> > too. If things work out fine we can make it default-on.) I've uploaded 
> > the -50-39 patch with these changes included.
> > 
> Ooops, you didn't apply this part of the patch:
> 
> <snip>
> --- linux-2.6.12-RT-50-35/arch/i386/kernel/mpparse.c	2005-06-30 16:38:00.000000000 +0200
> +++ linux-2.6.12-RT/arch/i386/kernel/mpparse.c	2005-06-29 20:30:50.000000000 +0200
> @@ -263,6 +263,7 @@
>  		return;
>  	}
>  	mp_ioapics[nr_ioapics] = *m;
> +	io_apic_base[nr_ioapics] = IO_APIC_BASE(nr_ioapics);
>  	nr_ioapics++;
>  }
>  
> @@ -914,6 +915,7 @@
>  	mp_ioapics[idx].mpc_apicaddr = address;
>  
>  	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
> +	io_apic_base[idx] = IO_APIC_BASE(idx);
>  	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
>  	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
> </snip>
> 
> It provides the precalculation of the ioapics's virtual address.
> Or does IO_APIC_BASE() compile to an indexed lookup?
>  then io_apic_base[] wouldn't be needed...
> 
It is needed (only for optimization):
There are ioapics that have baseaddresses not on a page boundary.
Another idea: to merge the virtual ioapic base addresses into the io_apic_cache struct to use 
the cpu-cache more efficiently ;-) 

Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
