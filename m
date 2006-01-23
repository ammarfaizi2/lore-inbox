Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWAWSz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWAWSz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWAWSz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:55:59 -0500
Received: from mail.gmx.de ([213.165.64.21]:30876 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964890AbWAWSz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:55:59 -0500
X-Authenticated: #428038
Date: Mon, 23 Jan 2006 19:55:49 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060123185549.GA15985@merlin.emma.line.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060123105634.GA17439@merlin.emma.line.org> <1138014312.2977.37.camel@laptopd505.fenrus.org> <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138039993.2977.62.camel@laptopd505.fenrus.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, Arjan van de Ven wrote:

> hmm... curious that mlockall() succeeds with only a 32kb rlimit....

It's quite obvious with the seteuid() shuffling behind the scenes of the
app, for the mlockall() runs with euid==0, and the later mmap() with euid!=0.

Clearly the application should do both with the same privilege or raise
the RLIMIT_MEMLOCK while running with privileges.

The question that's open is one for the libc guys: malloc(), valloc()
and others seem to use mmap() on some occasions (for some allocation
sizes) - at least malloc/malloc.c comments as of 2.3.4 suggest so -, and
if this isn't orthogonal to mlockall() and set[e]uid() calls, the glibc
is pretty deeply in trouble if the code calls mlockall(MLC_FUTURE) and
then drops privileges.

The function in question appears to be valloc() with glibc 2.3.5.

In this light, mlockall(MCL_FUTURE) is pretty useless, since there is no
way to undo MCL_FUTURE without unlocking all pages at the same time.
Particularly so for setuid apps...

I'm asking the Bcc'd gentleman to reconsider mlockall() and perhaps use
explicit mlock() instead.

-- 
Matthias Andree
