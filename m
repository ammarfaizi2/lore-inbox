Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWFIIcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWFIIcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWFIIcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:32:22 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:56732 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751445AbWFIIcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:32:21 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock
	detected!
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060609071900.GA27005@elte.hu>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com>
	 <1149751953.10056.10.camel@imp.csi.cam.ac.uk>
	 <20060608095522.GA30946@elte.hu>
	 <1149764032.10056.82.camel@imp.csi.cam.ac.uk>
	 <20060609071900.GA27005@elte.hu>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 09 Jun 2006 09:31:56 +0100
Message-Id: <1149841916.4061.2.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 09:19 +0200, Ingo Molnar wrote: 
> * Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > This last lookup of physical location in map_mft_record() [actually in 
> > readpage as map_mft_record() reads the page cache page containing the 
> > record] cannot require us to load an extent mft record because the 
> > runlist is complete so we cannot deadlock here.
> 
> ah! So basically, the locking sequences the validator observed during 
> load_system_files() are a one-time event that can only occur during 
> ntfs_fill_super().
> 
> if we ignore those dependencies (of the initial reading of the MFT inode 
> generating recursive map_mft_record() calls) and take into account that 
> the MFT inode will never again trigger map_mft_record() calls, then the 
> locking is conflict-free after mounting has finished, right?

Correct!  (-:

> so the validator is technically correct that load_system_files() 
> generates locking patterns that have dependency conflicts - but that 
> code is guaranteed to be single-threaded because it's a one time event 
> and because the VFS has no access to the filesystem at that time yet so 
> there is zero parallellism.

Correct.

I just sent you a long description of the process before reading your
email above...  Did not need to bother if I knew you already understood
the case!

> can you think of any simple and clean solution that would avoid those 
> conflicting dependencies within the NTFS code? Perhaps some way to read 
> the MFT inode [and perhaps other, always-cached inodes that are later 
> used as metadata] without locking? I can code it up and test it, but i 
> dont think i can find the best method myself :-)

I really do not want to do that.  It would penalise ntfs performance in
the general case by introducing "if in mount don't lock otherwise lock"
checks everywhere in the driver pretty much or you would need to
duplicate a ton of code which I avoided duplicating exactly using my
bootstrapping mechanism which is why it exists in the first place!

And given the only reason for the change you want to make is to make the
lock validator happy I would much rather you did something with the lock
validator instead...  Can't you just insert a call to the validator in
ntfs_fill_super() just before the call to ntfs_read_inode_mount() to the
effect of "turn_off_lock_validator_data_gathering()" and then just after
ntfs_read_inode_mount() returns insert a call to the validator to the
effect of "turn_on_lock_validator_data_gathering()".

Does that sound reasonable to you?

I really cannot see why code needs to be penalised for a validator...  I
would much rather see a complicated and slow lock validator then a
complicated and slow driver given a lock validator is only compiled in
for debugging purposes whilst a driver is compiled in all kernels
including release ones...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

