Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWAXX0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWAXX0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWAXX0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:26:35 -0500
Received: from mail.gmx.net ([213.165.64.21]:44737 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750839AbWAXX0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:26:34 -0500
X-Authenticated: #428038
Date: Wed, 25 Jan 2006 00:26:29 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: "Theodore Ts'o" <tytso@mit.edu>, Arjan van de Ven <arjan@infradead.org>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060124232629.GA9613@merlin.emma.line.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Arjan van de Ven <arjan@infradead.org>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <20060123203010.GB1820@merlin.emma.line.org> <1138092761.2977.32.camel@laptopd505.fenrus.org> <43D5EEA2.nailCE7111GPO@burner> <1138094141.2977.34.camel@laptopd505.fenrus.org> <20060124212843.GA15543@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060124212843.GA15543@thunk.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o schrieb am 2006-01-24:

> I thought in the case we were talking about, the problem is that we
> have a setuid program which calls mlockall() but then later drops its
> privileges.  So when it tries to allocate memories, RLIMIT_MEMLOCK
> applies again, and so all future memory allocations would fail.  

That's the coarse view. In fact, the application does not call setuid()
at this time, but only seteuid(), so it can regain privileges later, and
will in fact do that.

The application in question does this:

(root here)
1 mlockall()
2 seteuid(500);  /* park privileges for a moment */
3 valloc(63 kB); /* fails since 2.6.9's tight MEMLOCK limit */

The first patch I suggested for the application exchanged steps #2 and
#3 and works, but is not acceptable to Jörg. We haven't talked about the
reasons.

The idea behind my patch was this: if it wants the memory locked (which
is a privileged operation on many systems anyways), then why not
allocate as root? Would this hurt portability to any other system? I
don't think so. Is such a rationale unreasonable in itself? Not either.

Further patch suggestions negotiated forth and back on raising the limit
and to what value.

The other problem is that glibc 2.3.5 is part of the story, but
off-topic here, because glibc is the link between valloc() (application
side) and the mmap() (kernel side).

> What I proposed is a hack, [and] strictly speaking not necessary
> according to the POSIX standards, but the problem is that a portable
> program can't be expected to know that Linux has a RLIMIT_MEMLOCK
> resource limit, such that a program which calls mlockall() and then
> drops privileges will work under Solaris and fail under Linux.  Hence
> I why proposed a hack where mlockall() would adjust RLIMIT_MEMLOCK.
> Yes, no question it's a hack and a special case; the question is
> whether cure or the disease is worse.

Is the KERNEL the right place to implement policy such as setting
locked-page limits to 32 kB?

What if the limit were RLIM_INFINITY for root processes instead of
hacking mlockall() and the resource checks?

-- 
Matthias Andree
