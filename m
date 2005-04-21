Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVDUIn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVDUIn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDUIaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:30:01 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:19397 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261467AbVDUHbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:31:50 -0400
Subject: Re: [patch] fix race in __block_prepare_write (again)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1114068058.5182.22.camel@npiggin-nld.site>
References: <1114064046.5182.13.camel@npiggin-nld.site>
	 <Pine.LNX.4.60.0504210757220.3348@hermes-1.csi.cam.ac.uk>
	 <1114067401.11293.3.camel@imp.csi.cam.ac.uk>
	 <1114068058.5182.22.camel@npiggin-nld.site>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 21 Apr 2005 08:31:44 +0100
Message-Id: <1114068704.12751.8.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 17:20 +1000, Nick Piggin wrote:
> On Thu, 2005-04-21 at 08:10 +0100, Anton Altaparmakov wrote:
> > And one more thing...
> > 
> > On Thu, 2005-04-21 at 08:01 +0100, Anton Altaparmakov wrote:
> > > On Thu, 21 Apr 2005, Nick Piggin wrote:
> > > > ... I somehow didn't send it to Andrew last time.
> > > > 
> > > > Fix a race where __block_prepare_write can leak out an in-flight
> > > > read against a bh if get_block returns an error. This can lead to
> > > > the page becoming unlocked while the buffer is locked and the read
> > > > still in flight. __mpage_writepage BUGs on this condition.
> > > [snip]
> > > > --- linux-2.6.orig/fs/buffer.c	2005-04-21 11:55:17.549614278 
> > > +1000
> > > > +++ linux-2.6/fs/buffer.c	2005-04-21 15:55:41.483826075 +1000
> > > > @@ -1988,6 +1988,7 @@
> > > >  			*wait_bh++=bh;
> > > >  		}
> > > >  	}
> > > > +out:
> > > >  	/*
> > > >  	 * If we issued read requests - let them complete.
> > > >  	 */
> > > > @@ -1996,8 +1997,9 @@
> > > >  		if (!buffer_uptodate(*wait_bh))
> > > >  			return -EIO;
> > 
> > This return is now wrong after your patch.  It should be "err = -EIO;"
> > otherwise you do not zero newly allocated blocks and thus risk exposing
> > stale data on buffer i/o errors. 
> > 
> 
> Hmm yeah I should have been more careful. But isn't that another bug? I
> mean, wasn't that wrong *before* my patch as well?
> 
> It was, right? Because not only might it return without having waited
> for all in-flight buffers, but it also didn't zero the blocks on errors?

I agree with you.  It was a bug.  There are a lot more bugs in the
generic write code paths.  I have been analysing the code quite
thoroughly because I am reimplementing it in NTFS and am shocked that a
number of bugs in the generic file write code paths have gone unnoticed
for ages (I guess since they only affect seldom traversed code paths).
When I have the time I will be cooking up patches but it might be a
while.  And perhaps someone else will fix them before I get to them so
here are a couple of examples off the top of my head...

mm/filemap.c::file_buffered_write():

- It calls fault_in_pages_readable() which is completely bogus if
@nr_segs > 1.  It needs to be replaced by a to be written
"fault_in_pages_readable_iovec()".

- It increments @buf even in the iovec case thus @buf can point to
random memory really quickly (in the iovec case) and then it calls
fault_in_pages_readable() on this random memory.  Ouch...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

