Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268416AbUHLAcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268416AbUHLAcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268485AbUHLAaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:30:00 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:24782 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268416AbUHLAA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:00:59 -0400
Date: Thu, 12 Aug 2004 00:59:29 +0100
From: Dave Jones <davej@redhat.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com
Subject: Re: [PATCH 0/3] Transition /proc/cpuinfo -> sysfs
Message-ID: <20040811235929.GB32468@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Deepak Saxena <dsaxena@plexity.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com
References: <20040811224117.GA6450@plexity.net> <20040811231314.GA32106@redhat.com> <20040811234245.GA7721@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811234245.GA7721@plexity.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 04:42:45PM -0700, Deepak Saxena wrote:

 > > For x86 at least, this can be entirely decoded in userspace using
 > > the /dev/cpu/x/cpuid interface. See x86info for example of this.
 > > 
 > >  > - Instead of dumping the "flags" field, should we just dump cpu
 > >  >   registers as hex strings and let the user decode (as the comment
 > >  >   for the x86_cap_flags implies.
 > > 
 > > ditto.
 > 
 > OK, just saw that code now and my reponse is to remove that 
 > interface in the long-term and move cpuid into sysfs (and not 
 > export all the cache info separately).

but why? it's totally pointless when the same info can be obtained
from userspace without the bloat.

 > In theory we don't even 
 > need the xxx_bug fields as those can be determined from looking
 > at CPU binary data.

not all of them you can't iirc.

 > > As these require arch specific parsers anyway, I don't think it makes
 > > too much sense making a kernel abstraction trying to make them all
 > > look 'the same', and if it can be done in userspace, why bother ?
 > 
 > If it is all done in userspace, then just having the raw binary
 > data available via sysfs w/o kernel parsing is probably best.

the raw binary is already available. in /dev/cpu/x/cpuid
I repeat, duplicating this in sysfs is utterly pointless other than
to bloat the kernels runtime memory usage.

 > > The only other concern I have is the further expansion of sysfs with
 > > no particular gain over what we currently have. The sysfs variant
 > > *will* use more unreclaimable RAM than the proc version.
 > 
 > Agreed, but that hasn't kept other data such as PCI and partition 
 > information from moving into sysfs.

So because one subsystem decides to do it, every other should follow
lemming-like ?
 
 > > /proc/cpuinfo has done well enough for us for quite a number of years
 > > now, what makes it so urgent to kill it now that sysfs is the
 > > virtual-fs-de-jour ?
 > 
 > Consitency in userspace interface.

sorry, but I think that argument is total crap.  Any userspace tool needing
this info will still need to support the /dev/cpu/ interfaces if they want to
also run on 2.2 / 2.4 kernels.  Likewise, anything using /proc/cpuinfo.
Ripping this out does nothing useful that I see other than cause headache
for userspace by having yet another interface to support.

 > My understanding is that goal is to 
 > make /proc slowly return to it's original purpose (process-information) 
 > and move other data out into sysfs.  

I don't think thats a realistic goal. It'll take years just to migrate the
in-kernel stuff, and there's god alone knows how much out-of-tree code doing
the same, plus the add-ons from various vendor kernels etc so I doubt it'll
ever be the process-only utopia you envision.

Changing userspace interfaces on a whim just causes pain for those
that use them, especially when there is nothing wrong with the existing
interfaces.

		Dave

