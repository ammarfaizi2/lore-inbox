Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVIDEy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVIDEy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 00:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVIDEy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 00:54:57 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:50876 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S1751061AbVIDEy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 00:54:57 -0400
Date: Sat, 3 Sep 2005 21:54:45 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>, phillips@istop.com,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Message-ID: <20050904045444.GS8684@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, phillips@istop.com,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <200508310854.40482.phillips@istop.com> <20050830231307.GE22068@insight.us.oracle.com> <20050830162846.5f6d0a53.akpm@osdl.org> <20050904035341.GO8684@ca-server1.us.oracle.com> <20050904041224.GP8684@ca-server1.us.oracle.com> <20050904044136.GR8684@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904044136.GR8684@ca-server1.us.oracle.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 09:41:36PM -0700, Joel Becker wrote:
> On Sat, Sep 03, 2005 at 09:12:24PM -0700, Joel Becker wrote:
> > On Tue, Aug 30, 2005 at 04:28:46PM -0700, Andrew Morton wrote:
> > > Sure, but all that copying-and-pasting really sucks.  I'm sure there's some
> > > way of providing the slightly different semantics from the same codebase?
> 

	So, what conclusions can we draw from looking at this again?
	First, merging the kobject/kset structures with the
config_item/config_group structures has one benefit: they have the same
name.  However, that's also the first problem.  As it currently stands,
you know from the name what you are working with.  If they have the same
name, you don't know if you are working with an object in sysfs or
configfs.  We call a pid "pid_t" rather than "unsigned int" for the same
reason, clarity of usage.
	Merging them has a lot of other problems.  Far from removing
code bloat (a configfs object and a sysfs object need different
initialization, etc, so there would be two paths anyway), it adds
significant memory bloat, as configfs objects and sysfs objects are
carrying around members for the other filesystem.  Finally, there are
surprises in store if you try to use some of the API that isn't
appropriate.  With a different name and type, you just _can't_ do that.
	We could perhaps share the attribute structure.  This has the
same name confusion problem above, but that's about it, assuming that
sysfs never wants to do anything smarter with them.  I'm hoping the
sysfs folks comment on this.
	Sharing the attribute file code is much harder.  They operate on
different types, and those types are laid out differently.  I think we'd
have to make the API far more invasive.  Instead of black-boxing the API
and having only show/store to implement, we'd have to provide some sort
of translation from the native structure to a shared type.  Basically,
repeating what the VFS has already done for us.
	Finally, assuming that the sysfs_dirent/configfs_dirent
arrangement is pretty fleshed out, I think that perhaps this backing
store could be joined.  Again, no more magic could be added, and it
would have to handle the sysfs and configfs types in concurrence, but I
think it could be done.  Again, sysfs folks, please comment.

Joel

-- 

"Hell is oneself, hell is alone, the other figures in it, merely projections."
        - T. S. Eliot

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
