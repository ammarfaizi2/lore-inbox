Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136221AbRA1BGK>; Sat, 27 Jan 2001 20:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136237AbRA1BGB>; Sat, 27 Jan 2001 20:06:01 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:59193 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S136221AbRA1BFo>; Sat, 27 Jan 2001 20:05:44 -0500
Message-ID: <3A737061.F1B914A3@linux.com>
Date: Sun, 28 Jan 2001 01:05:37 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <3A7295F6.621BBEC4@Home.com> <3A731E65.8BE87D73@pobox.com> <3A7359BB.7BBEE42A@linux.com> <94voof$17j$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately klogd reads /proc....erg.

So the following is a painstakingly slow hand translation, I'll only print
the D state entries unless someone asks otherwise.

Prior to this:
    XMMS is running playing star wars mpeg. (regular user) (frozen)
    TOP is running (regular user) (frozen)
    while [ 1 ]; do ls -laR /proc ; done (regular user) (frozen)
    skill -9 xmms (root) (frozen)
    X 4.0.2 running, scp of 600meg file over pegasus usb ethernet (10Mbit).

syslog caught:
Jan 27 16:42:26 nifty kernel: SysRq: Show State
Jan 27 16:42:26 nifty kernel:
Jan 27 16:42:26 nifty kernel:
free                        sibling
Jan 27 16:42:26 nifty kernel:   task             PC    stack   pid father
child younger older
Jan 27 16:42:26 nifty kernel: init      S CBFEBF2C  3184     1      0   187
(NOTLB)
<end>

dmesg shows (only D state for brevity):
top       D CA98B3DC  4440   219    158        (NOTLB)
Call Trace: [<c010791d>] [<c0107a68>] [<c02f73dd>] [<c014b5cb>] [<c01311e6>]
[<c0108d5f>] [<c010002b>]

c01078c8 T __down
c0107964 T __down_interruptible
c0107a28 T __down_trylock
c0107a60 T __down_failed
c0107a6c T __down_failed_interruptible

c02f6a00 T stext_lock
c02f827e A _etext

c014b578 t proc_info_read
c014b688 t mem_read

c0131150 T sys_read
c013121c T sys_write

c0108d2c T system_call
c0108d64 T ret_from_sys_call

c0100000 t startup_32
c0100139 t is486


xmms      D CACC5EA8  4116   713    155   715  (NOTLB)    1493   674
Call Trace: [<c0124966>] [<c012412f>] [<c01242b8>] [<c0144138>] [<c014238e>]
[<c0131cd0>] [<c01236b2>]
       [<c01239f2>] [<c01ac5ca>] [<c010d1f6>] [<c0108e7c>] [<c0108d5f>]

c01248e4 T ___wait_on_page
c0124984 t __lock_page

c01240dc t truncate_list_pages
c0124268 T truncate_inode_pages
c01242d4 t writeout_one_page

c0144094 T remove_inode_hash
c01440a8 T iput
c01441fc T force_delete

c01422a0 T dput
c01423e4 T d_invalidate

c0131c58 T fput
c0131d28 T fget

c012365c t unmap_fixup
c0123788 t free_pgtables

c012380c T do_munmap
c0123a5c T sys_munmap

...ask if you want more

xmms      S C2979F30     0   715    713   725  (NOTLB)
Call Trace: [<c01142fb>] [<c0114240>] [<c013f95e>] [<c013fb53>] [<c0119fff>]
[<c0108d5f>]
xmms      S C2B75F2C  1156   716    715        (NOTLB)     718
Call Trace: [<c01142fb>] [<c0114240>] [<c013f341>] [<c013f6e0>] [<c0108d5f>]
xmms      S 7FFFFFFF     0   718    715        (NOTLB)     719   716
Call Trace: [<c011429f>] [<c013f341>] [<c013f6e0>] [<c0108d5f>]
xmms      S C2975F88   832   719    715        (NOTLB)     725   718
Call Trace: [<c01142fb>] [<c0114240>] [<c011d468>] [<c0108d5f>] [<c010002b>]
xmms      S CA8D7F88  2672   725    715        (NOTLB)           719
Call Trace: [<c01142fb>] [<c0114240>] [<c011d468>] [<c0108d5f>]

c0114240 t process_timeout
c0114288 T schedule_timeout
c011431c T schedule_tail

c0113d70 t remap_area_pages
c0114020 T __ioremap

c0108d2c T system_call
c0108d64 T ret_from_sys_call


ls        D CA98B3DC     0  1896    222        (NOTLB)
Call Trace: [<c010791d>] [<c0107a68>] [<c02f73b5>] [<c014b95a>] [<c01389a2>]
[<c0108d5f>]
skill     D CA98B3DC     0  1897    187        (NOTLB)
Call Trace: [<c010791d>] [<c0107a68>] [<c02f73dd>] [<c014b5cb>] [<c01311e6>]
[<c0108d5f>]

c0107964 T __down_interruptible
c0107a28 T __down_trylock
c0107a60 T __down_failed
c0107a6c T __down_failed_interruptible

c02f6a00 T stext_lock
c02f827e A _etext
 ...


SysRq: Show Memory
Mem-info:
Free pages:        2240kB (     0kB HighMem)
( Active: 4153, inactive_dirty: 198, inactive_clean: 1077, free: 560 (383 766
1149) )
31*4kB 1*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB =
660kB)
125*4kB 5*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 0*2048kB
= 1580kB)
= 0kB)
Swap cache: add 3165, delete 547, find 25/124
Free swap:        53104kB
49136 pages of RAM
0 pages of HIGHMEM
1798 reserved pages
2619 pages shared
2618 pages swap cached
0 pages in page table cache
Buffer memory:     1276kB

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
