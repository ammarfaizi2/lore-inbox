Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVGEUyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVGEUyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 16:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGEUyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 16:54:55 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:25040 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261895AbVGEUxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 16:53:31 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 5 Jul 2005 21:53:25 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Daniel Drake <dsd@gentoo.org>, David G?mez <david@pleyades.net>,
       Robert Love <rml@novell.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
In-Reply-To: <20050705180711.GA17429@tentacle.dhs.org>
Message-ID: <Pine.LNX.4.60.0507052104021.30788@hermes-1.csi.cam.ac.uk>
References: <42C72563.7040103@gentoo.org> <Pine.LNX.4.60.0507030053040.15398@hermes-1.csi.cam.ac.uk>
 <42C7BF37.9010005@gentoo.org> <1120487242.11399.5.camel@imp.csi.cam.ac.uk>
 <42C9788F.50205@gentoo.org> <Pine.LNX.4.60.0507042008310.7572@hermes-1.csi.cam.ac.uk>
 <1120527203.18268.2.camel@vertex> <Pine.LNX.4.60.0507050855410.27724@hermes-1.csi.cam.ac.uk>
 <20050705154837.GA16512@tentacle.dhs.org> <Pine.LNX.4.60.0507051804050.1458@hermes-1.csi.cam.ac.uk>
 <20050705180711.GA17429@tentacle.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005, John McCutchan wrote:
> On Tue, Jul 05, 2005 at 06:06:56PM +0100, Anton Altaparmakov wrote:
> > On Tue, 5 Jul 2005, John McCutchan wrote:
> > > On Mon, 4 Jul 2005, John McCutchan wrote:
> > > > Nice work, I am going to have a closer look at the patch soon. Could you
> > > > post the final patch at http://bugzilla.kernel.org/show_bug.cgi?id=4796
> > > 
> > > Originally inotify had 2 functions that handled this. One that would
> > > build up a list of inodes to call remove_watch on, the other function
> > > would do the actual calling of remove_watch. This mirrored the other
> > > unmount paths. I'm wondering if it wouldn't be cleaner to revert back to
> > > that way?
> > 
> > That is certainly possible.  Out of curiosity, how did you anchor the 
> > inodes to your private list?  Or did you just have a dynamically allocated 
> > array of pointers to inodes?
> 
> The only reason I suggested it, is I'm afraid that maybe we are still
> missing a corner case. Even with your fix.

Oh, are you thinking of anything in particular?  I don't think you are 
missing anything now...

You cannot get any new watches which makes things a lot easier (see 
analysis I just posted in the other thread on LKML: Re: [-mm patch] Fix 
inotify umount hangs).  Thus you can ignore anything that cannot possibly 
have a watch and that is what my patch does.  Both i_count of zero and the 
three i_states I_CLEAR, I_FREEING, and I_WILL_FREE, which imply an i_count 
of zero mean that no watches can be present since each watch holds a 
reference via i_count.

> We just added a new list_head in the inode struct. If you look at older
> versions of inotify, maybe around 0.15 you can see for yourself.

That is far too space wasting IMHO given you only use it at umount time.  
That means you are wasting 8 or 16 bytes for each and every inode on the 
system.  If you are going down that route, IMHO it would be better if you 
just do an array of inodes and then walk that.  For scalability you could 
use a two dimensional array of pages each holding inodes for example.  It 
doesn't really matter what you do given umount is not exactly a hot path 
so the overhead of doing the necessary page allocations and then freeing 
them is not important.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
