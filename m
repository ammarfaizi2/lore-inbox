Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWC1U5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWC1U5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWC1U5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:57:30 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:11248 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932158AbWC1U5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:57:30 -0500
Subject: Re: realtime-preempt 2.6.16-rt7-10 bug?
From: Steven Rostedt <rostedt@goodmis.org>
To: "Shayne O'Connor" <machine@machinehasnoagenda.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, ardour-dev@lists.ardour.org
In-Reply-To: <1143559994.2959.5.camel@machine>
References: <1143559994.2959.5.camel@machine>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 15:57:19 -0500
Message-Id: <1143579439.12960.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 02:33 +1100, Shayne O'Connor wrote:
> i've compiled the 2.6.16 kernel with the realtime-preempt patches, but
> have run into some problems while using Ardour for realtime audio.
> Ardour crashes whenever i stop recording, and after running dmesg i'm
> suspecting a bug in the realtime patch (i've tried rt7 and rt10, both
> have the same problem):
> 

Hmm, this may be a bug in Ardour.  Since it's for realtime audio, I
assume that it knows about the timeofday hack, which is the only way to
get this bug.  The user application set itself to be uninterruptible by
calling gettimeofday with the two pointers and the integer 1.  This sets
the task's flag to be uninterruptible (PF_NOSCHED).  But then it did a
write to the file system (ext3) which did a schedule. Thus you got a
BUG.

I've CC'd Ingo and Thomas and added the ardour mailing list to take a
look too.

-- Steve

> ardour:2843 userspace BUG: scheduling in user-atomic context!
>  [<c03731d8>] schedule+0x108/0x130 (8)
>  [<c037320e>] io_schedule+0xe/0x20 (36)
>  [<c016518b>] sync_buffer+0x3b/0x50 (8)
>  [<c0373795>] __wait_on_bit+0x45/0x70 (12)
>  [<c0165150>] sync_buffer+0x0/0x50 (8)
>  [<c0165150>] sync_buffer+0x0/0x50 (12)
>  [<c037383d>] out_of_line_wait_on_bit+0x7d/0x90 (8)
>  [<c012eaf0>] wake_bit_function+0x0/0x60 (24)
>  [<c016804d>] __bread+0x8d/0xc0 (24)
>  [<c01d6c56>] ext3_free_branches+0x96/0x250 (20)
>  [<c01d936a>] ext3_truncate+0x97a/0xa20 (60)
>  [<c011556c>] __wake_up+0x3c/0x70 (20)
>  [<c01e7d79>] journal_start+0x109/0x140 (64)
>  [<c0135ef7>] rt_up+0x27/0x40 (20)
>  [<c01d60d4>] start_transaction+0x24/0x60 (24)
>  [<c01d9506>] ext3_delete_inode+0xf6/0x130 (24)
>  [<c01d9410>] ext3_delete_inode+0x0/0x130 (16)
>  [<c017ea69>] generic_delete_inode+0x69/0x110 (8)
>  [<c0174586>] do_unlinkat+0x116/0x140 (24)
>  [<c0163972>] sys_write+0x72/0x80 (56)
>  [<c0102eff>] sysenter_past_esp+0x54/0x75 (40)
> 
> 
> please CC any comments or requests for more info to me ...


