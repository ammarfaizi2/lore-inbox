Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311702AbSCNSPr>; Thu, 14 Mar 2002 13:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311706AbSCNSPi>; Thu, 14 Mar 2002 13:15:38 -0500
Received: from elin.scali.no ([62.70.89.10]:26639 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S311702AbSCNSPa>;
	Thu, 14 Mar 2002 13:15:30 -0500
Date: Thu, 14 Mar 2002 17:37:56 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
To: <linux-kernel-owner@vger.kernel.org>
Subject: Tyan Tiger 2466 (760MPX) locks up
Message-ID: <Pine.LNX.4.30.0203141722460.18803-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list readers,

In our lab we have two Tyan Tiger 2466 760MPX boards with a dual Athlon MP
1900 setup. Sometimes running a module with heavy locking in kernel mode
results in machine lockup. I've enabled the kernel with KDB, and it looks
like one CPU is hanging forever in flush_tlb_others() and the other is
waiting to acquire a spinlock. Here are some backtraces and instruction
dumps :

0]kdb> cpu 0

Entering kdb (current=0xc8472000, pid 2590) on processor 0 due to cpu switch
[0]kdb> bt
    EBP       EIP         Function(args)
0xc8473e58 0xc0113510 flush_tlb_others+0x80 (0x2, 0xc79c5b00, 0xffffffff, 0x8400000)
                               kernel .text 0xc0100000 0xc0113490 0xc0113540
0xc8473e70 0xc01135da flush_tlb_mm+0x5a (0xc79c5b00, 0xdf0b8340, 0xc79c5b00, 0x805a000, 0x8f000)
                               kernel .text 0xc0100000 0xc0113580 0xc01135f0
0xc8473ec4 0xc01278b6 zap_page_range+0x316 (0xc79c5b00, 0x805a000, 0x8f000, 0xc79c5b00, 0xc79c5b00)
                               kernel .text 0xc0100000 0xc01275a0 0xc0127910
0xc8473eec 0xc0129f4a exit_mmap+0xca (0xc79c5b00, 0xc8472000)
                               kernel .text 0xc0100000 0xc0129e80 0xc0129fa0
0xc8473efc 0xc011819e mmput+0x4e (0xc79c5b00, 0x2, 0xc8472000, 0xc8472000)
                               kernel .text 0xc0100000 0xc0118150 0xc01181c0
0xc8473f14 0xc011cb81 do_exit+0xc1 (0x2, 0xc8472000, 0x0, 0x4, 0x2)
                               kernel .text 0xc0100000 0xc011cac0 0xc011cd10
0xc8473fbc 0xc0107051 do_signal+0x231 (0x9, 0xbffff9e8, 0x200, 0x0, 0x4)
                               kernel .text 0xc0100000 0xc0106e20 0xc0107100
           0xc010724c signal_return+0x14
                               kernel .text 0xc0100000 0xc0107238 0xc0107250

[0]kdb> id flush_tlb_others+0x80
0xc0113510 flush_tlb_others+0x80:       mov    0xc03a02bc,%eax
0xc0113515 flush_tlb_others+0x85:       test   %eax,%eax
0xc0113517 flush_tlb_others+0x87:       jne    0xc0113510 flush_tlb_others+0x80:
0xc0113519 flush_tlb_others+0x89:       movl   $0x0,0xc03a02c0
0xc0113523 flush_tlb_others+0x93:       movl   $0x0,0xc03a02c4
0xc011352d flush_tlb_others+0x9d:       movb   $0x1,0xc033a820
0xc0113534 flush_tlb_others+0xa4:       mov    %ebp,%esp
0xc0113536 flush_tlb_others+0xa6:       pop    %ebp
0xc0113537 flush_tlb_others+0xa7:       ret
0xc0113538 flush_tlb_others+0xa8:       nop
0xc0113539 flush_tlb_others+0xa9:       lea    0x0(%esi,1),%esi
0xc0113540 flush_tlb_current_task:      push   %ebp
0xc0113541 flush_tlb_current_task+0x1:  mov    %esp,%ebp
0xc0113543 flush_tlb_current_task+0x3:  mov    $0xffffe000,%eax
0xc0113548 flush_tlb_current_task+0x8:  and    %esp,%eax
0xc011354a flush_tlb_current_task+0xa:  mov    $0xfffffffe,%edx

[0]kdb> id 0xc03a02bc
0xc03a02bc flush_cpumask:       add    (%eax),%al

[0]kdb> md 0xc03a02bc
0xc03a02bc 00000002 c79c5b00 ffffffff c7511e18   .....[.Çÿÿÿÿ..QÇ
0xc03a02cc 00000000 00000000 00000000 00000000   ................
0xc03a02dc 00000000 00000000 00000000 00000000   ................
0xc03a02ec 00000000 00000000 00000000 00000000   ................
0xc03a02fc 00000000 02060206 00010101 00000001   ................
0xc03a030c 0383fbff c1cbfbff 00000000 00000000   ÿû..ÿûËÁ........
0xc03a031c 68747541 69746e65 444d4163 00000000   AuthenticAMD....
0xc03a032c 20444d41 6c687441 74286e6f 4d20296d   AMD Athlon(tm) M

[0]kdb> cpu 1

Entering kdb (current=0xc7326000, pid 1831) on processor 1 due to cpu switch
[1]kdb> bt
    EBP       EIP         Function(args)
           0xe091ad04 [ssci].text.lock+0x4
                               ssci .text.lock 0xe091ad00 0xe091ad00 0xe091ad30
0xc7327f44 0xe0915e2e [ssci]KalAcquireFastMutex+0x2e (0xc83d0b00, 0xc831bb80, 0x0, 0xc82a2800, 0xe0915eda)
                               ssci .text 0xe08fa060 0xe0915e00 0xe0915e90
0xc7327f84 0xe093d7f2 [scimac]scimac_ch_sendq+0x22 (0xc831bb80, 0xce0e9780, 0x0)
                               scimac .text 0xe093a060 0xe093d7d0 0xe093db80
0xc7327f98 0xe0942d96 [scimac]ppa_check_senders+0x2a (0xc831bb80, 0xc831b580, 0xc19265c0, 0xc732633a, 0xc7326000)
                               scimac .text 0xe093a060 0xe0942d6c 0xe0942de4
0xc7327fbc 0xe0942e4f [scimac]scimac_checkqueues+0x6b (0xc82a2800, 0xe0935120, 0xc7327fec, 0xe0948c76, 0xce4177ca)
                               scimac .text 0xe093a060 0xe0942de4 0xe0942e6c
0xc7327fec 0xe094890f [scimac]scimac_thread+0x13f
                               scimac .text 0xe093a060 0xe09487d0 0xe0948980
           0xc01058b3 kernel_thread+0x23
                               kernel .text 0xc0100000 0xc0105890 0xc01058d0


[1]kdb> id KalAcquireFastMutex+0x2e
0xe0915e2e KalAcquireFastMutex+0x2e:    lock decb 0x4(%ebx)
0xe0915e32 KalAcquireFastMutex+0x32:    js     0xe091ad00 .text.lock:
0xe0915e38 KalAcquireFastMutex+0x38:    mov    %eax,(%ebx)
0xe0915e3a KalAcquireFastMutex+0x3a:    mov    0x8(%ebx),%edx
0xe0915e3d KalAcquireFastMutex+0x3d:    test   %edx,%edx
0xe0915e3f KalAcquireFastMutex+0x3f:    je     0xe0915e59 KalAcquireFastMutex+0x59:
0xe0915e41 KalAcquireFastMutex+0x41:    mov    0xe0935120,%eax
0xe0915e46 KalAcquireFastMutex+0x46:    push   %eax
0xe0915e47 KalAcquireFastMutex+0x47:    push   %esi
0xe0915e48 KalAcquireFastMutex+0x48:    push   %edx
0xe0915e49 KalAcquireFastMutex+0x49:    push   $0xe09351a0
0xe0915e4e KalAcquireFastMutex+0x4e:    call   0xe09157b0 warn:
0xe0915e53 KalAcquireFastMutex+0x53:    mov    0x8(%ebx),%edx
0xe0915e56 KalAcquireFastMutex+0x56:    add    $0x10,%esp
0xe0915e59 KalAcquireFastMutex+0x59:    test   %edx,%edx
0xe0915e5b KalAcquireFastMutex+0x5b:    je     0xe0915e77
KalAcquireFastMutex+0x77:
[1]kdb> id 0xe091ad00
0xe091ad00 .text.lock:  cmpb   $0x0,0x4(%ebx)
0xe091ad04 .text.lock+0x4:      repz nop
0xe091ad06 .text.lock+0x6:      jle    0xe091ad00 .text.lock:
0xe091ad08 .text.lock+0x8:      jmp    0xe0915e2e KalAcquireFastMutex+0x2e:
0xe091ad0d .text.lock+0xd:      cmpb   $0x0,(%eax)
0xe091ad10 .text.lock+0x10:     repz nop
0xe091ad12 .text.lock+0x12:     jle    0xe091ad0d .text.lock+0xd:
0xe091ad14 .text.lock+0x14:     jmp    0xe0915f56 KalAcquireMutex+0x6:
0xe091ad19 .text.lock+0x19:     call   0xc0106088 __write_lock_failed:
0xe091ad1e .text.lock+0x1e:     jmp    0xe0916648 kal_rwlock_lock+0x28:
0xe091ad23 .text.lock+0x23:     call   0xc01060a4 __read_lock_failed:
0xe091ad28 .text.lock+0x28:     jmp    0xe091666c kal_rwlock_lock+0x4c:


I'm currently running these boxes with MPS 1.4 support enabled. Is it an
idea to disable it ? It seems to me that CPU 0 is waiting for CPU 1 to
finish the TLB flush ?

Regards,
 --
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency


