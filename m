Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTFKBp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 21:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263964AbTFKBp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 21:45:58 -0400
Received: from pat.uio.no ([129.240.130.16]:38339 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263952AbTFKBpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 21:45:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16102.36078.894833.262461@charged.uio.no>
Date: Wed, 11 Jun 2003 03:59:10 +0200
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Frank Cusack <fcusack@fcusack.com>, torvalds@transmeta.com,
       marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
In-Reply-To: <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk>
References: <20030603165438.A24791@google.com>
	<shswug2sz5x.fsf@charged.uio.no>
	<20030604142047.C24603@google.com>
	<16094.25720.895263.4398@charged.uio.no>
	<20030609065141.A9781@google.com>
	<20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == viro  <viro@parcelfarce.linux.theplanet.co.uk> writes:

     > On Mon, Jun 09, 2003 at 06:51:41AM -0700, Frank Cusack wrote:
    >> When foo is unlinked, nfs_unlink() does a sillyrename, this
    >> puts the dentry on nfs_delete_queue, and (in the VFS) unhashes
    >> it from the dcache.  This causes a problem, because
    >> dentry->d_parent->d_inode is now guaranteed to remain stale.
    >> (OK, I'm not really sure about this last part.)

     > ????

Al,

AFAICS the problem is the following:

  - NFS sillyrenames dentry 1
  - Upon return from nfs_unlink(), VFS unhashes dentry 1

  - Upon next lookup, VFS+NFS conspire to create aliased dentry 2 to
    sillyrenamed file
  - Upon last close of files associated with dentry 1, NFS completes
    sillyrename. File is unlinked on server.
  - Aliased dentry 2 is still around, but it is now pointing to stale
    fh.

IOW we just want to prevent VFS from unhashing the dentry in the first
place: dentry aliasing cannot work together with sillyrename.

Cheers,
  Trond
