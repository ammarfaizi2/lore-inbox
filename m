Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289313AbSBJG1d>; Sun, 10 Feb 2002 01:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289314AbSBJG1X>; Sun, 10 Feb 2002 01:27:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27460 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289313AbSBJG1N>; Sun, 10 Feb 2002 01:27:13 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Feb 2002 23:23:09 -0700
In-Reply-To: <Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com>
Message-ID: <m1k7tl6ek2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sat, 9 Feb 2002, Andrew Morton wrote:
> >
> > This is due to BUG() calls in inline functions in headers.  The biggest
> > culprit is dget(), in dcache.h.  This causes the full path of the header file
> > to be expanded into each and every compilation unit which includes
> > dcache.h.
> 
> Hmm. Which brings up another issue: can somebody come up with an idea of
> how to make the thing not use the whole pathname, but only the basename
> relative to the top-of-tree?
> 
> I doubt it is possible, but maybe there is some clever way to avoid it..
> 
> > I'm showing thirteen header files, for a total of 83k.  I'll do something
> > about this...
> 
> Ok, so even your gcc obviously is _not_ intelligent enough to throw away
> strings from inline functions that aren't used. Oh well.

One possibility is to do something like:

ud2
.word __LINE__
.long 1f
.section __FILE__
.linkonce discard
1: .asciz __FILE__
.previous

Which will put each filename string in it's own section and let the
linker merge the duplicates.  I don't know how to wrap all of this up
nicely in a inline asm statement but perhaps someone else can work
out the remaining details.  Ideally I would put a prefix on the name
of all of the sections for easy processing, but string concatenation
doesn't work in asm :(

Eric
