Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbTACQsm>; Fri, 3 Jan 2003 11:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267589AbTACQsl>; Fri, 3 Jan 2003 11:48:41 -0500
Received: from users.ccur.com ([208.248.32.211]:10781 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S267583AbTACQsj>;
	Fri, 3 Jan 2003 11:48:39 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200301031656.QAA29658@rudolph.ccur.com>
Subject: 2.4.21-pre2 stalls out when running unixbench
To: sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com,
       rusty@rustcorp.com.au, riel@conectiva.com.br
Date: Fri, 3 Jan 2003 11:56:31 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,
2.4.21-pre2 and -pre1 stall when running unixbench 4.1.0.  2.4.20
works perfectly.  Stall is detected by running
	
    while true; do sync; sleep 1; echo -e '.\c'; done

in another window while unixbench is running.  Stall is assumed if
the dots stop printing for 10 minutes.  Stall will happen anywhere
from 40 seconds to 6-7 minutes into the run.

Rather than run all of unixbench, I have been running the parts that
seem to trigger the issue:

    for i in 0 1 2 3 4 5 6 7 8 9; do
	./Run fstime fsbuffer fsdisk
    done


Other windows continue to operate and accept new commands, as long as
one stays away from sync(1).

Another 2.4.21-pre2 kernel, loaded up with patches (kdb, lcrash,
preempt, O1, etc), also exhibits the same behavior.  I used this
kernel to get kdb stack trackbacks of all processes sitting in
uninterruptible-sleep.  This may be interesting since generally one
cannot catch any process sleeping uninterruptably unless the system
is suffering from a sleep-semaphore deadlock.

Random data points: ext3, scsi, dual cpu, problem did not appear when
booted singleuser (one attempt), kernel built with gcc version 2.96
20000731 (Red Hat Linux 7.3 2.96-110).

Joe - Concurrent Computer Corporation


[0]kdb> ps
Task Addr  Pid      Parent   [*] cpu  State Thread     Command
0xc282e000 00000001 00000000  0  000  islp  0xc282e400 init
0xc282a000 00000002 00000001  0  000  islp  0xc282a400 migration/0
0xc2828000 00000003 00000001  0  001  islp  0xc2828400 migration/1
0xf7bf4000 00000004 00000001  0  001  islp  0xf7bf4400 keventd
0xf7bf2000 00000005 00000001  0  000  islp  0xf7bf2400 ksoftirqd/0
0xf7bee000 00000006 00000001  0  001  islp  0xf7bee400 ksoftirqd/1
0xf7bda000 00000007 00000001  0  000  islp  0xf7bda400 kswapd
0xf7bb6000 00000008 00000001  0  000  islp  0xf7bb6400 bdflush
0xf7bb2000 00000009 00000001  0  000  islp  0xf7bb2400 kupdated
0xf7b42000 00000010 00000001  0  000  islp  0xf7b42400 scsi_eh_0
0xf7b40000 00000011 00000001  0  000  islp  0xf7b40400 scsi_eh_1
0xf7b3c000 00000012 00000001  0  000  islp  0xf7b3c400 scsi_eh_2
0xf7af8000 00000013 00000001  0  001  islp  0xf7af8400 khubd
0xf7abe000 00000014 00000001  0  001  islp  0xf7abe400 kjournald
0xf76de000 00000111 00000001  0  000  islp  0xf76de400 kjournald
0xf76ca000 00000112 00000001  0  000  islp  0xf76ca400 kjournald
0xf76c2000 00000113 00000001  0  000  uslp  0xf76c2400 kjournald
0xf77ba000 00000222 00000001  0  000  islp  0xf77ba400 login
0xf74a4000 00000397 00000001  0  000  islp  0xf74a4400 syslogd
0xf7496000 00000401 00000001  0  000  islp  0xf7496400 klogd
0xf7488000 00000412 00000001  0  000  islp  0xf7488400 portmap
[0]more> 
0xf7474000 00000431 00000001  0  001  islp  0xf7474400 rpc.statd
0xf7370000 00000498 00000001  0  000  islp  0xf7370400 sshd
0xf7338000 00000512 00000001  0  001  islp  0xf7338400 xinetd
0xf7190000 00000525 00000001  0  001  islp  0xf7190400 rpc.rquotad
0xf7186000 00000529 00000001  0  001  islp  0xf7186400 nfsd
0xf7180000 00000530 00000001  0  001  islp  0xf7180400 nfsd
0xf7176000 00000531 00000001  0  001  islp  0xf7176400 nfsd
0xf716e000 00000532 00000001  0  000  islp  0xf716e400 nfsd
0xf7166000 00000533 00000001  0  000  islp  0xf7166400 nfsd
0xf715e000 00000534 00000001  0  000  islp  0xf715e400 nfsd
0xf715c000 00000535 00000001  0  000  islp  0xf715c400 nfsd
0xf7154000 00000536 00000001  0  001  islp  0xf7154400 nfsd
0xf719c000 00000538 00000001  0  001  islp  0xf719c400 lockd
0xf714c000 00000539 00000538  0  001  islp  0xf714c400 rpciod
0xf7136000 00000544 00000001  0  001  islp  0xf7136400 rpc.mountd
0xf7110000 00000554 00000001  0  000  islp  0xf7110400 elmd
0xf7046000 00000640 00000001  0  000  islp  0xf7046400 gpm
0xf7030000 00000649 00000001  0  001  islp  0xf7030400 crond
0xf6c9a000 00000722 00000001  0  000  islp  0xf6c9a400 xfs
0xf76e4000 00000740 00000001  0  000  islp  0xf76e4400 atd
0xf6c5e000 00000750 00000001  0  000  islp  0xf6c5e400 nstar.d
0xf6cae000 00000757 00000001  0  001  islp  0xf6cae400 mingetty
0xf6c5c000 00000758 00000001  0  000  islp  0xf6c5c400 mingetty
[0]more> 
0xf6bd4000 00000761 00000222  0  000  islp  0xf6bd4400 bash
0xf6b98000 00000807 00000761  0  000  islp  0xf6b98400 Run
0xf6b2e000 00000867 00000512  0  001  islp  0xf6b2e400 in.telnetd
0xf6b0e000 00000868 00000867  0  001  islp  0xf6b0e400 login
0xf693e000 00000869 00000868  0  000  islp  0xf693e400 bash
0xf694a000 00001363 00000807  0  000  islp  0xf694a400 time
0xf4fbe000 00001364 00001363  0  001  uslp  0xf4fbe400 fsdisk
0xf49f2000 00001468 00000869  0  000  uslp  0xf49f2400 sync

[0]kdb> btp 113
    EBP       EIP         Function(args)
0xf76c3e18 0xc011c065 do_schedule+0x4f5 (0xf76c3e24, 0xc014d1b8, 0xf4cf3c80, 0x0, 0xf76c3fb8)
                               kernel .text 0xc0100000 0xc011bb70 0xc011c130
0xf76c3e60 0xc014bb4e __wait_on_buffer+0xce (0xf481bc00, 0x2, 0x0, 0x2ee0, 0xf76c2000)
                               kernel .text 0xc0100000 0xc014ba80 0xc014bbe0
0xf76c3fb8 0xc0181edf journal_commit_transaction+0x4ef (0xf76ce800, 0x0, 0x0, 0x1d27f, 0x0)
                               kernel .text 0xc0100000 0xc01819f0 0xc0182c9b
0xf76c3fec 0xc0184bc6 kjournald+0x176
                               kernel .text 0xc0100000 0xc0184a50 0xc0184ca0
           0xc010745d kernel_thread+0x3d
                               kernel .text 0xc0100000 0xc0107420 0xc01074d0

[0]kdb> btp 1364 
    EBP       EIP         Function(args)
0xf4fbfd74 0xc011c065 do_schedule+0x4f5 (0xf4fbfd80, 0xf4fbfdb4, 0xc01ef37e, 0x805, 0xf76ce800)
                               kernel .text 0xc0100000 0xc011bb70 0xc011c130
0xf4fbfdbc 0xc014bb4e __wait_on_buffer+0xce (0xf481bc00, 0x1, 0xf76ce800, 0xc01801e6, 0xf6bb7d80)
                               kernel .text 0xc0100000 0xc014ba80 0xc014bbe0
0xf4fbfdec 0xc0180626 journal_dirty_data+0x116 (0xf6c20280, 0xf481bc00, 0x0, 0xc1aeb360, 0x0)
                               kernel .text 0xc0100000 0xc0180510 0xc0180700
0xf4fbfe4c 0xc0178068 journal_dirty_sync_data+0x18 (0xf6c20280, 0xf6b5d580, 0xf481bc00, 0x1000, 0x0)
                               kernel .text 0xc0100000 0xc0178050 0xc01780c0
0xf4fbfe70 0xc0177d74 walk_page_buffers+0x54 (0xf6c20280, 0xf6b5d580, 0xf481bc00, 0x0, 0x1000)
                               kernel .text 0xc0100000 0xc0177d20 0xc0177da0
0xf4fbfebc 0xc017831a ext3_commit_write+0x18a (0xf6961d80, 0xc1aeb360, 0x0, 0x1000, 0xf4fbff00)
                               kernel .text 0xc0100000 0xc0178190 0xc0178450
0xf4fbff54 0xc013c5af generic_file_write+0x4af (0xf6961d80, 0x80491e0, 0x1000, 0xf6961da0, 0xc0175790)
                               kernel .text 0xc0100000 0xc013c100 0xc013c810
0xf4fbff78 0xc01757b1 ext3_file_write+0x21 (0xf6961d80, 0x80491e0, 0x1000, 0xf6961da0, 0x1)
                               kernel .text 0xc0100000 0xc0175790 0xc0175840
0xf4fbffbc 0xc014a592 sys_write+0x112
                               kernel .text 0xc0100000 0xc014a480 0xc014a650
           0xc0109234 trace_syscall_entry_ret+0x2d
                               kernel .text 0xc0100000 0xc0109207 0xc0109268

[0]kdb> btp 1468
    EBP       EIP         Function(args)
0xf49f3f28 0xc011c065 do_schedule+0x4f5 (0x0, 0xf49f2000, 0xf76ce854, 0xf76ce854, 0xf76ce800)
                               kernel .text 0xc0100000 0xc011bb70 0xc011c130
0xf49f3f4c 0xc011c695 sleep_on+0x65 (0xf76cea00, 0x1)
                               kernel .text 0xc0100000 0xc011c630 0xc011c6f0
0xf49f3f5c 0xc01851da log_wait_commit+0x6a (0xf76ce800, 0x4b5df, 0xf76ce800, 0x0, 0xf76cea00)
                               kernel .text 0xc0100000 0xc0185170 0xc0185230
0xf49f3f78 0xc017efa6 ext3_sync_fs+0x26 (0xf76cea00, 0xf49f2000, 0x0)
                               kernel .text 0xc0100000 0xc017ef80 0xc017efb0
0xf49f3f8c 0xc01508ce sync_supers+0x13e (0x0, 0x1, 0x0, 0xffffffff, 0x0)
                               kernel .text 0xc0100000 0xc0150790 0xc0150920
0xf49f3fb0 0xc014c108 fsync_dev+0x58 (0x0)
                               kernel .text 0xc0100000 0xc014c0b0 0xc014c150
0xf49f3fbc 0xc014c16a sys_sync+0xa
                               kernel .text 0xc0100000 0xc014c160 0xc014c170
           0xc0109234 trace_syscall_entry_ret+0x2d
                               kernel .text 0xc0100000 0xc0109207 0xc0109268
