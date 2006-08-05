Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWHELfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWHELfm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 07:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbWHELfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 07:35:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37079 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161196AbWHELfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 07:35:42 -0400
Date: Sat, 5 Aug 2006 12:35:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Smith <dsmith@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, prasanna@in.ibm.com, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH] module interface improvement for kprobes
Message-ID: <20060805113538.GA21135@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Smith <dsmith@redhat.com>, linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au, prasanna@in.ibm.com, ananth@in.ibm.com,
	anil.s.keshavamurthy@intel.com, davem@davemloft.net
References: <1154704652.15967.7.camel@dhcp-2.hsv.redhat.com> <20060804155711.GA13271@infradead.org> <1154716239.15967.22.camel@dhcp-2.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154716239.15967.22.camel@dhcp-2.hsv.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 01:30:39PM -0500, David Smith wrote:
> Why shouldn't I put a probe into a module other than at a symbol I can
> find with kallsyms?  For example, I'm interested when a particular
> module hits an error condition that occurs.  I don't want to probe how
> many times the function gets called - just when the error condition
> occurs.

How do you find that offset?  You'll probably mention the S-Word but
we really want something that works with the latest kernel, not just
the vendor trees.

> With the existing interface, if I use kallsysms to find the value of a
> symbol, the module can be unloaded between the time I use kallsyms and
> register the kprobe.  The patch I included fixes that race condition by
> incrementing the module reference count.

Yes, and that's a good thing.  But the interface for doing it is wrong.
You don't really want the users to do all that by itself.  For the typical
case of putting a probe at the usual points you want an interface that
puts in the probe given a name and does the right thing for you.  For example
the interface I proposed in my last mail.  Adding another field to struct
kprobe to specify an offset into the symbol would be the logical extension
of that.

> Your example works for a very small number of symbols, but with a large
> number it could take a long time to register the kprobes.  Plus, that
> would need to be done every time the kprobe was registered.  With my
> patch, the symbol lookup can be done once, then all those symbols can be
> turned into offsets from the base address of the module.

Registering a kprobe is everything but a fastpath, and you definitly should
not have a lot of probes anyway.  It's far more worthwhile to have a sane
interface that the user can't get wrong then a small speedup in something
that's not a fastpath.  I think Rusty even has a paper or talk about why
this is absolutely nessecary :)
