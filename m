Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265192AbTLFPjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 10:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbTLFPjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 10:39:25 -0500
Received: from thunk.org ([140.239.227.29]:51664 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265192AbTLFPjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 10:39:10 -0500
Date: Sat, 6 Dec 2003 10:38:45 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Larry McVoy <lm@work.bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Larry McVoy <lm@bitmover.com>, Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031206153845.GA8552@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Erik Andersen <andersen@codepoet.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Paul Adams <padamsdev@yahoo.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com> <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com> <Pine.LNX.4.58.0312041750270.6638@home.osdl.org> <20031206030037.GB28765@work.bitmover.com> <Pine.LNX.4.58.0312051949210.2092@home.osdl.org> <20031206051433.GA25766@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031206051433.GA25766@work.bitmover.com>
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

On Fri, Dec 05, 2003 at 09:14:33PM -0800, Larry McVoy wrote:
> Your view that "(b) is compiled into a Linux kernel module, then it
> _is_ part of (a+b) whether (a) is physically present or not." is not
> something that I have managed to seen in any caselaw.  On the other hand,
> it is widely held that you can't force licenses across an API and it's
> perfectly reasonable to see the loadable module interface as an API.

Well, whether or not you can force licenses across an API is not well
settled, as far as I know (IANAL) Microsoft and Apple still have
licenses that try to claim ownership across API's.  And to the extent
that the FSF still tries to claim that programs written to use the GNU
readline library must fall under the GPL, when two other BSD-licensed
implementations of the readline interface exist, they are claiming
exactly the same thing (although the FSF has been known to call for
bycotts of companies that try to claim interfacde copyrights; heh).

Which brings up an interesting point.  The moment someone implements
BSD-licensed code which implements a particular interface, it very
strongly weakens the case that anyone implementing code to that
interface is a derived work of the GPL'ed interface.  This is one of
the reasons why claiming that the GPL can infect across an interface
(whether it is a module interface, a system call interface, or
dynamically linked shared library interface) is bizarre at best.

For example, let me give the following example.  Debugfs of the
e2fsprogs library uses libss, which I recently enhanced to attempt to
dynamically load one of the following libraries via dlopen: readline
(GPL'ed), editline (BSD licensed), or libedit (BSD licensed), which
all export the same interface.  Libss dates back to 1985 or so, and
has a BSD-style license.  It is also used in Kerberos V5 (which is
also BSD licensed), and so Solaris has a propietary derived version of
Krb5 whose administration client uses libss.  So if you compile the
latest version of e2fsprogs on Solaris, and Solaris' krb5 admin client
manages to use the new version of libss, then you could potentially
have in the single address space:

	* Solaris's propietary admin client
	* The libss shared library (BSD)
	* The GPL'ed readline library

OK, riddle me this: is there a GPL violation, and if so, who committed
it?  The user, for running the admin client in this configuration?
But the GPL explicitly says that it's only about distribution, and
doesn't restrict usage in any way, and the end-user is only using the
code.  

Solaris, the owner of the propietary admin client?  But they weren't
involved in my enhancing the libss shared library to dynamically load
either a GPL'ed or a BSD-licensed library, and they created the admin
client before I added the libss enhancement.  And heck, the original
admin client was created by me while I was working at MIT, and is part
of the original MIT Kerberos V5 disitribution (although Sun has
modified it extensively since then).

Me, for modifying a BSD-licensed library to try to dynamically load a
GPL'ed library?  But I was trying to make a perfectly legitimate stack
work:

	* Debugfs (which is GPL'ed)
	* The libss shared library (BSD)
	* The GPL'ed readline library

and the reason why I used dynamic linking was because I wanted debugfs
to only optionally depend on readline library, since the readline
library is a monster (over 600k) and so it wouldn't fit on a rescue
floppy.

So trust me, you really don't want to claim that just because a
program was written to use a particular interface, the license infects
across the API.  Apple and Microsoft are playing that game, and a very
unsavory game it is.  And it leads to all sorts of paradoxes, such as
the one I described above.

						- Ted
