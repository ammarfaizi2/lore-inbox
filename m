Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVABDqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVABDqg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 22:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVABDqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 22:46:36 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:25744 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261242AbVABDqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 22:46:31 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 1 Jan 2005 19:46:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Jesse Allen <the3dfxdude@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0501011406330.2280@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501011424210.3870@bigblue.dev.mdolabs.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <1104401393.5128.24.camel@gamecube.scs.ch>  <1104411980.3073.6.camel@littlegreen>
  <200412311413.16313.sailer@scs.ch>  <1104499860.3594.5.camel@littlegreen>
 <53046857041231074248b111d5@mail.gmail.com> <Pine.LNX.4.58.0412310753400.10974@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412311359460.2280@ppc970.osdl.org>
 <Pine.LNX.4.58.0501011357030.3870@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0501011406330.2280@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jan 2005, Linus Torvalds wrote:

> On Sat, 1 Jan 2005, Davide Libenzi wrote:
> > 
> > I used the test program below on 2.4.27, 2.6.8.1 and latest BK + TF-careful. 
> > In all cases single stepping over POPF succeeded.
> 
> I don't think you realize what the failure case for popf was.
>
> It wasn't that we couldn't single-step it: it was that we corrupted the 
> resulting elfags value after single-stepping it.

I thought you were saying that we cleared TF, and this resulted in ptrace 
losing control over the tracee becasue of the missing flag. But yeah, TF 
reporting has always been broken.



> Try to extend your program to print out not only the EIP after the 
> single-step, but also the value of EFLAGS, and you'll see what I mean. 
> Earlier kernels are _really_ bad at it: they'll always report that TF is 
> set. The "TF-careful" patch gets TF right for normal instructions, and the 
> "TF-popf" patch gets TF right after popf too.
> 
> The one remaining case I know of where we still get TF wrong is "pushf",
> where single-stepping a pushf will not corrupt TF, but it will save the
> wrong value on the stack (which obviously may corrupt TF _later_, when the
> paired "popf" happens).

That would be even trickier than the POPF case. Do you really want to go 
there? Anyway, the TF-careful fixes Wine and single-step-after-syscall, 
and on top of that brings some needed cleanup. It still remain to be 
verfied the strace case, for which I do not have a testcase. Looking at 
how we handle things in TF-careful, it should be fine too.


- Davide

