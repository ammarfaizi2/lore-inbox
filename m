Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUIPTDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUIPTDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 15:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUIPTDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 15:03:32 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:61201 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268064AbUIPTD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 15:03:27 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Stas Sergeev <stsp@aknet.ru>, linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
Date: Thu, 16 Sep 2004 22:03:17 +0300
User-Agent: KMail/1.5.4
References: <4149D243.5050501@aknet.ru>
In-Reply-To: <4149D243.5050501@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409162203.17988.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 20:49, Stas Sergeev wrote:
> Hello.
>
> My question is not directly linux-related,
> but I think people here can give me some clue
> on an issue.
>
> There is a "semi-official" bug in Intel CPUs,
> which is described here:
> http://www.intel.com/design/intarch/specupdt/27287402.PDF
> chapter "Specification Clarifications"
> section 4: "Use Of ESP In 16-Bit Code With 32-Bit Interrupt Handlers".
>
> A short quote:
> "ISSUE: When a 32-bit IRET is used to return to another privilege level,
> and the old level uses a 4G stack (D/B bit in the segment register = 1),
> while the new level uses a 64k stack (D/B bit = 0), then only the
> lower word of ESP is updated."
>
> Which means that the higher word of ESP gets
> trashed. This bug beats dosemu rather badly,
> but there seem to be not much info about that
> bug available on the net.

Well. Strictly speaking it's not a bug.
Code executes as it should. IRET returns to the correct
location. Upper 16 bits of ESP do not affect execution
in this case.

You want CPU to preserve upper bits,
but this will waste a handful of transistors
practically for no gain.

I think dosemu should just work around this.
Is there some subtle problem with that in dosemu?

> What I want to find out, is what CPUs are
> affected. I wrote a small test-case. It is
> attached. I tried it on Intel Pentium and
> on AMD Athlon - bug is present on both. But
> I'd like to know if it is also present on a
> Transmeta Crusoe, Cyrix and other CPUs.
> Can someone please run the test-case on some
> of that CPUs and see how it goes?
> Note: specifying "32" as an arg to the
> test-case, will make it to use the 32bit
> segment for the stack, and it will not detect
> the bug. It is there to prove that it detects
> the Right Thing. Run it without that argument.
>
> I'd also like to know any thoughts on whether
> it is possible to work around the bug, probably
> in a kernel? Well, I am not hoping on such a
> possibility, but who knows...
> Anyway, I'd be glad to get any info on that bug.
> Why it was not fixed for so many years, looks
> also like an interesting question, as for me.

Because it does not matter for 99.9999% of users...

# gcc -O2 stk.c
# ./a.out
sp=0xbffffb30, ss=0x7b
In sighandler: esp=bffffb10
Now sp=0xccf1fb10, ss=0x7f
Esp changed, strange...
# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : Unknown CPU Typ
stepping        : 1
cpu MHz         : 1743.632
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
--
vda

