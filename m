Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbUKUWeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbUKUWeM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbUKUWeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:34:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261824AbUKUWeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:34:01 -0500
Date: Sun, 21 Nov 2004 14:33:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Daniel Jacobowitz <dan@debian.org>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
 <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Nov 2004, Davide Libenzi wrote:
> 
> I'd agree with Linus here. A signal handler is part of the application, so 
> it should be single stepped in the same way other application code does. 
> My original patch simply reenabled the flag before returning to userspace, 
> and this had the consequence to single step into signal handlers too.

Hmmm.. I think I may have a test-case for the problem.

Lookie here:

	#include <signal.h>
	#include <sys/mman.h>

	void function(void)
	{
		printf("Copy protected: ok\n");
	}

	void handler(int signo)
	{
		extern char smc;
		smc++;
	}

	#define TF 0x100

	int main(int argc, char **argv)
	{
		void (*fnp)(void);

		signal(SIGTRAP, handler);
		mprotect((void *)(0xfffff000 & (unsigned long)main), 4096, PROT_READ | PROT_WRITE);
		asm volatile("pushfl ; orl %0,(%%esp) ; popfl"
			: :"i" (TF):"memory");
		asm volatile("pushfl ; andl %0,(%%esp) ; popfl"
			: :"i" (~TF):"memory");	
		asm volatile("\nsmc:\n\t"
			".byte 0xb7\n\t"
			".long function"
			:"=d" (fnp));
		fnp();
		exit(1);
	}

Compile it, run it, and it should say

	Copy protected: ok

Now, try to "strace" it, or debug it with gdb, and see if you can repeat 
the behaviour.

Roland? Think of it as a challenge,

		Linus
