Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbUJYIVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbUJYIVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbUJYIUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:20:06 -0400
Received: from [211.58.254.17] ([211.58.254.17]:7314 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261729AbUJYIAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 04:00:51 -0400
Date: Mon, 25 Oct 2004 17:00:46 +0900
From: Tejun Heo <tj@home-tj.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] Per-device parameter support (13/16)
Message-ID: <20041025080046.GC20995@home-tj.org>
References: <20041023043138.GN3456@home-tj.org> <1098683773.8098.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098683773.8098.43.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 03:56:13PM +1000, Rusty Russell wrote:
> On Sat, 2004-10-23 at 13:31 +0900, Tejun Heo wrote:
> > +void devparam_module_done(struct module *mod)
> > +{
> > +	struct vector *vec = &mod->param_vec;
> > +	int i;
> > +
> > +	for (i = 0; i < vector_len(vec); i++) {
> > +		char **param = vector_elem(vec, i, 0);
> > +		if (param[0])
> > +			printk(KERN_ERR
> > +			       "Device params: Unknown parameter `%s'\n",
> > +			       param[0]);
> > +	}
> > +	
> > +	vector_destroy(vec);
> > +}
> 
> That seems a strange place to warn...  Is that right?

 Yes, it's right.  Because a module may contain more than one drivers,
devparam puts all paramters into an array and mask them off with NULL
when they are taken and, after module initialization is done, above
devparam_module_done() is called and prints warnings about untaken
paramters.  The same approach is used for boot options too.

> > +
> > +	/* Module parameter vector, used by deviceparam */
> > +	struct vector param_vec;
> 
> I don't mind the addition of your vector type, but adding infrastructure
> always results in arguments.  Can you think of another place which needs
> it?

 I just find dynamically expandable arrays very useful when I code
stuff.  Expanding/shrinking in the middle is maybe unnecessary but in
general, a vector w/ constructor/destructor is handy.  I cannot
pinpoint any specific code right now but I am pretty positive that
there are many places where unncessary fixed limit is employed to
avoid dynamic array management (not that fixed limit is always bad but
it's better to avoid them when possible without much overhead).

 If getting the vector in is difficult, I can merge vector codes into
devparam or change devparam to use list instead.  No problem there.
But I think that having generic vector around isn't a bad idea.  I'll
try to find places where vector can be useful if I can find some time.

 Thanks.

-- 
tejun

