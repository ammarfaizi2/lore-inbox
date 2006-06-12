Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWFLJ1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWFLJ1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWFLJ1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:27:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51584 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751330AbWFLJ1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:27:16 -0400
From: Andi Kleen <ak@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Still data corruption with LTP doio on 2.6.17rc
Date: Mon, 12 Jun 2006 11:27:10 +0200
User-Agent: KMail/1.9.3
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, okir@suse.de
References: <200606081244.13000.ak@suse.de> <1149778177.15644.19.camel@lade.trondhjem.org>
In-Reply-To: <1149778177.15644.19.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606121127.10490.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 16:49, Trond Myklebust wrote:
> On Thu, 2006-06-08 at 12:44 +0200, Andi Kleen wrote:
> > I'm still seeing data corruption when running LTP over NFS
> > between two 2.6.17rc* hosts. I already saw this before 2.6.16
> > and reported.
> > 
> > Server is running knfsd 2.6.17-rc4-git9, client is running 2.6.17-rc6
> > with nfsroot. Both x86-64 and SUSE 10.0 userland. The file system
> > is exported as async and mounted with
> > /dev/root / nfs rw,vers=2,rsize=4096,wsize=4096,hard,nolock,proto=udp,timeo=11,retrans=2,addr=10.23.204.1 0 0
> > 
> > First I always get lots of
> > 
> > do_vfs_lock: VFS is out of sync with lock manager!
> > 
> > messages on the client. They don't seem to be directly related though. 
> > 
> > I set up ltp-full-20051103 on the NFS root and run it on the client
> > with runltplite.sh. Eventually it reports
> > 
> > 
> > <<<test_start>>>
> > tag=rwtest03 stime=1149754762
> > cmdline="export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$"
> > contacts=""
> > analysis=exit
> > initiation_status="ok"
> > <<<test_output>>>
> > 
> > doio(rwtest03) ( 8155) 08:19:23
> > ---------------------
> > *** DATA COMPARISON ERROR ***
> > check_file(/tmp/ltp-2256/mm-buff-8139, 7813848, 81293, U:8155:bigfoot:doio*, 20, 0) failed
> > 
> > Comparison fd is 3, with open flags 0
> > Corrupt regions follow - unprintable chars are represented as '.'
> > -----------------------------------------------------------------
> > corrupt bytes starting at file offset 7813848
> >     1st 32 expected bytes:  U:8155:bigfoot:doio*U:8155:bigfo
> >     1st 32 actual bytes:    ................................
> > 
> > Request number 36
> >           fd 4 is file /tmp/ltp-2256/mm-buff-8139 - open flags are 02 O_RDWR,
> >           write done at file offset 7813848 - pattern is U (0125)
> >           number of requests is 1, strides per request is 1
> >           i/o byte count = 81293
> >           memory alignment is unaligned
> > 
> > syscall:  mmap-write(NULL, 12800000, PROT_WRITE, MAP_SHARED, 4, 0)
> >         file is mmaped to: 0x2b73b87f0000
> >         file-mem=0x2b73b8f63ad8, length=81293, buffer=0x52d540
> > 
> > 
> > est03) ( 8152) 08:19:23
> > ---------------------
> > (parent) pid 8155 exited because of data compare errors
> 
> mmap() is still not 100% safe when the client believes that the file has
> changed on the server and needs to call invalidate_inode_pages2(): if
> there is dirty data on the page when unmap_mapping_range() gets called,
> then that dirty data may be lost (basically, we need a VM helper that
> does unmap+flush+invalidate_page).
> 
> The attached patch may, however reduce the number of calls to
> invalidate_inode_pages2() since it ensures that revalidations only occur
> if and when we're going to read from the page cache (i.e. in places when
> we _need_ the assurance that the page cache is valid).

Sorry for the delay.

I tested your patch with -rc6 and the problem is still there:

Also I did some testing with 2.6.16 and I couldn't reproduce it here
so maybe it was introduced afterwards (however I could swear I've seen
it before, but I can't remember which exact version number it was)

BTW you can probably easily reproduce it yourself by downloading LTP
from ltp.sourceforge.net and compiling/running it on a NFS mount.

-Andi

doio(rwtest03) ( 8621) 07:42:18
---------------------
*** DATA COMPARISON ERROR ***
check_file(/tmp/ltp-2819/mm-buff-8605, 507558, 49196, O:8621:bigfoot:doio*, 20, 0) failed

Comparison fd is 4, with open flags 0
Corrupt regions follow - unprintable chars are represented as '.'
-----------------------------------------------------------------
corrupt bytes starting at file offset 532480
    1st 32 expected bytes:  8621:bigfoot:doio*O:8621:bigfoot
    1st 32 actual bytes:    ................................

Request number 1
          fd 3 is file /tmp/ltp-2819/mm-buff-8605 - open flags are 02 O_RDWR,
          write done at file offset 507558 - pattern is O (0117)
          number of requests is 1, strides per request is 1
          i/o byte count = 49196
          memory alignment is unaligned

syscall:  mmap-write(NULL, 12800000, PROT_WRITE, MAP_SHARED, 3, 0)
        file is mmaped to: 0x2b0b89f6f000
        file-mem=0x2b0b89feaea6, length=49196, buffer=0x52d547


doio(rwtest03) ( 8618) 07:42:18
---------------------
(parent) pid 8621 exited because of data compare errors
rwtest(rwtest03) : doio reported errors (r=4)
rwtest03    1  FAIL  :  doio reported errors (r=4)
rwtest03    1  FAIL  :  Test failed
<<<execution_status>>>
duration=67 termination_type=exited termination_id=4 corefile=no
cutime=32 cstime=141
<<<test_end>>>
<<<test_start>>>
tag=rwtest04 stime=1150098204
cmdline="export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:m
m-sync-$$"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
doio(rwtest04) ( 8640) 07:43:26
---------------------
*** DATA COMPARISON ERROR ***
check_file(/tmp/ltp-2819/mm-sync-8625, 4585176, 82650, T:8640:bigfoot:doio*, 20, 0) failed

Comparison fd is 4, with open flags 0
Corrupt regions follow - unprintable chars are represented as '.'
-----------------------------------------------------------------
corrupt bytes starting at file offset 4585176
    1st 32 expected bytes:  T:8640:bigfoot:doio*T:8640:bigfo
    1st 32 actual bytes:    ................................

Request number 54
          fd 3 is file /tmp/ltp-2819/mm-sync-8625 - open flags are 010002 O_RDWR,O_SYNC,
          write done at file offset 4585176 - pattern is T (0124)
          number of requests is 1, strides per request is 1
          i/o byte count = 82650
          memory alignment is unaligned

syscall:  mmap-write(NULL, 12800000, PROT_WRITE, MAP_SHARED, 3, 0)
        file is mmaped to: 0x2addadf68000
        file-mem=0x2addae3c76d8, length=82650, buffer=0x52d541


doio(rwtest04) ( 8638) 07:43:26
---------------------
(parent) pid 8640 exited because of data compare errors

doio(rwtest04) ( 8641) 07:43:26
---------------------
*** DATA COMPARISON ERROR ***
check_file(/tmp/ltp-2819/mm-sync-8625, 7161356, 118706, E:8641:bigfoot:doio*, 20, 0) failed
Comparison fd is 4, with open flags 0
Corrupt regions follow - unprintable chars are represented as '.'
-----------------------------------------------------------------
corrupt bytes starting at file offset 7254016
    1st 32 expected bytes:  E:8641:bigfoot:doio*E:8641:bigfo
    1st 32 actual bytes:    ................................

Request number 61
          fd 3 is file /tmp/ltp-2819/mm-sync-8625 - open flags are 010002 O_RDWR,O_SYNC,
          write done at file offset 7161356 - pattern is E (0105)
          number of requests is 1, strides per request is 1
          i/o byte count = 118706
          memory alignment is unaligned

syscall:  mmap-write(NULL, 12800000, PROT_WRITE, MAP_SHARED, 3, 0)
        file is mmaped to: 0x2addadf68000
        file-mem=0x2addae63c60c, length=118706, buffer=0x52d543


doio(rwtest04) ( 8638) 07:43:26
---------------------
(parent) pid 8641 exited because of data compare errors
rwtest(rwtest04) : iogen reported errors (r=141)
rwtest04    1  FAIL  :  Test failed
