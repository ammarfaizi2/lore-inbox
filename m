Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVASSAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVASSAR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVASR5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:57:34 -0500
Received: from canuck.infradead.org ([205.233.218.70]:60938 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261818AbVASRwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:52:50 -0500
Subject: Re: thoughts on kernel security issues
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41EE96E7.3000004@comcast.net>
References: <20050112205350.GM24518@redhat.com>
	 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	 <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>
	 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
	 <20050113082320.GB18685@infradead.org>
	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
	 <1105635662.6031.35.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
	 <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu>
	 <41EE96E7.3000004@comcast.net>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 18:52:31 +0100
Message-Id: <1106157152.6310.171.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ES has been actively developed since it was poorly implemented in 2003.
>  PaX has been actively developed since it was poorly implemented in
> 2000.  PaX has had about 4 times longer to go from a poor
> proof-of-concept NX emulation patch based on the plex86 announcement to
> a full featured security system, and is written by a competant security
> developer rather than a competant scheduler developer.

I would call that an insult to Ingo.


> Split-out portions of PaX (and of ES) don't make sense.  

they do. Somewhat. 
> ASLR can be
> evaded pretty easily:  inject code, read %efp, find the GOT, read
> addresses.  The NX protections can be evaded by using ret2libc.  on x86,
> you need emulation to make an NX bit or the NX protections are useless.

actually modern x86 cpus have hardware NX. 

> PT_GNU_STACK annoys me :P  I'm more interested in 1) PaX' full set of
> markings (-ps for NX, -m for mprotect(), r for randmmap, x for
> randexec), 2) getting rid of the need for anything but -m, and 3)
> eliminating relocations.  Sometimes they don't patch GLIBC here and
> Firefox won't load flash or Java because they're PT_GNU_STACK and don't
> really need it (the java executables are marked, but the java plug-in
> doesn't need PT_GNU_STACK).

so remark them.

> 
> I guess it works on Exec Shield, but it frightens me that I have to
> audit every library an executable uses for a PT_GNU_STACK marking to see
> if it has an executable stack.

there is lsexec which does this automatic for you based on running
propcesses

> 
> Either or if it stops an exploit; there's no "stopping an exploit
> better," just stopping more of them and having fewer loopholes.  As I
> understand, ES' NX approximation fails if you relieve protections on a
> higher mapping

which is REALLY rare for programs to do

> -- which confuses me, isn't vsyscall() a high-address
> executable mapping, which would disable NX protection for the full
> address space?

just like PaX, execshield has to disable the vsyscall page.
Exec-Shield actually has the code to 1) move the vsyscall page down in
the address space and 2) randomize it per process, but that is inactive
right now since it needs a bit of help from the VM that isn't provided
anymore since 2.6.8 or so.


> PaX though gives me powerful, flexible administrative control over
> executable space protections as a privileged resource.
> mprotect(PROT_EXEC|PROT_WRITE) isn't something normal programs need; so
> it's not something I allow everyone to do.

it's a balance between compatibility and security. PaX strikes a
somewhat different balance from E-S. E-S goes a long way to avoid
breaking things that posix requires, even if they are silly and rare.
Apps don't DO   PROT_EXEC|PROT_WRITE normally after all.. so this added
"protect" is to a point artifical.



