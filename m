Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbWF3XwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWF3XwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 19:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWF3XwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 19:52:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932565AbWF3XwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 19:52:12 -0400
Date: Fri, 30 Jun 2006 16:55:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm one process gets stuck in infinite loop in the
 kernel.
Message-Id: <20060630165532.5eadf286.akpm@osdl.org>
In-Reply-To: <20060630215405.GA9744@aitel.hist.no>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<44A3B8A0.4070601@aitel.hist.no>
	<20060629104117.e96df3da.akpm@osdl.org>
	<20060630215405.GA9744@aitel.hist.no>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> On Thu, Jun 29, 2006 at 10:41:17AM -0700, Andrew Morton wrote:
> > On Thu, 29 Jun 2006 13:25:20 +0200
> > Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> > 
> > > I have seen this both with mm2, m33 and mm4.
> > > Suddenly, the load meter jumps.
> > > Using ps & top, I see one process using 100% cpu.
> > > This is always a process that was exiting, this tend to happen
> > > when I close applications, or doing debian upgrades which
> > > runs lots of short-lived processes.
> > > 
> > > I believe it is running in the kernel, ps lists it with stat "RN"
> > > and it cannot be killed, not even with kill -9 from root.
> > > 
> > > Something wrong with process termination?
> > > 
> > 
> > Please generate a kernel profile when it happens so we can see
> > where it got stuck.
> > 
> > <boot with profile=1>
> > <wait for it to happen>
> > readprofile -r
> > sleep 10
> > readprofile -n -v -m /boot/System.map | sort -n -k 3 | tail -40
> 
> It was easier to reproduce on my home machine, running mm2.
> I followed the recipe above, except typing manually means
> the wait was more than 10s.
> 
> Output from the pipe above:
> ffffffff801f9050 do_get_write_access                          210,0170
> ffffffff80111c20 __do_softirq                                 280,1591
> ffffffff8012e0e0 vm_stat_account                              280,2917
> ffffffff80194890 search_exception_tables                      491,5312
> ffffffff801f1380 ext3_journal_start_sb                        821,0250
> ffffffff801fd670 __log_space_left                             892,7812
> ffffffff8010bf50 __wake_up_bit                               1252,6042
> ffffffff8010c2f0 put_page                                    1412,9375
> ffffffff8010dd30 mark_page_accessed                          1732,1625
> ffffffff801a3340 __filemap_copy_from_user_iovec_inatomic     1951,7411
> ffffffff801643f0 cond_resched                                2001,5625
> ffffffff8015f241 error_exit                                  2431,8409
> ffffffff801a5dd0 balance_dirty_pages_ratelimited_nr          2580,5375
> ffffffff801f9aa0 journal_start                               3211,0559
> ffffffff8011ac00 page_waitqueue                              3813,9688
> ffffffff80139ea0 generic_commit_write                        4254,4271
> ffffffff80117500 __block_commit_write                        4902,3558
> ffffffff8010b320 __down_read_trylock                         50210,4583
> ffffffff8013d100 block_prepare_write                         57712,0208
> ffffffff80121800 __up_read                                   5833,3125
> ffffffff80117bc0 unlock_page                                 69214,4167
> ffffffff801fd710 journal_blocks_per_page                     83426,0625
> ffffffff8012e0c0 __wake_up                                   89427,9375
> ffffffff80109d70 kmem_cache_alloc                           112617,5938
> ffffffff801e78b0 walk_page_buffers                          12657,1875
> ffffffff801ea920 ext3_ordered_commit_write                  13525,2812
> ffffffff801074c0 kmem_cache_free                            15807,5962
> ffffffff801f11e0 __ext3_journal_stop                        169617,6667
> ffffffff801f96b0 start_this_handle                          18711,8562
> ffffffff801f8e50 journal_stop                               19063,7227
> ffffffff801eacf0 ext3_prepare_write                         19915,9256
> ffffffff80113440 find_lock_page                             205314,2569
> ffffffff8010f690 generic_file_buffered_write                21391,2612
> ffffffff8010deb0 __block_prepare_write                      22841,9291
> ffffffff801e85c0 ext3_writepage_trans_blocks                279919,4375
> ffffffff80166356 bad_gs                                     33520,4129
> ffffffff80179070 search_extable                             386834,5357
> ffffffff8010b400 find_vma                                   420137,5089
> ffffffff8010a180 do_page_fault                             107535,1302
> 0000000000000000 total                                     516580,0124


Oh.  This is probably the generic_file_buffer_write() hang, due to
zero-length iovec segments.

If so, the below should fix it up.

The presence of do_page_fault() in that trace is interesting.  At a guess,
I'd say that userspace is passing in a bad iovec.iov_base as well as
iovec.iov_len=0, and the kernel's copy_from_user() implementation is
needlessly dereferencing the pointer, getting a fault, then seeing that it
didn't need to copy anything anyway.  hmm.


diff -puN mm/filemap.c~generic_file_buffered_write-handle-zero-length-iovec-segments-stable mm/filemap.c
--- a/mm/filemap.c~generic_file_buffered_write-handle-zero-length-iovec-segments-stable
+++ a/mm/filemap.c
@@ -2125,6 +2125,12 @@ generic_file_buffered_write(struct kiocb
 			break;
 		}
 
+		if (unlikely(bytes == 0)) {
+			status = 0;
+			copied = 0;
+			goto zero_length_segment;
+		}
+
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
 			loff_t isize = i_size_read(inode);
@@ -2154,7 +2160,8 @@ generic_file_buffered_write(struct kiocb
 			page_cache_release(page);
 			continue;
 		}
-		if (likely(copied > 0)) {
+zero_length_segment:
+		if (likely(copied >= 0)) {
 			if (!status)
 				status = copied;
 
diff -puN mm/filemap.h~generic_file_buffered_write-handle-zero-length-iovec-segments-stable mm/filemap.h
--- a/mm/filemap.h~generic_file_buffered_write-handle-zero-length-iovec-segments-stable
+++ a/mm/filemap.h
@@ -88,7 +88,7 @@ filemap_set_next_iovec(const struct iove
 	const struct iovec *iov = *iovp;
 	size_t base = *basep;
 
-	while (bytes) {
+	do {
 		int copy = min(bytes, iov->iov_len - base);
 
 		bytes -= copy;
@@ -97,7 +97,7 @@ filemap_set_next_iovec(const struct iove
 			iov++;
 			base = 0;
 		}
-	}
+	} while (bytes);
 	*iovp = iov;
 	*basep = base;
 }
_


