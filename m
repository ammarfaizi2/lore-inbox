Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbUJZWON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbUJZWON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 18:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbUJZWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 18:14:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:22195 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261507AbUJZWNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 18:13:53 -0400
Date: Tue, 26 Oct 2004 15:15:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: jfannin1@columbus.rr.com
Cc: agk@redhat.com, matt@minas-morgul.org, jfannin1@columbus.rr.com,
       christophe@saout.de, linux-kernel@vger.kernel.org, axboe@suse.de,
       bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
Message-Id: <20041026151559.041088f1.akpm@osdl.org>
In-Reply-To: <20041026213703.GA6174@rivenstone.net>
References: <87oeitdogw.fsf@barad-dur.crans.org>
	<1098731002.14877.3.camel@leto.cs.pocnet.net>
	<20041026123651.GA2987@zion.rivenstone.net>
	<20041026135955.GA9937@agk.surrey.redhat.com>
	<20041026213703.GA6174@rivenstone.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jfannin1@columbus.rr.com wrote:
>
> > [To check for repeat of old problems with related symptoms:]
> >   Were both kernels compiled with the same compiler version? Which version?
> >   Does it make any difference if you rebuild lvm with --disable-o_direct?
> 
>     Chris Han (BCC'ed) mailed me to let me know he'd narrowed the
> problem down to the 'dio-handle-eof.patch'.  Reverting it makes things
> work for me too.  Yay!

If you have time, please restore dio-handle-eof.patch and then apply the
below fixup, then retest.  Thanks.

--- 25/fs/direct-io.c~dio-handle-eof-fix	2004-10-26 00:49:40.363376432 -0700
+++ 25-akpm/fs/direct-io.c	2004-10-26 00:49:40.367375824 -0700
@@ -987,6 +987,8 @@ direct_io_worker(int rw, struct kiocb *i
 	isize = i_size_read(inode);
 	if (bytes_todo > (isize - offset))
 		bytes_todo = isize - offset;
+	if (!bytes_todo)
+		return 0;
 
 	for (seg = 0; seg < nr_segs && bytes_todo; seg++) {
 		user_addr = (unsigned long)iov[seg].iov_base;
_

