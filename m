Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbRLCIvz>; Mon, 3 Dec 2001 03:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281836AbRLCIsq>; Mon, 3 Dec 2001 03:48:46 -0500
Received: from holomorphy.com ([216.36.33.161]:17536 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S284584AbRLCBe1>;
	Sun, 2 Dec 2001 20:34:27 -0500
Date: Sun, 2 Dec 2001 17:34:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] wait_for_devfsd_finished deadlock
Message-ID: <20011202173408.A866@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011201191113.A1034@holomorphy.com> <200112021901.fB2J1wM11465@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200112021901.fB2J1wM11465@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sun, Dec 02, 2001 at 12:01:58PM -0700
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2001 at 12:01:58PM -0700, Richard Gooch wrote:
> Your sh process appears to be hung in wait_for_devfsd_finished(). It
> would be helpful to know what devfsd was doing at this time. If it
> were hung internally (in user-space), it would account for this
> behaviour. However, if devfsd crashes, then devfsd_close() will be
> called, which will wake any waiters.

A oops trace from quite a bit further back in my logs makes this
appear to be an instance of an already reported problem. I apologize
for overlooking this detail in my prior post:

Dec  1 16:49:11 holomorphy kernel:  printing eip:
Dec  1 16:49:11 holomorphy kernel: c016536d
Dec  1 16:49:11 holomorphy kernel: Oops: 0002
Dec  1 16:49:11 holomorphy kernel: CPU:    0
Dec  1 16:49:11 holomorphy kernel: EIP:    0010:[devfs_put+13/192]    Not tainte
d
Dec  1 16:49:11 holomorphy kernel: EFLAGS: 00010206
Dec  1 16:49:11 holomorphy kernel: eax: 5a5a5a5a   ebx: 5a5a5a5a   ecx: 00000002
   edx: 5a5a5a5a
Dec  1 16:49:11 holomorphy kernel: esi: 00000000   edi: 00000026   ebp: 00000000
   esp: ef785f40
Dec  1 16:49:11 holomorphy kernel: ds: 0018   es: 0018   ss: 0018
Dec  1 16:49:11 holomorphy kernel: Process devfsd (pid: 20, stackpage=ef785000)
Dec  1 16:49:12 holomorphy kernel: Stack: 00000026 c01680dc 5a5a5a5a c1ca8d74 ffffffea 00000000 00000420 c1cc4800 
Dec  1 16:49:12 holomorphy kernel:        c02a2a00 ef653308 5a5a5a5a 000003fa 00
000000 00000000 00000001 00000000 
Dec  1 16:49:12 holomorphy kernel:        ef784000 00000000 00000000 00000000 ef
784000 c02a2a2c c02a2a2c c0130bd6 
Dec  1 16:49:12 holomorphy kernel: Call Trace: [devfsd_read+860/992] [sys_read+1
50/208] [system_call+51/56] 
Dec  1 16:49:12 holomorphy kernel: 
Dec  1 16:49:12 holomorphy kernel: Code: ff 4b 04 0f 94 c0 84 c0 0f 84 9d 00 00 
00 3b 1d d8 1b 30 c0 


On Sun, Dec 02, 2001 at 12:01:58PM -0700, Richard Gooch wrote:
> Are these related?
> cron		->	pipe_wait()
> procmail	->	interruptible_sleep_on_locked()
> exim		->	sys_wait4()

> Maybe these are just waiting on mutt(1)?

I don't believe so. In my configuration, exim delivers to a file
through a procmail pipe, and to the best of my knowledge, mutt does
little more than monitor the files with poll or select, which should
not interfere with the completion of their operations. cron should be
entirely unrelated, as no mail-related activities are scheduled with it.

I suspect in the case I reported, the destruction of the devfsd thread
is responsible for the deadlocks.



Thanks,
Bill
