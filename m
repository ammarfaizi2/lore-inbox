Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVEXRjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVEXRjB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVEXRiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:38:51 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:60936 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261884AbVEXRiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:38:02 -0400
To: raven@themaw.net
CC: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.62.0505242215330.8219@donald.themaw.net>
	(raven@themaw.net)
Subject: Re: [VFS-RFC] autofs4 and bind, rbind and move mount requests
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
 <E1DaERw-0002cC-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.62.0505232339250.3469@donald.themaw.net>
 <E1DaG04-0002hk-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0505240846410.26293@wombat.indigo.net.au>
 <E1DaSRW-0003V9-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.62.0505242215330.8219@donald.themaw.net>
Message-Id: <E1Dad0Y-0004RN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 May 2005 19:15:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does it work if somebody renames a directory in the path leading to
> > the autofs mountpoint?  The result is very similar to move mount.
> 
> Don't know but I doubt it.
> I don't think it should because autofs needs be true to the mount maps 
> that define what automounts are to be provided.

OK.  Then you can just say that move mount isn't supported.  

You can't stop a stupid sysadmin from messing up the system, so you
shouldn't really try.

Of course even in this case there shouldn't be anything nasty (like
Oops or panic), but I think it's OK if it simply won't work anymore.

> > You could solve both, by having the automoutnter daemon chdir to the
> > autofs root, and then it would just not care about any namespace
> > changes outside it's own filesystem.
> 
> Perhaps but I think it will not be that simple.
> It's worth thinking about.
> 
> I'm working on providing full direct mount support atm (I have limited 
> functionality now).

Can you please explain what "direct mount" is?  I'm not really
familiar with automount terminology.

> I will have many autofs mounts handled by a single daemon. So that
> makes it a bit harder. This will be done using a file handle to
> identify (for map entry lookup) each direct mount point in the map,
> but still I suspect the corresponding vfsmount will end up being
> wrong. I'm also thinking of doing this for indirect mounts during
> this rework. A similar approach I think, to what you describe below.
> 
> I must point out that my current focus is to push the current autofs 
> implementation as far as it can go within its original design. Which is 
> probably not much further than implementing functionaly workable direct 
> mounts. This means that multiple namespace support is not under 
> consideration. Indeed the current design will not easily lend itself to 
> it.
> 
> Mike Waychison was working on a new version to address this and other 
> limitations of the current design but development of this seems to have 
> stopped.

I've just seen those patches (Mike pointed them out to me in another
thread).

> I saw that code when I was looking at this problem.
> It looks quite interesting.
> Again, I'll have to think about it.
> Changes of that magnitude won't happen quickly.
> It's already been a hard slog to get autofs to a reasonably stable state.
> 
> When I was looking at it I didn't see anything that would help with some 
> of the issues such as:
> 
> 1) lazy mount/umount/expire of a tree of mount points (needs to be handled 
> atomically).
> 2) Didn't see anything relating to expire timeouts just busyness.
> 3) I don't think that item (1) in the file you refer to above is correct. 
> The nameidata struct passed to follow_link assumes that a mount point has 
> not been followed prior to the call. So this approach can't work for 
> direct mounts without some more work in the VFS. Maybe it can be done 
> another way but I'm not aware of it.
> 5) It seems that exporting the vfsmount_lock so it can be used in a 
> module is not good pratice (at least that was the case the last time I 
> needed it).
> 
> Please don't get me wrong. I did notice this code (but not the doco) and 
> it does look really useful to me but it means a significant redesign of 
> autofs. I need what's currently in place to work as it's likely to be 
> around for quite a while yet.

I'm not too familiar with that code either, and I'm not trying to
convince you either way :)

I think it does address the atomicity issue, but requires special
do_add_mount() call (which places the vfsmount on the expiry list), so
it probably needs some work to export that functionality to userspace
mounts.

> What I really need is agreement that adding a super_operations method such 
> as "mount" is acceptable so that I can veto bind and move mounts with the 
> current version. Perhaps I can do it another way ?????

If you just want to disable bind (so that it doesn't cause trouble),
the simplest way seems to be to remember the original vfsmount, and
just ignore any lookups in other vfsmounts.  You can do this, since
the vfsmount is passed in the nameidata parameter of dir->lookup().

Then bind will succeed, but the autofs will simply not do anything in
the copied mount.  I think that would be much cleaner than trying to
veto a bind request.

Miklos
