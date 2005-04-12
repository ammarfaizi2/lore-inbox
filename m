Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVDLM10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVDLM10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVDLMY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:24:28 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:2185 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S262335AbVDLMVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:21:35 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Stas Sergeev <stsp@aknet.ru>
Subject: Re: 2.6.12-rc2-mm3
Date: Tue, 12 Apr 2005 14:22:01 +0200
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, jamagallon@able.es,
       linux-kernel@vger.kernel.org
References: <20050411012532.58593bc1.akpm@osdl.org> <20050411152243.22835d96.akpm@osdl.org> <425B4C92.1070507@aknet.ru>
In-Reply-To: <425B4C92.1070507@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504121422.02628.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 April 2005 06:20, Stas Sergeev wrote:

Here we go again:

You might be right about the int3 instruction:

(gdb) disas 0xc0102ee0
Dump of assembler code for function restore_all:
0xc0102ed1 <restore_all+0>:     mov    0x30(%esp),%eax
0xc0102ed5 <restore_all+4>:     mov    0x2c(%esp),%al
0xc0102ed9 <restore_all+8>:     test   $0x20003,%eax
0xc0102ede <restore_all+13>:    je     0xc0102ee7 <resume_kernelX>
0xc0102ee0 <restore_all+15>:    cmpl   $0x0,0x14(%ebp)
0xc0102ee4 <restore_all+19>:    je     0xc0102ee7 <resume_kernelX>
0xc0102ee6 <restore_all+21>:    int3
End of assembler dump.

> Could you please also do
> "p $esp" or "info reg", so that we can
> see the rest of the registers?

Program received signal SIGTRAP, Trace/breakpoint trap.
0xc0102ee7 in resume_kernelX () at atomic.h:175
175     {
(gdb) p $esp
$1 = (void *) 0xdfcb4fc4

(gdb) info reg
eax            0x273    627
ecx            0x0      0
edx            0x10000  65536
ebx            0xb7fd9c00       -1208116224
esp            0xdfcb4fc4       0xdfcb4fc4
ebp            0xbfbd5948       0xbfbd5948
esi            0x77     119
edi            0x1cb    459
eip            0xc0102ee7       0xc0102ee7
eflags         0x82     130
cs             0x60     96
ss             0x68     104
ds             0xc010007b       -1072693125
es             0xdfcb007b       -540344197
fs             0xffff   65535
gs             0xffff   65535
(gdb)
> >> And as we see, we're at the "mov    0x30(%esp),%eax" which accesses
> >> above the bottom of the stack.
>
> But that's strange. Another instance of
> the 0x30(%esp) is there a few instructions
> above this one, see it with "disas restore_all".
> It is much more likely that the real offender
> is the previous instruction. $eip points on
> the instruction *after* the trap, which might
> be innocent.
>
> >> After applying nmi_stack_correct-fix.patch, rc2-mm3
>
> I can't find this one in an -mm broken-outs.
> Where is this patch?
> Could you please also test this one:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0504.0/1287.html
>
> > Interesting.  It could be an interaction between the kgdb patch and the
> > new vm86 checking code.
>
> I think so too, will have a look if I can
> reproduce it.
>
> > The above code is accessing esp+56,
>
> Yes, but this particular instruction was
> not reached. "int $3" killed the system
> for some reasons.
>
> > -	p->thread.esp0 = (unsigned long) (childregs+1) - 8;
> > +	p->thread.esp0 = (unsigned long) (childregs+1) - 15;
<snip>

So, as next I'm gonna try disabling CONFIG_TRAP_BAD_SYSCALL_EXITS and see what 
happens there and then the stack-aligned process.c one liner above.
/me open to testing suggestions.

Regards,
Boris.
