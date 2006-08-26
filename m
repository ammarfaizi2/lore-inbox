Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWHZIki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWHZIki (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 04:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWHZIkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 04:40:37 -0400
Received: from 1wt.eu ([62.212.114.60]:20241 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S964922AbWHZIkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 04:40:37 -0400
Date: Sat, 26 Aug 2006 10:22:36 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: Ernie Petrides <petrides@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: printk()s of user-supplied strings (Re: [PATCH] binfmt_elf.c : the BAD_ADDR macro again)
Message-ID: <20060826082236.GA29736@1wt.eu>
References: <20060822030755.GB830@openwall.com> <200608222023.k7MKNHpH018036@pasta.boston.redhat.com> <20060824164425.GA17692@openwall.com> <20060824164633.GA21807@1wt.eu> <20060826022955.GB21620@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826022955.GB21620@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 06:29:55AM +0400, Solar Designer wrote:
> On Thu, Aug 24, 2006 at 06:46:33PM +0200, Willy Tarreau wrote:
> > On Thu, Aug 24, 2006 at 08:44:25PM +0400, Solar Designer wrote:
> > > Yet there are lots of such printk()s - and I suggest that we make a
> > > determination on all of them before we possibly start fixing individual
> > > ones.  In fact, perhaps there are too many of them to be fixing any in
> > > 2.4, unless we determine to somehow harden printk() itself.
> > > 
> > > Even current->comm is untrusted user input, but there are at least 58
> > > printk()s of it in 2.4.33.  (58 is the number spotted by a grep that
> > > would only match those that have current->comm on the same line with
> > > printk itself.)
> > 
> > I still fail to imagine a useful case for printk("%s") to output non-printable
> > chars verbatim. I really think that the right solution would be for printk()
> > to output all non-printable chars escaped (eg: \n, \r, \xXX).
> 
> Well, this would be ASCII codes 0 through 0x1f and 0x7f through 0x9f.
> Unfortunately, some of the latter correspond to national letters and
> other visible characters with weird charsets:
> 
> 	http://en.wikipedia.org/wiki/Windows_code_page
> 
> but perhaps it is OK to not support them in kernel logs - syslogd's
> printline() would escape them anyway, so we can do it earlier to also
> protect the console.

I think that we are trying to protect against :
  1) local users faking kernel messages. (eg: disk errors, oopses, ...)
  2) local users changing console settings (eg: black on black)
  3) local users corrupting the log reader's terminal

1) is relatively easy to do, basically if we escape \b, \r and \n, it will
become hard to produce fake logs.

2) should be as easy. I'm not aware of any way to change a local console
setting with non-control chars (>= 0x20)

3) is a problem of interpretation between the program storing the logs on
disk and the one retrieving them and showing them to the user. It's by no
way a kernel problem.

Thus, 1 and 2 could be merged by escaping chars \x00 to \x1F. Sysklogd
prints them as control chars prefixed with the '^' sign, so a linefeed
would appear as '^J'.

> Would you escape backslashes themselves, though?  Perhaps not.  syslogd
> (as maintained in Linux sysklogd) doesn't.  Yes, this escaping is not
> reliably reversible in that case.

I don't think we will have to escape the escape char itself. I know that
this is dirty and will not make it reliable to reverse the string, but
we need to keep in mind that what we are trying to do is not preventing
users from hiding their programs' exact names, but preventing them from
faking logs. Moreover, sysklogd does not escape the escape char either,
so we are not introducing a new weakness by doing this.

Also, we should not prevent the kernel from outputting such chars. For
instance, RAMDISK decompression displays a rotating bar followed by
backspaces (doing dmesg on a serial console on this is somewhat funny).
Such strings are hard-coded, so as long as we only protect the %s interpreter,
we will not break those legitimate uses.

> > It would
> > definitely fix the problem without removing useful information. I remember
> > having had the problem a long time ago with a name extracted from a string
> > supplied by the BIOS which mangled the dmesg at early boot.
> > 
> > It would be too much work (and too risky) to expect from all drivers to check
> > their strings for correctness, so the hardening way would be the best one IMHO.
> 
> I agree.

I will try to propose something this week-end.

> Alexander

Cheers,
Willy

