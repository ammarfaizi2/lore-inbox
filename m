Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUKBOmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUKBOmC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbUKBOmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:42:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45270 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262576AbUKBOkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:40:22 -0500
Date: Tue, 2 Nov 2004 15:39:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Mathieu Segaud <matt@minas-morgul.org>
Cc: Andrew Morton <akpm@osdl.org>, jfannin1@columbus.rr.com, agk@redhat.com,
       christophe@saout.de, linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
Message-ID: <20041102143919.GT6821@suse.de>
References: <1098731002.14877.3.camel@leto.cs.pocnet.net> <20041026123651.GA2987@zion.rivenstone.net> <20041026135955.GA9937@agk.surrey.redhat.com> <20041026213703.GA6174@rivenstone.net> <20041026151559.041088f1.akpm@osdl.org> <87hdogvku7.fsf@barad-dur.crans.org> <20041026222650.596eddd8.akpm@osdl.org> <20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de> <877jpcgolt.fsf@barad-dur.crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877jpcgolt.fsf@barad-dur.crans.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27 2004, Mathieu Segaud wrote:
> Jens Axboe <axboe@suse.de> disait dernièrement que :
> 
> 
> > This feels pretty icky, but should suffice for testing. Does it make a
> > difference?
> >
> > --- /opt/kernel/linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:29:51.866931262 +0200
> > +++ linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:41:20.292172299 +0200
> > @@ -987,8 +987,8 @@
> >  	isize = i_size_read(inode);
> >  	if (bytes_todo > (isize - offset))
> >  		bytes_todo = isize - offset;
> > -	if (!bytes_todo)
> > -		return 0;
> > +	if (bytes_todo < PAGE_SIZE)
> > +		bytes_todo = PAGE_SIZE;
> >  
> >  	for (seg = 0; seg < nr_segs && bytes_todo; seg++) {
> >  		user_addr = (unsigned long)iov[seg].iov_base;
> 
> As 2.6.10-rc1-mm1 failed (as expected), I tried tour fix applied upon
> 2.6.10-rc1-mm1. This did not make any difference.
> The only workaround for now is backing out dio-handle-eof-fix.patch and
> dio-handle-eof.patch
> I am willing to test anything you could send :)

Does this work, on top of 2.6.0-rc1-mm1?

--- /opt/kernel/linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:29:51.000000000 +0200
+++ linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-11-02 15:36:51.864411244 +0100
@@ -985,10 +985,12 @@
 	}
 
 	isize = i_size_read(inode);
-	if (bytes_todo > (isize - offset))
-		bytes_todo = isize - offset;
-	if (!bytes_todo)
-		return 0;
+	if (bytes_todo > (isize - offset)) {
+		if ((isize - offset))
+			bytes_todo = isize - offset;
+		if (bytes_todo > PAGE_SIZE)
+			bytes_todo = PAGE_SIZE;
+	}
 
 	for (seg = 0; seg < nr_segs && bytes_todo; seg++) {
 		user_addr = (unsigned long)iov[seg].iov_base;
@@ -1008,10 +1010,9 @@
 		dio->curr_page = 0;
 
 		dio->total_pages = 0;
-		if (user_addr & (PAGE_SIZE-1)) {
+		if (user_addr & (PAGE_SIZE-1))
 			dio->total_pages++;
-			bytes -= PAGE_SIZE - (user_addr & (PAGE_SIZE - 1));
-		}
+
 		dio->total_pages += (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
 		dio->curr_user_address = user_addr;
 	

-- 
Jens Axboe

