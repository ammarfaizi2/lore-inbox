Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbULaFgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbULaFgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 00:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbULaFgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 00:36:43 -0500
Received: from nevyn.them.org ([66.93.172.17]:19397 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261616AbULaFgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 00:36:41 -0500
Date: Fri, 31 Dec 2004 00:36:18 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesse Allen <the3dfxdude@gmail.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
Message-ID: <20041231053618.GA25850@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jesse Allen <the3dfxdude@gmail.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
	Eric Pouech <pouech-eric@wanadoo.fr>,
	Roland McGrath <roland@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
References: <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com> <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <20041230230046.GA14843@nevyn.them.org> <Pine.LNX.4.58.0412301513200.22893@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412301513200.22893@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 03:17:01PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 30 Dec 2004, Daniel Jacobowitz wrote:
> > 
> > does not look right to me.  Before, we'd get an 0x80|SIGTRAP result
> > from wait.  Now, you've moved the 0x80 to live only inside the siginfo.
> > This is accessible to the debugger via ptrace, but only very recently
> > (late 2.5.x).  So this will probably break users of PT_TRACESYSGOOD.
> 
> I don't see how to easily emulate the old behaviour 100% - see
> ptrace_notify. We always sent the signal SIGTRAP to the process, and then
> set "exit_code" tp have the 0x80 marker by calling ptrace_stop() by hand.
> However, if we make it a real signal (which we need to do to get the 
> continue semantics right), we no longer have that out-of-band info 
> available to us.
> 
> We could make "get_signal_to_deliver()" pass in some other exit_code to 
> ptrace_stop() than just signr. It would have to pick it up from the 
> siginfo structure, but then we'd have to make sure that _other_ signal 
> users do that properly..
> 
> Patches/suggestions welcome.

Well, you put SIGTRAP|0x80 in si_code.  Coincidentally, 0x80 is
SI_KERNEL.  So testing for SI_KERNEL | 0x80 is probably OK in the
signal path, since most of its other arbitrary values would be either
negative or not include SI_KERNEL.

-- 
Daniel Jacobowitz
