Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTJ1Oai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 09:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTJ1Oai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 09:30:38 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:519 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263980AbTJ1Oag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 09:30:36 -0500
Subject: Re: [pm] fix time after suspend-to-*
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Patrick Mochel <mochel@osdl.org>, George Anzinger <george@mvista.com>,
       John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031028093233.GA1253@elf.ucw.cz>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>
	 <1067329994.861.3.camel@teapot.felipe-alfaro.com>
	 <20031028093233.GA1253@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1067351431.1358.11.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Tue, 28 Oct 2003 15:30:31 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-28 at 10:32, Pavel Machek wrote:

> > Many userspace applications are not prepared for suspension, like
> > Evolution. When suspending the machine for a long time, all IMAP
> > sessions are broken as their counterpart TCP sockets timeout. While
> > resuming, Evolution is unable to handle this condition and simply
> > informs the network connection has been dropped.
> > 
> > What about sending the SIGPWR signal to all userspace processes before
> > suspending so applications like Evolution can be improved to handle this
> > signal, drop their IMAP connections and then, when resuming, reestablish
> > them?
> 
> Not sure... We do not want applications to know. Certainly we can't
> send a signal; SIGPWR already has some meaning and it would be bad to
> override it.

OK, maybe using SIGPWR is not a good idea, but some userspace
applications need to know when the system is going to sleep. Even more,
userspace apps should be able to tell the kernel whether suspending the
system at a given moment is a good idea or not.

Examples:

1. Network connections must be reestablished. A userspace program can't
try to automatically reestablish a broken TCP connection for no apparent
reason. A broken TCP connection could be the cause of an overloaded or
broken server/service. If we do not inform userspace processes that the
system is going to sleep (or that the system has been brought up from
standby), they will blindly try to restore TCP connections back, even
when the remote server is broken, generating a lot of unnecesary
traffic.

2. Sound: I've been unable to suspend via APM with the Yamaha YMFPCI
driver loaded. I need to unload it, but I can't unload it if there is
some app using the sound driver. Before going to sleep, sound-aware apps
could be informed that the system is being put to sleep so that they
stop playing sound gracefully. Thus, the sound driver could be unloaded.

3. CD/DVD burners: Some userspace apps should be able to try to avoid
suspending the system. Imagine what could happen if average joe user
tries to suspend while burning a CD. The CD recording app should be able
to notify the kernel that a real-time sensitive operation is being taken
place. A policy-based decision system could take the responsibility to
prevent the system from entering suspension or ignore the userspace
application and force the suspend, for example, to prevent losing data
when a laptop is really, really low on batteries.

Don't know if I'm able to convince you ;-)

