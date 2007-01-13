Return-Path: <linux-kernel-owner+w=401wt.eu-S1422719AbXAMQzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbXAMQzg (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 11:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbXAMQzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 11:55:36 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:56088 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422719AbXAMQzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 11:55:35 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: O_DIRECT question
To: Linus Torvalds <torvalds@osdl.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Chris Mason <chris.mason@oracle.com>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Reply-To: 7eggert@gmx.de
Date: Sat, 13 Jan 2007 17:53:59 +0100
References: <7BYkO-5OV-17@gated-at.bofh.it> <7BYul-6gz-5@gated-at.bofh.it> <7C74B-2A4-23@gated-at.bofh.it> <7CaYA-mT-19@gated-at.bofh.it> <7Cpuz-64X-1@gated-at.bofh.it> <7Cz0T-4PH-17@gated-at.bofh.it> <7CBcl-86B-9@gated-at.bofh.it> <7CBvH-52-9@gated-at.bofh.it> <7CBFn-hw-1@gated-at.bofh.it> <7CBP1-KI-3@gated-at.bofh.it> <7CBYG-WK-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1H5m8l-0000ns-9e@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> On Sat, 13 Jan 2007, Michael Tokarev wrote:

>> (No, really - this load isn't entirely synthetic.  It's a typical database
>> workload - random I/O all over, on a large file.  If it can, it combines
>> several I/Os into one, by requesting more than a single block at a time,
>> but overall it is random.)
> 
> My point is that you can get basically ALL THE SAME GOOD BEHAVIOUR without
> having all the BAD behaviour that O_DIRECT adds.
> 
> For example, just the requirement that O_DIRECT can never create a file
> mapping,

That sounds sane, but the video streaming folks will be unhappy.

Maybe you could do:
 reserve_space(); (*)
 do_write_odirect();
 update_filesize();
and only allow reads up to the current filesize?

Off cause if you do ftruncate first and then write o_direct, the holes will
need to be filled before the corresponding blocks are assigned to the file.
Either you'll zero them or you can insert them into the file after the write.

Races:
against other reads:  May happen in any order, to-be-written pages are
 beyond filesize (inaccessible), zeroed or not yet assigned to the file.
against other writes: No bad effect, since you don't unreserve
 mappings, and update_filesize won't shrink the file. You must, however,
 not reserve two chunks for the same location in the file unless you can
 handle replacing blocks of files.
 open(O_WRITE) without O_DIRECT is not allowed, therefore that can't race.
against truncate: Yes, see below

(*) This would allow fadvise_size(), too, which could reduce fragmentation
    (and give an early warning on full disks) without forcing e.g. fat to
    zero all blocks. OTOH, fadvise_size() would allow users to reserve the
    complete disk space without his filesizes reflecting this.

> and can never interact with ftruncate

ACK, r/w semaphore, read={r,w}_odirect, write=ftruncate?

> would actually make
> O_DIRECT a lot more palatable to me. Together with just the requirement
> that an O_DIRECT open would literally disallow any non-O_DIRECT accesses,
> and flush the page cache entirely, would make all the aliases go away.

That's probably the best semantics.

Maybe you should allow O_READ for the backup people, maybe forcing
O_DIRECT|O_ALLOWDOUBLEBUFFER (doing the extra copy in the kernel).

> At that point, O_DIRECT would be a way of saying "we're going to do
> uncached accesses to this pre-allocated file". Which is a half-way
> sensible thing to do.

And I'd bet nobody would notice these changes unless they try inherently
stupid things.

> But what O_DIRECT does right now is _not_ really sensible, and the
> O_DIRECT propeller-heads seem to have some problem even admitting that
> there _is_ a problem, because they don't care.

It's a hammer - having it will make anything look like a nail,
and there is nothing wrong with hammering a nail!!! .-)

> A lot of DB people seem to simply not care about security or anything
> else.anything else. I'm trying to tell you that quoting numbers is
> pointless, when simply the CORRECTNESS of O_DIRECT is very much in doubt.

The only thing you'll need for a correct database behaviour is:
If one process has completed it's write and the next process opens that
file, it must read the current contents.

Races with normal reads and writes, races with truncate - don't do that then.
You wouldn't expect "cat somefile > database.dat" on a running db to be a
good thing, too, no matter if o_direct is used or not.
-- 
Funny quotes:
3. On the other hand, you have different fingers.

Friﬂ, Spammer: mJyp@uhu.7eggert.dyndns.org
