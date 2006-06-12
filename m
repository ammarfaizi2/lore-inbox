Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWFLIr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWFLIr1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWFLIr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:47:27 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:52864 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751121AbWFLIr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:47:26 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock
	detected!
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060612083117.GA29026@elte.hu>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com>
	 <1149751953.10056.10.camel@imp.csi.cam.ac.uk>
	 <20060608095522.GA30946@elte.hu>
	 <1149764032.10056.82.camel@imp.csi.cam.ac.uk>
	 <20060608112306.GA4234@elte.hu>
	 <1149840563.3619.46.camel@imp.csi.cam.ac.uk>
	 <20060610075954.GA30119@elte.hu>
	 <Pine.LNX.4.64.0606100916050.25777@hermes-1.csi.cam.ac.uk>
	 <20060611053154.GA8581@elte.hu>
	 <Pine.LNX.4.64.0606110739310.3726@hermes-1.csi.cam.ac.uk>
	 <20060612083117.GA29026@elte.hu>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 12 Jun 2006 09:47:21 +0100
Message-Id: <1150102041.24273.15.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 10:31 +0200, Ingo Molnar wrote:
> * Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> 
> > First an explanation of two relevant locks that are both going to 
> > upset the validator.  I half expected this to happen given what has 
> > happened so far.  The two locks are lcnbmp_lock and mftbmp_lock (both 
> > are r/w semaphores).
> 
> thanks!
> 
> > Is the above description sufficient for you to fix it?
> 
> yeah. I have split off vol->lcnbmp_ino's locking rules (for mrec_lock 
> and runlist.lock) from normal inode locking rules, and this fixed the 
> file-writing dependency.
> 
> but i can still trigger a warning, and i think this time it's a real 
> bug: if i mount NTFS with -o show_system_files, and i append data to the 
> $Bitmap, then i get the dependency conflict attached further below.

Not surprising.  (-:  Writing to metadata from user space is definitely
not allowed...

> While extending the $Bitmap manually is extremely evil, the filesystem 
> should nevertheless not break - for example a script could do it by 
> accident. I believe NTFS should either disallow writing to the $Bitmap 
> (by forcing it to be readonly under all circumstances), or the writing 
> should be made safe - right now if that happens in parallel to some 
> other process extending an NTFS file then i think we could deadlock, 
> right?

Absolutely correct.  Writing to metadata files from userspace is
guaranteed to break things.  I don't think a script could do anything
bad because it would never see that a file called $Bitmap exists (-o
show_sys_files is only for debugging/recovery purposes not for general
use).

I never cared for fixing this case because writing to any of those files
is almost guaranteed to corrupt the file system to the extent of Windows
dieing with a blue screen of death on boot and the only option at that
point will be to reformat and reinstall (at least until we write an
ntfsck utility)...

But yes, we could just make all system files read-only.  That would be a
simple enough fix, especially for the ones we keep open all the time
during a mount as they do not even have to affect the iget() code path.
For other system inodes we would have to stick the read-only force in
iget() (or open them at mount time and keep them open).

I will do that when I have some more spare time...  I don't think it is
particularly urgent given it has always been like this and if anyone is
trying to kill their file system even fixing this will not stop them...
They would just need to run the ntfsprogs provided utilities to achieve
anything they like...  I have always followed the principle of giving
people enough rope to hang themselves if they really want to...  (-;
But I agree we should probably make the system files read-only.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

