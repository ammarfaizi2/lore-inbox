Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271383AbTHMEdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 00:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271384AbTHMEdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 00:33:04 -0400
Received: from thunk.org ([140.239.227.29]:38285 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S271383AbTHMEdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 00:33:00 -0400
Date: Wed, 13 Aug 2003 00:32:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC] file extents for EXT3
Message-ID: <20030813043218.GC1244@think>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jeff Garzik <jgarzik@pobox.com>,
	Andreas Dilger <adilger@clusterfs.com>,
	Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <m3ptjcabey.fsf@bzzz.home.net> <3F3791C8.4090903@pobox.com> <20030811095518.T7752@schatzie.adilger.int> <3F37C2EB.5050503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F37C2EB.5050503@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 12:23:07PM -0400, Jeff Garzik wrote:
> 
> The net effect of slowly sliding features into ext2/3 via feature flags 
> creates the poor situation we have today:  your filesystem, and your 
> kernel, may or may not support the featureset you're looking for.  Sure, 
> slowly sliding features into existing filesystems can be made to work 
> with compatibility flags and careful thought.
> 
> However, I argue that there should be an ext2/3 filesystem feature 
> freeze.  And in this regard I am talking about _software_ versions, not 
> filesystem formats.  ext4 should be where the bulk of the new work goes. 
>  Please -- leave ext3 alone!  It's still being stabilized.

Any time you add features to a filesystem, there will potentially be
compatibility problems.  In the case of htree, a lot of careful
thought was put into how to add them without causing compatibility
problems, and we succeeded.

There are at least three separate issues here, that you're conflating
into one.

The first is code stability.  If we add new features, we risk possibly
destablizing the tree.  However, I'm sure any instability will be no
worse, and probably a lot better, than what people suffered when the
IDE drivers went to hell and back.  Kernel development survived, even
if it was a bit inconvenienced.  In addition, we are very careful
about not modifying the old code paths when we add a new feature, even
this risk can be minimized.  (And of course, we would only do this in
development kernels, and in initial test patches first!)

The second is issue is one of filesystem backwards compatibility
issues.  I disagree that it is a "poor" situation that a kernel may
not support a filesystem with new features.  That's just simply life!
Whether or not you use minor versions with feature flags, which might
or might not have compatibility, issues, or you do an entirely new
major number bump, the net result is still the same.  For example,
there's no hope at all of using a kernel that understands only
reiserfs3 to mount a reiserfs4 filesystem.

However, in some cases we can do better, by making certain changes
which preserve read-only compatibility, or which only requires a
forced update to a newer version of e2fsprogs.  In the case of file
extents, certainly we won't be able to do anything but an incompatible
version bump.  But this is true whether we do this via a filesystem
compatibility flag or by changing the major number in the superblock!

In any case, it will always be up to the user to decide whether or not
to enable any new feature.  

> Of course, the other alternative is to rename ext3 to "linuxfs", add a 
> "no journal at all" mode, and remove ext2.  But I prefer my "ext4" 
> solution :)

I would like to add "no journal" support to ext3, and then rename it
to ext2.  At some level, the only reason why we called it ext3 was
mainly for the code stability issue.  (Well, that and in case people
wanted a slightly smaller variant of ext2/3 --- but the people who
care about size issues will likely be in embedded applications, and in
those applications they will probably want to use something like jffs2
anyway.)

I really don't want to have to support n different variants of the
ext2/3/4/5/6/7 codebase.  That's just silly, and it's a code
maintenance headache.

						- Ted
