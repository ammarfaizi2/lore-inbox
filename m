Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284163AbRLKWfJ>; Tue, 11 Dec 2001 17:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284153AbRLKWfA>; Tue, 11 Dec 2001 17:35:00 -0500
Received: from inje.iskon.hr ([213.191.128.16]:34483 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S284143AbRLKWeq>;
	Tue, 11 Dec 2001 17:34:46 -0500
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 writeback mode slower than ordered mode?
In-Reply-To: <871yi5wh93.fsf@atlas.iskon.hr> <3C12C57C.FF93FAC0@zip.com.au>
	<877krwch39.fsf@atlas.iskon.hr> <20011210181809.J1919@redhat.com>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 11 Dec 2001 23:31:22 +0100
In-Reply-To: <20011210181809.J1919@redhat.com> ("Stephen C. Tweedie"'s message of "Mon, 10 Dec 2001 18:18:09 +0000")
Message-ID: <874rmx2xtx.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> writes:

> Hi,
> 
> On Sun, Dec 09, 2001 at 08:46:02PM +0100, Zlatko Calusic wrote:
> 
> > To sumarize:
> > 
> > ext2            0.01s user 1.86s system 98% cpu 1.893 total
> > ext3/ordered    0.07s user 3.50s system 99% cpu 3.594 total
> > ext3/writeback  0.00s user 6.05s system 98% cpu 6.129 total
> > 
> > What is strange is that not always I've been able to get different
> > results for writeback case (comparing to ordered), but when I get it,
> > it is repeatable.
> 
> So it could be something as basic as disk layout or allocation
> pattern.  Hmm.

Hm, I'm not that sure about disk layout, as nothing actually hits the
disk platter in these tests, but the latter reason is possible.

> 
> Could you profile the kernel and see where writeback is spending all
> the time, in that case?

I have made a simple test and collected kernel profiling data. The
test consists of repetitive writing of a 100MB file (on a 768MB
machine) and immediately deleting it after the write is finished. In a
loop, 100 times.

ordered:

 51611 total                                      0.0392
 34550 default_idle                             664.4231
  4941 generic_file_write                         3.0575
   741 journal_dirty_metadata                     1.9500
   727 get_hash_table                             4.5438
   566 journal_add_journal_head                   2.2109
   561 do_get_write_access                        0.4510
   514 journal_get_write_access                   5.5870
   371 journal_cancel_revoke                      2.0163
   368 ext3_do_update_inode                       0.4000
   323 journal_unlock_journal_head                2.9907
   311 ext3_new_block                             0.1747
   293 rmqueue                                    0.6315
   272 ext3_get_inode_loc                         0.7234
   192 handle_IRQ_event                           1.5484
   182 __brelse                                   5.6875
   175 ext3_get_block_handle                      0.2701
   174 kmem_cache_alloc                           0.6493
   161 ext3_commit_write                          0.3073
   147 journal_flushpage                          0.5176


writeback:

 53652 total                                      0.0407
 23781 default_idle                             457.3269
  4700 generic_file_write                         2.9084
  2429 get_hash_table                            15.1813
  2026 journal_dirty_metadata                     5.3316
  1423 do_get_write_access                        1.1439
  1348 journal_get_write_access                  14.6522
  1056 journal_cancel_revoke                      5.7391
  1025 journal_add_journal_head                   4.0039
   869 ext3_new_block                             0.4882
   807 journal_unlock_journal_head                7.4722
   755 ext3_do_update_inode                       0.8207
   580 ext3_get_inode_loc                         1.5426
   572 ext3_get_block_handle                      0.8827
   454 __brelse                                  14.1875
   347 journal_flushpage                          1.2218
   329 rmqueue                                    0.7091
   317 ext3_mark_iloc_dirty                       4.4028
   315 do_generic_file_read                       0.2853
   308 unlock_buffer                              4.8125


Notice how the numbers for the writeback case are much bigger. But,
strange thing is that the total time hasn't changed?! So my program
reports half the throughput and profile numbers are much bigger for
the writeback case, but in both cases tests finish in about the same
time. Tell me I'm not goin' nuts?!

Yes, I have reseted the profile counter correctly between the
runs. Also, if I change to another writeback mounted partition (on the
same disk, nearby) it behaves normally (similar numbers as on the
ordered mounted one). Why is my /tmp so special? :)

***

And now, something completely different. When mounted in ordered mode,
and doing the test above (writing & deleting), kernel leaks memory. In
fact, such memory can be easily recovered, but still, such behaviour
makes unwanted memory pressure, forces stuff to disk too early and
even produces some swapping. Every time a file of 100MB was written
and unlinked immediately afterwards (before FS had a chance to commit
it to disk) ~100MB of memory stayed allocated. Looks like buffer heads
which are pinning page cache pages, but as I deleted a file, shouldn't
that memory be freed? Another writing and there goes another 100MB of
RAM...

This is how things looked just before the test (most of the memory free)

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0  50124 516816  40220  53356   0   0     0    60 1696   949   0   3  96


and after the test (memory gone)


   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0  58888  99988  11608  35008   0   0     0    60 1546   924   0   1  99

/proc/slabinfo (the only suspicious entry)
buffer_head       134513 159440     96 3543 3986    1 :  252  126

I remind, that only happens when the partition is mounted in the
ordered mode.


OK, I know this is all confusing, but I'm just trying to help weed
bugs and maybe understand a thing or two about the ext3. :)

Regards,
-- 
Zlatko
