Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWJFFdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWJFFdT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWJFFdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:33:18 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:23253 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751357AbWJFFdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:33:17 -0400
Subject: Re: tracepoint maintainance models
From: Steven Rostedt <rostedt@goodmis.org>
To: Vara Prasad <prasadav@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       systemtap <systemtap@sourceware.org>
In-Reply-To: <450F0180.1040606@us.ibm.com>
References: <20060917143623.GB15534@elte.hu>
	 <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu>
	 <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu>
	 <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu>
	 <1158594491.6069.125.camel@localhost.localdomain>
	 <20060918152230.GA12631@elte.hu>
	 <1158596341.6069.130.camel@localhost.localdomain>
	 <20060918161526.GL3951@redhat.com>
	 <1158598927.6069.141.camel@localhost.localdomain>
	 <450EEF2E.3090302@us.ibm.com>
	 <1158608981.6069.167.camel@localhost.localdomain>
	 <450F0180.1040606@us.ibm.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 01:33:11 -0400
Message-Id: <1160112791.30146.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coming into this really late, and I'm still behind in reading this and
related threads, but I want to throw this idea out, and it's getting
late.

On Mon, 2006-09-18 at 13:28 -0700, Vara Prasad wrote:
> Alan Cox wrote:
> 
> >
> >>This still doesn't solve the problem of compiler optimizing such that a 
> >>variable i would like to read in my probe not being available at the 
> >>probe point.
> >>    
> >>
> >
> >Then what we really need by the sound of it is enough gcc smarts to do
> >something of the form
> >
> >	.section "debugbits"
> >	
> >	.asciiz 'hook_sched'
> >	.dword l1	# Address to probe
> >	.word 1		# Argument count
> >	.dword gcc_magic_whatregister("next"); [ reg num or memory ]
> >	.dword gcc_magic_whataddress("next"); [ address if exists]
> >
> >
> >Can gcc do any of that for us today ?
> >
> >  
> >
> No, gcc doesn't do that today.
> 
> 


---- cut here ----
#include <stdio.h>

#define MARK(label, var)			\
	asm ("debug_" #label ":\n"		\
	     ".section .data\n"			\
	     #label "_" #var ": xor %0,%0\n"	\
	     ".previous" : : "r"(var))


static int func(int a)
{
	int y;
	int z;

	y = a;
	MARK(func, y);
	z = y+2;

	return z;

}



static void read_label(void)
{
	extern unsigned short regA;
	unsigned short *r = &regA;
	char *regs[] = {
		"A", "B", "C", "D", "DI", "BP", "SP", "CH"
	};
	int i;
	extern unsigned short func_y;
	extern unsigned long debug_func;

	asm (".section .data\n"
	     "regA: xor %eax,%eax\n"
	     "regB: xor %ebx,%ebx\n"
	     "regC: xor %ecx,%ecx\n"
	     "regD: xor %edx,%edx\n"
	     "regDI: xor %edi,%edi\n"
	     "regBP: xor %ebp,%ebp\n"
	     "regSP: xor %esp,%esp\n"
	     ".previous");

	for (i=0; i < 7; i++) {
		if (r[i] == func_y)
			break;
	}
	if (i < 7)
		printf("func y is in reg %s at %p\n",
		       regs[i],
		       &debug_func);
	else
		printf("func y not found!\n");
}

int main (int argc, char **argv)
{
	int g;
	g = func(argc);
	read_label();
	return g;
}
---- end cut ----

$ gcc -O2 -o mark mark.c
$ ./mark
func y is in reg B at 0x80483ce



Now the question is, isn't MARK() in this code a non intrusive marker?

So couldn't a kprobe be set at "debug_func" and we can find what
register "y" is without adding any overhead to the code being marked?

Obviously, this would need to be done special for each arch.

-- Steve


