Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVAUUgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVAUUgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVAUUgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:36:50 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40730
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262510AbVAUUea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:34:30 -0500
Date: Fri, 21 Jan 2005 21:34:25 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050121203425.GB11112@dualathlon.random>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121195522.GA14982@elte.hu>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 08:55:22PM +0100, Ingo Molnar wrote:
> 
> * Chris Wright <chrisw@osdl.org> wrote:
> 
> > * Rik van Riel (riel@redhat.com) wrote:
> > > Yes, but do you care about the performance of syscalls
> > > which the program isn't allowed to call at all ? ;)
> > 
> > Heh, no, but it's for every syscall not just denied ones.  Point is
> > simply that ptrace (complexity aside) doesn't scale the same.
> 
> seccomp is about CPU-intense calculation jobs - the only syscalls
> allowed are read/write (and sigreturn). UML implements a full kernel
> via ptrace and CPU-intense applications run at native speed.

Indeed. Performance is not an issue (in the short term at least, since
those syscalls will be probably network bound).

The only reason I couldn't use ptrace is what you found, that is the oom
killing of the parent (or a mistake of the CPU seller that kills it by
mistake by hand, I must prevent him to screw himself ;). Even after
fixing ptrace, I've an hard time to prefer ptrace, when a simple,
localized and self contained solution like seccomp is available.

The reason I called it seccomp and not restricted syscalls, is that I'm
not allowing Chris to choose which syscall to restrict. I restricted
only the ones that are required to be able to compute securely, hence
the name "seccomp" and not "restricted syscalls". Obviously I'm
restricting certain number of syscalls to create this seccomp mode.

I'm open to different solutions, I can even live with you forcing me to
use the fixed version of ptrace, but you must be confortable to take the
blame if it breaks ;). Personally I'm confortable to take the blame only
if seccomp breaks, it's so simple that it can't break. And with break I
don't mean 0xf00f, that's a minor issue that will be autodetected by the
system. I mean breaking like killing the ptrace parent right now... That
can be fixed up reasonably securely too, but it _can't_ be autodetected
easily (I keep cross logs for everything so I can trace it, but it
won't be an immediate/automated task like the 0xf00f or fcnlex).
