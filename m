Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264612AbTF3OWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 10:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbTF3OWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 10:22:10 -0400
Received: from pat.uio.no ([129.240.130.16]:25505 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264612AbTF3OWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 10:22:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16128.19176.804116.866980@charged.uio.no>
Date: Mon, 30 Jun 2003 16:36:24 +0200
To: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH 0/4] Optimize NFS open() calls by means of 'intents'...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add the concept of 'intents' to the VFS layer,
and are subsequently used to optimize the NFSv2/v3 close-to-open code,
and to add O_EXCL support.
                                                                                
Intents are a concept which have been pioneered under Linux by Peter
Braam. They are an optional field that is passed down to inode ops and
are used in order to pass down extra information to the filesystem
about the nature of the operation being undertaken.
 
This allows the filesystem in turn to make assumptions in order to
optimize away unnecessary operations (for instance under NFS - doing
both a LOOKUP and a GETATTR when doing an open), and to choose
variants that improve the atomicity (For instance under NFSv4 you
may choose to OPEN rather than LOOKUP).

So far, I have only implemented OPEN intents. In the future, it may
prove to be useful to add intents for other operations (I know the
Lustre project in particular is keen to do this) in order to optimize
away unnecessary file permission checks, and other such things.
 
The patches presented now differ from those presented in May in that
I've tried to take into account both Linus' and Al Viro's comments.
The strategy is therefore to make use of the 'struct nameidata',
when it exists, and feed that down to the filesystem. The actual
intent information is then included as a union in the nameidata.
 
Cheers,
  Trond
