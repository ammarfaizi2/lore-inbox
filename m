Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVAAWOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVAAWOl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 17:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVAAWOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 17:14:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:16803 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261191AbVAAWOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 17:14:38 -0500
Date: Sat, 1 Jan 2005 14:14:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Jesse Allen <the3dfxdude@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0501011357030.3870@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0501011406330.2280@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <1104401393.5128.24.camel@gamecube.scs.ch>  <1104411980.3073.6.camel@littlegreen>
  <200412311413.16313.sailer@scs.ch>  <1104499860.3594.5.camel@littlegreen>
 <53046857041231074248b111d5@mail.gmail.com> <Pine.LNX.4.58.0412310753400.10974@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412311359460.2280@ppc970.osdl.org>
 <Pine.LNX.4.58.0501011357030.3870@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Jan 2005, Davide Libenzi wrote:
> 
> I used the test program below on 2.4.27, 2.6.8.1 and latest BK + TF-careful. 
> In all cases single stepping over POPF succeeded.

I don't think you realize what the failure case for popf was.

It wasn't that we couldn't single-step it: it was that we corrupted the 
resulting elfags value after single-stepping it.

Try to extend your program to print out not only the EIP after the 
single-step, but also the value of EFLAGS, and you'll see what I mean. 
Earlier kernels are _really_ bad at it: they'll always report that TF is 
set. The "TF-careful" patch gets TF right for normal instructions, and the 
"TF-popf" patch gets TF right after popf too.

The one remaining case I know of where we still get TF wrong is "pushf",
where single-stepping a pushf will not corrupt TF, but it will save the
wrong value on the stack (which obviously may corrupt TF _later_, when the
paired "popf" happens).

It's sad that x86 put the single-stepping into a user-visible register.  
All the other debug state is kernel-only, meaning that we don't have to
play any games with them... It would have been nice if Intel had added a
"single-step" bit to %db7, and then just or'ed in the values of TF and the
new flag when deciding to single-step. That would have allowed the legacy
stuff to work, and given debuggers a much less intrusive way to single-
step.

		Linus
