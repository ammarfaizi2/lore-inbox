Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbTEAA1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTEAA1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:27:46 -0400
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:43282 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S262599AbTEAA1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:27:43 -0400
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <1051749599.20870.234.camel@iguana.localdomain>
From: Matt_Domsch@Dell.com
To: greg@kroah.com
cc: alan@redhat.com, linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
Date: Wed, 30 Apr 2003 19:39:57 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12AEB36A2685019-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First off, nice idea, but I think the implementation needs a bit of
> work.

Thanks.  I didn't expect it to be perfect first-pass.
Let me answer some questions out-of-order, maybe that will help.

> > echo 1 > probe_it
> > Why wouldn't the writing to the new_id file cause the probe to
> happen immediatly?  Why wait?  So I think we can get rid of that file.

That was my first idea, but Jeff said:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104681922317051&w=2
        I think there is value in decoupling the two operations:
        
        	echo "0x0000 0x0000 0x0000 0x0000 0x0000 0x0000" >
.../3c59x/table
        	echo 1 > .../3c59x/probe_it
        
        Because you want the id table additions to be persistant in the face
of
        cardbus unplug/replug, and for the case where cardbus card may not
be
        present yet, but {will,may} be soon.
        

> >  Individual device drivers may override the behavior of the new_id
> >   file, for instance, if they need to also pass driver-specific
> >   information.  Likewise, reading the individual dynamic ID files
> >   can be overridden by the driver.
> 
> Why would a driver want to override these behaviors?

Because the one field I'm not filling in by default is the opaque
unsigned long driver_data.  Most drivers don't need it, and those that
do tend to come in two camps:  those that put a single integer there
which is an internal table lookup for equivalancy, and those that put a
pointer there to something (which definitely shouldn't be passed from
userspace).  There aren't many of the latter (which is good), but I
didn't want them to break with the introduction of this patch.  They
should be recoded to to a table lookup, but that's beyond the scope I
wanted to deal with today. :-)

That said, if drivers implement their own write routines, I wanted to
give them a way to programatically expose what data should be written,
and how.   I'll grant that the current help text isn't programatically
helpful ATM.

> Ick, don't put help files within the kernel image.  Didn't you take
> them all out for the edd patch a while ago?  :)

If we resolve the above, I'll be happy to nuke them.

> Also, do we really need to keep a list of id's visible to userspace
> (the "0" file above?  We currently don't do that for the "static ids"
> (yeah I know they are easily extracted from the module image...)

That's the only reason I know - so one can always write an app to
retreive what IDs a given module has, both static and dynamic.  I don't
think it's critical to keep.


> Is that the exists() callback?

Yes.

> Is it really needed?  Can't the pci core do this without needing to
> push that logic into the driver core?  After all, it knows if the
> pci_driver->probe() call is non-NULL, the driver core doesn't.

I'll look into this.  I did something similar in the EDD code, so I
reused the idea again.

> Also, we really need a generic way to easily create subdirectories
> within the driver model, to keep you from having to dive down into
> kobjects and the mess, like you had to do here.  Pat's said he will
> work on this next, once he emerges from his OLS paper writing hole,
> and there's even a bug assigned to him for this:
>         http://bugme.osdl.org/show_bug.cgi?id=650
> Once that is in, this patch should clean up a whole lot.  I'd
> recommend waiting for that

Yes, that's fine.  I'd love to have that ability.  I did it the way Pat
wanted it a couple months ago.
http://marc.theaimsgroup.com/?l=linux-kernel&m=104678872809999&w=2

> (or if you want to tackle it, please do) before applying something
> like your patch.

I'm srue Pat will do a fine job. :-)

Thanks for the comments.
-Matt


-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


