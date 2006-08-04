Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161263AbWHDP5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbWHDP5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbWHDP5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:57:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53439 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161263AbWHDP5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:57:15 -0400
Date: Fri, 4 Aug 2006 16:57:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Smith <dsmith@redhat.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, prasanna@in.ibm.com,
       ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH] module interface improvement for kprobes
Message-ID: <20060804155711.GA13271@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Smith <dsmith@redhat.com>, linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au, prasanna@in.ibm.com, ananth@in.ibm.com,
	anil.s.keshavamurthy@intel.com, davem@davemloft.net
References: <1154704652.15967.7.camel@dhcp-2.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154704652.15967.7.camel@dhcp-2.hsv.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> {
> 	/* grab the module, making sure it won't get unloaded until
> 	 * we're done */
> 	const char *mod_name = "joydev";
> 	if (module_get_byname(mod_name, &mod) != 0)
> 		return 1;
> 
> 	/* Specify the address/offset where you want to insert
> 	 * probe.  If this were a real kprobe module, we'd "relocate"
> 	 * our probe address based on the load address of the module
> 	 * we're interested in. */
> 	kp.addr = (kprobe_opcode_t *) mod->module_core + 0;
> 
> 	/* All set to register with Kprobes */
>         register_kprobe(&kp);
> 	return 0;
> }

This interface is horrible.  You actual patch looks good to me, but it
I can't see why you would need it.  kallsyms_lookup_name deals with modules
transparently and you shouldn't put a probe at a relative offset into a
module but only at a symbol you could find with kallsys.

That beeing said we should probably change the kprobes interface to
automatically do the kallsysms name lookup for the caller.  It would simplify
the kprobes interface and allow us to get rid of the kallsyms_lookup_name
export that doesn't have a valid use except for kprobes.  With
that change the example kprobe would look like:

static struct kprobe kp = {
	.pre_handler	= handler_pre,
	.post_handler	= handler_post,
	.fault_handler	= handler_fault,
	.symbol_name	= "do_fork",
};

static int __init probe_example_init(void)
{
	return register_kprobe(&kp);
}

(and btw, init_module is gone, so both your example and the one in
Documentation/kprobes.txt can't compile anymore - care to send a patch
to update the latter?)
