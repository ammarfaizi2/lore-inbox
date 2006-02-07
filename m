Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWBGR3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWBGR3Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWBGR3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:29:23 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:8922 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932123AbWBGR3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:29:22 -0500
Subject: Re: [PATCH] ibmasm driver: don't use previously freed pointer
From: Max Asbock <masbock@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060204060254.GA4454@kroah.com>
References: <1139005598.7521.68.camel@w-amax>
	 <20060204060254.GA4454@kroah.com>
Content-Type: text/plain
Message-Id: <1139333357.7521.81.camel@w-amax>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 07 Feb 2006 09:29:17 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 22:02, Greg KH wrote:
> On Fri, Feb 03, 2006 at 02:26:38PM -0800, Max Asbock wrote:
> > ibmasm driver:
> > Fix the command_put() function which uses a pointer for a spinlock that
> > can be freed before dereferencing it.
> > 
> > Signed-off-by: Max Asbock masbock@us.ibm.com
> > 
> > ---
> > 
> > diff -burpN linux-2.6.16-rc1/drivers/misc/ibmasm/ibmasm.h linux-2.6.16-rc1.ibmasm/drivers/misc/ibmasm/ibmasm.h
> > --- linux-2.6.16-rc1/drivers/misc/ibmasm/ibmasm.h	2006-02-01 11:50:01.000000000 -0800
> > +++ linux-2.6.16-rc1.ibmasm/drivers/misc/ibmasm/ibmasm.h	2006-02-03 13:57:42.000000000 -0800
> > @@ -101,10 +101,11 @@ struct command {
> >  static inline void command_put(struct command *cmd)
> >  {
> >  	unsigned long flags;
> > +	spinlock_t *lock = cmd->lock;
> >  
> > -	spin_lock_irqsave(cmd->lock, flags);
> > +	spin_lock_irqsave(lock, flags);
> >          kobject_put(&cmd->kobj);
> > -	spin_unlock_irqrestore(cmd->lock, flags);
> > +	spin_unlock_irqrestore(lock, flags);
> >  }
> 
> If this patch is true, doesn't the spinlock the pointer is pointing out
> still get deleted?
> 
> Yes you save a pointer off, but it looks like the problem is still
> present.
> 
> Or am I missing something?
> 

The lock pointer in struct command points to a spinlock outside the
structure that doesn't get deleted.

max

