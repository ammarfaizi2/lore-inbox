Return-Path: <linux-kernel-owner+w=401wt.eu-S933003AbWLSVYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003AbWLSVYg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932972AbWLSVYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:24:35 -0500
Received: from mx1.cs.washington.edu ([128.208.5.52]:43192 "EHLO
	mx1.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933003AbWLSVYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:24:35 -0500
Date: Tue, 19 Dec 2006 13:24:24 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Bob Copeland <me@bobcopeland.com>, Dave Jones <davej@redhat.com>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: my handy-dandy, "coding style" script
In-Reply-To: <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64N.0612191311590.24901@attu4.cs.washington.edu>
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain> 
 <20061219164146.GI25461@redhat.com> <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com>
 <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006, Jan Engelhardt wrote:

> > I don't know if anyone cares about them anymore, since I think gcc
> > grew some smarts in the area recently, but there are a lot of lines of
> > code matching "static int.*= *0;" and equivalents in the driver tree.
> 
> I'd really like to see the C compiler being enhanced to detect
> "stupid casts", i.e. those, which when removed, do not change (a) the outcome
> (b) the compiler warnings/error output.
> 

If your desire is for the compiler warnings output to be unchanged, I'm 
not sure how you'd enhance the compiler from detecting these casts.  All 
of the casts that have been removed in these cleanup patches do not change 
the assembly when using gcc; they simply reduce the amount of visual noise 
in the source code.

This is also true in terms of global static variables being initialized to 
0 (or NULL).  While it is indeed unnecessary by the standard, it simply 
moves the initialization from one segment of the assembly to the other, 
regardless of how many different functions it is referenced in.  gcc does 
not emit movl $0, var for these cases.

It _would_ be helpful to add a macro such as:

	#define	SILENCE_GCC(x)	= x

to eliminate warnings such that:

	auto int a SILENCE_GCC(a);
	fill_a(&a);
	if (a)
		...

would not produce a "may be used uninitialized" warning.

		David
