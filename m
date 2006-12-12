Return-Path: <linux-kernel-owner+w=401wt.eu-S1751000AbWLLKSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWLLKSv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 05:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWLLKSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 05:18:51 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:20456 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbWLLKSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 05:18:51 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Dmitriy Monakhov <dmonakhov@sw.ru>,
       Dmitriy Monakhov <dmonakhov@openvz.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>, <devel@openvz.org>,
       xfs@oss.sgi.com
Subject: Re: [PATCH]  incorrect error handling inside generic_file_direct_write
References: <87k60y1rq4.fsf@sw.ru> <20061211124052.144e69a0.akpm@osdl.org>
	<87bqm9tie3.fsf@sw.ru> <20061212015232.eacfbb46.akpm@osdl.org>
From: Dmitriy Monakhov <dmonakhov@sw.ru>
Date: Tue, 12 Dec 2006 16:18:32 +0300
In-Reply-To: <20061212015232.eacfbb46.akpm@osdl.org> (Andrew Morton's message of "Tue, 12 Dec 2006 01:52:32 -0800")
Message-ID: <87psapz1zr.fsf@sw.ru>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Andrew Morton <akpm@osdl.org> writes:

> On Tue, 12 Dec 2006 15:20:52 +0300
> Dmitriy Monakhov <dmonakhov@sw.ru> wrote:
>
>> > XFS (at least) can call generic_file_direct_write() with i_mutex not held. 
>> > And vmtruncate() expects i_mutex to be held.
>> >
>> > I guess a suitable solution would be to push this problem back up to the
>> > callers: let them decide whether to run vmtruncate() and if so, to ensure
>> > that i_mutex is held.
>> >
>> > The existence of generic_file_aio_write_nolock() makes that rather messy
>> > though.
>> This means we may call generic_file_aio_write_nolock() without i_mutex, right?
>> but call trace is :
>>   generic_file_aio_write_nolock() 
>>   ->generic_file_buffered_write() /* i_mutex not held here */ 
>> but according to filemaps locking rules: mm/filemap.c:77
>>  ..
>>  *  ->i_mutex			(generic_file_buffered_write)
>>  *    ->mmap_sem		(fault_in_pages_readable->do_page_fault)
>>  ..
>> I'm confused a litle bit, where is the truth? 
>
> xfs_write() calls generic_file_direct_write() without taking i_mutex for
> O_DIRECT writes.
Yes, but my quastion is about __generic_file_aio_write_nolock().
As i understand _nolock sufix means that i_mutex was already locked 
by caller, am i right ?
If yes, than __generic_file_aio_write_nolock() is beter place for vmtrancate() 
acclivity after generic_file_direct_write() has fail.
Signed-off-by: Dmitriy Monakhov <dmonakhov@openvz.org>
-------

--=-=-=
Content-Disposition: inline; filename=diff-generic-direct-io-write-fix

diff --git a/mm/filemap.c b/mm/filemap.c
index 7b84dc8..723d2ca 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2282,6 +2282,15 @@ __generic_file_aio_write_nolock(struct k
 
 		written = generic_file_direct_write(iocb, iov, &nr_segs, pos,
 							ppos, count, ocount);
+		if (written < 0) {
+			loff_t isize = i_size_read(inode);
+			/*
+			 * generic_file_direct_write() may have instantiated 
+			 * a few blocks outside i_size. Trim these off again.
+			 */
+			if (pos + count > isize)
+				vmtruncate(inode, isize);
+		}
 		if (written < 0 || written == count)
 			goto out;
 		/*

--=-=-=--

