Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261924AbTCTUKR>; Thu, 20 Mar 2003 15:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261937AbTCTUKR>; Thu, 20 Mar 2003 15:10:17 -0500
Received: from web13807.mail.yahoo.com ([216.136.175.17]:51564 "HELO
	web13807.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261924AbTCTUKP>; Thu, 20 Mar 2003 15:10:15 -0500
Message-ID: <20030320202115.86154.qmail@web13807.mail.yahoo.com>
Date: Thu, 20 Mar 2003 12:21:15 -0800 (PST)
From: William Chow <lilbilchow@yahoo.com>
Subject: smp_call_function/flush_tlb_all hang on large memory system
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my 2.4.18 system, I am seeing a hang in
smp_call_function() when my machine is configured with
>2GB of RAM. Examining the call_data, it appears that
only 2 out of the other 3 cpus have responded to the
IPI (started == finished == 2). Examining eflags on
each of the cpus, shows that one of the cpus has
interrupts disabled (bit 9 was clear). However, that
cpu's stack does not show anything that would have
disabled interrupts, i.e. appears as if somebody
forgot to sti. Interestingly, manually setting that
bit (from kdb) will actually unwedge the system.

I always see smp_call_function() called from
flush_tbl_all(), which is usually called from
kmap_high; there has been one occassion when it was
called from vmfree_area_pages.

3]kdb> bt
EBP      EIP      Function (args)
4d4afec4 40111398 smp_call_function+0x88 (40111180 0 1
1 755)
4d4afee0 401111dc flush_tlb_all+0x14 (0 4d4ac000
433ca6b0)
4d4afef4 40138779 flush_all_zero_pkmaps+0x89 (433ca6b0
4d4aff6c 403 40129fd0 433ca6b0)
4d4aff28 4013888a kmap_high+0x106 (4d112474 2000
499392e4 4d1124dc 0)
4d4aff74 4012c997 generic_file_write+0x40b (499392c4
3fffd4a4 1000 499392e4 0)
4d4aff98 40178df5 nfs_file_write+0xa9 (499392c4
3fffc4a4 2000 499392e4 4d4ac000)
4d4affbc 4013ad18 sys_write+0x98 (4 3fffc4a4 2000 2000
3fffc4a4)
         401071ab system_call+0x33

This hang is fairly reproducible when exercising NFS
(as shown above), e.g. repeatedly copying a large
file.

Browsing the web, I found a similar occurrence, but
didn't find a reply to the post:
http://oss.sgi.com/projects/xfs/mail_archive/200010/msg00122.html

Has anyone ever seen this or possibly have any ideas?
Please CC me directly on the response. Thanks in
advance.

- William Chow

__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
