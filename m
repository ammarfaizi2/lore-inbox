Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUGAEBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUGAEBQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 00:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUGAEBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 00:01:16 -0400
Received: from mail.shareable.org ([81.29.64.88]:46765 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263847AbUGAEBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 00:01:05 -0400
Date: Thu, 1 Jul 2004 05:01:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: Testing PROT_NONE and other protections, and a surprise
Message-ID: <20040701040101.GC1564@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org> <20040701033518.GT21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701033518.GT21066@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> > When running it on i386, I got a *huge* surprise (to me).  A
> > PROT_WRITE-only page can sometimes fault on read or exec.  This is the
> > output:
> 
> This is unsurprising. The permissions can't be represented in pagetables,
> but can opportunistically be enforced when exceptions are taken for other
> reasons (e.g. TLB invalidations related to page replacement).

Sure, it makes sense.  I understand exactly why the results are like that.
But it was a surprise because it just hadn't occurred to me.

The big point is that I know other people haven't thought of it
either.  I'm sure it's commonly thought that when you specify
PROT_WRITE, you'll get a readable page on architectures that can't
do write-only pages.

Interestingly, on Alpha you _will_ always get a readable page.
The Alpha fault handler has different enforcement rules to i386.

I know why this is done too, but it does indicate that the actual
behaviour of different architectures isn't immediately obvious.

The lessons from this investigation for portable code are:

    1. You really must specify all the access protections you need,
       i.e. read, write and/or exec if you use them.  This was obvious.

    2. In general you cannot depend on a kernel to _prevent_ accesses
       of a certain kind if you don't enable that in the protection flags,
       unless you know that architecture and its kernel well.
       This was obvious too.

    3. Less obviously, if you find that turning off a flag appears to
       prevent access of that type in tests, that is _not_ evidence
       that it will always prevent access of that type, even on the
       same machine.

       This is important if you're hoping to prevent certain accesses
       and trap them, e.g. for a garbage collector, virtual machine,
       memory access checker etc.  It has implications for
       autoconf-style tests which check for these properties.

       There are two exceptions which you can depend on across all
       architectures, at least running Linux:

    4. Exception #1: Turning off PROT_WRITE always disables writing.
       This is probably portable to every system which supports mprotect().

    5. Exception #2: PROT_NONE works.  Any access will fail, and you
       can trap the signal.  Historically this hasn't always been the
       case with Linux, though.  It is probably much less dependable
       among other operating systems than exception #1.

People knew these rules already.  It's implicit in a lot of code.
However I've not seen them clearly written down in one place.
Now they are.

Feel free to add any I missed, or provide corrections, thanks!

-- Jamie
