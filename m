Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130033AbQJIX5A>; Mon, 9 Oct 2000 19:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129177AbQJIX4u>; Mon, 9 Oct 2000 19:56:50 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:19494 "EHLO deliverator.sgi.com") by vger.kernel.org with ESMTP id <S129090AbQJIX43>; Mon, 9 Oct 2000 19:56:29 -0400
Message-ID: <39E2583C.120DB42C@sgi.com>
Date: Mon, 09 Oct 2000 16:43:56 -0700
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: sct@redhat.com, mingo@elte.hu
Subject: kmap_high/flush_tlb_all/smp_call_function problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are running some fairly intensive tests with XFS
and with HIGHMEM on an X86 machine with 4G of memory and
4 cpus. The linux-kernel version is test8. The code
also contains Stephen Tweedie's highmem-kiobuf.

What we see is that after a while of running,
smp_call_function getting stuck in the loop below:

---------- arch/i386/kernel/smp.c -----------
    463         /* Wait for response */
    464         while (atomic_read(&data.started) != cpus)
    465                 barrier();
---------------------------------------------

The cpu is stuck because the number of cpus which have
joined the barrier is not 3 (n-1 == 4-1 == 3) ... this
smells of a race. As can be seen below, all the cpus are fine,
and in fact have responded to the IPI which kdb generated
subsequent to the NMI watchdog ...

The kdb stack trace on the stuck cpu (cpu 0) is as follows.
The other cpus are stuck on the kmap_lock. The system
got into kdb because of the NMI watchdog kicking-in on
cpu 1 because of the long wait on the kmap_lock.
Are there any known problems being pursued w.r.t
flush_tlb_all/kmap_high? If you need any more info, please
let me know.

Backtraces:
---------------------------------------------
[0]kdb> bt
    EBP       EIP         Function(args)
           0xc0278abd stext_lock+0x1955
                               kernel .text.lock 0xc0277168 0xc0277168 0xc027dac0
0xe3571eb4 0xc013350b kmap_high+0xb (0x2a2, 0xc324f978, 0x2a2)
                               kernel .text 0xc0100000 0xc0133500 0xc0133674
0xe3571ef4 0xc0137e88 __block_prepare_write+0x5c (0xe9629820, 0xc324f978, 0x2a2, 0x2fc,
0xc0156a4c)
                               kernel .text 0xc0100000 0xc0137e2c 0xc013803c
0xe3571f18 0xc01386c1 block_prepare_write+0x21 (0xc324f978, 0x2a2, 0x2fc, 0xc0156a4c)
                               kernel .text 0xc0100000 0xc01386a0 0xc0138724
0xe3571f30 0xc0157189 ext2_prepare_write+0x19 (0xf69618c0, 0xc324f978, 0x2a2, 0x2fc, 0xf69618c0)
                               kernel .text 0xc0100000 0xc0157170 0xc0157190
0xe3571f98 0xc012c461 generic_file_write+0x2b9 (0xf69618c0, 0x40019000, 0x5a, 0xf69618e0,
0xe3570000)
                               kernel .text 0xc0100000 0xc012c1a8 0xc012c5c0
0xe3571fbc 0xc0135658 sys_write+0x98 (0x6f, 0x40019000, 0x5a, 0x5a, 0x40019000)
                               kernel .text 0xc0100000 0xc01355c0 0xc0135670
           0xc010a77b system_call+0x33
                               kernel .text 0xc0100000 0xc010a748 0xc010a780
[0]kdb> 
[0]kdb> cpu 1

Entering kdb (current=0xe15f4000, pid 8178) on processor 1 due to cpu switch
[1]kdb> bt
    EBP       EIP         Function(args)
           0xc0278add stext_lock+0x1975
                               kernel .text.lock 0xc0277168 0xc0277168 0xc027dac0
0xe15f5cd8 0xc0133679 kunmap_high+0x5
                               kernel .text 0xc0100000 0xc0133674 0xc0133710
0xe15f5d00 0xc0166472 _pagebuf_handle_iovecs+0x2b2 (0xe15f5ee0, 0xc314c754, 0x1000, 0x31000,
0x0)
                               kernel .text 0xc0100000 0xc01661c0 0xc016648c
0xe15f5d2c 0xc01664b2 _pagebuf_iomove_apply+0x26 (0xe15f5ee0, 0xd9493540, 0x31000, 0x0,
0xc314c754)
                               kernel .text 0xc0100000 0xc016648c 0xc01664bc
0xe15f5d90 0xc01657c4 pagebuf_segment_apply+0x234 (0xc016648c, 0xe15f5ee0, 0xd9493540, 0x0,
0x20000)
                               kernel .text 0xc0100000 0xc0165590 0xc016581c
0xe15f5dbc 0xc01667ad _pb_buffered_read+0xed (0xe0e19860, 0x30000, 0x0, 0x10000, 0xe15f5e30)
                               kernel .text 0xc0100000 0xc01666c0 0xc01667c4
0xe15f5e4c 0xc0166b61 pagebuf_file_read+0x225 (0xe218dce0, 0xe15f5ee0, 0xe16d5304, 0x1,
0xe0e19860)
                               kernel .text 0xc0100000 0xc016693c 0xc0166c08
0xe15f5e74 0xc01c0a12 linvfs_file_read+0x32 (0xe218dce0, 0xe15f5ee0)
                               kernel .text 0xc0100000 0xc01c09e0 0xc01c0a30
0xe15f5eac 0xc012a1fc do_generic_file_read+0xe8 (0xe218dce0, 0xe218dd00, 0xe15f5ee0, 0xc0166c08)
                               kernel .text 0xc0100000 0xc012a114 0xc012a618
0xe15f5f1c 0xc0166cfb pagebuf_generic_file_read+0xc3 (0xe218dce0, 0x41dc9200, 0x38000,
0xe218dd00)
                               kernel .text 0xc0100000 0xc0166c38 0xc0166d4c
0xe15f5f44 0xc01c12a8 xfs_rdwr+0x48 (0xe16d5304, 0xe218dce0, 0x41dc9200, 0x38000, 0xe218dd00)
                               kernel .text 0xc0100000 0xc01c1260 0xc01c12d4
[1]more> 
0xe15f5f70 0xc01c1325 xfs_read+0x51 (0xe16d5304, 0xe218dce0, 0x41dc9200, 0x38000, 0xe218dd00)
                               kernel .text 0xc0100000 0xc01c12d4 0xc01c1330
0xe15f5f98 0xc01be202 linvfs_read+0x62 (0xe218dce0, 0x41dc9200, 0x38000, 0xe218dd00, 0xe15f4000)
                               kernel .text 0xc0100000 0xc01be1a0 0xc01be20c
0xe15f5fbc 0xc01355a8 sys_read+0x94 (0x3d, 0x41dc9200, 0x38000, 0x38000, 0x41dc9200)
                               kernel .text 0xc0100000 0xc0135514 0xc01355c0
           0xc010a77b system_call+0x33
                               kernel .text 0xc0100000 0xc010a748 0xc010a780
[1]kdb> cpu 2

Entering kdb (current=0xe24dc000, pid 8180) on processor 2 due to cpu switch
[2]kdb> bt
    EBP       EIP         Function(args)
0xe24ddc74 0xc0112f48 smp_call_function+0x84 (0xc0112db8, 0x0, 0x1, 0x1)
                               kernel .text 0xc0100000 0xc0112ec4 0xc0112f7c
0xe24ddc90 0xc0112e1c flush_tlb_all+0x14
                               kernel .text 0xc0100000 0xc0112e08 0xc0112e68
0xe24ddca4 0xc01334f6 flush_all_zero_pkmaps+0x7a (0x0)
                               kernel .text 0xc0100000 0xc013347c 0xc0133500
0xe24ddcd8 0xc01335c6 kmap_high+0xc6
                               kernel .text 0xc0100000 0xc0133500 0xc0133674
0xe24ddd00 0xc0166248 _pagebuf_handle_iovecs+0x88 (0xe24ddee0, 0xc3118940, 0x0, 0x39000, 0x0)
                               kernel .text 0xc0100000 0xc01661c0 0xc016648c
0xe24ddd2c 0xc01664b2 _pagebuf_iomove_apply+0x26 (0xe24ddee0, 0xe0294a20, 0x39000, 0x0,
0xc3118940)
                               kernel .text 0xc0100000 0xc016648c 0xc01664bc
0xe24ddd90 0xc01657c4 pagebuf_segment_apply+0x234 (0xc016648c, 0xe24ddee0, 0xe0294a20, 0x0,
0x8000)
                               kernel .text 0xc0100000 0xc0165590 0xc016581c
0xe24dddbc 0xc01667ad _pb_buffered_read+0xed (0xe0b98c60, 0x32000, 0x0, 0x8000, 0xe24dde30)
                               kernel .text 0xc0100000 0xc01666c0 0xc01667c4
0xe24dde4c 0xc0166b61 pagebuf_file_read+0x225 (0xe20ce140, 0xe24ddee0, 0xe1785ab4, 0x1,
0xe0b98c60)
                               kernel .text 0xc0100000 0xc016693c 0xc0166c08
0xe24dde74 0xc01c0a12 linvfs_file_read+0x32 (0xe20ce140, 0xe24ddee0)
                               kernel .text 0xc0100000 0xc01c09e0 0xc01c0a30
0xe24ddeac 0xc012a1fc do_generic_file_read+0xe8 (0xe20ce140, 0xe20ce160, 0xe24ddee0, 0xc0166c08)
                               kernel .text 0xc0100000 0xc012a114 0xc012a618
[2]more> 
0xe24ddf1c 0xc0166cfb pagebuf_generic_file_read+0xc3 (0xe20ce140, 0x41dc9200, 0x38000,
0xe20ce160)
                               kernel .text 0xc0100000 0xc0166c38 0xc0166d4c
0xe24ddf44 0xc01c12a8 xfs_rdwr+0x48 (0xe1785ab4, 0xe20ce140, 0x41dc9200, 0x38000, 0xe20ce160)
                               kernel .text 0xc0100000 0xc01c1260 0xc01c12d4
0xe24ddf70 0xc01c1325 xfs_read+0x51 (0xe1785ab4, 0xe20ce140, 0x41dc9200, 0x38000, 0xe20ce160)
                               kernel .text 0xc0100000 0xc01c12d4 0xc01c1330
0xe24ddf98 0xc01be202 linvfs_read+0x62 (0xe20ce140, 0x41dc9200, 0x38000, 0xe20ce160, 0xe24dc000)
                               kernel .text 0xc0100000 0xc01be1a0 0xc01be20c
0xe24ddfbc 0xc01355a8 sys_read+0x94 (0x3a, 0x41dc9200, 0x38000, 0x38000, 0x41dc9200)
                               kernel .text 0xc0100000 0xc0135514 0xc01355c0
           0xc010a77b system_call+0x33
                               kernel .text 0xc0100000 0xc010a748 0xc010a780
[2]kdb> cpu 3

Entering kdb (current=0xe2668000, pid 8182) on processor 3 due to cpu switch
[3]kdb> bt
    EBP       EIP         Function(args)
           0xc0278abd stext_lock+0x1955
                               kernel .text.lock 0xc0277168 0xc0277168 0xc027dac0
0xe2669e14 0xc013350b kmap_high+0xb
                               kernel .text 0xc0100000 0xc0133500 0xc0133674
0xe2669e3c 0xc0166248 _pagebuf_handle_iovecs+0x88 (0xe2669ee0, 0xc3064d54, 0x0, 0x8000, 0x0)
                               kernel .text 0xc0100000 0xc01661c0 0xc016648c
0xe2669e6c 0xc0166c2d _pagebuf_read_helper+0x25 (0xe2669ee0, 0xc3064d54, 0x0, 0x1000)
                               kernel .text 0xc0100000 0xc0166c08 0xc0166c38
0xe2669eac 0xc012a334 do_generic_file_read+0x220 (0xe34c74a0, 0xe34c74c0, 0xe2669ee0,
0xc0166c08)
                               kernel .text 0xc0100000 0xc012a114 0xc012a618
0xe2669f1c 0xc0166cfb pagebuf_generic_file_read+0xc3 (0xe34c74a0, 0x41d88200, 0x38000,
0xe34c74c0)
                               kernel .text 0xc0100000 0xc0166c38 0xc0166d4c
0xe2669f44 0xc01c12a8 xfs_rdwr+0x48 (0xe180d470, 0xe34c74a0, 0x41d88200, 0x38000, 0xe34c74c0)
                               kernel .text 0xc0100000 0xc01c1260 0xc01c12d4
0xe2669f70 0xc01c1325 xfs_read+0x51 (0xe180d470, 0xe34c74a0, 0x41d88200, 0x38000, 0xe34c74c0)
                               kernel .text 0xc0100000 0xc01c12d4 0xc01c1330
0xe2669f98 0xc01be202 linvfs_read+0x62 (0xe34c74a0, 0x41d88200, 0x38000, 0xe34c74c0, 0xe2668000)
                               kernel .text 0xc0100000 0xc01be1a0 0xc01be20c
0xe2669fbc 0xc01355a8 sys_read+0x94 (0x31, 0x41d88200, 0x38000, 0x38000, 0x41d88200)
                               kernel .text 0xc0100000 0xc0135514 0xc01355c0
           0xc010a77b system_call+0x33
                               kernel .text 0xc0100000 0xc010a748 0xc010a780


-- 
--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
