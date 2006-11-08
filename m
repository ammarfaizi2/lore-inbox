Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754617AbWKHRoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbWKHRoZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbWKHRoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:44:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53157 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754617AbWKHRoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:44:24 -0500
Subject: Re: Possible spinlock recursion in search_module_extables() ?
From: Jeff Layton <jlayton@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200606190635_MC3-1-C2D8-258F@compuserve.com>
References: <200606190635_MC3-1-C2D8-258F@compuserve.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 12:42:17 -0500
Message-Id: <1163007738.12604.4.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 06:31 -0400, Chuck Ebbert wrote:
> Looking at this code:
> 
> const struct exception_table_entry *search_exception_tables(unsigned long addr)
> {
>         const struct exception_table_entry *e;
> 
>         e = search_extable(__start___ex_table, __stop___ex_table-1, addr);
>         if (!e)
>                 e = search_module_extables(addr);
>         return e;
> }
> 
> const struct exception_table_entry *search_module_extables(unsigned long addr)
> {
>         unsigned long flags;
>         const struct exception_table_entry *e = NULL;
>         struct module *mod;
> 
>         spin_lock_irqsave(&modlist_lock, flags);
>         list_for_each_entry(mod, &modules, list) {
>                 if (mod->num_exentries == 0)
>                         continue;
> 
>                 e = search_extable(mod->extable,
>                                    mod->extable + mod->num_exentries - 1,
>                                    addr);
>                 if (e)
>                         break;
>         }
>         spin_unlock_irqrestore(&modlist_lock, flags);
> 
>         /* Now, if we found one, we are running inside it now, hence
>            we cannot unload the module, hence no refcnt needed. */
>         return e;
> }
> 
> 
> search_module_extables() takes a spinlock.  If some kind of fault occurs
> while it's holding that lock (module list corrupted etc.,) won't it be
> re-entered while looking for its own fault handler?  If so, would this
> be a possible fix?
> 
> const struct exception_table_entry *search_exception_tables(unsigned long addr)
> {
>         const struct exception_table_entry *e;
> 
>         if (core_kernel_text(addr))
>                 e = search_extable(__start___ex_table, __stop___ex_table-1, addr);
>         else
>                 e = search_module_extables(addr);
> 
>         return e;
> }

I seem to be able to reliably trigger this spinlock recursion problem
with systemtap on a RHEL4 kernel. The patch suggested above does seem to
correct it, but I'm not familiar enough with extables to know whether
the approach here is correct.

-- Jeff




