Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbTEBXBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 19:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTEBXBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 19:01:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:12962 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263200AbTEBXBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 19:01:44 -0400
Date: Fri, 2 May 2003 16:15:58 -0700
From: Greg KH <greg@kroah.com>
To: Matt_Domsch@Dell.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
Message-ID: <20030502231558.GA16209@kroah.com>
References: <1051749599.20870.234.camel@iguana.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051749599.20870.234.camel@iguana.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 07:39:57PM -0500, Matt_Domsch@Dell.com wrote:
> > First off, nice idea, but I think the implementation needs a bit of
> > work.
> 
> Thanks.  I didn't expect it to be perfect first-pass.
> Let me answer some questions out-of-order, maybe that will help.
> 
> > > echo 1 > probe_it
> > > Why wouldn't the writing to the new_id file cause the probe to
> > happen immediatly?  Why wait?  So I think we can get rid of that file.
> 
> That was my first idea, but Jeff said:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104681922317051&w=2
>         I think there is value in decoupling the two operations:
>         
>         	echo "0x0000 0x0000 0x0000 0x0000 0x0000 0x0000" >
> .../3c59x/table
>         	echo 1 > .../3c59x/probe_it
>         
>         Because you want the id table additions to be persistant in the face of
>         cardbus unplug/replug, and for the case where cardbus card may not be
>         present yet, but {will,may} be soon.

But by adding the device ids, they will be persistant, for that driver,
right?  Then when the device is plugged in, the core will iterate over
the static and dynamic ids, right?  If so, I don't see how a "probe_it"
file is needed.

> > >  Individual device drivers may override the behavior of the new_id
> > >   file, for instance, if they need to also pass driver-specific
> > >   information.  Likewise, reading the individual dynamic ID files
> > >   can be overridden by the driver.
> > 
> > Why would a driver want to override these behaviors?
> 
> Because the one field I'm not filling in by default is the opaque
> unsigned long driver_data.  Most drivers don't need it, and those that
> do tend to come in two camps:  those that put a single integer there
> which is an internal table lookup for equivalancy, and those that put a
> pointer there to something (which definitely shouldn't be passed from
> userspace).  There aren't many of the latter (which is good), but I
> didn't want them to break with the introduction of this patch.  They
> should be recoded to to a table lookup, but that's beyond the scope I
> wanted to deal with today. :-)
> 
> That said, if drivers implement their own write routines, I wanted to
> give them a way to programatically expose what data should be written,
> and how.   I'll grant that the current help text isn't programatically
> helpful ATM.

Ah, can't you just not worry about that driver_data field somehow?  Like
say, "Any driver that depends on it, can't use the dynamic_id"? :)

I know, wishful thinking.  But I still don't think you should be
cluttering up the driver core with that, it should be able to be
localized within the pci code somehow.

> > Ick, don't put help files within the kernel image.  Didn't you take
> > them all out for the edd patch a while ago?  :)
> 
> If we resolve the above, I'll be happy to nuke them.

Either way, we shouldn't have help files within the kernel.  I'd say
nuke them, and write up some good documentation :)

> > Also, do we really need to keep a list of id's visible to userspace
> > (the "0" file above?  We currently don't do that for the "static ids"
> > (yeah I know they are easily extracted from the module image...)
> 
> That's the only reason I know - so one can always write an app to
> retreive what IDs a given module has, both static and dynamic.  I don't
> think it's critical to keep.

I'd say drop it for now, it keeps the code simpler.  If people _really_
cry out for some way to retrieve them later, we can worry about that
then.

thanks,

greg k-h
