Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161508AbWHEC2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161508AbWHEC2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 22:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161513AbWHEC2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 22:28:36 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:29070 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161508AbWHEC2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 22:28:36 -0400
Subject: Re: [PATCH] module interface improvement for kprobes
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Smith <dsmith@redhat.com>
Cc: linux-kernel@vger.kernel.org, prasanna@in.ibm.com, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, davem@davemloft.net
In-Reply-To: <1154704652.15967.7.camel@dhcp-2.hsv.redhat.com>
References: <1154704652.15967.7.camel@dhcp-2.hsv.redhat.com>
Content-Type: text/plain
Date: Sat, 05 Aug 2006 12:28:33 +1000
Message-Id: <1154744913.28257.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 10:17 -0500, David Smith wrote:
> When inserting a kprobes probe into a loadable module, there isn't a way
> for the kprobes module to get a module reference (in order to find the
> base address of the module among perhaps other things).

OK, there's nothing fundamentally wrong with the idea of a new lookup
fn, but does kprobes really have a module name and an offset into the
load address of the module?  Or a symbol name?  Or an offset relative to
a specific section?

It seems to me that the last two options are best.  Both require
kallsyms, but I don't think that's unreasonable...

> +static inline long module_get_byname(const char *mod_name, struct module **mod)
> +{
> +	return 1;
> +}
...
> +long module_get_byname(const char *mod_name, struct module **mod)
> +{
> +	*mod = NULL;
>  
> +	/* We must hold module_mutex before calling find_module(). */
> +	if (mutex_lock_interruptible(&module_mutex) != 0)
> +		return -EINTR;
> +
> +	*mod = find_module(mod_name);
> +	mutex_unlock(&module_mutex);
> +	if (*mod) {
> +		if (! strong_try_module_get(*mod)) {
> +			*mod = NULL;
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}

Your return values here are confused. Please just return struct module
*.  Also, there doesn't seem to be any reason for this function to exist
in the CONFIG_MODULES=n case.

Cheers!
Rusty,
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

