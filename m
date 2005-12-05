Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbVLEXCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVLEXCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVLEXCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:02:43 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:63675
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751435AbVLEXCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:02:42 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Greg KH <greg@kroah.com>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Mon, 5 Dec 2005 16:47:55 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20051203152339.GK31395@stusta.de> <20051203225020.GF25722@merlin.emma.line.org> <20051204002043.GA1879@kroah.com>
In-Reply-To: <20051204002043.GA1879@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512051647.55395.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 December 2005 18:20, Greg KH wrote:
> On Sat, Dec 03, 2005 at 11:50:20PM +0100, Matthias Andree wrote:
> > The point is, removing something that has worked well enough that some
> > people had a reason to use it, is not "stable".
>
> Please remember, no one is calling 2.6 "stable" anymore than they are
> calling it "development".  The current development model is different
> than what we used to do pre 2.6.  See the archives for details about
> this if you want more information.
>
> > Third, IF udev is so sexy but OTOH a real kernel-space devfs can be done
> > in 200 LoC as has been claimed so often,
>
> 282 LoC:
...
> > why in hell is this not happening?
>
> Because it's not the correct solution.

More detail on this:

On the busybox list we're currently working out a design for mdev, the 
micro-udev that'll go into busybox 1.2.  So we're thinking about this issue 
pretty carefully, as we speak.  What's the minimal amount of work we can't 
get away with not doing?

And much as we'd like to, we can't eliminate the config file.  In mdev we can 
accept the kernel's suggested names for devices, throw everything into a 
single directory with no subdirectories, even configure out hotplugging 
support (since not all embedded devices need that).  But nowhere in sys is 
there any hint about the correct ownership and permissions for a device, and 
you can't create a device node without specifying that.

The fundamental problem is that the kernel _can't_ tell us this through /sys 
because the kernel has no idea what users and groups are on a given system.  
It can't, and it shouldn't.  That's not it's job.  (It deals with uid and gid 
and never looks at /etc/passwd or /etc/groups.  And if it doesn't know who 
should own what, it can't know what permissions they should have either.)

So no in-kernel filesystem can get this right without help from userspace 
(even devfs had devfsd), and as soon as you've got a userspace daemon to tell 
the kernel who is who you might as well do the whole thing there, now that 
the kernel is exporting everyting _else_ we need to know via /sys 
and /sbin/hotplug.

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
