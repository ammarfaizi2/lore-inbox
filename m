Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWHXQr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWHXQr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWHXQr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:47:58 -0400
Received: from mother.openwall.net ([195.42.179.200]:23170 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751612AbWHXQr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:47:57 -0400
Date: Thu, 24 Aug 2006 20:44:25 +0400
From: Solar Designer <solar@openwall.com>
To: Ernie Petrides <petrides@redhat.com>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: printk()s of user-supplied strings (Re: [PATCH] binfmt_elf.c : the BAD_ADDR macro again)
Message-ID: <20060824164425.GA17692@openwall.com>
References: <20060822030755.GB830@openwall.com> <200608222023.k7MKNHpH018036@pasta.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608222023.k7MKNHpH018036@pasta.boston.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 04:23:17PM -0400, Ernie Petrides wrote:
> On Tuesday, 22-Aug-2006 at 7:7 +0400, Solar Designer wrote:
> > > -			printk(KERN_ERR "Unable to load interpreter %.128s\n",
> > > -				elf_interpreter);
> >
> > I'd rather have this message rate-limited, not dropped completely.
> 
> I consider any printk() that can be arbitrarily triggered by an
> unprivileged user to be inappropriate, rate-limited or not.  I
> recommend that it be removed entirely.

Some of them are quite useful.  For example, the presence of this one in
dmesg and the logs typically (although not necessarily) indicates that
there was an OOM condition - and the interpreter name is useful to know
that the message indeed applied to /lib/ld-linux.so.2 rather than to
some user-supplied ELF interpreter (that could simply be non-existent).
Alan has recently suggested that another rate-limited user triggerable
message be introduced for set*uid() failing on transient errors.  Then,
what about warnings of emulated unaligned accesses on Alpha?  Those were
useful to me on many occasions.  There can be many other examples.

Also, for some printk()s it is difficult to say whether they're user
triggerable.  A printk() indicating a "machine check" or an ECC error
may well be user triggerable on a particular system.

> > Another long-time concern that I had is that we've got some printk()s
> > of user-supplied string data.  What about embedded linefeeds - can this
> > be used to produce fake kernel messages with arbitrary log level (syslog
> > priority)?  It certainly seems so.
> >
> > Also, there are terminal controls...
> 
> These are valid concerns.  Allowing the kernel to print user-fabricated
> strings is a terrible idea.

Yet there are lots of such printk()s - and I suggest that we make a
determination on all of them before we possibly start fixing individual
ones.  In fact, perhaps there are too many of them to be fixing any in
2.4, unless we determine to somehow harden printk() itself.

Even current->comm is untrusted user input, but there are at least 58
printk()s of it in 2.4.33.  (58 is the number spotted by a grep that
would only match those that have current->comm on the same line with
printk itself.)

Alexander
