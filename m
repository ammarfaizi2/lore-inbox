Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264855AbUEVB27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUEVB27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbUEVBZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:25:21 -0400
Received: from web02.mailshell.com ([209.157.66.232]:11948 "HELO mailshell.com")
	by vger.kernel.org with SMTP id S263614AbUEVBYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 21:24:23 -0400
Message-ID: <40AD2F8A.6030306@serice.net>
Date: Thu, 20 May 2004 17:22:02 -0500
From: Paul Serice <paul@serice.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040127
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] iso9660 inodes beyond 4GB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ISO 9660 standard allows meta-data to be stored at almost any
arbitrary byte on the file system.  The current inode scheme uses the
byte offset as the inode value making it easy to find the underlying
block and block offset.

This scheme is subject to obvious integer overflow problems that
prevents it from being able to reach meta-data beyond the 4GB
boundary.  Looking back through the archives, this problem was
anticipated but discounted because mkisofs puts its meta-data near the
beginning of the file system.

However, there are at least two common scenarios where meta-data must
be located beyond the 4GB boundary.  First, growisofs needs to add
meta-data beyond the 4GB boundary when it merges a new session with an
old session that ended beyond the 4GB boundary.  The following URL has
more information:

     http://fy.chalmers.se/~appro/linux/DVD+RW/#isofs4gb

Second (and what prompted this patch) is that I've written two
programs that together with cdrecord or growisofs allow arbitrarily
large backups to span a multi-volume set of DVDs without the need for
any intermediate files (much like the functionality of a tape drive).
Because I only know the file lengths near the end of each burn, I have
to write the meta-data near the end of the DVD.  The following URL has
more information:

     http://www.serice.net/shunt/

To support these types of DVDs, the inode scheme for isofs must be
changed.  The patch I'm submitting for review provides one such
comprehensive inode scheme.  It assigns inode numbers sequentially
starting with 1 for the root inode.  It keeps a mapping for each inode
that is indexed both by the inode number and by the block and block
offset.  The indexes are implemented using two rbtrees and protected
by a reader-writer spin lock.

The patch is about 28K and can be downloaded from the following URL:

     http://www.serice.net/shunt/linux-2.6.6-isofs.patch


Thanks
Paul Serice

