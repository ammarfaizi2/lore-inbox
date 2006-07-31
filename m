Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWGaU13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWGaU13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWGaU13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:27:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54209 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932520AbWGaU12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:27:28 -0400
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<20060730124139.45861b47.akpm@osdl.org>
	<orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<17613.16090.470524.736889@cse.unsw.edu.au>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Mon, 31 Jul 2006 17:27:11 -0300
In-Reply-To: <17613.16090.470524.736889@cse.unsw.edu.au> (Neil Brown's message of "Mon, 31 Jul 2006 09:20:58 +1000")
Message-ID: <ord5blcyg0.fsf@free.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 30, 2006, Neil Brown <neilb@suse.de> wrote:

>  1/
>     It just isn't "right".  We don't mount filesystems from partitions
>     just because they have type 'Linux'.  We don't enable swap on
>     partitions just because they have type 'Linux swap'.  So why do we
>     assemble md/raid from partitions that have type 'Linux raid
>     autodetect'? 

Similar reason to why vgscan finds and attempts to use any partitions
that have the appropriate type/signature (difference being that raid
auto-detect looks at the actual partition type, whereas vgscan looks
at the actual data, just like mdadm, IIRC): when you have to bootstrap
from an initrd, you don't want to be forced to have the correct data
in the initrd image, since then any reconfiguration requires the info
to be introduced in the initrd image before the machine goes down.
Sometimes, especially in case of disk failures, you just can't do
that.

>  2/ 
>     It can cause problems when moving devices.

It can, indeed, and it has caused such problems to me before, but
they're the exception, not the rule, and one should optimize for the
rule, not the exception.

>  3/ 
>     The information redundancy can cause a problem when it gets out of
>     sync.  i.e. you add a partition to a raid array without setting
>     the partition type to 'fd'.  This works, but on the next reboot
>     the partition doesn't get added back into the array and you have
>     to manually add it yourself.
>     This too is not purely theory - it has been reported slightly more
>     often than '2'.

This has happened to me as well, and I remember it was extremely
confusing when it first happened :-)  But that's an argument to change
the behavior so as to look for the superblock instead of trusting the
partition type, not an argument to remove the auto-detection feature.

And then, the reliance on partition type has been useful at times as
well, when I explicitly did *not* want a certain raid device or raid
member to be brought up on boot.

> So my preferred solution to the problem is to tell people not to use
> autodetect.  Quite possibly this should be documented in the code, and
> maybe even have a KERN_INFO message if more than 64 devices are
> autodetected. 

I wouldn't have a problem with that, since then distros would probably
switch to a more recommended mechanism that works just as well, i.e.,
ideally without requiring initrd-regeneration after reconfigurations
such as adding one more raid device to the logical volume group
containing the root filesystem.

> If we were to 'fix' this problem, I think the cleanest approach (which
> I haven't actually coded, so it might not work...) would be to define
> a new flag to go in hd_struct->policy to say if the partition type
> suggested auto-detect, and get partitions/check.c to set this.
> Then have md iterate all partitions looking for this flag.

AFAICT we'd still need a list or an array, since we add stuff back to
the list in various situations.

> So:  Do you *really* need to *fix* this, or can you just use 'mdadm'
> to assemble you arrays instead?

I'm not sure.  I'd expect not to need it, but the limited feature
currently in place, that initrd uses to bring up the raid1 devices
containing the physical volumes that form the volume group where the
logical volume with my root filesystem is also brings up various raid6
physical volumes that form an unrelated volume group, and it does so
in such a way that the last of them, containing the 128th fd-type
partition in the box, ends up being left out, so the raid device it's
a member of is brought up either degraded or missing the spare member,
none of which are good.

I don't know that I can easily get initrd to replace nash's
raidautorun for mdadm unless mdadm has a mode to bring up any arrays
it can find, as opposed to bringing up a specific array out of a given
list of members or scanning for members.  Either way, this won't fix
the problem 2) that you mentioned, but requiring initrd-regeneration
after extending the volume group containing the root device is another
problem that the current modes of operation of mdadm AFAIK won't
contemplate, so switching to it will trade one problem for another,
and the latter is IMHO more common than the former.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Secretary for FSF Latin America        http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
