Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbTD1VIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 17:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbTD1VIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 17:08:41 -0400
Received: from mail.casabyte.com ([209.63.254.226]:48644 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S261269AbTD1VIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 17:08:39 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Per-Mount UID/GID Rewrite Vector
Date: Mon, 28 Apr 2003 14:20:56 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGAEEACJAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

[Disclaimer: This is a proto-thought and question, posed without sufficient
relevant knowledge to advocate the position.  E.g. this is a "does this
sound feasible" mixed with a "does anybody who knows what they are doing
think this would be interesting" grade inquiry.]

So I just bought a Zaurus (PDA sized embedded Linux box) and was playing
with the CompactFlash inserts, and had a thought...

Whenever you stick a CF device into this box, it automatically mounts it and
makes its contents readily available.  It would be really easy to put a
setuid-root program onto such a flash and unlock anybodies PDA.  Similarly
there has always been such a potential problem with CDs etc.

The currently existing means for controlling mount point behavior is via the
mount options NOEXEC NOSUID and NODEV.  Also some file system drivers let
you set the user and group id of all of the files (FAT, AFFS, ADFS etc)
because they don't have user IDs at all.  NFS also lets you do a "root
squash" to remap uid 0 to some other value.  Over time this per-driver
technique is going to prove insufficient, especially as more hot-plugable
technology moves into the common sector.

In particular, it would be good if an application that lived totally within
a plugable device (on on a CD etc, though that isn't as interesting a case)
could be consistently operate without ever colliding with the contents of
the existing machine.  To do this the existing "relative permissions" would
have to be preserved while still giving the host the chance to protect
itself from the contents of the motile software.

It seems to me that it would be good, interesting, and extremely valuable,
to build UID and GID redirection into the vnode system.  The "obvious" place
to do this is in the (generic) super-block data structure so that when
you --bind or --move items the redirection wouldn't get lost/dropped.

Essentially, the super block would contain a normally-null pointer.  If the
pointer isn't null, it points to a redirection table.  The table would have
a set of entries (stored-id, system-id, is_gid) representing the
relationship between the uids and gids on the disk to the active system uids
and gids.  In the special case of zero (0) mapped to anything else, the
system-id would be "root for this device" in terms of being able to set
ownerships and permissions and such.

The system root would write through normally, as would any not-remapped ID.

So lets say you had a setuid-root application installed on your removable
module, and the system was set up to map (0, 5000, false) (0, 5000, true)
[that is, both root user and group mapped to the number 5000].  When the app
was started it would run as 5000 but it would still be able to do the
root-like things to the storage "it owned" but it would be powerless to
affect the rest of system as a whole.

This would be implemented in the generic system as, for the most part, an
after-vnode-allocation table look-up and tweak of the new vnode.  (e.g. you
could just re-write the uid/gid fields of the opened vnode).  It would, if
the root ability was in force, also be an "if (retval == EPERM &&
is_virtual_root(current_uid))" type of exception retry [or something] in the
virtual file system.

Eventually there probably would evolve a helper callback of the sort where
if the remap table is allocated but a file of an un-mapped uid/gid is
encountered the system could look for an unused uid number to use in the
mapping table.  Who knows.

Alternately there could just be a delta-value applied (e.g. +5000 for this
mount point, +6000 for that one and so on).

None of this even intimates that such relative-root accounts should be able
to affect the rest of the system (like getting sockets < 1024 etc).

Basically, I am talking about being able to sand-box removable media in a
way that would let such media provide interesting and feature rich content
without letting it even accidentally (in a well designed user space) let the
media identities overlap with the core system identities.

I really don't know how this "should" work nor how well it would fit, but
allowing for this unilaterally at the kernel level instead of writing it
into the individual drivers seems like a win.

Opinions?  Objections?  Reasons I'm an idiot?

Rob.

