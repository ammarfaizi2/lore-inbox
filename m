Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWHACgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWHACgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWHACgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:36:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31956 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030393AbWHACgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:36:14 -0400
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<20060730124139.45861b47.akpm@osdl.org>
	<orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<17613.16090.470524.736889@cse.unsw.edu.au>
	<ord5blcyg0.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<17614.44057.322945.156592@cse.unsw.edu.au>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Mon, 31 Jul 2006 23:35:56 -0300
In-Reply-To: <17614.44057.322945.156592@cse.unsw.edu.au> (Neil Brown's message of "Tue, 1 Aug 2006 11:19:21 +1000")
Message-ID: <orpsflrxmb.fsf@free.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 31, 2006, Neil Brown <neilb@suse.de> wrote:

> The initrd need to 'know' how to find the root filesystem, whether by
> devnum or uuid or whatever.

Yeah, the tricky bit is the `whatever' alternative, when / is a
logical volume, and you need to bring up all of the physical volumes
in order for vgscan to bring up the volume group in a usable way.

> In exactly the same way it needs to know how to find the components
> for the root md array - uuid is the best.  There is no need to
> reconfigure this in the case of a disk failure.

When you add physical volumes to the volume group, you'd have to
reconfigure initrd if it wasn't for mdadm's ability to scan all
partitions.

> Current mdadm will assemble arrays for you given only a hostname.  You
> still need to get the hostname into the initrd, but that is no
> different from a root device number.

Yep, this should work, at least until someone changes the hostname,
creates a new array with the new option and then gets puzzled because
only that array isn't brought up.

Or, worse, does all of the above and then rebuilds initrd ``just in
case'', and then ends up unable to reboot because the root device
won't be brought up.  Oops :-)

>> 
>> >  2/ 
>> >     It can cause problems when moving devices.

>> It can, indeed, and it has caused such problems to me before, but
>> they're the exception, not the rule, and one should optimize for the
>> rule, not the exception.

> We aren't talking about optimisation.  We are talking about whether it
> actually works or not.

Yes, I'm talking about getting it to work most often in the most
common case.  Obviously we can't get it to work in every possible
case, since there are the various corner cases involving moving disks
around, renaming hosts and creating arrays, some of which must
necessarily fail in order for others to work.  It's finding the right
balance between them that is tricky, and some people will always be
unhappy because their particularly rare case failed, even without
realizing that this was in order to enable a more common case they
happened to rely on to work.

> A system that stops booting just because you plugged a couple of
> extra drives in is a badly configured system.

I tend to agree, although I used to exercise a case that wouldn't be
covered by this new policy: I used to move a pair of raid 1 external
disks between two hosts, and have them configured to be optionally
mounted on boot, depending on whether the raid devices were in place
or not.  With hostname identification, this wouldn't quite work :-)

> Well, at boot it should only bring up the raid array containing the
> root filesystem.

If all you have is in a single LVM volume group, then that must be
everything :-/

> Everything else is best done by /etc/init.d scripts.  And you can
> stop those from running by booting with -s (or whatever it is to get
> single-user).

Booting into single user mode actually attempts to mount everything
that is local, after bringing up raid devices et al, so that would be
too late.  But there's always init=/bin/bash :-)

> Get mdadm 2.5.2 (or 2.5.3 if I get that out soon enough) and try

>   mdadm --assemble --scan --homehost='<system>' --auto-update-homehost \
>   --auto=yes --run

> in your initrd, having set the hostname correctly first.  It might do
> exactly what you want.

Awesome, thanks, I'd missed that in the docs.  It might make sense to
spell it out as an example, instead of requiring someone to figure out
all of the bits and pieces from the extensive documentation.  Not
complaining about the extent of the documentation, BTW :-)

I'll give it a try some time tomorrow, since I won't turn on that
noisy box today any more; my daughter is already asleep :-)

Anyhow, unless there's a good reason to keep the code the way it is,
wasting valuable bytes of memory in the fixed-size array, I guess it
would make more sense to just merge the patch in, no? :-)

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Secretary for FSF Latin America        http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
