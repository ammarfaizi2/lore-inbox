Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVF0SqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVF0SqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVF0SqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:46:22 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:30405 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261581AbVF0SqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:46:01 -0400
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, Hubertus Franke <frankeh@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Shailabh Nagar <nagar@us.ibm.com>, Vivek Kashyap <vivk@us.ibm.com>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 08/38] CKRM e18: Documentation 
In-reply-to: Your message of Sun, 26 Jun 2005 23:24:26 +0200.
             <20050626212426.GB1315@elf.ucw.cz> 
Date: Mon, 27 Jun 2005 11:45:32 -0700
Message-Id: <E1Dmybs-0004I0-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pavel - thanks for the comments - responses below:

On Sun, 26 Jun 2005 23:24:26 +0200, Pavel Machek wrote:
> > +CKRM Basics
> > +-------------
> 
> Perhaps you want to explain what "CKRM" means?
 
I'll update this to spell out CKRM a bit more.  CKRM stands for
Class based Kernel Resource Management.  I realize that that is a
bit wordy but early on the team chose to try to be explicit about what
was being added.  And, I'm guessing you really don't want to see
class_base_kernel_resource_management_number_of_tasks as a structure
name or class_base_kernel_resource_management_register_classification_engine()
as a function name.  And, while the term class is great for grouping in
the workload management context, using class_number_of_tasks seems a
bit presumptious in the kernel naming space.

I'm inclined to leave the name CKRM as is and improve the documentation
at this point unless you have a more specific solution which can be
acceptable to all.

> > +RCFS depicts a CKRM class as a directory. Hierarchy of classes can be
> 
> Another four letter acronym, unexplained?

Sorry - this is spelled out in a few places but probably not everywhere
it should be.  RCFS is the resource control filesystem.  This is simply
the place where class associates are defined and viewed.  This is a
somewhat special filesystem, on the order of sysfs or procfs but
specifically centered on CKRM management.  This avoids such nasties
as ioctl's or a whole raft of system calls, and also allows a fair
amount of flexibility for adding and modifying class based behaviors.

> > +   # cat /rcfs/taskclass/c1/members
> > +   lists pids of tasks belonging to c1
> > +
> > +   # cat /rcfs/socket_class/s1/members
> > +   lists the ipaddress\port of all listening sockets in s1
>                          ~
> 			  did you want to use "/" here?

I'm going to defer this one to Vivek.  This changed and I think the
backslash was in there but it may have changed to a : later.  Vivek?

> > Index: linux-2.6.12-ckrm1/Documentation/ckrm/crbce
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6.12-ckrm1/Documentation/ckrm/crbce	2005-06-20 13:08:35.000000000 -0700
> > @@ -0,0 +1,33 @@
> > +CRBCE
> > +----------
> > +
> > +crbce is a superset of rbce. In addition to providing automatic
> > +classification, the crbce module
> 
> Nice, but you should describe what RBCE means... And capitalize your
> acronyms consistently...
 
Sorry - again documentation should be updated here.  RBCE is one of
several possible classification engines.  The goal of a classification
engine is to automatically place processes at creation time (or at
the time of a change in several key attributes such as uid/gid/etc.)
into the proper user defined class.  RBCE is a Rule Based classification
engine, allowing you to set up some very basic rules for how processes
are classified.  It is the most simplistic of classification engines and
happens to also be the basis for CRBCE.

CRBCE has a *very* bad name. ;)   The C is for "Custom" rule based
classification engine.  And in part, it was intended primarily to be
an example of what more you could do in a classification engine beyond
just the basic classification.  In particular, it is a classifation
engine that also does some monitor of changes to classes, although I'm
wondering now based on an idea from Matt Helsley if this could actually
be a simple add-on to RBCE called something more like "class monitoring".

We'll look at this one a little more - in the meantime it is pretty easy
to play with as a good example of what else can be done.  It also shows
how to tie in a user level program for additional monitoring and feedback
which makes it both useful in a real sense as well as in an illustrative
sense.

> > Index: linux-2.6.12-ckrm1/Documentation/ckrm/rbce_basics
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6.12-ckrm1/Documentation/ckrm/rbce_basics	2005-06-20 13:08:35.000000000 -0700
> > @@ -0,0 +1,67 @@
> > +Rule-based Classification Engine (RBCE)
> > +-------------------------------------------
> > +
> > +The ckrm/rbce directory contains the sources for two classification engines
> > +called rbce and crbce. Both are optional, built as kernel modules and share much
> > +of their codebase. Only one classification engine (CE) can be loaded at a time
> > +in CKRM.
> 
> TMFLAs! (*)
> 
> Your resource managment may be quite nice system, but the naming is
> definitely very ugly. With your design we would not have open() system
> call, but ofsoarh() -- open filesystem object and return its
> handle. Can you come up with some reasonable naming?

Can you help?  ;)  I'd rather not change CKRM itself at this point - too
many papers and users and such.   While it is not impossible, I'm not
sure that it would help.  RCFS seems quite reasonable.  RBCE and CRBCE,
well, I'm much more likely to get excited about better names here.  ;)

There has to be a balance between 80 character names and complete
obfuscation by elidification of alphabetical constructs (COEAC).

I'm open to ideas...

> 								Pavel
> (*) Too many four letter acronyms.
> -- 
> teflon -- maybe it is a trademark, but it should not be.

gerrit
