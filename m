Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTGKRCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTGKRCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:02:46 -0400
Received: from pat.uio.no ([129.240.130.16]:61913 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264495AbTGKRCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:02:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16142.61723.615768.520443@charged.uio.no>
Date: Fri, 11 Jul 2003 19:17:15 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.75 Support dentry revalidation under open(".")
In-Reply-To: <Pine.LNX.4.44.0307110955180.3452-100000@home.osdl.org>
References: <16142.54383.804882.881178@charged.uio.no>
	<Pine.LNX.4.44.0307110955180.3452-100000@home.osdl.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@osdl.org> writes:

     > I'm not sure. It may not impact other filesystems, but it
     > impacts the internal consistency of the dentry tree, and can
     > cause some really nasty aliasing issues.

We can remove the d_invalidate(). See my response to your second
paragraph...

However as a more general argument: it is hard to avoid aliasing if
people are playing games on the server. If e.g. somebody does

mv foo bar
mkdir foo

on the server side while one of our processes was in the original
"foo" directory, it would IMHO be wrong not to allow us to d_drop()
the original dentry in order to allow other processes to access the
new "foo".

     > If d_invalidate() returns a failure, that means that the dentry
     > is still hashed (because it was busy), and returning NULL and
     > leaving the dentry there sounds very wrong, since it can never
     > be fixed with a new lookup.

The d_invalidate() is not really crucial for the purposes of the
open(".")-type call, and could indeed be taken out. The main point as
far as NFS is concerned is the d_revalidate() call.

I will resubmit the patch with the d_invalidate taken out...

Cheers,
  Trond
