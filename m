Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965363AbWAGAFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965363AbWAGAFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWAGAFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:05:21 -0500
Received: from ns.suse.de ([195.135.220.2]:53383 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932288AbWAGAFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:05:20 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	<1136543914.2940.11.camel@laptopd505.fenrus.org>
	<43BEA672.4010309@pobox.com>
	<20060106184841.GA13917@mars.ravnborg.org>
From: Andi Kleen <ak@suse.de>
Date: 07 Jan 2006 01:05:16 +0100
In-Reply-To: <20060106184841.GA13917@mars.ravnborg.org>
Message-ID: <p73k6dcykar.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

First I must object to the thread/patch title.  x86-64 always used
unit-at-a-time when available. Other architectures used the compiler
default which is on in newer gccs. Only a popular legacy architecture
didn't. It should reflect that.

> On Fri, Jan 06, 2006 at 12:18:42PM -0500, Jeff Garzik wrote:
> > 
> > ACK, with a note:  gcc also supports limited program-at-a-time -- you 
> > pass multiple .c files on the same command line, and specify a single 
> > output on the command line.
> > 
> > It would be nice to update kbuild to do this for single directory 
> > modules....
> 
> How much will it gain?

You just get cross inlining between .c files. Nothing more. 
Since the kernel  doesn't use -O3 only functions marked inline would
be considered for this. And the fraction of functions in .c 
files that are marked inline, but not static is probably very small.

The feature also has some drawbacks - last time I checked it
was still quite green (as in bananas). First it causes gcc 
to eat a lot more memory because it has to hold completely directories
worth of source in memory. This might slow things down if setups
that didn't swap before start doing this now.

I suspect it'll also run slower with this because it has some algorithms
that scale with the size of the input source and some of the
directories in the kernel can be quite big (e.g. i'm not 
sure letting a optimizer lose on all of xfs at the same 
time is a good idea)

And gcc is really picky about type compatibility between source files
with program-at-a-time.  If any types of the same symbols are
incompatible even in minor ways you get an ICE. That's technically
illegal, but tends to happen often in practice (e.g. when people
use extern) It might end up being quite a lot of work to clean this up.

I wouldn't bother implementing this right now - it's probably not
worth it for the inlining. 

If gcc ever makes this feature usable and fixes the problems and
actually learns more optimizations using it that could be
reconsidered. 

-Andi
