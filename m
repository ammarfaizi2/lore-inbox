Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268087AbUHQDuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268087AbUHQDuv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 23:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUHQDuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 23:50:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:34719 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268087AbUHQDul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 23:50:41 -0400
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David N. Welton" <davidw@dedasys.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <87llgfdqb7.fsf@dedasys.com>
References: <873c2ohjrv.fsf@dedasys.com> <1092569364.9539.16.camel@gaston>
	 <873c2n41hs.fsf@dedasys.com> <1092668911.9539.55.camel@gaston>
	 <87llgfdqb7.fsf@dedasys.com>
Content-Type: text/plain
Message-Id: <1092714140.9539.91.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 13:42:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, I'll try that.  Piddling around myself, I was tracing the crash to
> on or around this code (via-pmu.c:2550):
> 
> 	/* Save & disable L2 and L3 caches*/
> //	save_l3cr = _get_L3CR();	/* (returns -1 if not available) */
> //	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
> /* 	if (save_l3cr != 0xffffffff && (save_l3cr & L3CR_L3E) != 0)
> 		_set_L3CR(save_l3cr & 0x7fffffff);  */
> /* 	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
> 		_set_L2CR(save_l2cr & 0x7fffffff);  */
> 
> commenting it out lets things go to sleep, although they don't seem to
> wake up again.

Yah, you aren't disabling the cache ... I fail to see how flushing &
disabling the L2 would cause a machine check tho, it's really weird.

Yes, try 2.6.7 and let me know.

Ben.

> > Can you get me the actual xmon output and eventually backtrace ?
> > (you can disable the adb sleep code to get the kbd working in xmon)
> 
> that would be adb_notify_sleep?  ... yes, that seems to work ...
> 
> Managed to catch this:
> 
> Oops: machine check, sig: 7 [#1]
> NIP: C025C5D8 LR: C025C768 SP: CD121E50 REGS: cd121da0 TRAP: 0200    Not tainted
> MSR: 02043420 EE: 0 PR: 0 FP: 1 ME: 1 IR/DR: 10
> TASK = cf4b0660[886] 'pmud' THREAD: cd120000Last syscall: 54
> GPR00: FFFFFFFF CD121E50 CF4B0660 39200000 00400000 00000000 FFFFFF10 02003032
> GPR08: 8014C0AC C025C768 00000004 00000000 88044428 1001E214 10010000 10000000
> GPR16: 10000000 10000000 10000000 7FFFFD48 10000000 00000001 46FFFFFF 00000000
> GPR24: FFFFFFFF 00000000 CD121E60 00000000 B9000000 20004200 FFFFFFE7 C0260000
> NIP [c025c5d8] 0xc025c5d8
> LR [c025c768] 0xc025c768
> Call trace:
>  [c025cf34] 0xc025cf34
>  [c006e0e0] sys_ioctl+0xdc/0x2f4
>  [c0005f40] ret_from_syscall+0x0/0x44
> 
> So it's just getting the ioctcl and going into sleep_Core99.
> 
> The instructions around C025C5D8 look like:
> 
> 
> c025c584:       48 00 9c 8d     bl      c0266210 <pmu_request>
> c025c588:       7f 43 d3 78     mr      r3,r26
> c025c58c:       48 00 9e 51     bl      c02663dc <pmu_wait_complete>
> c025c590:       4b db 0e e1     bl      c000d470 <_get_L3CR>
> c025c594:       7c 7b 1b 78     mr      r27,r3
> c025c598:       7c 78 18 f8     not     r24,r3
> c025c59c:       57 77 0f fe     rlwinm  r23,r27,1,31,31
> c025c5a0:       4b db 0d d1     bl      c000d370 <_get_L2CR>
> c025c5a4:       31 38 ff ff     addic   r9,r24,-1
> c025c5a8:       7c 09 c1 10     subfe   r0,r9,r24
> c025c5ac:       7c 7c 1b 78     mr      r28,r3
> c025c5b0:       7c 09 b8 39     and.    r9,r0,r23
> c025c5b4:       40 82 01 b8     bne-    c025c76c <powerbook_sleep_Core99+0x298>
> c025c5b8:       7f 96 e0 f8     not     r22,r28
> c025c5bc:       57 95 0f fe     rlwinm  r21,r28,1,31,31
> c025c5c0:       31 36 ff ff     addic   r9,r22,-1
> c025c5c4:       7c 09 b1 10     subfe   r0,r9,r22
> c025c5c8:       7c 09 a8 39     and.    r9,r0,r21
> c025c5cc:       40 82 01 94     bne-    c025c760 <powerbook_sleep_Core99+0x28c>
> c025c5d0:       3f e0 c0 26     lis     r31,-16346
> c025c5d4:       80 1f 78 c4     lwz     r0,30916(r31)
> c025c5d8:       2c 00 00 00     cmpwi   r0,0
> c025c5dc:       41 82 01 54     beq-    c025c730 <powerbook_sleep_Core99+0x25c>
> c025c5e0:       3f 20 c0 27     lis     r25,-16345
> c025c5e4:       4b ff f8 91     bl      c025be74 <save_via_state>
> c025c5e8:       39 39 93 54     addi    r9,r25,-27820
> c025c5ec:       80 09 00 94     lwz     r0,148(r9)
> c025c5f0:       2c 00 00 00     cmpwi   r0,0
> c025c5f4:       40 82 01 1c     bne-    c025c710 <powerbook_sleep_Core99+0x23c>
> c025c5f8:       80 1f 78 c4     lwz     r0,30916(r31)
> c025c5fc:       2c 00 00 00     cmpwi   r0,0
> c025c600:       41 82 01 08     beq-    c025c708 <powerbook_sleep_Core99+0x234>
> c025c604:       3f c0 01 21     lis     r30,289
> c025c608:       3b e0 13 87     li      r31,4999
> c025c60c:       3f a0 c0 23     lis     r29,-16349
> c025c610:       63 de ea c0     ori     r30,r30,60096
> 
> I don't have too many ideas.  If it's useful, I suppose I can try
> backing of to 2.6.7 to see if it suffers from the same problem...
> 
> Thankyou,
> --
> David N. Welton
>      Personal: http://www.dedasys.com/davidw/
> Free Software: http://www.dedasys.com/freesoftware/
>    Apache Tcl: http://tcl.apache.org/
>        Photos: http://www.dedasys.com/photos/
> 
> ** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

