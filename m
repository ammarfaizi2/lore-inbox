Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVANSkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVANSkm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVANSkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:40:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52934 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261286AbVANSka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:40:30 -0500
Message-ID: <002901c4fa68$7266a990$6900a8c0@comcast.net>
From: "John Hawkes" <hawkes@sgi.com>
To: "Robert Love" <rml@novell.com>
Cc: "John McCutchan" <ttb@tentacle.dhs.org>,
       "John Hawkes" <hawkes@tomahawk.engr.sgi.com>,
       <linux-kernel@vger.kernel.org>
References: <200501132356.j0DNujUY016224@tomahawk.engr.sgi.com> <1105663758.6027.215.camel@localhost>  <1105666283.15782.2.camel@vertex> <1105669742.6027.243.camel@localhost> <002301c4fa63$9d9d3b10$6900a8c0@comcast.net> <1105726549.6027.268.camel@localhost>
Subject: Re: 2.6.10-mm3 scaling problem with inotify
Date: Fri, 14 Jan 2005 10:39:56 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Robert Love" <rml@novell.com>
> On Fri, 2005-01-14 at 10:05 -0800, John Hawkes wrote:
>
> > The patch shows a substantial 4x improvement for my specific workload
(@64p),
> > although I can still envision workloads that will stimulate high spinlock
> > contention from spin_lock(&dentry->d_lock).  First things first -- let's
get
> > this fix into the -mm tree.  Thanks!
>
> Glad it worked!
>
> Does the spin_lock() show up in dnotify's code path?  It is getting
> called, unconditionally, there, too.

No, it doesn't show up (with this workload).
Lock contention and cacheline contention can be complex.  Contention in one
area can alter the timing of other areas and reduce contention.  Anyway, with
your inotify_dentry_parent_queue_event() patch, the PC sampling for my
workload is now (with the lock waits getting rolled up to the callers) for
everything above 0.1% is:

 12:38pm  Samples: 1887402, Mode: pc,  load average: 1832.89, 1722.88, 1264.14

     COUNT (  % )     ADDR NAME
    843466 (44.7) a000000100147ba0 vma_adjust
    521940 (27.7) a0000001001131a0 USER
    278285 (14.7) a000000100150d20 anon_vma_unlink
     26952 ( 1.4) a000000100150ba0 anon_vma_link
     26099 ( 1.4) a00000010013c1e0 clear_page_range
     16638 ( 0.9) a0000001007473e0 established_get_next
     12378 ( 0.7) a00000010044b200 _mcount
     12150 ( 0.6) a000000100039d20 ia64_brk
     10237 ( 0.5) a00000010013dba0 zap_pte_range
      9886 ( 0.5) a00000010044aba0 copy_page
      9311 ( 0.5) a00000010013cfe0 copy_pte_range
      8239 ( 0.4) a00000010014bcc0 do_munmap
      5014 ( 0.3) a0000001001c1340 update_atime
      4743 ( 0.3) a00000010044b300 __copy_user
      4462 ( 0.2) a0000001004dc360 inotify_dentry_parent_queue_event
      4439 ( 0.2) a000000100115020 find_get_page
      3602 ( 0.2) a0000001000b0e40 copy_mm
      3581 ( 0.2) a0000001000d3d80 del_timer_sync
      2951 ( 0.2) a0000001001720e0 vfs_read

John Hawkes

