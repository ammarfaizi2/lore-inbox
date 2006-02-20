Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWBTLRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWBTLRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWBTLRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:17:31 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:9880 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932496AbWBTLRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:17:30 -0500
Date: Mon, 20 Feb 2006 13:17:28 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, axboe@suse.de,
       karim@opersys.com, compudj@krystal.dyndns.org, akpm@osdl.org
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060220111728.GA8673@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Tom Zanussi <zanussi@us.ibm.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, axboe@suse.de, karim@opersys.com,
	compudj@krystal.dyndns.org, akpm@osdl.org
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17401.21427.568297.830492@tut.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 11:29:23PM -0600, Tom Zanussi wrote:
> But just to make sure I'm not missing anything in the patches, please
> let me know if any of the following is incorrect.  What they do is
> remove the fs part of relayfs and move the remaining code into a
> single file, while leaving everthing else basically intact i.e. the
> relayfs kernel API remains the same and existing clients would only
> need to make relatively minor changes:
> 
> - find a new home for their relay files i.e. sysfs, debufs or procfs.
> 
> - replace any relayfs-specific code with their counterparts in the new
>   filesystem i.e. directory creation/removal, non-relay ('control')
>   file creation/removal.
> 
> - change userspace apps to look for the relay files in the new
>   filesystem instead of relayfs e.g. change /relay/* to /sys/*
>   in the relay file pathnames.
> 
Yes, that's correct.

With the patch I posted in reply to Dave it's also possible to keep
the relayfs mount point that just wraps in to the new CONFIG_RELAY
abstraction. Going this route (in place of the last 2 patches of my
patch set) might make the migration a little less painful, but as there
are no in-tree users for the kernel side, it's debatable whether keeping
it around is worthwhile at all.

The changes needed both in the kernel and user space client side are
quite trivial anyways. Likewise it's also possible for the sysfs
attribute patch to be applied first with the rest outstanding to let
people start switching to the sysfs interface.

Either way, as there seems to be enough interest in this, it would be
nice to get it in to -mm for testing at least, people can follow
blktrace's example on working with CONFIG_RELAY.

The first 3 patches in my series can be used in addition to the
follow-patch to Dave for introducing the CONFIG_RELAY interface while
retaining legacy relayfs behaviour, so this might be the best way to go
for -mm testing. The later patches can be rolled in once the few users
have switched, if it's deemed that they're actually relevant as users.

I'm fine with either approach, as long as I can use CONFIG_RELAY without
having another mount point to deal with.

> Although I personally don't have any problems with doing this, I've
> added some of the authors of current relayfs applications to the cc:
> list in case they might have any objections to it.  The major relayfs
> applications I'm aware of are:
> 
> - blktrace, currently in the -mm tree.  This could probably move its
>   relayfs files to sysfs using your new interface.
> 
Jens pointed out that this should be quite easy, so that shouldn't be an
issue.

> - LTT, not sure where LTT would want to move.
> 
LTT is already quite invasive on the kernel side. If they're interested
in continually using relayfs rather than switching to something else,
then they can use the patch I posted to Dave for stripping relayfs down
to work with CONFIG_RELAY. This leaves relayfs implemented in 312 lines,
which seems painless enough for the people that care about the API being
consistent.

> - systemtap.  sytemtap uses relayfs as one possible transport.  The
>   other is a proc-based transport, so logically it would make sense
>   for systemtap to move its relay files to /proc.

Again, this is out-of-tree, and the kernel side changes to accomodate
some other file system are trivial.

If that's all the users, then fixing these up would seem to be the better
alternative to leaving in a wrapper file system that people might want to
use for future interfaces.
