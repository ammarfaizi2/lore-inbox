Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWHJGQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWHJGQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbWHJGQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:16:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:56229 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161076AbWHJGQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:16:51 -0400
Date: Thu, 10 Aug 2006 11:48:00 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, David Smith <dsmith@redhat.com>,
       linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
Message-ID: <20060810061759.GA30283@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20060807115537.GA15253@in.ibm.com> <20060808162421.GA28647@infradead.org> <1155139305.8345.20.camel@dhcp-2.hsv.redhat.com> <20060809161039.GA30856@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809161039.GA30856@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 05:10:39PM +0100, Christoph Hellwig wrote:
> On Wed, Aug 09, 2006 at 11:01:45AM -0500, David Smith wrote:
> > > +	if (p->symbol_name) {
> > > +		if (p->addr)
> > > +			return -EINVAL;
> > > +		p->addr = kprobe_lookup_name(p->symbol_name) + p->offset;
> > > +	}
> > 
> > What if kprobe_lookup_name() fails
> 
> for that case we need the check in your snipplet below.

The next check:

        if ((!kernel_text_address((unsigned long) p->addr)) ||
                in_kprobes_functions((unsigned long) p->addr))
                return -EINVAL;

will catch this case anyway (unless some arch has kernel text starting
at vaddr 0)

Ananth

> 
> > or if CONFIG_KALLSYMS isn't set?
> 
> I think we should just disallow that case.  having kprobes without kallsyms
> is rather pointless.  I'll send a patch to add the dependency to the Kconfig
> files.
> 
> > Perhaps this needs something like:
> > 
> > 	if (p->symbol_name) {
> > 		if (p->addr)
> > 			return -EINVAL;
> > 		p->addr = kprobe_lookup_name(p->symbol_name) + p->offset;
> > 		if (p->addr == p->offset)
> > 			return -EINVAL;
> > 	}
