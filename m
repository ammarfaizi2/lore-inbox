Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSIEIHW>; Thu, 5 Sep 2002 04:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSIEIHW>; Thu, 5 Sep 2002 04:07:22 -0400
Received: from holomorphy.com ([66.224.33.161]:58793 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317286AbSIEIHV>;
	Thu, 5 Sep 2002 04:07:21 -0400
Date: Thu, 5 Sep 2002 01:03:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] __write_lock_failed() oops
Message-ID: <20020905080310.GF18800@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After running 64 simultaneous tiobench 256's a few times,
I get the following oops, which I've been seeing intermittently
for a number of 2.5.x releases (since 2.5.x booted on NUMA-Q):


Program received signal SIGSEGV, Segmentation fault.
0xc0106693 in __write_lock_failed () at semaphore.c:176
176     semaphore.c: No such file or directory.
        in semaphore.c

for some reason, I'm unable to get a backtrace:

(gdb) bt
#0  0xc0106693 in __write_lock_failed () at semaphore.c:176
Reply contains invalid hex digit 36

This one's relatively painful to reproduce. My attempts to debug it
have more or less flopped thus far.


(gdb) disassemble __write_lock_failed
Dump of assembler code for function __write_lock_failed:
0xc0106684 <__write_lock_failed>:       lock addl $0x1000000,(%eax)
0xc010668b <__write_lock_failed+7>:     repz nop 
0xc010668d <__write_lock_failed+9>:     cmpl   $0x1000000,(%eax)
0xc0106693 <__write_lock_failed+15>:    
    jne    0xc010668b <__write_lock_failed+7>
0xc0106695 <__write_lock_failed+17>:    lock subl $0x1000000,(%eax)
0xc010669c <__write_lock_failed+24>:    jne    0xc0106684 <__write_lock_failed>
0xc01066a2 <__write_lock_failed+30>:    ret    
0xc01066a3 <__write_lock_failed+31>:    nop    
End of assembler dump.

(gdb) p/x $eax
$3 = 0xc0331ca0
(gdb) p/x *(unsigned long *)$eax
$4 = 0xffffff



Cheers,
Bill
