Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbTFMFLC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 01:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbTFMFLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 01:11:01 -0400
Received: from pat.uio.no ([129.240.130.16]:3010 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265133AbTFMFK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 01:10:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16105.24576.901270.856844@charged.uio.no>
Date: Thu, 12 Jun 2003 22:24:16 -0700
To: dipankar@in.ibm.com
Cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
In-Reply-To: <20030612195302.GH1438@in.ibm.com>
References: <20030612125630.GA19842@butterfly.hjsoft.com>
	<20030612135254.GA2482@in.ibm.com>
	<16104.40370.828325.379995@charged.uio.no>
	<20030612155345.GB1438@in.ibm.com>
	<16104.43445.918001.683257@charged.uio.no>
	<20030612195302.GH1438@in.ibm.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dipankar Sarma <dipankar@in.ibm.com> writes:

    >> Look at all those functions that take dcache_lock, and then
    >> test
    >> dentry-> d_count. Unless I'm missing something here, your
    >> d_lookup() clearly has them all screwed, no?

     > Not necessarily. One example is the fact that d_lookup() can
     > only increase d_count. Besides, dput() decrements d_count
     > without dcache_lock, so I am not sure holding dcache_lock
     > during d_count test buys you much.

Wrong. Look at the VFS code. In all cases the test is of the form.

    spin_lock(&dcache_lock);
    /* Are we the sole users of this dentry */
    if (atomic_read(&dentry->d_count) == 1) {
       /* Yes - do some operation */
    }


Knowing that d_lookup() can *increase* d_count is not a plus here. The
whole idea is to have a test for sole use.

In most cases, the "do some operation" above is

	d_drop(dentry);

in order (for instance) to ensure that nobody else can look up this
dentry while we're working on it (e.g. rename or unlink,...).

Your d_lookup() screws the above example of code which you can find in
any number of VFS functions. dput(), d_delete(), d_invalidate(),
d_prune_aliases(), prune_dcache(), shrink_dcache_sb() are but a few
functions that rely on the above code snippet working to keep
d_lookup() from intruding.

Cheers,
   Trond
