Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbTFLFup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 01:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264752AbTFLFup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 01:50:45 -0400
Received: from pat.uio.no ([129.240.130.16]:32765 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264750AbTFLFuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 01:50:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16104.6119.365469.836306@charged.uio.no>
Date: Wed, 11 Jun 2003 23:04:23 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] First casuality of hlist poisoning in 2.5.70
In-Reply-To: <Pine.LNX.4.44.0306112206430.29133-100000@home.transmeta.com>
References: <16103.48257.400430.785367@charged.uio.no>
	<Pine.LNX.4.44.0306112206430.29133-100000@home.transmeta.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > But I suspect that neither dentry nor target should really ever
     > be unhashed by the time we call d_move(). That's reinforced by
     > the fact that it looks like a unhashed dentry in d_move() would
     > have been a silent bug previously - staying unhashed if it just
     > shared the bucket.

It is not a bug.

Looking more carefully at the Oops, it seems that this problem is
occurring inside an nfs_rename() in which the target name belongs to
an open file - and thus needs to be sillyrenamed first.

In that case, we certainly do not want to rehash the dentry in order
to do the d_move() since that would give rise to a race: we want to do
a real rename into the same dentry after we're done with the
sillyrename.

I can agree that the patch was flawed, but I still believe that we do
need to allow d_move to work with unhashed dentries.

Cheers,
  Trond
