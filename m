Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752471AbWCGCBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbWCGCBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbWCGCBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:01:17 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36533 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752471AbWCGCBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:01:16 -0500
Subject: Re: [RFC][PATCH 1/6] prepare sysctls for containers
From: Dave Hansen <haveblue@us.ibm.com>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Sam Vilain <sam@vilain.net>
In-Reply-To: <20060307005002.GA15640@MAIL.13thfloor.at>
References: <20060306235248.20842700@localhost.localdomain>
	 <20060306235249.880CB28A@localhost.localdomain>
	 <20060307005002.GA15640@MAIL.13thfloor.at>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 18:00:21 -0800
Message-Id: <1141696822.9274.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 01:50 +0100, Herbert Poetzl wrote:
> On Mon, Mar 06, 2006 at 03:52:49PM -0800, Dave Hansen wrote:
> > 
> > Right now, sysctls can only deal with global variables.  This
> > patch makes them a _little_ more flexible by allowing there to
> > be an accessor function to get at the variable being changed,
> > instead of it being global.
> > 
> > This allows the sysctls to be backed by variables that are,
> > for instance, dynamically allocated and not available at
> > compile-time.
> > 
> > This also provides a very simple mechanism to take things that
> > are currently global and containerize them.
> 
> hmm, why do you call the sysctl_table_data() over and
> over again? what's the purpose?

Letting me be lazy and code with s/// :)

For the current application, it doesn't really matter.  But, I can
imagine that other users could be a bit more costly.  

> what about sideeffects?

Require that there aren't any. ;)

It might be necessary to have something effectively implementing put and
get, but this certainly doesn't need it yet.

> > Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> > ---
> > 
> >  work-dave/include/linux/sysctl.h |    8 ++++
> >  work-dave/kernel/sysctl.c        |   65 ++++++++++++++++++++++++++-------------
> >  2 files changed, 52 insertions(+), 21 deletions(-)
> > 
> > diff -puN include/linux/sysctl.h~sysctls-for-containers include/linux/sysctl.h
> > --- work/include/linux/sysctl.h~sysctls-for-containers	2006-03-06 15:41:55.000000000 -0800
> > +++ work-dave/include/linux/sysctl.h	2006-03-06 15:41:55.000000000 -0800
> > @@ -872,6 +872,7 @@ extern void sysctl_init(void);
> >  
> >  typedef struct ctl_table ctl_table;
> >  
> > +typedef void *ctl_data_access (void);
> >  typedef int ctl_handler (ctl_table *table, int __user *name, int nlen,
> >  			 void __user *oldval, size_t __user *oldlenp,
> >  			 void __user *newval, size_t newlen, 
> > @@ -957,6 +958,13 @@ struct ctl_table 
> >  	int ctl_name;			/* Binary ID */
> >  	const char *procname;		/* Text ID for /proc/sys, or zero */
> >  	void *data;
> > +	ctl_data_access *data_access;	/* set this to a function if you
> > +					 * don't have a static place to point
> > +					 * ->data at compile-time.  This
> > +					 * function will be called to dynamically
> > +					 * figure out a ->data pointer.  Do not
> > +					 * set this and ->data at once.
> > +					 */
> >  	int maxlen;
> >  	mode_t mode;
> >  	ctl_table *child;
> > diff -puN kernel/sysctl.c~sysctls-for-containers kernel/sysctl.c
> > --- work/kernel/sysctl.c~sysctls-for-containers	2006-03-06 15:41:55.000000000 -0800
> > +++ work-dave/kernel/sysctl.c	2006-03-06 15:41:55.000000000 -0800
> > @@ -1197,6 +1197,24 @@ repeat:
> >  	return -ENOTDIR;
> >  }
> >  
> 
> I'd expect that to be inline, and to vanish when
> containers are disabled ...

Unless we want non-container code to be able to use it.  I guess we
could restrict it to containers only, though.

> > +void *sysctl_table_data(ctl_table *table)
> > +{
> > +	void *data;
> > +
> > +	if (table->data && table->data_access) {
> > +		printk(KERN_WARNING
> > +			"sysctl: data and accessor function set for: '%s'\n",
> > +			table->procname);
> > +		table->data = NULL;
> 
> why is ->data and ->data_access evil?

As it stands, which one do you use?  What if they aren't consistent?  Do
you use both?  Just one?  Which first?  Easiest to just say that it
isn't allowed.

> wouldn't some get/set helper make more sense?
> i.e. some virtualizer and devirtualizer functions?

I'm not quite sure I know what you mean.  Can you elaborate some more?

-- Dave

