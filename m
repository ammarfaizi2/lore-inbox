Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTJTR0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 13:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTJTR0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 13:26:23 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:1409 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262719AbTJTR0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 13:26:21 -0400
Date: Mon, 20 Oct 2003 19:26:07 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: VBI capture dying in 2.6.0-test7/8?
Message-ID: <20031020172607.GB26316@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   since kernel update last thursday VBI capture is dying after (at most) 
6 hours of grabbing. Grabbing process looks like if there is no input signal:

t2            S D6EE7E78     0 29539  27884                     (NOTLB)
d6ee7eb0 00000082 c0130a24 d6ee7e78 00942fc6 00000000 00100100 00200200
       00942fc6 1d244b3c 00000246 00000005 d6f66960 00001adf 2031f544 0000091e
       d6fa9960 d8238ef8 00000001 d6ee6000 d8238f58 e299a942 e2aeae94 00000000
Call Trace:
 [<c0130a24>] schedule_timeout+0x9b/0xdf
 [<e299a942>] videobuf_waiton+0x92/0xee [video_buf]
 [<c012029c>] default_wake_function+0x0/0x2e
 [<e299bf5d>] videobuf_read_stream+0xc1/0x382 [video_buf]
 [<e2acf43c>] bttv_reinit_bt848+0x116/0x1cd [bttv]      << stale entry due to large videobuf_read_stream stack?
 [<e2ad2e65>] bttv_read+0xb8/0x13a [bttv]
 [<c016e911>] vfs_read+0xb0/0x119
 [<c016eb8c>] sys_read+0x42/0x63
 [<c0109ba7>] syscall_call+0x7/0xb

When I attempt to attach strace to the process, I get (my program does not handle interrupted
vbi read()):

Process 29539 attached - interrupt to quit
time([1066669984])                      = 1066669984
rt_sigaction(SIGTSTP, {SIG_IGN}, {0x40045530, [], SA_RESTORER|SA_RESTART, 0x40091578}, 8) = 0
poll([{fd=0, events=POLLIN}], 1, 0)     = 0
poll([{fd=0, events=POLLIN}], 1, 0)     = 0
write(1, "\33[2;46H\33[31m\33[40m04:57:06\33[0;10m"..., 144) = 144
rt_sigaction(SIGTSTP, {0x40045530, [], SA_RESTORER|SA_RESTART, 0x40091578}, NULL, 8) = 0
open("ct2", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
write(4, "TTXDATA 1.0\32\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 16) = 16
_llseek(4, 0, [8208], SEEK_CUR)         = 0
close(4)                                = 0
munmap(0x40016000, 4096)                = 0
close(3

t2            D C10524E0     0 29539  26630                     (NOTLB)
d6ee7e80 00000082 00000000 c10524e0 000001ef 00000286 00000000 c10b1c60
       00001000 c10b1c60 00000246 c10b1c60 c9720960 0000293d 0c2f2d29 00001953
       d6fa9960 d8238ef8 00000000 d6ee6000 d8238f58 e299a942 c9720abc 00000000
Call Trace:
 [<e299a942>] videobuf_waiton+0x92/0xee [video_buf]
 [<c012029c>] default_wake_function+0x0/0x2e
 [<c012029c>] default_wake_function+0x0/0x2e
 [<e2adadcc>] bttv_dma_free+0x4a/0x9f [bttv]
 [<e299acf7>] videobuf_queue_cancel+0x10a/0x1c6 [video_buf]
 [<c01303de>] update_process_times+0x46/0x52
 [<e299be4e>] videobuf_read_stop+0x1b/0x69 [video_buf]
 [<e2ad3344>] bttv_release+0xc2/0x138 [bttv]
 [<c016fbc2>] __fput+0xdd/0xef
 [<c016e069>] filp_close+0x59/0x86
 [<c016e181>] sys_close+0xeb/0x1ed
 [<c010fec7>] do_syscall_trace+0x35/0x6a
 [<c0109ba7>] syscall_call+0x7/0xb


and it stops here, forever. FD 3 is /dev/vbi1. Do you have any idea what can be wrong?
Stacktrace suggests that bttv_reinit_bt848 was invoked before thing stopped working,
but here my expertise ends :-( Kernel is UP, with spinlock debugging enabled.
Last kernel known to work correctly is 2.6.0-test5-c1342 from Sep 25th.
								Thanks,
									Petr Vandrovec

