Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVA3MkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVA3MkY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 07:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVA3MkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 07:40:24 -0500
Received: from mail.dif.dk ([193.138.115.101]:27051 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261694AbVA3MkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 07:40:13 -0500
Date: Sun, 30 Jan 2005 13:43:35 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: "Paul `Rusty' Russell" <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] micro optimization in kernel/params.c; don't call
 to_module_kobject before we really have to.
In-Reply-To: <41FC2693.6060601@didntduck.org>
Message-ID: <Pine.LNX.4.62.0501301307260.2731@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.62.0501300024110.2829@dragon.hygekrogen.localhost>
 <41FC2693.6060601@didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2005, Brian Gerst wrote:

> Jesper Juhl wrote:
> > In kernel/params.c::module_attr_show and kernel/params.c::module_attr_store
> > we call to_module_kobject() and save the result in a local variable right
> > before a conditional statement that does not depend on the call to
> > to_module_kobject() and may cause the function to return. If the function
> > returns before we use the result of to_module_kobject() then the call is
> > just a waste of time. The patch moves the call to to_module_kobject() down
> > just before it is actually used, thus we save a call to the function in a
> > few cases. I doubt this is in any way measurable, but I see no reason to not
> > move the call - it should be an infinitesimal improvement with no ill
> > sideeffects.
> > Please consider applying.
> > 
> > 
> > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> > 
> > diff -up linux-2.6.11-rc2-bk7-orig/kernel/params.c
> > linux-2.6.11-rc2-bk7/kernel/params.c
> > --- linux-2.6.11-rc2-bk7-orig/kernel/params.c	2005-01-29 23:54:53.000000000
> > +0100
> > +++ linux-2.6.11-rc2-bk7/kernel/params.c	2005-01-30 00:27:08.000000000
> > +0100
> > @@ -625,11 +625,12 @@ static ssize_t module_attr_show(struct k
> >  	int ret;
> >   	attribute = to_module_attr(attr);
> > -	mk = to_module_kobject(kobj);
> >   	if (!attribute->show)
> >  		return -EPERM;
> >  +	mk = to_module_kobject(kobj);
> > +
> >  	if (!try_module_get(mk->mod))
> >  		return -ENODEV;
> >  @@ -649,11 +650,12 @@ static ssize_t module_attr_store(struct  	int
> > ret;
> >   	attribute = to_module_attr(attr);
> > -	mk = to_module_kobject(kobj);
> >   	if (!attribute->store)
> >  		return -EPERM;
> >  +	mk = to_module_kobject(kobj);
> > +
> >  	if (!try_module_get(mk->mod))
> >  		return -ENODEV;
> >  
> > 
> 
> I'd bet that the compiler already reorders the assignment since there is no
> side effect to to_module_kobject().  Even with a patch like this you can't
> control exactly when the assignment is done.  There may not even be an
> assignment, since mk is a constant offset of kobj.
> 
True, the compiler is free to be clever, but I still think it's best to 
write the code in the most optimal way as seen from a C perspective. 
I just took a look at the compiled object files with and without the 
patch, and it makes no difference what-so-ever - gcc generates the exact 
same code. So you are right, gcc is clever about it. 
Hmm, it's Rusty's code as far as I can see, I'll leave it up to him to 
apply the patch or not.

-- 
Jesper


