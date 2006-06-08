Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWFHKoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWFHKoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWFHKoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:44:25 -0400
Received: from mx1.suse.de ([195.135.220.2]:1686 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964777AbWFHKoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:44:24 -0400
From: Andi Kleen <ak@suse.de>
To: neilb@cse.unsw.edu.au, resource@suse.de
Subject: Still data corruption with LTP doio on 2.6.17rc
Date: Thu, 8 Jun 2006 12:44:12 +0200
User-Agent: KMail/1.9.3
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       trond.myklebust@fys.uio.no, okir@suse.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606081244.13000.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm still seeing data corruption when running LTP over NFS
between two 2.6.17rc* hosts. I already saw this before 2.6.16
and reported.

Server is running knfsd 2.6.17-rc4-git9, client is running 2.6.17-rc6
with nfsroot. Both x86-64 and SUSE 10.0 userland. The file system
is exported as async and mounted with
/dev/root / nfs rw,vers=2,rsize=4096,wsize=4096,hard,nolock,proto=udp,timeo=11,retrans=2,addr=10.23.204.1 0 0

First I always get lots of

do_vfs_lock: VFS is out of sync with lock manager!

messages on the client. They don't seem to be directly related though. 

I set up ltp-full-20051103 on the NFS root and run it on the client
with runltplite.sh. Eventually it reports


<<<test_start>>>
tag=rwtest03 stime=1149754762
cmdline="export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>

doio(rwtest03) ( 8155) 08:19:23
---------------------
*** DATA COMPARISON ERROR ***
check_file(/tmp/ltp-2256/mm-buff-8139, 7813848, 81293, U:8155:bigfoot:doio*, 20, 0) failed

Comparison fd is 3, with open flags 0
Corrupt regions follow - unprintable chars are represented as '.'
-----------------------------------------------------------------
corrupt bytes starting at file offset 7813848
    1st 32 expected bytes:  U:8155:bigfoot:doio*U:8155:bigfo
    1st 32 actual bytes:    ................................

Request number 36
          fd 4 is file /tmp/ltp-2256/mm-buff-8139 - open flags are 02 O_RDWR,
          write done at file offset 7813848 - pattern is U (0125)
          number of requests is 1, strides per request is 1
          i/o byte count = 81293
          memory alignment is unaligned

syscall:  mmap-write(NULL, 12800000, PROT_WRITE, MAP_SHARED, 4, 0)
        file is mmaped to: 0x2b73b87f0000
        file-mem=0x2b73b8f63ad8, length=81293, buffer=0x52d540


est03) ( 8152) 08:19:23
---------------------
(parent) pid 8155 exited because of data compare errors

doio(rwtest03) ( 8154) 08:19:23
---------------------
*** DATA COMPARISON ERROR ***
check_file(/tmp/ltp-2256/mm-buff-8139, 4223869, 130577, X:8154:bigfoot:doio*, 20, 0) failed

Comparison fd is 4, with open flags 0
Corrupt regions follow - unprintable chars are represented as '.'
-----------------------------------------------------------------
corrupt bytes starting at file offset 4349952
    1st 32 expected bytes:  154:bigfoot:doio*X:8154:bigfoot:
    1st 32 actual bytes:    ................................

Request number 36
          fd 3 is file /tmp/ltp-2256/mm-buff-8139 - open flags are 02 O_RDWR,
          write done at file offset 4223869 - pattern is X (0130)
          number of requests is 1, strides per request is 1
          i/o byte count = 130577
          memory alignment is unaligned

syscall:  mmap-write(NULL, 12800000, PROT_WRITE, MAP_SHARED, 3, 0)
        file is mmaped to: 0x2b73b87f0000
        file-mem=0x2b73b8bf737d, length=130577, buffer=0x52d540


doio(rwtest03) ( 8152) 08:19:23
---------------------
(parent) pid 8154 exited because of data compare errors
rwtest(rwtest03) : iogen reported errors (r=141)
rwtest03    1  FAIL  :  Test failed
<<<execution_status>>>
duration=1 termination_type=exited termination_id=2 corefile=no
cutime=1 cstime=7
<<<test_end>>>
<<<test_start>>>
tag=rwtest04 stime=1149754763
cmdline="export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>

doio(rwtest04) ( 8174) 08:19:23
---------------------
*** DATA COMPARISON ERROR ***
check_file(/tmp/ltp-2256/mm-sync-8159, 12102771, 46088, O:8174:bigfoot:doio*, 20, 0) failed

Comparison fd is 4, with open flags 0
Corrupt regions follow - unprintable chars are represented as '.'
-----------------------------------------------------------------
corrupt bytes starting at file offset 12128256
    1st 32 expected bytes:  4:bigfoot:doio*O:8174:bigfoot:do
    1st 32 actual bytes:    ................................

Request number 11
          fd 3 is file /tmp/ltp-2256/mm-sync-8159 - open flags are 010002 O_RDWR,O_SYNC,
          write done at file offset 12102771 - pattern is O (0117)
          number of requests is 1, strides per request is 1
          i/o byte count = 46088
          memory alignment is unaligned

syscall:  mmap-write(NULL, 12800000, PROT_WRITE, MAP_SHARED, 3, 0)
        file is mmaped to: 0x2b8b163cc000
        file-mem=0x2b8b16f56c73, length=46088, buffer=0x52d546


doio(rwtest04) ( 8172) 08:19:23
---------------------
(parent) pid 8174 exited because of data compare errors
rwtest(rwtest04) : doio reported errors (r=4)
rwtest04    1  FAIL  :  doio reported errors (r=4)
rwtest04    1  FAIL  :  Test failed
<<<execution_status>>>
duration=66 termination_type=exited termination_id=4 corefile=no
cutime=33 cstime=170
<<<test_end>>>


-Andi
