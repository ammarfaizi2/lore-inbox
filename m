Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVGGUBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVGGUBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVGGT6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:58:54 -0400
Received: from buffy.riseup.net ([69.90.134.155]:10189 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S262284AbVGGT5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:57:36 -0400
Date: Thu, 7 Jul 2005 22:00:27 +0200
From: st3@riseup.net
To: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: enhanced intel speedstep feature was Re: speedstep-centrino on
 dothan
Message-ID: <20050707220027.413343d4@horst.morte.male>
In-Reply-To: <20050706235557.0c122d33@horst.morte.male>
References: <20050706112202.33d63d4d@horst.morte.male>
	<42CC37FD.5040708@tmr.com>
	<20050706211159.GF27630@redhat.com>
	<20050706235557.0c122d33@horst.morte.male>
X-Mailer: Sylpheed-Claws 1.9.12 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Ramalhais found another interesting thing in:
ftp://download.intel.com/design/Pentium4/manuals/25366816.pdf

that's the IA32_CLOCK_MODULATION (still called
MSR_IA32_THERM_CONTROL in include/asm-i386/msr.h, and I think this would
need a fix) register, that let set a reduced CPU duty cycle. So just today I
coded something to use it.

Just add to speedstep-centrino.c:
[yes I know, this isn't the Right Coding Style, but it's just to give an
idea of the whole thing]

static int sccm_level = 0;
module_param(sccm_level, uint, 0644);
MODULE_PARM_DESC(sccm_level, "Software Controlled Clock Modulation level: 0
	for disabling, 7 for 12.5\% duty cycle");

in the first part, right after the third #define

and this function after centrino_target():

static int centrino_target_sccm ()
{
        unsigned int msr, h;
        
        rdmsr(MSR_IA32_THERM_CONTROL, msr, h);
        msr &= (0<<1); msr &= (0<<2); msr &= (0<<3);

        switch (sccm_level) {
		case 0:
			msr &= (0<<4);
                case 1:
                        msr |= (1<<4); msr |= (1<<3); msr |= (1<<2);
			msr |= (1<<1); break;
		case 2:
                        msr |= (i<<4); msr |= (1<<3); msr |= (1<<2); break;
                case 3:
                        msr |= (1<<4); msr |= (1<<3); msr |= (1<<1); break;
                case 4:
                        msr |= (1<<4); msr |= (1<<3); break;
                case 5:
                        msr |= (1<<4); msr |= (1<<2); msr |= (1<<1); break;
                case 6:
                        msr |= (1<<4); msr |= (1<<2); break;
                case 7:
                        msr |= (1<<4); msr |= (1<<1); break;
        }

        wrmsr (MSR_IA32_THERM_CONTROL, msr, h);
}

Then you'll just have to insmod speedstep-centrino.ko sccm_level=x, where x
can be 0 to disable software cycle control modulation, 1 to enable a
reduced duty cycle of 87.5%, 7 to enable a duty cycle of 12.5% and so on.

Enabling, say, a duty cycle of 12.5% means that the CPU chip will be driven
by clock just one time every eight, thus reducing power consumption and
temperature (and it speeds down dramatically the CPU, too =).

I tested it so far on my Pentium M Dothan 715 and on a Dothan 725.

What do you think, could this be useful? I could provide a patch or a
stand-alone module. Should I write an interface to sysfs?


--
ciao
st3

