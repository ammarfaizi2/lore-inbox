Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbTFMGAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 02:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbTFMGAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 02:00:01 -0400
Received: from pat.uio.no ([129.240.130.16]:40406 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265157AbTFMF77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 01:59:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16105.27531.983439.972077@charged.uio.no>
Date: Thu, 12 Jun 2003 23:13:31 -0700
To: dipankar@in.ibm.com
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
In-Reply-To: <20030613055001.GA1331@in.ibm.com>
References: <20030612125630.GA19842@butterfly.hjsoft.com>
	<20030612135254.GA2482@in.ibm.com>
	<16104.40370.828325.379995@charged.uio.no>
	<20030612155345.GB1438@in.ibm.com>
	<16104.43445.918001.683257@charged.uio.no>
	<20030612195302.GH1438@in.ibm.com>
	<16105.24576.901270.856844@charged.uio.no>
	<20030613055001.GA1331@in.ibm.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dipankar Sarma <dipankar@in.ibm.com> writes:

     > Well, d_lookup() isn't the only place that does a dget()
     > without holding dcache_lock. There are *many* places where
     > dget() is done without holding dcache_lock. That didn't seem to
     > be a requirement in the pre-RCU dcache model.

d_lookup() is the only place where someone can pick up an existing
dentry for which they do not already hold a reference.

    >> d_invalidate(), d_prune_aliases(), prune_dcache(),
    >> shrink_dcache_sb() are but a few functions that rely on the
    >> above code snippet working to keep d_lookup() from intruding.

     > Those routines hold the per-dentry lock as required and that
     > protects them from intruding lockfree d_lookup().

d_invalidate() does not. d_prune_aliases() does not. d_unhash() does
not.

Down in the per-filesystem code, I know of several locations in the
NFS code that do not. There's one in procfs. I'm sure you can find
more examples in the other filesystems too...

Your argument only holds water if you demand that all callers of
d_drop() should also take the per-dentry lock. AFAICS this is not
being enforced.

Cheers,
  Trond
