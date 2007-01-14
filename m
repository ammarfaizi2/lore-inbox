Return-Path: <linux-kernel-owner+w=401wt.eu-S1751551AbXANS4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbXANS4l (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 13:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbXANS4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 13:56:41 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:56228 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbXANS4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 13:56:40 -0500
Date: Sun, 14 Jan 2007 19:51:21 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Bill Davidsen <davidsen@tmr.com>
cc: 7eggert@gmx.de, Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT question
In-Reply-To: <45A9336E.3050807@tmr.com>
Message-ID: <Pine.LNX.4.58.0701141902010.2649@be1.lrz>
References: <7BYkO-5OV-17@gated-at.bofh.it> <7BYul-6gz-5@gated-at.bofh.it>
 <7C74B-2A4-23@gated-at.bofh.it> <7CaYA-mT-19@gated-at.bofh.it>
 <7Cpuz-64X-1@gated-at.bofh.it> <7Cz0T-4PH-17@gated-at.bofh.it>
 <7CBcl-86B-9@gated-at.bofh.it> <7CBvH-52-9@gated-at.bofh.it>
 <7CBFn-hw-1@gated-at.bofh.it> <7CBP1-KI-3@gated-at.bofh.it>
 <7CBYG-WK-3@gated-at.bofh.it> <E1H5m8l-0000ns-9e@be1.lrz> <45A9336E.3050807@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2007, Bill Davidsen wrote:

> Bodo Eggert wrote:
> 
> > (*) This would allow fadvise_size(), too, which could reduce fragmentation
> >     (and give an early warning on full disks) without forcing e.g. fat to
> >     zero all blocks. OTOH, fadvise_size() would allow users to reserve the
> >     complete disk space without his filesizes reflecting this.
> 
> Please clarify how this would interact with quota, and why it wouldn't 
> allow someone to run me out of disk.

I fell into the "write-will-never-fail"-pit. Therefore I have to talk 
about the original purpose, write with O_DIRECT, too.

- Reserved blocks should be taken out of the quota, since they are about
  to be written right now. If you emptied your quota doing this, it's
  your fault. It it was the group's quota, just run fast enough.-)

- If one write failed that extended the reserved range, the reserved area 
  should be shrunk again. Obviously you'll need something clever here.
  * You can't shrink carelessly while there are O_DIRECT writes.
  * You can't just try to grab the semaphore[0] for writing, this will 
    deadlock with other write()s.
  * If you drop the read lock, it will work out, because you aren't
    writing anymore, and if you get the write lock, there won't be anybody 
    else writing. Therefore you can clear the reservation for the not-
    written blocks. You may unreserve blocks that should stay reserved,
    but that won't harm much. At worst, you'll get fragmentation, loss
    of speed and an aborted (because of no free space) write command.
    Document this, it's a feature.-)

- If you fadvise_size on a non-quota-disk, you can possibly reserve it 
  completely, without being the easy-to-spot offender. You can do the
  same by actually writing these files, keeping them open and unlinking 
  them. The new quality is: You can't just look at the file sizes in
  /proc in order to spot the offender. However, if you reflect the 
  reserved blocks in the used-blocks-field of struct stat, du will
  work as expected and the BOFH will know whom to LART.

  BTW: If the fs supports holes, using du would be the right thing
  to do anyway.


BTW2: I don't know if reserving without actually assigning blocks is 
supported or easy to support at all. These reservations are the result of 
"These blocks are not yet written, therefore they contain possibly secret 
data that would leak on failed writes, therefore they may not be actually 
assigned to the file before write finishes. They may not be on the free 
list either. And hey, if we support pre-reserving blocks to the file, we 
may additionally use it for fadvise_size. I'll mention that briefly."




[0] r/w semaphore, read={r,w}_odirect, write=ftruncate

-- 
Fun things to slip into your budget
Paradigm pro-activator (a whole pack)
	(you mean beer?)
