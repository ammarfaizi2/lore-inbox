Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWJHIOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWJHIOt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 04:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWJHIOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 04:14:49 -0400
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:61573
	"EHLO saville.com") by vger.kernel.org with ESMTP id S1750904AbWJHIOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 04:14:48 -0400
Message-ID: <4528B377.2050104@saville.com>
Date: Sun, 08 Oct 2006 01:14:47 -0700
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Arjan van de Ven <arjan@infradead.org>, Matthias Hentges <oe@hentges.net>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Hang in fb_notifier_call_chain with nvidia framebuffer
References: <45206777.7020405@saville.com>	<1159808447.4652.6.camel@mhcln03>	<4521E326.2000406@saville.com>	<1159882225.2891.525.camel@laptopd505.fenrus.org>	<4523E09C.9000609@saville.com> <20061007230129.323ac807.akpm@osdl.org>
In-Reply-To: <20061007230129.323ac807.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 04 Oct 2006 09:26:04 -0700
> Wink Saville <wink@saville.com> wrote:
> 
>> Attached in the zip file is:
>>
>> log-hang1.txt	-> log showing hang
>> cfg-hang1	-> config file for hang condition
>> cfg-ok		-> config file that works
>> fbmem.c		-> Modifications to register_framebuffer
>>
>> To possibly assist I turned on debugging in nvidia.c and found that it 
>> hung in the call to register_framebuffer. I then added some additional 
>> debug in that routine and it appears the hang occurs in the call to 
>> fb_notifier_call_chain.
>>
>> Please let me know what else maybe needed.
> 
> Please:
> 
> - get sysrq working:
> 
> 	set CONFIG_MAGIC_SYSRQ=y, rebuild, reboot
> 	echo 1 > /proc/sys/kernel/sysrq
> 	dmesg -n 8
> 
> - make it hang
> 
> - Hit alt-sysrq-T
> 
> - Send us the resulting output
> 
> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andrew,

Thank you for the reply, I believe I've found the reason frame buffer doesn't
work on my system, there is a divide by zero occurring at line 157 of
nvGetClocks in ./drivers/video/nvidia/nv_hw.c.

(Note: The screwy output below is due to hacking drivers/serial/8250.c to add two
routines serial_putchar and serial_putchars so that I could make progress looking
for the bug, as printk stopped working at acquire_console_sem called from bind_con_driver.)

Last portion of the output:

@[   97.643286] take_over_console: call bind_con_driver csw=ffffffff805d8600 first=0, last=62, deflt=1
@[   97.652521] bind_con_driver: E
@[   97.655774] bind_con_driver: acquire_console_sem
@1[   97.660604] acquire_console_sem: drivers/char/vt.c:bind_con_driver:2752
@!2345689abABCDEF<fb_con_init>abcdefghij<nvidiafb_set_par>abcd<nvidia_calc_regs>bdjkl<NVCalcStateExt>acei<nv30UpdateArbitrationSettings>a<nv
GetClocks>N=83 NB=0 freq=27000 M=3 MB=0 P=0

>From the above output we see MB=0 and hence death at line 157:

*MClk = ((N * NB * par->CrystalFreqKHz) / (M * MB)) >> P;

It would seem that my hardware (7600 GT K0) is not supported by the driver?
It should also be noted that there are quite a number of divisions
in the nv_hw.c that have no protection against divide by zeros.


