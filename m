Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWKDAnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWKDAnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 19:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWKDAnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 19:43:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:39832 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932525AbWKDAnT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 19:43:19 -0500
Subject: Re: [PATCH 1/9] Task Watchers v2: Task watchers v2
From: Matt Helsley <matthltc@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1162560154.2801.13.camel@localhost.localdomain>
References: <20061103042257.274316000@us.ibm.com>
	 <20061103042748.438619000@us.ibm.com>
	 <1162560154.2801.13.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Fri, 03 Nov 2006 16:43:14 -0800
Message-Id: <1162600994.12419.397.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 08:22 -0500, Daniel Walker wrote:
> On Thu, 2006-11-02 at 20:22 -0800, Matt Helsley wrote:
> > +/*
> > + * Watch for events occuring within a task and call the supplied
> > function
> > + * when (and only when) the given event happens.
> > + * Only non-modular kernel code may register functions as
> > task_watchers.
> > + */
> > +#define task_watcher_func(ev, fn) \
> > +static task_watcher_fn __task_watcher_##ev##_##fn __attribute_used__
> > \
> > +       __attribute__ ((__section__ (".task_watchers." #ev))) = fn
> > +#else
> > +#error "task_watcher() macro may not be used in modules."
> > +#endif 
> 
> You should make this TASK_WATCHER_FUNC() or even just TASK_WATCHER(). It
> looks a little goofy in the code that uses it.

I can certainly change this. In my defense I didn't capitalize it
because very similar macros in init.h were not capitalized. For example:

#define core_initcall(fn)               __define_initcall("1",fn)
#define postcore_initcall(fn)           __define_initcall("2",fn)
#define arch_initcall(fn)               __define_initcall("3",fn)
#define subsys_initcall(fn)             __define_initcall("4",fn)
#define fs_initcall(fn)                 __define_initcall("5",fn)
#define device_initcall(fn)             __define_initcall("6",fn)
#define late_initcall(fn)               __define_initcall("7",fn)

setup_param, early_param, module_init, etc. do not use all-caps. And I'm
sure that's not all.

All of these declare variables and assign them attributes and values.

> Looking at it now could you do something like,
> 
> static int __task_watcher_init 
> audit_alloc(unsigned long val, struct task_struct *tsk)
> 
> Instead of a macro? Might be a little less invasive.

	I like your suggestion. However, I don't see how such a macro could be
made to replace the current macro.

	I need to be able to call every init function during task
initialization. The current macro creates and initializes a function
pointer in an array in the special ELF section. This allows the
notify_task_watchers function to traverse the array and make calls to
the init functions.

	I use the name of the function and event to name and intialize the
function pointer. I don't see any way to get the name of the function
without taking a parameter. This also means it would have to be
initialized after the function was declared or defined.

	I considered placing the function code in the ELF section. However I
don't know of any gcc or linker functions that would allow me to iterate
over all of the functions in an ELF section and call them from fork,
exec, exit, etc. I've even looked through the docs and googled.

	I considered doing symbol lookups. Part of the problem is knowing the
names I need to look up. Furthermore, I think doing symbol lookups for
each call would be alot slower. I could create a dynamically-allocated
array and put the lookup results there. However that's more code and
more memory...

	However, your suggestion could put all of the functions near each
other. That locality could improve performance. So I'll try adding
__task_watcher_<event> macros but I can't see a way to make them work as
you suggested.

Cheers,
	-Matt Helsley

