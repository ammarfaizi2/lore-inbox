Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSGHCCT>; Sun, 7 Jul 2002 22:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316723AbSGHCCS>; Sun, 7 Jul 2002 22:02:18 -0400
Received: from p0013.as-l042.contactel.cz ([194.108.237.13]:2688 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S316709AbSGHCCR>;
	Sun, 7 Jul 2002 22:02:17 -0400
Date: Mon, 8 Jul 2002 04:04:56 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: IDE94 lockup on lock_page or __wait_on_buffer
Message-ID: <20020708020456.GA1144@ppc.vc.cvut.cz>
References: <Pine.LNX.4.44.0207071922350.1441-100000@linux-box.realnet.co.sz> <Pine.SOL.4.30.0207071915310.1945-200000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0207071915310.1945-200000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 07:27:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Do you realise that 2.5.25 have IDE 93 and it should be fixed in IDE 96.
> 
> BTW: know problem with 96 is broken ide_timer_expiry().
> Attached IDE 98 (or not) prepatch should fix it.

Hello,
  there is something wrong with IDE94 :-( I'm starring at this problem for
6 hours, but I still cannot explain that. After applying IDE94 and
simple booting with:

Linux init=/bin/bash
# bash < /dev/tty2 > /dev/tty2 2>&1 &
<change to vt2>
# dd if=/dev/hdg of=/dev/null bs=4k
<change back to vt1>
# df

system deadlocks. Call stack is either (when dd locks)

__lock_page
lock_page
filemap_nopage  (first call to lock_page, at line 1550)
do_no_page
handle_mm_fault
do_page_fault
error_code

or (when bash dies while trying to start df)

__wait_on_buffer
__bread_slow
__getblk
ext2_get_inode
ext2_read_inode
ext2_lookup
real_lookup
do_lookup
link_path_walk
path_lookup
__user_walk
vfs_stat
sys_stat64
syscall_call

Probably IDE messes its request queue and forgets to execute some requests,
or what's going on...

None of running processes (2x bash, dd, keventd, 
ksoftirqd...) is executing IDE code when the deadlock happens. IDE channel
in question is dead after deadlock occurs (hdparm -d 0 /dev/hde says 
channel busy after some timeout).

Kernel is up, non-preemptible, running on 1GHz Athlon, 
one UDMA100 IDE (hde) and one UDMA33 IDE (hdg) connected to pdc20265, 512MB 
RAM. I did not notice any problem while using this patch for last 7 days 
on 450MHz PIII, two UDMA33 IDE connected to PIIX4, 640MB RAM.

Problem occurs even with latest ide-98-pre.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


