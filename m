Return-Path: <linux-kernel-owner+w=401wt.eu-S932601AbXARWO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbXARWO0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbXARWOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:14:25 -0500
Received: from terminus.zytor.com ([192.83.249.54]:37363 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932601AbXARWOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:14:25 -0500
Message-ID: <45AFF12D.2070901@zytor.com>
Date: Thu, 18 Jan 2007 14:14:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@openvz.org>
CC: ak@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, devel@vger.kernel.org
Subject: Re: [PATCH] rdmsr_on_cpu, wrmsr_on_cpu
References: <20070118144527.GA6021@localhost.sw.ru>
In-Reply-To: <20070118144527.GA6021@localhost.sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> There was OpenVZ specific bug rendering some cpufreq drivers unusable
> on SMP. In short, when cpufreq code thinks it confined itself to
> needed cpu by means of set_cpus_allowed() to execute rdmsr, some
> "virtual cpu" feature can migrate process to anywhere. This triggers
> bugons and does wrong things in general.
> 
> This got fixed by introducing rdmsr_on_cpu and wrmsr_on_cpu executing
> rdmsr and wrmsr on given physical cpu by means of
> smp_call_function_single().
> 
> Dave Jones mentioned cpufreq might be not only user of rdmsr_on_cpu()
> and wrmsr_on_cpu(), so I'm going to put them into arch/i386/lib/
> (after patch gets some more testing othen than compile and UP run)

The CPUID and MSR drivers need something like this.

HOWEVER -- and this is where things get gnarly -- the CPUID and MSR 
drivers would really like to be able to execute CPUID, WRMSR and RDMSR 
with the entire GPR register set (except the stack pointer) pre-set and 
post-captured, since it's highly likely that there are going to be 
nonstandard MSRs and CPUID levels (already witness Intel breaking the 
CPUID architecture by introducing %ecx dependencies.)

So I would like to see:

/* It probably makes sense to use the same structure on x86 and
    x86-64 */
struct x86_gpr_regs {
	u64 rax, rcx, rdx, rbx;
	u64 rsp, rbp, rsi, rdi;
	u64 r8, r9, r10, r11;
	u64 r12, r13, r14, r15;
};

void rdmsr_on_cpu(unsigned cpu,
	const struct x86_gpr_regs *in, struct x86_gpr_regs *out);
void wrmsr_on_cpu(unsigned cpu,
	const struct x86_gpr_regs *in, struct x86_gpr_regs *out);
void cpuid_on_cpu(unsigned cpu,
	const struct x86_gpr_regs *in, struct x86_gpr_regs *out);

This requires assembly to do in the nonparavirtualized case, of course. 
  I'll try to get that written up in the next day or so.

	-hpa
