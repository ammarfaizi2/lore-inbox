Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTFKXvC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 19:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264612AbTFKXvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 19:51:01 -0400
Received: from pat.uio.no ([129.240.130.16]:22663 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264493AbTFKXvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 19:51:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16103.50069.802804.254270@charged.uio.no>
Date: Wed, 11 Jun 2003 17:04:37 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] First casuality of hlist poisoning in 2.5.70
In-Reply-To: <Pine.LNX.4.44.0306111640590.28014-100000@home.transmeta.com>
References: <16103.48257.400430.785367@charged.uio.no>
	<Pine.LNX.4.44.0306111640590.28014-100000@home.transmeta.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

    >> - hlist_del_rcu(&dentry->d_hash);
    >> - hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
    >> + if (!hlist_unhashed(&dentry->d_hash))
    >> + hlist_del_rcu(&dentry->d_hash);
    >> + if (!hlist_unhashed(&target->d_hash)) {
    >> + hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
    >> + dentry->d_vfs_flags &= ~DCACHE_UNHASHED;
    >> + } else
    >> + dentry->d_vfs_flags |= DCACHE_UNHASHED;

     > Can source or target really be validly unhashed? That makes no
     > sense, since we just looked it up, and we've held the directory
     > semaphores over the whole thing.

When renaming, we may want to unhash the dentry in order to stop
d_lookup()s from succeeding (Recall that cached_lookup() does not
attempt to take the directory semaphore - only real_lookup() does
that).

AFAICS one should not rehash the dentry until after the d_move(). Does
that make sense?

Cheers,
   Trond
