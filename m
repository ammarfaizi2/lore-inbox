Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbVLMI13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbVLMI13 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVLMI1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:27:05 -0500
Received: from web8605.mail.in.yahoo.com ([202.43.219.80]:21372 "HELO
	web8605.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932562AbVLMI06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:26:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=a07PA0uVCs5vBT7HNVFr+CYpUO2O5SR9wscxBh2q6BtZJRPWaLn3wKJ643gl1dDbAgdVi1HAGvHhIXlb/Es6tCl3mYAWV6KfbXRjNYxSuP2Pd1h/ov1SNiNJ8Dwg0irEGXNlVHui4DRSKx2U20VlRm7i7TAdYTDxiKo+4O99Lw0=  ;
Message-ID: <20051213082350.11599.qmail@web8605.mail.in.yahoo.com>
Date: Tue, 13 Dec 2005 00:23:50 -0800 (PST)
From: "Anand H. Krishnan" <anandhkrishnan@yahoo.co.in>
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
To: Jesper Juhl <jesper.juhl@gmail.com>,
       Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, rth@redhat.com,
       akpm@osdl.org, Greg KH <greg@kroah.com>, anandhkrishnan@yahoo.co.in
In-Reply-To: <9a8748490512121425r63cba7axab114f80746ee066@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> I'm wondering, doesn't this take quite a long time? 
> Too long to hold
> a spinlock for?
> 
> Of course we need locking to prevent other module
> loads to modify the
> symbol table while we are checking this one, but to
> prevent the kernel
> from stalling everything else for a long time,
> wouldn't it be better
> to use a semaphore (we can sleep with those -
> right?) and an explicit
> schedule() call in the loop(s)?   Or am I completely
> out in outere
> space with that thought?
> 

Both at the time of loading a module and while
unloading a 
module module_mutex is acquired. In the first place we
wer
e not planning to take the spinlock at all. But saw
that r
esolve_symbol does that and hence wasn't sure whether 
the
lock should be acquired. 


> Shouldn't this printk() be using KERN_ERROR ?
> 
> 	printk(KERN_ERROR "%s: Duplicate Exported Symbol
> found in %s\n",
> 
> 
> > +			strtab + index, mod->name);
> > +	return -ENOEXEC;
> > +duplicate_gpl_sym:
> > +	spin_unlock_irq(&modlist_lock);
> > +	printk("%s: Duplicate Exported Symbol found in
> %s\n",
> > +			strtab + index, mod->name);
> > +	return -ENOEXEC;
> > +}
> 
> Why 3 different exit paths? and 2 of them are even
> identical. Why not
> something like this instead? :
> 
> {
> ...
>     if (unlikely(value) {
>         ret = -ENOEXEC;
>         goto out;
>     }
> ...
>  out:
>     spin_unlock_irq();
>     if (ret)
>         printk();
>     return ret;
> }
> 

We will send an updated patch with the modifications.

Thanks,
Anand


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
