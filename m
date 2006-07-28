Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWG1LPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWG1LPU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 07:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWG1LPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 07:15:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:47750 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751079AbWG1LPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 07:15:19 -0400
Message-ID: <44C9F1BF.7040003@garzik.org>
Date: Fri, 28 Jul 2006 07:15:11 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>
CC: Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com> <44C44622.9050504@namesys.com> <20060724085455.GD24299@merlin.emma.line.org> <44C4813E.2030907@namesys.com> <20060726131709.GB5270@ucw.cz> <44C8FE41.5040909@garzik.org> <44C975C4.7040803@namesys.com>
In-Reply-To: <44C975C4.7040803@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Jeff Garzik wrote:
>> Plugins --do not-- mean that you can just change the filesystem format
>> willy-nilly, with zero impact.

> Yes they do.....

Take off your marketing cap for a second :)

Plugins do not eliminate the going-back-to-older-kernels issue, as 
discussed at length in the recent ext4 thread.  Plugins complicate, 
rather than simplify, the issue of determining the compatibility between 
the kernel's metadata handling code and on-disk metadata.

Quite simply, there is always a compatibility impact when the filesystem 
format changes.  Enterprise customers will inevitably run several 
-generations- of your software, and they are very aware of migration 
costs when dealing with hardware+software life cycles in the 5-10 year 
range.  Power users and kernel developers bounce between kernel versions 
all the time.

This is the same problem I described in the ext4 thread, then summarized 
as "what ext3 am I talking to, today?"  You can easily rewrite that as 
"what reiser4 set of plugins am I talking to, today?"

Plugins == a ton of new software to be versioned and tracked.  Rather 
than just track "reiser4", you must now track the collection of plugin 
versions as well.  OBVIOUS increased complexity, and OBVIOUS additional 
admin learning curve for the serious IT shop.


Now prepare for the bombshell revelation...


THAT SAID, I do think fs {algorithm|metadata} plugins are a very 
interesting idea.

The plugin infrastructure is the logical result of trying to support 
multiple incompatible {inode, dir, file data, ...} object types in the 
same Linux filesystem.  Looking at in-tree Linux filesystems, one can 
see common design patterns in filesystems that hand-code support for 
multiple metadata format versions -- Al Viro's fs/sysv hacks being a 
simple and elegant example.

It is then simple to follow that train of logic:  why not make it easy 
to replace the directory algorithm [and associated metadata]?  or the 
file data space management algorithms?  or even the inode handling?  why 
not allow customers to replace a stock algorithm with an exotic, 
site-specific one?

In essence, reiser4 is not really a filesystem, but a second VFS, with a 
few stock metadata modules.

Furthermore, it completely changes the notion of what a Linux filesystem 
is.  Currently, each Linux filesystem is a tightly constrained set of 
metadata support.  reiser4 changes "tightly constrained" to "infinity". 
  While that freedom is certainly liberating, it also has obvious 
support costs due to new admin paradigms and customer configuration 
possibilities.

I don't want to be the distro support person trying to fix a crash in 
"reiser4", where the customer has secretly replaced the standard inode 
data structure with a plugin written by an intern, and secretly replaced 
the directory algorithm with a closed source plugin from PickYourVendor. 
  Trying picking through that mess with a filesystem debugger.

The reiser4 plugin system is far better implemented as the VFS level, as 
an optional library, like fs/libfs.c.  Such a library would contain 
factored-out infrastructure common to all filesystems that support 
multiple versions of the same object type, thereby shrinking the "real" 
filesystem code.  Then add a tiny bit of code that allows addition and 
removal of object types within each filesystem.

At that point, you have reduced a Linux filesystem to binding between a 
common name ("reiser4", "ext3") and a set of cooperating modules.

A very interesting train of thought.  But not one that belongs in the 
kernel in its current form.  If you hide a second VFS inside fs/reiser4, 
I GUARANTEE that you will get the locking and multi-threading wrong.  I 
guarantee your code will be under-reviewed, and NAK'd.  You lose all the 
testing that would be gained by others travelling your code paths, if 
the code was implemented generically in fs/libplugin.c rather than 
fs/reiser4/*

To move forward towards the goal of merging reiser4 into the kernel, you 
must recognize two distinctly SEPARATE ISSUES, and deal with them 
separately:

1) merging the latest whiz-bang collection of filesystem algorithms, 
under the filesystem name "reiser4"
2) adding the plugin concept to the Linux VFS

I don't know if #2 will pass consensus, but I certainly think we should 
at least experiment in that direction.  Your guys definitely have a lot 
of good ideas, and I'm glad Linux is seeing a fresh injection of new ideas.

I just don't think its a good idea to merge a filesystem called "foo" 
that can be completely redefined in the field.  Or least, not without 
thinking a lot more on the impact.  Its a VFS _and_ a filesystem, and 
should be evaluated as such.

	Jeff


