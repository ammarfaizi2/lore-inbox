Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280191AbRJaND0>; Wed, 31 Oct 2001 08:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280193AbRJaNDR>; Wed, 31 Oct 2001 08:03:17 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:52114 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S280191AbRJaNDL>; Wed, 31 Oct 2001 08:03:11 -0500
Message-ID: <3BDFF478.5030604@wipro.com>
Date: Wed, 31 Oct 2001 18:24:16 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Manuel Cepedello Boiso <manuel@cauchy.eii.us.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops when unmounting a floppy (linux 2.4.13)
In-Reply-To: <Pine.LNX.4.33L2.0110311334210.902-100000@cauchy.eii.us.es>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Preliminary analysis shows that getblk now no longer holds lru_list_lock.
I am sure there is a good reason for that, I hope :-)

get_hash_table just holds hash_table_lock where as invalidate_buffer
holds lru_list_lock.

Comments from kernel code

/* Anti-deadlock ordering:
 *      lru_list_lock > hash_table_lock > unused_list_lock
 */

Notes from document on locks (lse.sourceforge.net)

Lock:           lru_list_lock
Interrupts:     Ignored
Functions:      sync_buffers(), buffer_insert_inode_queue(),
                inode_has_buffers(),  __invalidate_buffers(),
                set_blocksize(), fsync_inode_buffers(),
                osync_inode_buffers(), invalidate_inode_buffers(),
                getblk(), refile_buffers(), __bforget(),
                try_to_free_buffers(), show_buffers(),
                flush_dirty_buffers()
Use:            Held while reading or writing the lru_list.
Notes:          if hash_table_lock and  unused_list_lock are also used,
                then the order should be lru_list_lock --> hash_table_lock
                --> unused_list_lock to avoid deadlocks.  The routines
                __removed_from_queues() and __insert_into_queues()
                expect this lock to be held upon entry.

getblk() is no longer holding lru_list_lock, so I suspect this caused the
race, the fix I think is quite simple, hold the lru_list_lock in getblk()
and release it at the end.


Comments,
Balbir

Manuel Cepedello Boiso wrote:

>
>I've found a kernel oops when I tried to unmount a floppy under Linux
>2.4.13. The disquette has an HFS filesystem (Macintosh) and the support
>for the floppy was compiled as module.
>
>The kernel log is the following:
>
>Oct 31 12:59:43 cauchy kernel: inserting floppy driver for 2.4.13
>Oct 31 12:59:43 cauchy kernel: Floppy drive(s): fd0 is 1.44M
>Oct 31 12:59:43 cauchy kernel: FDC 0 is a post-1991 82077
>Oct 31 12:59:43 cauchy kernel: VFS: Disk change detected on device fd(2,0)
>Oct 31 13:01:34 cauchy kernel: kernel BUG at buffer.c:673!
>Oct 31 13:01:34 cauchy kernel: invalid operand: 0000
>Oct 31 13:01:34 cauchy kernel: CPU:    0
>Oct 31 13:01:34 cauchy kernel: EIP:    0010:[invalidate_bdev+157/312]
>Tainted: PF
>Oct 31 13:01:34 cauchy kernel: EFLAGS: 00010282
>Oct 31 13:01:34 cauchy kernel: eax: 0000001c   ebx: cd7025c0   ecx:
>c01fe6a0   edx: 000028d7
>Oct 31 13:01:34 cauchy kernel: esi: 00000001   edi: c0a295c0   ebp:
>00000000   esp: cf561ef8
>Oct 31 13:01:34 cauchy kernel: ds: 0018   es: 0018   ss: 0018
>Oct 31 13:01:34 cauchy kernel: Process umount (pid: 2436,
>stackpage=cf561000)
>Oct 31 13:01:34 cauchy kernel: Stack: c01d48bc 000002a1 c194a1e0 c300b860
>00000000 d4dd9244 02000000 00000000
>Oct 31 13:01:34 cauchy kernel:        00000000 c0131b59 c194a1e0 00000001
>c194a1e0 c013263a c194a1e0 d4dd9200
>Oct 31 13:01:34 cauchy kernel:        c194a1e0 00000200 c0131816 c194a1e0
>00000002 c180e460 d4dd9200 cf561f98
>Oct 31 13:01:34 cauchy kernel: Call Trace: [kill_bdev+13/40]
>[blkdev_put+78/144] [kill_super+250/316] [<e0995520>] [__mntput+30/36]
>Oct 31 13:01:34 cauchy kernel:    [path_release+39/44]
>[sys_umount+167/180] [sys_munmap+53/84] [sys_oldumount+12/16]
>[system_call+51/56]
>Oct 31 13:01:34 cauchy kernel:
>Oct 31 13:01:34 cauchy kernel: Code: 0f 0b 83 c4 08 8d b6 00 00 00 00 f6
>43 18 02 74 0d 68 c5 48
>
>
>
>Manuel Cepedello
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

-------------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------

--------------InterScan_NT_MIME_Boundary--
