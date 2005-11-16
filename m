Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbVKPQjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbVKPQjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVKPQjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:39:15 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:50109 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030402AbVKPQjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:39:14 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 16 Nov 2005 16:38:49 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, andrea@suse.de,
       hugh@veritas.com, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC] sys_punchhole()
In-Reply-To: <1132157106.24066.61.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0511161630190.6470@hermes-1.csi.cam.ac.uk>
References: <1131664994.25354.36.camel@localhost.localdomain> 
 <1131686314.2833.0.camel@laptopd505.fenrus.org> <1132157106.24066.61.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005, Badari Pulavarty wrote:
> On Fri, 2005-11-11 at 06:18 +0100, Arjan van de Ven wrote:
> > On Thu, 2005-11-10 at 15:23 -0800, Badari Pulavarty wrote:
> > > 
> > > We discussed this in madvise(REMOVE) thread - to add support 
> > > for sys_punchhole(fd, offset, len) to complete the functionality
> > > (in the future).
> > 
> > in the past always this was said to be "really hard" in linux locking
> > wise, esp. the locking with respect to truncate...
> > 
> > did you find a solution to this problem ?
> 
> I have been thinking about some of the race condition we might run into.
> Its hard to think all of them, when I really don't have any code to play
> with :(
> 
> Anyway, I think race against truncate is fine. We hold i_alloc_sem -
> which should serialize against truncates. This should also serialize
> against DIO. Holding i_sem should take care of writers.
> 
> One concern I can think of is, racing with read(2). While we are
> thrashing pagecache and calling filesystem to free up the blocks - 
> a read(2) could read old disk block and give old data (since it won't
> find it in pagecache). This could become a security hole :(

So why not tell the fs to perform the "punch" before dealing with the page 
cache?  If you do it in that order, a racing read(2) (or a racing mmapped 
access for that matter) will see the hole, not the old data.

btw. I sometimes wonder whether it is correct for truncate to do the page 
cache update before calling down into the fs for simillar reasons but I 
think that it is ok after all because truncate only ever converts between 
(exists/hole -> does not exist) or (does not exist -> exists as 
zeroes/hole) but it never deals with (exists A -> exists B/hole) which is 
what sys_punchhole does.  I just had to adapt the address space operations 
readpage and writepage in ntfs to cope with a read/write request outside 
the end of the file which does happen when a racing truncate has extended 
the file's i_size but the fs has not done the necessary metadata updates 
yet...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
