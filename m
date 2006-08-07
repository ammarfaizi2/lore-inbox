Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWHGEvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWHGEvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 00:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWHGEvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 00:51:03 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:59881 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751033AbWHGEvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 00:51:02 -0400
Date: Mon, 7 Aug 2006 10:22:13 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, David Smith <dsmith@redhat.com>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
       prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com,
       davem@davemloft.net
Subject: Re: [PATCH] module interface improvement for kprobes
Message-ID: <20060807045213.GA12898@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <1154704652.15967.7.camel@dhcp-2.hsv.redhat.com> <20060804155711.GA13271@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804155711.GA13271@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 04:57:11PM +0100, Christoph Hellwig wrote:
> > {
> > 	/* grab the module, making sure it won't get unloaded until
> > 	 * we're done */
> > 	const char *mod_name = "joydev";
> > 	if (module_get_byname(mod_name, &mod) != 0)
> > 		return 1;
> > 
> > 	/* Specify the address/offset where you want to insert
> > 	 * probe.  If this were a real kprobe module, we'd "relocate"
> > 	 * our probe address based on the load address of the module
> > 	 * we're interested in. */
> > 	kp.addr = (kprobe_opcode_t *) mod->module_core + 0;
> > 
> > 	/* All set to register with Kprobes */
> >         register_kprobe(&kp);
> > 	return 0;
> > }
> 
> This interface is horrible.  You actual patch looks good to me, but it
> I can't see why you would need it.  kallsyms_lookup_name deals with modules
> transparently and you shouldn't put a probe at a relative offset into a
> module but only at a symbol you could find with kallsys.
> 
> That beeing said we should probably change the kprobes interface to
> automatically do the kallsysms name lookup for the caller.  It would simplify
> the kprobes interface and allow us to get rid of the kallsyms_lookup_name
> export that doesn't have a valid use except for kprobes.  With
> that change the example kprobe would look like:

This sounds like a good idea. How about we still allow .addr atleast for
users who know what they are doing and would want to just specify a text
addr?

> static struct kprobe kp = {
	.addr		= <addr>

> 	.pre_handler	= handler_pre,
> 	.post_handler	= handler_post,
> 	.fault_handler	= handler_fault,
> 	.symbol_name	= "do_fork",
> };

The symbol_name lookup can then be done when only when .addr is non-NULL.

That said, I have a working patch I was planning to post today that
introduces the KPROBE_ADDR macro that abstracts out the architecture-specific
artefacts of getting the actual text address to probe, so kprobe modules
can be made more portable. I was envisaging this to be used by the module
writer, but with your idea, this could live in-kernel itself.

I'll cook up a patch for this in a short while.

Ananth

