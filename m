Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWHDSeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWHDSeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWHDSeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:34:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14043 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751393AbWHDSeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:34:15 -0400
Subject: Re: [PATCH] module interface improvement for kprobes
From: David Smith <dsmith@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, prasanna@in.ibm.com,
       ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net
In-Reply-To: <20060804155711.GA13271@infradead.org>
References: <1154704652.15967.7.camel@dhcp-2.hsv.redhat.com>
	 <20060804155711.GA13271@infradead.org>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 13:30:39 -0500
Message-Id: <1154716239.15967.22.camel@dhcp-2.hsv.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

Thanks for thinking about this.  See comments below.

On Fri, 2006-08-04 at 16:57 +0100, Christoph Hellwig wrote:
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

Why shouldn't I put a probe into a module other than at a symbol I can
find with kallsyms?  For example, I'm interested when a particular
module hits an error condition that occurs.  I don't want to probe how
many times the function gets called - just when the error condition
occurs.

With the existing interface, if I use kallsysms to find the value of a
symbol, the module can be unloaded between the time I use kallsyms and
register the kprobe.  The patch I included fixes that race condition by
incrementing the module reference count.

> That beeing said we should probably change the kprobes interface to
> automatically do the kallsysms name lookup for the caller.  It would simplify
> the kprobes interface and allow us to get rid of the kallsyms_lookup_name
> export that doesn't have a valid use except for kprobes.  With
> that change the example kprobe would look like:
> 
> static struct kprobe kp = {
> 	.pre_handler	= handler_pre,
> 	.post_handler	= handler_post,
> 	.fault_handler	= handler_fault,
> 	.symbol_name	= "do_fork",
> };
> 
> static int __init probe_example_init(void)
> {
> 	return register_kprobe(&kp);
> }

Your example works for a very small number of symbols, but with a large
number it could take a long time to register the kprobes.  Plus, that
would need to be done every time the kprobe was registered.  With my
patch, the symbol lookup can be done once, then all those symbols can be
turned into offsets from the base address of the module.

-- 
David Smith
dsmith@redhat.com
Red Hat, Inc.
http://www.redhat.com
256.217.0141 (direct)
256.837.0057 (fax)


