Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWG0Jfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWG0Jfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 05:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWG0Jfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 05:35:39 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:14487 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932546AbWG0Jfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 05:35:38 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [BUG?] possible recursive locking detected
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, eike-kernel@sf-tec.de,
       linux-kernel@vger.kernel.org, aia21@cantab.net
In-Reply-To: <44C884EF.6010705@yahoo.com.au>
References: <200607261805.26711.eike-kernel@sf-tec.de>
	 <20060726225311.f51cee6d.akpm@osdl.org> <44C86271.9030603@yahoo.com.au>
	 <1153984527.21849.2.camel@imp.csi.cam.ac.uk>
	 <20060727003806.def43f26.akpm@osdl.org>
	 <1153988398.21849.16.camel@imp.csi.cam.ac.uk>
	 <44C884EF.6010705@yahoo.com.au>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 27 Jul 2006 10:35:28 +0100
Message-Id: <1153992928.21849.41.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 19:18 +1000, Nick Piggin wrote:
> Anton Altaparmakov wrote:
> > On Thu, 2006-07-27 at 00:38 -0700, Andrew Morton wrote:
> > 
> >>On Thu, 27 Jul 2006 08:15:27 +0100
> >>Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >>
> >>
> >>>>I'm surprised ext2 is allocating with __GFP_FS set, though. Would that
> >>>>cause any problem?
> >>>
> >>>That is an ext2 bug IMO.
> >>
> >>There is no bug.
> >>
> >>What there is is an ill-defined set of rules.  If we want to tighten these
> >>rules we have a choice between
> > 
> > 
> > I beg to differ.  It is a bug.  You cannot reenter the file system when
> > the file system is trying to allocate memory.  Otherwise you can never
> > allocate memory with any locks held or you are bound to introduce an
> > A->B B->A deadlock somewhere.
> 
> I don't think it is a bug in general. It really depends on the allocation:
> 
> - If it is a path that might be required in order to writeout a page, then
> yes GFP_NOFS is going to help prevent deadlocks.
> 
> - If it is a path where you'll take the same locks as page reclaim requires,
> then again GFP_NOFS is required.
> 
> For NTFS case, it seems like holding i_mutex on the write path falls foul
> of the second problem. But I agree with Andrew that this is a critical case
> where we do have to enter the fs. GFP_NOFS is too big a hammer to use.
> 
> I guess you'd have to change NTFS to do something sane privately, or come
> up with a nice general solution that doesn't harm the common filesystems
> that apparently don't have a problem here... can you just add GFP_NOFS to
> NTFS's mapping_gfp_mask to start with?

I don't think NTFS has a problem either.  It is a theoretical problem
with an extremely small chance of being hit.  I am happy to have such a
problem for now.  There are more pressing problems to solve.  The only
thing that needs to happen is for the messages to stop so people stop
complaining / getting worried about them...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://www.linux-ntfs.org/ & http://www-stu.christs.cam.ac.uk/~aia21/

