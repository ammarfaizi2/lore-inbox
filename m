Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWH1IXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWH1IXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWH1IXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:23:20 -0400
Received: from 1wt.eu ([62.212.114.60]:31505 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751411AbWH1IXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:23:19 -0400
Date: Mon, 28 Aug 2006 10:02:46 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: Ernie Petrides <petrides@redhat.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: printk()s of user-supplied strings
Message-ID: <20060828080246.GB9078@1wt.eu>
References: <20060822030755.GB830@openwall.com> <200608222023.k7MKNHpH018036@pasta.boston.redhat.com> <20060824164425.GA17692@openwall.com> <20060824164633.GA21807@1wt.eu> <20060826022955.GB21620@openwall.com> <20060826082236.GA29736@1wt.eu> <20060826231314.GA24109@openwall.com> <20060827200440.GA229@1wt.eu> <20060828015224.GA27199@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828015224.GA27199@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Mon, Aug 28, 2006 at 05:52:24AM +0400, Solar Designer wrote:
> On Sun, Aug 27, 2006 at 10:04:40PM +0200, Willy Tarreau wrote:
> > I didn't want to affect anything but "%s". Unfortunately, it seems that it
> > was already too much because there are several users in the kernel which
> > first construct their multi-line strings then call printk("%s") with it :-(
> 
> I've tried looking up the printk() calls corresponding to the example
> output that you provided.  Those that I've checked do not use "%s" on
> multi-line strings; rather, they merely embed the final '\n' that is meant
> to end the line within the last "%s" string.  Perhaps we could allow for
> this special case (that is, not escape the '\n' if it is the last
> character to be output by the printk() call).

That's a good idea. I can say I haven't thought about that.

> Yes, there will be a few
> printk("%s", ...) calls that we won't protect - namely, those that are
> meant to output user-supplied strings in the middle of a line, yet are
> invoked separately from the printk() that is meant to complete the line.
> Those would need to be spotted and fixed individually.
> 
> > Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled^J<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
> 
> The first line (before the ^J) is output with:
> 
> 	printk(KERN_INFO "%s version %s%s (%s) with%s", serial_name,
> 	       serial_version, LOCAL_VERSTRING, serial_revdate,
> 	       serial_options);
> 
> The linefeed is embedded in serial_options.
> 
> > IP Protocols: ICMP, UDP, TCP, IGMP^J<6>IP: routing cache hash table of 8192 buckets, 64Kbytes
> 
> 	printk(KERN_INFO "IP Protocols: ");
> 	for (p = inet_protocol_base; p != NULL;) {
> 		struct inet_protocol *tmp = (struct inet_protocol *) p->next;
> 		inet_add_protocol(p);
> 		printk("%s%s",p->name,tmp?", ":"\n");
> 		p = tmp;
> 	}
> 
> As you can see, this one is similar - a single line is formed with
> multiple printk()s and the linefeed is embedded in the last "%s" string.

Thanks for your analysis.

> > Another idea I had was to add a new format specifier to vsnprintf()
> > to explicitly escape the string (eg: "%S"). But there are so many
> > users of printk() to fix then that I'm not sure we would find them
> > all. However, it would be the real fix and not a hack because what
> > we're trying to do is to enforce controls on some data type, which
> > is exactly the point of this solution.
> 
> Yes, I had this thought, too.  This would be the cleanest solution, but
> I'm afraid that it will fail in practice.  People will continue
> introducing printk() calls with plain "%s" where the new "%S" would be
> needed.

Well, I'm not sure about this. Nearly all patches which get merged pass
through a public review first, and when you see how many replies you get
for and 'else' and and 'if' on two different lines, I expect lots of
spontaneous replies such as "use %S for user-supplied strings".

> Another problem is that there will be cases where it is
> difficult to make a determination whether a given string is untrusted
> user input.

If it is difficult to tell this, then the code will be difficult to audit
and will be waiting for an exploit. Providing the tools to the users may
help them write cleaner code too.

> A solution would be to normally use "%S" and only use
> "%s" where "%S" wouldn't work.  In that case, we could as well swap "%s"
> and "%S", though - hardening the existing "%s" and introducing "%S" for
> those callers that depend on the old behavior.

I'd rather not change "%s" semantics if we introduce another specifier
which does exactly what we would expect "%s" to do.

Also, if we can get all users to switch to %S for dangerous strings in
the long term, we might be able to remove the special cases on %s.

I will try your proposal to retain the trailing '\n' unescaped.

> Alexander

Cheers,
Willy

