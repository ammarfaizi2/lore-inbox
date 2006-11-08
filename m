Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161690AbWKHTDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161690AbWKHTDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161692AbWKHTDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:03:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42937 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161690AbWKHTDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:03:52 -0500
Date: Wed, 8 Nov 2006 10:56:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Possible spinlock recursion in search_module_extables() ?
Message-Id: <20061108105625.c08f4615.akpm@osdl.org>
In-Reply-To: <1163007738.12604.4.camel@dantu.rdu.redhat.com>
References: <200606190635_MC3-1-C2D8-258F@compuserve.com>
	<1163007738.12604.4.camel@dantu.rdu.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 12:42:17 -0500
Jeff Layton <jlayton@redhat.com> wrote:

> On Mon, 2006-06-19 at 06:31 -0400, Chuck Ebbert wrote:
> > Looking at this code:
> > 
> > const struct exception_table_entry *search_exception_tables(unsigned long addr)
> > {
> >         const struct exception_table_entry *e;
> > 
> >         e = search_extable(__start___ex_table, __stop___ex_table-1, addr);
> >         if (!e)
> >                 e = search_module_extables(addr);
> >         return e;
> > }
> > 
> > const struct exception_table_entry *search_module_extables(unsigned long addr)
> > {
> >         unsigned long flags;
> >         const struct exception_table_entry *e = NULL;
> >         struct module *mod;
> > 
> >         spin_lock_irqsave(&modlist_lock, flags);
> >         list_for_each_entry(mod, &modules, list) {
> >                 if (mod->num_exentries == 0)
> >                         continue;
> > 
> >                 e = search_extable(mod->extable,
> >                                    mod->extable + mod->num_exentries - 1,
> >                                    addr);
> >                 if (e)
> >                         break;
> >         }
> >         spin_unlock_irqrestore(&modlist_lock, flags);
> > 
> >         /* Now, if we found one, we are running inside it now, hence
> >            we cannot unload the module, hence no refcnt needed. */
> >         return e;
> > }
> > 
> > 
> > search_module_extables() takes a spinlock.  If some kind of fault occurs
> > while it's holding that lock (module list corrupted etc.,) won't it be
> > re-entered while looking for its own fault handler?  If so, would this
> > be a possible fix?
> > 
> > const struct exception_table_entry *search_exception_tables(unsigned long addr)
> > {
> >         const struct exception_table_entry *e;
> > 
> >         if (core_kernel_text(addr))
> >                 e = search_extable(__start___ex_table, __stop___ex_table-1, addr);
> >         else
> >                 e = search_module_extables(addr);
> > 
> >         return e;
> > }
> 
> I seem to be able to reliably trigger this spinlock recursion problem
> with systemtap on a RHEL4 kernel. The patch suggested above does seem to
> correct it, but I'm not familiar enough with extables to know whether
> the approach here is correct.
> 

It'll still deadlock if we take an oops from a module, won't it?

The usual way of fixing this sort of thing is to play games with
oops_in_progress.

