Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWHXRCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWHXRCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWHXRCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:02:42 -0400
Received: from 1wt.eu ([62.212.114.60]:15377 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751639AbWHXRCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:02:41 -0400
Date: Thu, 24 Aug 2006 18:46:33 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: Ernie Petrides <petrides@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: printk()s of user-supplied strings (Re: [PATCH] binfmt_elf.c : the BAD_ADDR macro again)
Message-ID: <20060824164633.GA21807@1wt.eu>
References: <20060822030755.GB830@openwall.com> <200608222023.k7MKNHpH018036@pasta.boston.redhat.com> <20060824164425.GA17692@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824164425.GA17692@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 08:44:25PM +0400, Solar Designer wrote:
> On Tue, Aug 22, 2006 at 04:23:17PM -0400, Ernie Petrides wrote:
> > On Tuesday, 22-Aug-2006 at 7:7 +0400, Solar Designer wrote:
> > > > -			printk(KERN_ERR "Unable to load interpreter %.128s\n",
> > > > -				elf_interpreter);
> > >
> > > I'd rather have this message rate-limited, not dropped completely.
> > 
> > I consider any printk() that can be arbitrarily triggered by an
> > unprivileged user to be inappropriate, rate-limited or not.  I
> > recommend that it be removed entirely.
> 
> Some of them are quite useful.  For example, the presence of this one in
> dmesg and the logs typically (although not necessarily) indicates that
> there was an OOM condition - and the interpreter name is useful to know
> that the message indeed applied to /lib/ld-linux.so.2 rather than to
> some user-supplied ELF interpreter (that could simply be non-existent).
> Alan has recently suggested that another rate-limited user triggerable
> message be introduced for set*uid() failing on transient errors.  Then,
> what about warnings of emulated unaligned accesses on Alpha?  Those were
> useful to me on many occasions.  There can be many other examples.
> 
> Also, for some printk()s it is difficult to say whether they're user
> triggerable.  A printk() indicating a "machine check" or an ECC error
> may well be user triggerable on a particular system.
> 
> > > Another long-time concern that I had is that we've got some printk()s
> > > of user-supplied string data.  What about embedded linefeeds - can this
> > > be used to produce fake kernel messages with arbitrary log level (syslog
> > > priority)?  It certainly seems so.
> > >
> > > Also, there are terminal controls...
> > 
> > These are valid concerns.  Allowing the kernel to print user-fabricated
> > strings is a terrible idea.
> 
> Yet there are lots of such printk()s - and I suggest that we make a
> determination on all of them before we possibly start fixing individual
> ones.  In fact, perhaps there are too many of them to be fixing any in
> 2.4, unless we determine to somehow harden printk() itself.
> 
> Even current->comm is untrusted user input, but there are at least 58
> printk()s of it in 2.4.33.  (58 is the number spotted by a grep that
> would only match those that have current->comm on the same line with
> printk itself.)

I still fail to imagine a useful case for printk("%s") to output non-printable
chars verbatim. I really think that the right solution would be for printk()
to output all non-printable chars escaped (eg: \n, \r, \xXX). It would
definitely fix the problem without removing useful information. I remember
having had the problem a long time ago with a name extracted from a string
supplied by the BIOS which mangled the dmesg at early boot.

It would be too much work (and too risky) to expect from all drivers to check
their strings for correctness, so the hardening way would be the best one IMHO.

Cheers,
Willy

