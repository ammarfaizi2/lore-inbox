Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSKCEO3>; Sat, 2 Nov 2002 23:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSKCEO3>; Sat, 2 Nov 2002 23:14:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10253 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261594AbSKCEO2>; Sat, 2 Nov 2002 23:14:28 -0500
Date: Sat, 2 Nov 2002 20:20:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Alexander Viro <viro@math.psu.edu>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <20021103035017.GD18884@waste.org>
Message-ID: <Pine.LNX.4.44.0211022004510.2503-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Nov 2002, Oliver Xymoron wrote:
> 
> Bindings are cool, but once you start talking about doing a lot of
> them, they're rather ungainly due to not actually being persisted on
> the filesystem, no? 

Well, they _are_ persistent in the filesystem, although in this case "the 
filesystem" is /etc/fstab.

It's not that different from the ".capabilities" file, except it's a lot 
more explicit, and from an implementation standpoint it's a lot easier.

However, I think there is a problem with Al's original approach: the bind 
can _not_ be just a mask that takes away capabilities from a suid 
application, since that would imply that the app has to be marked suid in 
the first place (and accessing it _without_ going through the bind will 
give it elevated privileges, which is what we're trying to avoid).

So the bind would have to _add_ capabilities, not take them away.

That's not really a problem, and the advantage of the filesystem bind
approach is that it is extremely explicit, and it is trivial for a
maintainer to at all times see all such "elevated" binaries: as Al points
out, the only thing you need to do is to just ask to be shown the mount
list with "mount" or with "cat /proc/mounts".

> A better approach is to just make a user-space capabilities-wrapper
> that's setuid, drops capabilities quickly and safely and calls the
> real app.

This is _not_ a good approach from a sysadmin standpoint. The sysadmin
does not explicitly know what the suid binary does internally, the
sysadmin just sees a number of suid binaries and has to trust them.

Yes, I realize that your example had "showcapwrap" etc sysadmin tools to 
work around this, and make the wrapping be transparent to the sysadmin. 
That certainly works, although it still depends on trusting that the 
wrapping cannot be confused some way. I guess that could be done fairly 
easily (although I think you'd want to make "mkcapwrap" actually _sign_ 
the wrapped binaries, to make sure that nobody can later try to inject a 
"bad" binary that _looks_ ok to "showcapwrap" and fools the admin to think 
everything is ok).

But from a security maintenance standpoint, wouldn't it be _nice_ to be 
able to

 - do a complete "find" over the whole system to show that there is not a 
   single suid binary anywhere.

 - trivially show each and every binary that is allowed elevated 
   permissions (and _which_ elevated permissions) by just doing a "mount".

 - and since the mount trees are really per-process, you can allow certain 
   process groups to have mounts that others don't have.

I think that as a anal-retentive security admin, I'd like such a system.

		Linus

