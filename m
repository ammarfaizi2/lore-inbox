Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTFKCqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 22:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264042AbTFKCqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 22:46:31 -0400
Received: from pat.uio.no ([129.240.130.16]:26330 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264030AbTFKCqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 22:46:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16102.39728.70064.966844@charged.uio.no>
Date: Wed, 11 Jun 2003 05:00:00 +0200
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Frank Cusack <fcusack@fcusack.com>, torvalds@transmeta.com,
       marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
In-Reply-To: <20030611022754.GC6754@parcelfarce.linux.theplanet.co.uk>
References: <20030603165438.A24791@google.com>
	<shswug2sz5x.fsf@charged.uio.no>
	<20030604142047.C24603@google.com>
	<16094.25720.895263.4398@charged.uio.no>
	<20030609065141.A9781@google.com>
	<20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk>
	<16102.36078.894833.262461@charged.uio.no>
	<20030611022754.GC6754@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == viro  <viro@parcelfarce.linux.theplanet.co.uk> writes:

     > Aliasing could be dealt with.  They would have the same inode,
     > so it's easy to detect.

I suppose we could... Is the procedure that nfs_lookup() should first
rehash the dropped dentry, then return it instead of NULL?

     > The real problem is different: what happens if I take
     > silly-renamed file and rename it away?  You suddenly get ->dir
     > and ->dentry if your nfs_unlinkdata having nothing to do with
     > each other.

->dir is the important one here, as it provides the filehandle. We
only use ->dentry in order to give us a name/string for the
NFSPROC_REMOVE call.

     > AFAICS, dcache will not get into inconsistent state, but it
     > will have very little to do with state of server...

But that's the best we can do in any scenario. NFS does not ever give
you a guarantee that someone won't screw things up on the server, nor
does it give you any failsafe mechanism for detecting it.
That's why operation atomicity is such an issue with the current
kernel, and is why I'm so eager to push the intent patches into 2.6.

Sure sillyrename fails miserably in the atomicity department. There's
bugger all we can do about that: if you are suggesting we should rely
on some sort of revalidation before we unlink, then that's just as
race prone as what we have now.

Cheers,
  Trond
