Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVKNTSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVKNTSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVKNTSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:18:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:60049 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751245AbVKNTSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:18:22 -0500
Subject: Re: [PATCH 17/18] unbindable mounts
From: Ram Pai <linuxram@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <p73d5l545h9.fsf@verdi.suse.de>
References: <E1EZInj-0001F9-CG@ZenIV.linux.org.uk>
	 <p73d5l545h9.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1131995897.4269.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 14 Nov 2005 11:18:17 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-12 at 19:00, Andi Kleen wrote:
> Al Viro <viro@ftp.linux.org.uk> writes:
> 
> > From: Ram Pai <linuxram@us.ibm.com>
> > Date: 1131402080 -0500
> > 
> > A unbindable mount does not forward or receive propagation. Also unbindable
> > mount disallows bind mounts. The semantics is as follows.
> > 
> > Bind semantics:
> >   Its invalid to bind mount a unbindable mount.
> > Move semantics:
> >   Its invalid to move a unbindable mount under shared mount.
> > Clone-namespace semantics:
> >   If a mount is unbindable in the parent namespace, the corresponding
> >   cloned mount in the child namespace becomes unbindable too.  Note:
> >   there is subtle difference, unbindable mounts cannot be bind mounted
> >   but can be cloned during clone-namespace.
> 
> What is it good for?
> Normally I would have expected that to be part of the description.

Its part of the documentation patch in the FAQ section. 

Lets say we have the following mount tree.
                  root
                /   \  \
              mnt  usr  home

If I want to replicate this mount tree under /mnt a couple of times as
follows
                             root
                   /               |   \
                  mnt            usr   home
         /         |         \
         r1        r2            r3
       / | \      / | \        /   |   \
    mnt usr home mnt usr home  mnt  usr home

than the series of commands to execute are 
  mount --rbind  /  /mnt/r1


  mount --rbind  /  /mnt/r2
  umount  /mnt/r2/mnt/r1/mnt
  umount /mnt/r2/mnt/r1/usr
  umount /mnt/r2/mnt/r1/home
 (or maybe just umount -l /mnt/r2/mnt/r1)


  mount --rbind  /  /mnt/r3
  umount -l /mnt/r3/mnt/r1
  umount -l /mnt/r3/mnt/r2

note: as we have more of these mounts replicating the system tree to
a location within the system tree the number of umounts increase
linearly.

The situation becomes exponential in case the root mount and submounts
within it are shared. (the documentation patch explains that case).

Unbindable mounts help to keep this in check.
All you have to do is mark /mnt as unbindable and after which its just
a matter of one --rbind.  All the unnecessary submounts get pruned
automatically.

This feature comes in handy if each user wants to mimic the entire
system tree and chroot to its replicate. Its kind of giving virtual
mount environment to the user.

RP





> 
> 
> -Andi (slightly worried about all these different mount variants. Hopefully
> you guys themselves can still keep them all in your heads)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

