Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWG3XV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWG3XV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWG3XV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:21:28 -0400
Received: from ns2.suse.de ([195.135.220.15]:3976 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964788AbWG3XV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:21:27 -0400
From: Neil Brown <neilb@suse.de>
To: Alexandre Oliva <aoliva@redhat.com>
Date: Mon, 31 Jul 2006 09:20:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17613.16090.470524.736889@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
In-Reply-To: message from Alexandre Oliva on Sunday July 30
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<20060730124139.45861b47.akpm@osdl.org>
	<orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[linux-raid added to cc.
 Background: patch was submitted to remove the current hard limit
 of 127 partitions that can be auto-detected - limit set by 
 'detected_devices array in md.c.
]

My first inclination is not to fix this problem.

I consider md auto-detect to be a legacy feature.
I don't use it and I recommend that other people don't use it.
However I cannot justify removing it, so it stays there.
Having this limitation could be seen as a good motivation for some
more users to stop using it.

Why not use auto-detect?
I have three issues with it.

 1/
    It just isn't "right".  We don't mount filesystems from partitions
    just because they have type 'Linux'.  We don't enable swap on
    partitions just because they have type 'Linux swap'.  So why do we
    assemble md/raid from partitions that have type 'Linux raid
    autodetect'? 

 2/ 
    It can cause problems when moving devices.  If you have two
    machines, both with an 'md0' array and you move the drives from one
    on to the other - say because the first lost a powersupply - and
    then reboot the machine that received the drives, which array gets
    assembled as 'md0' ?? You might be lucky, you might not. This
    isn't purely theoretical - there have been pleas for help on
    linux-raid resulting from exactly this - though they have been
    few. 

 3/ 
    The information redundancy can cause a problem when it gets out of
    sync.  i.e. you add a partition to a raid array without setting
    the partition type to 'fd'.  This works, but on the next reboot
    the partition doesn't get added back into the array and you have
    to manually add it yourself.
    This too is not purely theory - it has been reported slightly more
    often than '2'.

So my preferred solution to the problem is to tell people not to use
autodetect.  Quite possibly this should be documented in the code, and
maybe even have a KERN_INFO message if more than 64 devices are
autodetected. 


Now one doesn't always go with one's first inclination so I should
discuss the approaches to fixing the problem, should a fix really be
the right thing to do.

The idea of having a generic notifier is, I think, missing the point -
so I'd better explain what the point is.....

The kernel already has the hotplug mechanism for alerting user-space
about new partitions, and I'm sure kernel clients could hook into this
some how.  But even if they could, md wouldn't want to.
md doesn't really want to know about new partitions.  It simply wants a
list of all partitions which are of type 'autodetect'.   Getting a
list of all partitions is quite easy (/proc/partitions does it, so it
cannot be hard).  But 'struct hd_struct' doesn't record what the
partition type is at all.  It spare bits, so it could. (->policy is
currently a 'ro' flag.  A little work would allow multiple flags there).

The point of the current detected_devices array is precisely to find
partitions which have this flag set.

If we were to 'fix' this problem, I think the cleanest approach (which
I haven't actually coded, so it might not work...) would be to define
a new flag to go in hd_struct->policy to say if the partition type
suggested auto-detect, and get partitions/check.c to set this.
Then have md iterate all partitions looking for this flag.

That could be considered to be intrusive to bits of the kernel which
don't need to be intruded in to, and could run the risk of someone
wanting to expose that flag to user-space (with in /proc/partitions or
/sys) and I would be against that.  But otherwise it would be a
fairly clean approach.

The minimal (non-empty) approach of replacing the array by a linked
list as the original patch did would also be quite reasonable.  Maybe
not as clean as a flag in hd_struct, but maybe we don't need this
code to be particularly clean(?).

So:  Do you *really* need to *fix* this, or can you just use 'mdadm'
to assemble you arrays instead?

NeilBrown
