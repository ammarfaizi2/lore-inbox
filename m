Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTFVHPN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 03:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbTFVHPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 03:15:13 -0400
Received: from pat.uio.no ([129.240.130.16]:42128 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262288AbTFVHPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 03:15:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16117.23231.499556.86004@charged.uio.no>
Date: Sun, 22 Jun 2003 09:29:03 +0200
To: Frank Cusack <fcusack@fcusack.com>
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() again, and trivial nfs_fhget
In-Reply-To: <20030621184623.A29657@google.com>
References: <20030617051408.A17974@google.com>
	<shs1xxsr1gx.fsf@charged.uio.no>
	<20030617165507.A19126@google.com>
	<16112.63615.561414.52943@charged.uio.no>
	<20030621184623.A29657@google.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

     > It's to prevent RENAME of silly-renamed files.  Doing so in VFS
     > is a one-liner, and I agree that the VFS should be as clean as
     > possible, but let's face it, the VFS *must* have specific fs
     > knowledge.  eg, the ALWAYS_REVAL (something like that) patch
     > you recently submitted is just to treat NFS differently than
     > other fs's.  Just because the flag doesn't have "NFS" in it
     > doesn't make it generic.  (And so I repeat my earlier
     > suggestion that might make the change more palatable: rename
     > the NFSFS_RENAMED flag to DONT_UNLINK.)

On the contrary: The VFS should *avoid* specific fs knowledge
whereever possible.

In this case:

  - we *can* do this test in nfs_rename() itself without needing any
    extra VFS support.
  - No other filesystems have expressed a need for such a flag, so
    we're hardly covering a common need.

Those are 2 good reasons for doing the modification in the NFS code.

And no - NFSFS_RENAMED, and DONT_UNLINK are *not* the same concept.
Renaming sillyrenamed files would be quite acceptable as long as you
don't allow *cross-directory* renames. All other cases are fixable...

     > I hate to keep following up myself, but I forgot one point I
     > had in mind: other code in may_delete() is already fs-specific.
     >
     > IS_APPEND
     > IS_IMMUTABLE
     > check_sticky
     >
     > These things aren't generic, they require specific support from
     > the fs.

For starters, check_sticky has no business being in may_delete(), as
it breaks NFS (i.e. it should really be part of vfs_permission()).
All these comparisons of our local uid/gids or capabilities with
remote object uid/gids are broken.

That said, there is a huge leap between the 2 assertions that "some
special cases appear in the VFS." to "all special case must be done in
the VFS".

Cheers,
  Trond
