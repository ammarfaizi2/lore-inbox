Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbTIJP33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbTIJP33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:29:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:24228 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264992AbTIJP3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:29:20 -0400
Date: Wed, 10 Sep 2003 08:26:41 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] add kobject to struct module 
In-Reply-To: <20030910080955.9318E2C0EB@lists.samba.org>
Message-ID: <Pine.LNX.4.33.0309100807430.1012-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > read/write of what?  The attribute?  Sure, why not set the module
> > attribute sysfs file to the module that way the reference count will be
> > incremented if the sysfs file is opened.
> 
> Hmm, because there's one attribute: which module would own it?  You're
> going to creation attributes per module later (for module parameters),
> so when you do that it might make sense to do this too.

kernel/module.c owns the attribute code. (The same code and attribute 
structure is reused for each object its exported for, so the owner field 
must be set to the owner of the code itself.) 

> > But in looking at your patch, I don't see why you want to separate the
> > module from the kobject?  What benefit does it have?
> 
> The lifetimes are separate, each controlled by their own reference
> count.  I *know* this will work even if someone holds a reference to
> the kobject (for some reason in the future) even as the module is
> removed.

Correct me if I'm wrong, but this sounds similar to the networking 
refcount problem. The reference on the containing object is the 
interesting one, as far as visibility goes. As long as its positive, the 
module is active. 

The kobject refcount can still be used for the lifetime of the object. It
can simply be pinned the entire time the module is active. When the module
is deleted, the kobject can be unregistered somewhere around
free_module(). It looks like you might want to split that up into two
parts: "Before unregistering the kobject" that removed it from lists, etc, 
and "In kobject release method", which would call module_free() (and 
probably free the args then too). 

This way you should retain the same semantics and be able to use the 
kobject for controlling the lifetime (which will allow you to safely 
export attributes through sysfs). 

Make sense? 


	Pat

