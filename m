Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265594AbSJXSFl>; Thu, 24 Oct 2002 14:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265595AbSJXSFl>; Thu, 24 Oct 2002 14:05:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:13703 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265594AbSJXSFj>;
	Thu, 24 Oct 2002 14:05:39 -0400
Date: Thu, 24 Oct 2002 11:15:13 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Jeff Garzik <jgarzik@pobox.com>
cc: Mark Peloquin <peloquin@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <viro@math.psu.edu>
Subject: Re: Switching from IOCTLs to a RAMFS
In-Reply-To: <3DB831FF.4000900@pobox.com>
Message-ID: <Pine.LNX.4.44.0210241051340.983-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Oct 2002, Jeff Garzik wrote:

> Mark Peloquin wrote:
> > Based on the feedback and comments regarding
> > the use of IOCTLs in EVMS, we are switching to
> > the more preferred method of using a ram based
> > fs. Since we are going through this effort, I
> > would like to get it right now, rather than
> > having to switch to another ramfs system later
> > on. The question I have is:  should we roll our
> > own fs, (a.k.a. evmsfs) or should we use sysfs
> > for this purpose? My initial thoughts are that
> > sysfs should be used. However, recent discussions
> > about device mapper have suggested a custom ramfs.
> > Which is the *best* choice?
> 
> 
> (cc'd viro and mochel, as I feel they are 'owners' in the subject area)
> 
> Let's jump back a bit, for a second.  Why is procfs bad news?  There are 
> minor issues with the implementation of single-page output and lack of 
> pure file operations, but the big issue is lack of a sane namespace. 
> sysfs is no better than procfs if we keep heaving junk into it without 
> thinking about proper namespace organization.

That's one of my personal goals: to mandate some amount of sanity in the 
namespace organization. Without it, sysfs is basically just a modernized 
procfs. 

> I personally prefer a separate filesystem for what you describe.  That 
> gives the EVMS team control over their own portion of the namespace, 
> while giving complete flexibility.  I do _not_ see sysfs as simply a 
> procfs replacement -- sysfs IMO is more intended as a way to organize 
> certain events and export internal kernel structure.

I do not view those as necessarily competing goals. The mission statement 
of sysfs is to "export kernel objects, their attributes, and their 
relation to other objects". 

EVMS, like any other subsystem, has a set of objects and methods to
operate on them, as exported via attributes. They have their have their
own object hierarchy, and in no way do I want to dilute that (or pollute
anything else ;).  sysfs should be able to handle this. It does today,
though it's not as seamless as I would prefer it.

I would rather mature the API and consolidate the common code, than have N 
copies of the same filesystem, each with a slightly different purpose, in 
existence. There are so many benefits:

- Less code duplication, and less places to fix identical bugs. 

- It makes it easier to write for; instead of having to copy n' paste a
  new filesystem to export your subsystem's objects, you can add a field 
  to a structure and call a function.

- It's easier for the user to mount one filesystem and get everything, 
  instead of trying to figure out what fs has what ifno. 

- It's easier to associate objects between subsystems, since you can 
  internally create relative symlinks between two objects (and soon with a
  single call). 


	-pat

