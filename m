Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310413AbSCGRMA>; Thu, 7 Mar 2002 12:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310414AbSCGRLu>; Thu, 7 Mar 2002 12:11:50 -0500
Received: from ns.suse.de ([213.95.15.193]:39944 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310413AbSCGRLh>;
	Thu, 7 Mar 2002 12:11:37 -0500
Date: Thu, 7 Mar 2002 18:11:36 +0100
From: Dave Jones <davej@suse.de>
To: Luca Montecchiani <luca.montecchiani@teamfab.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux 2.2.21pre[23]
Message-ID: <20020307181136.J29587@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Luca Montecchiani <luca.montecchiani@teamfab.it>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16j0fe-0002m9-00@the-village.bc.nu> <3C879558.A727E265@teamfab.it> <20020307173948.I29587@suse.de> <3C879E01.B2BFAFCD@teamfab.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C879E01.B2BFAFCD@teamfab.it>; from luca.montecchiani@teamfab.it on Thu, Mar 07, 2002 at 06:06:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 06:06:09PM +0100, Luca Montecchiani wrote:
 > >  Ok, this doesn't make any sense at all.
 > You're right x86_serial_nr_setup() is c0278bc8
 > while c0278bc1 didn't exist in my system.map sorry!

 So we died in squash_the_stupid_serial_number()

static void __init squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
{
    if (c->x86_capability&(X86_FEATURE_PN) && disable_x86_serial_nr) {
        /* Disable processor serial number */
        unsigned long lo,hi;
        rdmsr(0x119,lo,hi);
        lo |= 0x200000;
        wrmsr(0x119,lo,hi);
        printk(KERN_NOTICE "CPU serial number disabled.\n");
        c->x86_capability &= ~X86_FEATURE_PN;
        c->cpuid_level = cpuid_eax(0);
    }
}

Given that you see the printk, its one of the last two lines.
I can't see how this can happen. 
Although the cpuid_eax function in include/asm-i386/processor.h
needs updating.

2.2 has
extern inline unsigned int cpuid_eax(unsigned int op)
{
    unsigned int eax, ebx, ecx, edx;

    __asm__("cpuid"
        : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
        : "a" (op));
    return eax;
}

2.4 has
    unsigned int eax;
    
    __asm__("cpuid"
        : "=a" (eax)
        : "0" (op)
        : "bx", "cx", "dx");
    return eax;


Though, that shouldn't make any noticable difference unless.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
