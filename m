Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTJWQu3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 12:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbTJWQu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 12:50:29 -0400
Received: from thunk.org ([140.239.227.29]:5612 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263614AbTJWQu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 12:50:27 -0400
Date: Thu, 23 Oct 2003 12:46:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Michael Glasgow <glasgowNOSPAM@beer.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: posix capabilities inheritance
Message-ID: <20031023164616.GA552@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Michael Glasgow <glasgowNOSPAM@beer.net>,
	linux-kernel@vger.kernel.org
References: <200310211126.h9LBQjx4097592@dark.beer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310211126.h9LBQjx4097592@dark.beer.net>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 06:26:45AM -0500, Michael Glasgow wrote:
> I wrote a simple setuid-root wrapper which sets some capabilities, 
> gives up all other privs, and and then execs a shell.  I was hoping
> to use this wrapper as a login shell so that I could have a user  
> log in interactively with a small subset of elevated privileges.
> 
> Unfortunately after looking over the capabilities code in the 2.4
> kernel, it would appear that this is not currently possible, and
> my wrapper cannot work without filesystem support for capabilities.
> And even then, I'd have to set each file's inheritable flag for the
> capabilities I want on every executable that I am likely to run,
> including the shell.  Am I mising something, or is this an accurate
> description?

No, you're not missing anything.

What happened here is that originally there was a security
vulnerability caused by an a badly desgined attempt to take advantage
of capabilities without filesystem support.  In order to fix it, the
patch took a very conservative path, which completely disabled the use
of selective capability inheritance.  (Capabilities are still useful,
but only in setuid root programs that selectively drop unneeded
capabilities --- still in my opinion the best way to use capabilities,
BTW).

> As an interim workaround, how about assuming all capabilities are
> inheritable in fs/exec.c:prepare_binprm, i.e. instead of
> cap_clear(bprm->cap_inheritable), call cap_set_full() ???  I don't
> think this would break anything, and it would make capabilities a
> lot more useful until we get fs support merged in.

I agree this is safe, and allows the use of your setuid wrapper
script.  The one reason why I think it's better to modify programs is
that it's too easy for individual system administrators to screw up
the configuration used by your wrapper script, and accidentally
introduce a security vulnerability into their system.  It's dangerous
to give a program some capability (or reduce the capability given to a
program designed to be setuid) without examining the source code and
being clueful.  So by making the program setuid and editing the source
code to add an explicit capability drop in the program is much, much
safer compared to having a random system administrator to edit a
config file and trust that he or she does so correctly.

						- Ted
