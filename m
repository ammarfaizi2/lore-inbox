Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132602AbRC1XcR>; Wed, 28 Mar 2001 18:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbRC1XcI>; Wed, 28 Mar 2001 18:32:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59809 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132602AbRC1Xbw>;
	Wed, 28 Mar 2001 18:31:52 -0500
Date: Wed, 28 Mar 2001 18:31:03 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Golds <jgolds@resilience.com>
cc: linux-kernel@vger.kernel.org
Subject: [horrors] Re: 2.4.2 Patch for missing "proc_get_inode" symbol in
 comx driver
In-Reply-To: <3AC26C07.61ED3332@resilience.com>
Message-ID: <Pine.GSO.4.21.0103281801300.26500-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Mar 2001, Jeff Golds wrote:

> Folks,
> 
> Sorry if this has been addressed before, but I didn't see this in the
> release notes for the latest ac drivers.
> 
> I tried to build the comx driver in the 2.4.2 kernel, but got unresolved
> external "proc_get_inode" when I attempted to load the module.  Looks
> like all that is missing is an EXPORT_SYMBOL entry in procfs_syms.c
> 
> Is there some reason why this function is not being exported or is it
> just an error?

Yes, there is. It's a helper function used by procfs directory lookups.
If you need it - why on the Earth use procfs in the first place?
	* You have your own directory operations (since procfs ones
	  apparently don't satisfy your needs)
	* You have your own file operations (since procfs has none)
In other words, what the hell does your situation have to procfs (aside
of being a filesystem)?

So either comx.c is actually OK with procfs directories (in that case
it doesn't need proc_get_inode) _or_ it shouldn't use procfs in the
first place.

<Looking>

Uh-oh... rmdir /proc/comx/foo succeeds (and no, foo is non-empty) and
$DEITY help you if it happens in the middle of write() into something in
/proc/comx/foo. 'Cause write() will merrily access kfree'd data.
Oh, and read() will do the same.

Apparently comx.c uses mkdir /proc/comx/foo to register foo and rmdir -
to unregister it. Would be nice, except that resulting directory is
_not_ empty. And remove_proc_entry() doesn't abort method-in-progress,
so said rmdir() leads to interesting effects. Aside of the general
bogosity level of rmdir succeeding on non-empty directory. And no,
unlink doesn't work on /proc/comx/foo/*.

Who the hell had invented that API and could I have some of the stuff they
were smoking? 

OK, is there anyone who would know what userland stuff uses that horror?
It really looks like a API in bad need of being changed...
								Al

