Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbUL3XRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUL3XRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 18:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUL3XRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 18:17:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:13504 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261754AbUL3XRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 18:17:24 -0500
Date: Thu, 30 Dec 2004 15:17:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Jesse Allen <the3dfxdude@gmail.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <20041230230046.GA14843@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0412301513200.22893@ppc970.osdl.org>
References: <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
 <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <20041230230046.GA14843@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Dec 2004, Daniel Jacobowitz wrote:
> 
> does not look right to me.  Before, we'd get an 0x80|SIGTRAP result
> from wait.  Now, you've moved the 0x80 to live only inside the siginfo.
> This is accessible to the debugger via ptrace, but only very recently
> (late 2.5.x).  So this will probably break users of PT_TRACESYSGOOD.

I don't see how to easily emulate the old behaviour 100% - see
ptrace_notify. We always sent the signal SIGTRAP to the process, and then
set "exit_code" tp have the 0x80 marker by calling ptrace_stop() by hand.
However, if we make it a real signal (which we need to do to get the 
continue semantics right), we no longer have that out-of-band info 
available to us.

We could make "get_signal_to_deliver()" pass in some other exit_code to 
ptrace_stop() than just signr. It would have to pick it up from the 
siginfo structure, but then we'd have to make sure that _other_ signal 
users do that properly..

Patches/suggestions welcome.

		Linus
