Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVF0Gwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVF0Gwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVF0Gtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:49:52 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:55931 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261886AbVF0Gnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:43:45 -0400
Message-ID: <42BFA014.9090604@yahoo.com.au>
Date: Mon, 27 Jun 2005 16:43:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: VFS scalability (was: [rfc] lockless pagecache)
References: <42BF9CD1.2030102@yahoo.com.au>
In-Reply-To: <42BF9CD1.2030102@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an interesting aside, when first testing the patch I was
using read(2) instead of nopage faults. I ran into some surprising
results there which I don't have the time to follow up at the
moment - it might be worth investigating if someone has the time,
regardless the state of the lockless pagecache work.

For the parallel workload as described in the parent post (but
read instead of fault), the vanilla kernel profile looks like
this:

  74453 total                                      0.0121
  25839 update_atime                              44.8594
  19595 _read_unlock_irq                         306.1719
  13025 do_generic_mapping_read                    5.5758
   9374 rw_verify_area                            29.2937
   1739 ia64_pal_call_static                       9.0573
   1567 default_idle                               4.0807
   1114 __copy_user                                0.4704
    848 _spin_lock                                 8.8333
    786 ia64_spinlock_contention                   8.1875
    246 ia64_save_scratch_fpregs                   3.8438
    187 ia64_load_scratch_fpregs                   2.9219
     16 file_read_actor                            0.0263
     15 fsys_bubble_down                           0.0586
     12 vfs_read                                   0.0170

This is with the filesystem mounted as noatime, so I can't work
out why update_atime is so high on the list. I suspect maybe a
false sharing issue with some other fields.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
