Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWE3B3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWE3B3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWE3B3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:29:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751546AbWE3B3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:29:11 -0400
Date: Mon, 29 May 2006 18:33:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 06/61] lock validator: add __module_address() method
Message-Id: <20060529183325.b2f02192.akpm@osdl.org>
In-Reply-To: <20060529212333.GF3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212333.GF3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:23:33 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> +/*
> + * Is this a valid module address? We don't grab the lock.
> + */
> +int __module_address(unsigned long addr)
> +{
> +	struct module *mod;
> +
> +	list_for_each_entry(mod, &modules, list)
> +		if (within(addr, mod->module_core, mod->core_size))
> +			return 1;
> +	return 0;
> +}

Returns a boolean.

>  /* Is this a valid kernel address?  We don't grab the lock: we are oopsing. */
>  struct module *__module_text_address(unsigned long addr)

But this returns a module*.

I'd suggest that __module_address() should do the same thing, from an API neatness
POV.  Although perhaps that's mot very useful if we didn't take a ref on the returned
object (but module_text_address() doesn't either).

Also, the name's a bit misleading - it sounds like it returns the address
of a module or something.  __module_any_address() would be better, perhaps?

Also, how come this doesn't need modlist_lock()?

