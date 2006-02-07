Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWBGRnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWBGRnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWBGRnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:43:53 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:31628
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932387AbWBGRnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:43:52 -0500
Date: Tue, 7 Feb 2006 09:44:05 -0800
From: Greg KH <greg@kroah.com>
To: Max Asbock <masbock@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ibmasm driver: don't use previously freed pointer
Message-ID: <20060207174405.GA9260@kroah.com>
References: <1139005598.7521.68.camel@w-amax> <20060204060254.GA4454@kroah.com> <1139333357.7521.81.camel@w-amax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139333357.7521.81.camel@w-amax>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 09:29:17AM -0800, Max Asbock wrote:
> On Fri, 2006-02-03 at 22:02, Greg KH wrote:
> > On Fri, Feb 03, 2006 at 02:26:38PM -0800, Max Asbock wrote:
> > > ibmasm driver:
> > > Fix the command_put() function which uses a pointer for a spinlock that
> > > can be freed before dereferencing it.
> > > 
> > > Signed-off-by: Max Asbock masbock@us.ibm.com
> > > 
> > > ---
> > > 
> > > diff -burpN linux-2.6.16-rc1/drivers/misc/ibmasm/ibmasm.h linux-2.6.16-rc1.ibmasm/drivers/misc/ibmasm/ibmasm.h
> > > --- linux-2.6.16-rc1/drivers/misc/ibmasm/ibmasm.h	2006-02-01 11:50:01.000000000 -0800
> > > +++ linux-2.6.16-rc1.ibmasm/drivers/misc/ibmasm/ibmasm.h	2006-02-03 13:57:42.000000000 -0800
> > > @@ -101,10 +101,11 @@ struct command {
> > >  static inline void command_put(struct command *cmd)
> > >  {
> > >  	unsigned long flags;
> > > +	spinlock_t *lock = cmd->lock;
> > >  
> > > -	spin_lock_irqsave(cmd->lock, flags);
> > > +	spin_lock_irqsave(lock, flags);
> > >          kobject_put(&cmd->kobj);
> > > -	spin_unlock_irqrestore(cmd->lock, flags);
> > > +	spin_unlock_irqrestore(lock, flags);
> > >  }
> > 
> > If this patch is true, doesn't the spinlock the pointer is pointing out
> > still get deleted?
> > 
> > Yes you save a pointer off, but it looks like the problem is still
> > present.
> > 
> > Or am I missing something?
> > 
> 
> The lock pointer in struct command points to a spinlock outside the
> structure that doesn't get deleted.

Ok, that's what I was missing, nevermind then :)

thanks,

greg k-h
