Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUDAHF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 02:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUDAHF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 02:05:58 -0500
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:21686 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S262175AbUDAHFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 02:05:55 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Date: Thu, 01 Apr 2004 09:04:08 +0200
MIME-Version: 1.0
Subject: Re: 2.4.21 on Itanium2: floating-point assist fault at ip 400000000062ada1, isr 0000020000000008
CC: linux-kernel@vger.kernel.org
Message-ID: <406BDB07.6325.3F7C64@localhost>
In-reply-to: <200403311900.17293.vda@port.imtp.ilyichevsk.odessa.ua>
References: <406AE0D5.10359.1930261@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.77+2.18+2.07.040+05 January 2004+87305@20040401.070341Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK,

thanks guys for the answers: It seems to be a hint that an instruction can't 
be done in hardware, but has to be emulated instead. I tried to find the 
offending code, and I was surprised that is't not a complicated function:

                br.few 0x400000000062aca0 <ab_CompManyEq+384>
0x400000000062ad70 <ab_CompManyEq+592>: [MII]       nop.m 0x0
0x400000000062ad71 <ab_CompManyEq+593>:             zxt4 r14=r44;;
0x400000000062ad72 <ab_CompManyEq+594>:             add r15=r35,r14
0x400000000062ad80 <ab_CompManyEq+608>: [MMI]       add r14=r34,r14;;
0x400000000062ad81 <ab_CompManyEq+609>:             ldfd f7=[r14]
0x400000000062ad82 <ab_CompManyEq+610>:             nop.i 0x0
0x400000000062ad90 <ab_CompManyEq+624>: [MMI]       ldfd f6=[r15];;
0x400000000062ad91 <ab_CompManyEq+625>:             nop.m 0x0
0x400000000062ad92 <ab_CompManyEq+626>:             nop.i 0x0
0x400000000062ada0 <ab_CompManyEq+640>: [MFI]       nop.m 0x0
0x400000000062ada1 <ab_CompManyEq+641>:             fcmp.eq.s0 p7,p6=f7,f6 <<<
0x400000000062ada2 <ab_CompManyEq+642>:             nop.i 0x0;;
0x400000000062adb0 <ab_CompManyEq+656>: [MIB]       nop.m 0x0
0x400000000062adb1 <ab_CompManyEq+657>:             nop.i 0x0

(when attaching to the process with gdb)

Thanks and regards,
Ulrich

On 31 Mar 2004 at 19:00, Denis Vlasenko wrote:

> On Wednesday 31 March 2004 15:16, Ulrich Windl wrote:
> > Hello,
> >
> > I did try to find an answer is SuSE's support database, not in SAP's
> > support database, and also did search Google, but could not find an answer:
> >
> > We run SuSE Linux Enterprise Server 8 (SLES8) on a HP rx4640 Itanium2
> > server with 2 CPUs (family: Itanium 2, model: 1, revision: 5, archrev: 0).
> >
> > In syslog is do see periodic kernel messages (with no implicit priority)
> > that read:
> >
> > dw.sapC11_DVS02(14393): floating-point assist fault at ip 400000000062ada1,
> > isr 0000020000000008
> >
> > ("dw.sapC11_DVS02" is a SAP R/3 work process (46D_EXT, patch 1754, for
> > those who care)
> >
> > Can anybody explain what this message means? Is it an application problem,
> > or is it a kernel problem?
> 
>         static int fpu_swa_count = 0;
>         static unsigned long last_time;
> ...
>         if (jiffies - last_time > 5*HZ)
>                 fpu_swa_count = 0;
>         if ((fpu_swa_count < 4) && !(current->thread.flags & IA64_THREAD_FPEMU_NOPRINT)) {
>                 last_time = jiffies;
>                 ++fpu_swa_count;
>                 printk(KERN_WARNING "%s(%d): floating-point assist fault at ip %016lx, isr %016lx\n",
>                        current->comm, current->pid, regs->cr_iip + ia64_psr(regs)->ri, isr);
>         }
> 
> kernel says that you have them too frequently, which probably
> impairs efficiency. It's a hint to programmer.
> --
> vda
> 
> 



