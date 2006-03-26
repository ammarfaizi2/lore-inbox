Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWCZAwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWCZAwJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 19:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWCZAwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 19:52:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932166AbWCZAwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 19:52:08 -0500
Date: Sat, 25 Mar 2006 19:51:58 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: Re: [PATCH] x86_64: Force broadcast timer on AMD systems with C3 too.
Message-ID: <20060326005158.GC30480@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ak@suse.de
References: <200603251813.k2PID0xC014763@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603251813.k2PID0xC014763@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 06:13:00PM +0000, Linux Kernel wrote:
 > commit bd6633476922b7b51227f7f704c2546e763ae5ed
 > tree 4e9844781419fe600c3e9f3e9dab8207f8dd12dd
 > parent 7682968b7d4d42bb076051b962c3926b4c98539a
 > author Andi Kleen <ak@suse.de> Sat, 25 Mar 2006 16:31:07 +0100
 > committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 26 Mar 2006 01:10:56 -0800
 > 
 > [PATCH] x86_64: Force broadcast timer on AMD systems with C3 too.

this breaks ia64.

drivers/acpi/processor_idle.c: In function 'acpi_processor_power_verify':
drivers/acpi/processor_idle.c:919: error: 'switch_APIC_timer_to_ipi' undeclared (first use in this function)
drivers/acpi/processor_idle.c:919: error: (Each undeclared identifier is reported only once
drivers/acpi/processor_idle.c:919: error: for each function it appears in.)

 >  #ifdef ARCH_APICTIMER_STOPS_ON_C3
 > -			if (cx->valid && c->x86_vendor == X86_VENDOR_INTEL) {
 > -				on_each_cpu(switch_APIC_timer_to_ipi,
 > -						&mask, 1, 1);
 > -			}
 > +			if (cx->valid)
 > +				timer_broadcast++;
 >  #endif
 >  			break;
 >  		}
 > @@ -913,6 +915,9 @@ static int acpi_processor_power_verify(s
 >  			working++;
 >  	}
 >  
 > +	if (timer_broadcast)
 > +		on_each_cpu(switch_APIC_timer_to_ipi, &mask, 1, 1);
 > +

Looks like it needs wrapping in that ifdef ?

		Dave


-- 
http://www.codemonkey.org.uk
