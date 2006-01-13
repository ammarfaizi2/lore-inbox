Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423080AbWAMW6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423080AbWAMW6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423077AbWAMW6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:58:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:12763 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1423075AbWAMW6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:58:47 -0500
Date: Fri, 13 Jan 2006 14:55:37 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kobject: don't oops on null kobject.name
Message-ID: <20060113225537.GA25522@kroah.com>
References: <200601122004_MC3-1-B5C5-4B72@compuserve.com> <20060113143013.0ed0f9c0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113143013.0ed0f9c0.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 02:30:13PM -0800, Andrew Morton wrote:
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> > kobject_get_path() will oops if one of the component names is
> > NULL.  Fix that by returning NULL instead of oopsing.
> > 
> > Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> > ---
> > 
> > Helge, this fixes your "2.6.15 OOPS while trying to mount cdrom".
> > 
> > Probably not the best fix, but It Works For Me (TM).
> > 
> > --- 2.6.15a.orig/lib/kobject.c
> > +++ 2.6.15a/lib/kobject.c
> > @@ -72,6 +72,8 @@ static int get_kobj_path_length(struct k
> >  	 * Add 1 to strlen for leading '/' of each level.
> >  	 */
> >  	do {
> > +		if (kobject_name(parent) == NULL)
> > +			return 0;
> >  		length += strlen(kobject_name(parent)) + 1;
> >  		parent = parent->parent;
> >  	} while (parent);
> > @@ -107,6 +109,8 @@ char *kobject_get_path(struct kobject *k
> >  	int len;
> >  
> >  	len = get_kobj_path_length(kobj);
> > +	if (len == 0)
> > +		return NULL;
> >  	path = kmalloc(len, gfp_mask);
> >  	if (!path)
> >  		return NULL;
> 
> I'd have thought that we'd want the test right at the start of
> kobject_add() - fail it if ->name is zero.  I don't know if that'd work for
> all callers, but kobject_add() does play around with the ->name field and
> will go oops if ->name==NULL and debugging is enabled.

Something like this instead?  (warning, untested...)

I'll try it out in a reboot cycle...

thanks,

greg k-h


--- gregkh-2.6.orig/lib/kobject.c	2006-01-13 09:15:18.000000000 -0800
+++ gregkh-2.6/lib/kobject.c	2006-01-13 14:54:40.000000000 -0800
@@ -164,6 +164,11 @@ int kobject_add(struct kobject * kobj)
 		return -ENOENT;
 	if (!kobj->k_name)
 		kobj->k_name = kobj->name;
+	if (!kobj->k_name) {
+		pr_debug("kobject attempted to be registered with no name!\n");
+		WARN_ON(1);
+		return -EINVAL;
+	}
 	parent = kobject_get(kobj->parent);
 
 	pr_debug("kobject %s: registering. parent: %s, set: %s\n",
