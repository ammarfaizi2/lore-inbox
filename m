Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSIXFmw>; Tue, 24 Sep 2002 01:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261575AbSIXFmw>; Tue, 24 Sep 2002 01:42:52 -0400
Received: from dp.samba.org ([66.70.73.150]:39583 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261574AbSIXFmu>;
	Tue, 24 Sep 2002 01:42:50 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Hien Nguyen <hien@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC} 3 of 4 - New problem logging macros, plus template generation 
In-reply-to: Your message of "Mon, 23 Sep 2002 22:12:02 -0400."
             <3D8FC9F2.1020604@pobox.com> 
Date: Tue, 24 Sep 2002 15:47:15 +1000
Message-Id: <20020924054804.334A52C0E9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D8FC9F2.1020604@pobox.com> you write:
> > +/*
> > + * introduce(), problem(), and detail() macros
> > + * Sample usage:
> > + *	problem(LOG_ALERT, "Disk on fire!",
> > + *		detail(disk, "%s", drive->name),
> > + *		detail(temperature, "%d", drive->degC),
> > + *		detail(action, "%s", "Put out fire; run fsck."));
> > + */
> 
> 
> action is policy, it does not belong in the kernel at all.

Yes, it's a bad example, but...

> Further, I not sure we need to add all this new infrastructure when
> we could obtain the same result via [off the top of my head] printk
> standards in key drivers.

They want to formalize it so you can template it.  Noone wants "ERR:
400001020567" on their console, so having a method of generating that
number from something which is readable in source (and by default
turns into a pretty printk) makes sense.

> Why don't you start out with a list of requirements that you want to see 
> from drivers?  Only then can we objectively evaluate our needs.
> 
> You are proposing a solution without really making it clear what 
> problems you are solving.

Driver error collection and reporting.  You want an automated
catalogue of all the error messages the kernel can produce.  You want
them to be consistent.  You want to be able to control the verbosity.
You want to be able to attach other mechanisms to collect them.  You
want to combine them with your userspace logging systems to give a
picture of machine state (think thousands of remotely administered
machines).

You *can* do this with printk, but only the most disciplined of
drivers do (eg. Becker net drivers are really good at putting "eth0:"
etc in messages, others are not so great).

For this to be useful, it has to be ubiquitous, and for that it has to
be *easier* than printk to use correctly (which is a hard challenge).

> If you actually want to standardize some diagnostic messages, it is a 
> huge mistake [as your scsi driver example shows] to continue to use 
> random text strings followed by a typed attribute list.  If you really 
> wanted to standardize logging, why continue to allow driver authors to 
> printk driver-specific text strings in lieu of a standard string that 
> applies to the same situation in N drivers.

I disagree.  In their non-printk backend, the strings are simply
hashed (with the driver name) into tokens: they're remarkably robust
against driver linenumber changes and minor code changes.

We don't have that much structure in the kernel: the helper macros the
minimal sufficient to ensure that the device is identified with every
problem.

There are nice things you can do with ratelimiting these messages
sanely as well, and translations.

I think the architecture is fairly sound, although the implementation
needs some tweaking.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
