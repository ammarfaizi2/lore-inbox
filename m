Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVAZAvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVAZAvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVAZAux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:50:53 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5129
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262076AbVAZAtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:49:03 -0500
Date: Wed, 26 Jan 2005 01:49:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: tglx@linutronix.de, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: User space out of memory approach
Message-ID: <20050126004901.GD7587@dualathlon.random>
References: <4d6522b9050110144017d0c075@mail.gmail.com> <20050110200514.GA18796@logos.cnet> <1105403747.17853.48.camel@tglx.tec.linutronix.de> <20050111083837.GE26799@dualathlon.random> <3f250c71050121132713a145e3@mail.gmail.com> <3f250c7105012113455e986ca8@mail.gmail.com> <20050122033219.GG11112@dualathlon.random> <3f250c7105012513136ae2587e@mail.gmail.com> <1106689179.4538.22.camel@tglx.tec.linutronix.de> <3f250c71050125161175234ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f250c71050125161175234ef9@mail.gmail.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 08:11:19PM -0400, Mauricio Lin wrote:
> Sometimes the first application to be killed is XFree. AFAIK the

This makes more sense now. You need somebody trapping sigterm in order
to lockup and X sure traps it to recover the text console.

Can you replace this:

	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
		force_sig(SIGTERM, p);
	} else {
		force_sig(SIGKILL, p);
	}

with this?

	force_sig(SIGKILL, p);

in mm/oom_kill.c.

This should fix it. Problem is that SIGTERM is unsafe even if the app is
not malicious, there's not enough ram to pagein the userland sighander,
so the system lockups.

We need a sort of timeout where we fallback into SIGKILL if SIGTERM
didn't help.

Anyway this is not a new bug, I didn't touch a single bit in that code.
I'd really like to see current fixes merged, then we can take care of
root app getting killed reliably. In all my test I always run the
malicious app as non-root, and anyway I never trap sigterm (X is tiny in
my setup, so it never gets killed). Probably the GUI stuff you opened
has increased significantly X size for X to be killed.
