Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbULaE4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbULaE4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 23:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbULaE4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 23:56:18 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:25985 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261830AbULaEzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 23:55:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bOKhCufP6FvxKyVAm/LI638S0L/Rl7qzJJGPFp1BKfuMRZgKzNmTLc59Qh3EJTH8bAOgUI/TTj7T1IoItWa00XcMtG6k2nXaZmdWFRwTtr43N3Mtd2ZS2j1J9rAyjsd2LcWg9kTsVqeqL0gI6tyrDJ/5+s1tftVTvHxIeKKud8Y=
Message-ID: <5304685704123020553f0ef982@mail.gmail.com>
Date: Thu, 30 Dec 2004 21:55:53 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
Cc: Davide Libenzi <davidel@xmailserver.org>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
In-Reply-To: <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
	 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
	 <53046857041230112742acccbe@mail.gmail.com>
	 <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 14:46:17 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> Ok, here's a patch that may or may not make Wine happier. It's a _lot_
> more careful about TF handling, and in particular it's trying really
> really hard to make sure that a controlling process does not change the
> trap flag as it is modified or used by the process.
> 
> This hopefully fixes:
> 
>  - single-step over "popf" should work - we won't clear TF after the popf,
>    but instead let the popf results remain.
> 
>    NOTE! I tried to make sure that it does the right thing for segments
>    with non-zero bases, but I never actually tested that code. It's fairly
>    obvious, but it's also fairly likely to have some silly problems. Wine
>    may well show effects of this, although I don't know how common
>    non-zero bases are with any kind of half-modern windows binaries.
> 
>  - ptrace reporting of "eflags" register after a single-step (we used to
>    report TF as being set because the debugger set it - even though the
>    "native state" without debugging had it cleared).
> 
>    This also hopefully means that all the conditional TF clearing games
>    etc aren't necessary, since arch/i386/kernel/traps.c should now be
>    taking care of hiding the debugger for most cases ("pushf" still
>    remains, and is hard. See comment in ptrace.c part of the patch)
> 
> It's a bit more involved than I'd like, since especially the "popf" case
> just is pretty complex, but I'd love to hear whether it works.
> 
> NOTE NOTE NOTE! I've tested it, but only on one small test-case, so it
> might be totally broken in many ways. I'd love to have people who are x86
> and ptrace-aware give this a second look, and I'm confident Jesse will
> find that it won't work, but can hopefully try to debug it a bit with
> this..
> 

Well I tried this patch and it works.  I captured a log showing the
signals and eflags again when running the program.  I compared it to
the working version.  There are differences, but none seem to be the
scenario TF was not set when it should have been.  Both log files are
just about the same size too.  I captured a second log in a row, and
compared the previous.  Again there are differences, so there is some
unavoidable randomness.

Since I cannot spot any issue, the patch looks good.  Are there any
other test cases?

Jesse
