Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbVIILZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVIILZp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbVIILZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:25:45 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:62618 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030244AbVIILZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:25:44 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [PATCH 2/25] NTFS: Allow highmem kmalloc()
	in	ntfs_malloc_nofs() and add _nofail() version.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0509091407220.27527@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
	 <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk>
	 <84144f0205090903366454da6@mail.gmail.com>
	 <1126263740.24291.16.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.58.0509091407220.27527@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 09 Sep 2005 12:25:38 +0100
Message-Id: <1126265138.24291.21.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 14:15 +0300, Pekka J Enberg wrote:
> On Fri, 9 Sep 2005, Anton Altaparmakov wrote:
> > Also note I only use the ntfs_malloc_nofs() wrapper if I have to.  If I
> > know how much I am allocating or at least know that the maximum is quite
> > small, I use kmalloc() directly.  It is pretty much only for the runlist
> > allocations that I use the wrapper as the runlist is typically small but
> > for fragmented files it can grow huge.  I have seen runlists consuming
> > over 256kiB of ram, without vmalloc that would be a real problem...
> 
> So things like
> 
> 	rl = ntfs_malloc_nofs(rlsize = PAGE_SIZE);
> 
> should be changed to kmalloc(), right?

They could be but I would rather not.  What if one day I decide to
change how ntfs_malloc_nofs() works?  Then it would be needed to
carefully go through the whole driver looking for places where kmalloc
is used and change those, too.

>From a software design point of view you should never mix interfaces
when accessing an object if you want clean and maintainable code.  And
using kmalloc() sometimes and ntfs_malloc_nofs() at other times for the
same object would violate that.

The wrapper is a static inline so I would assume gcc can optimize away
everything when a constant size is passed in like in the example you
point out above.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

