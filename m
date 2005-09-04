Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbVIDDxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbVIDDxz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 23:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVIDDxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 23:53:55 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:36965 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S1750871AbVIDDxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 23:53:54 -0400
Date: Sat, 3 Sep 2005 20:53:41 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: phillips@istop.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Message-ID: <20050904035341.GO8684@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, phillips@istop.com,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <200508310854.40482.phillips@istop.com> <20050830231307.GE22068@insight.us.oracle.com> <20050830162846.5f6d0a53.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830162846.5f6d0a53.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 04:28:46PM -0700, Andrew Morton wrote:
> Sure, but all that copying-and-pasting really sucks.  I'm sure there's some
> way of providing the slightly different semantics from the same codebase?

	First, let's look at sharing the primary structures.

[kobject vs config_item]

	When I first started configfs, I tried to make it part of sysfs.
That was obviously a bad idea before I got very far at all (more on this
as we go along).  So I forked the codebase.  I wanted, however, to
preserve kobject and kset, because I figured we didn't need another
kernel object type.  For the longest time usysfs (user-sysfs, as it was
originally called) used kobjects and jumped through hoops to make it work.
	The base structures, kobject and config_item, are indeed
identical in physical layout.  But in use, they are very different.  A
kobject, when created, is expected to appear sysfs.  You mistakenly
kobject_add(), whoops, there it is.  kobject_init() tries to link a
kobject to the kobject->kset pointer, because it's expecting the kernel
to be handling the relationship.
	In configfs, the relationship is handled by the VFS.  The
linkage is purposefully controlled by the ->mkdir() codepath.  The
client driver using this relationship can follow it, but never modify it
or call anything that modifies it.
	In the earlier configfs incarnations that used kobject/kset, I
found myself having to fool the kobject infrastructure to get
kobject->kset correct.  In addition, it was a complexity I had to always
think about.  In configfs with config_item, it's not an issue because it
doesn't exist.

[kobj_type vs config_item_type]

	kobj_type has three pointers.  A release function for the
object, a set of sysfs_ops for attribute functions, and a set of
default_attrs.
	config_item_type needs to know the module owner to pin the
client module.  It has 5 item operations (this includes the parallels
for sysfs_ops) and 4 group operations (this is for config_group, the
parallel of kset).  Because operation structures are often shared, these
are made into structures.
	kobj_type would have to know all the features of
config_item_type, even though it is useless stuff for sysfs.  Waste of
memory and code.

[subsystem vs configfs_subsystem]

	The sysfs folks are trying to lose the semaphore from a sysfs
subsystem, because it makes sense to have locking that is finer grained.
It should apply to the granularity of the specific device or so.
	configfs_subsystem needs the semaphore, because it protects only
one thing: the config_group/config_item hierarchy.  When a client module
wants to navigate the tree of its groups and items, it merely takes the
semaphore and navigates.  Once it finds and grabs a kref to what it
needs, it can drop it.  There is no need for any more complex locking.

[kset vs config_group]

	Here is where it gets really different.  A kset may or may not
represent a directory exactly.  kobjects can be part of a kset they
aren't under in the sysfs tree.  configfs_items must be part of the
parent config_group, becuase the VFS tree (the dcache) is the exact
arbiter of the relationship.
	Then there is the physical structure.  A kset contains a pointer
to a kobj_type that its children will be assigned.  This field is
useless in configfs, and more importantly, it could result in an
assignemnt that isn't related to the real object type, becuase of kset's
ability to have non-children members.  This adds more complexity to the
code, as you have to handle, prevent, or kludge around this case.
	kset contains a lock around its list of children.  configfs
doesn't need this because the subsystem lock is protecting the hierarchy
here.
	kset contains a hotplug ops pointer.  configfs has nothing to do
with hotplug.  So here are three pointers any configfs object has to
carry around for no reason other than sharing a structure.
	Conversely, a config_group contains a list of default subgroups.
They are not attributes, they are groups.  This is not the same as
config_item's default_attrs.  Here, kset would carry around an extra
pointer for every object.
	Given the stress everyone places on the memory usage of these
objects, adding useless pointers to both sides just to share the
structure seems a very bad idea.


-- 

"Well-timed silence hath more eloquence than speech."  
         - Martin Fraquhar Tupper

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
