Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282695AbRLBDLh>; Sat, 1 Dec 2001 22:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282700AbRLBDL1>; Sat, 1 Dec 2001 22:11:27 -0500
Received: from holomorphy.com ([216.36.33.161]:10368 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S282695AbRLBDLO>;
	Sat, 1 Dec 2001 22:11:14 -0500
Date: Sat, 1 Dec 2001 19:11:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] wait_for_devfsd_finished deadlock
Message-ID: <20011201191113.A1034@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While testing 2.4.17-pre1 with some other patches, a situation
reminiscent of a deadlock arose. mutt(1) would block indefinitely
while opening a large mbox, and all further calls to sys_open()
would block indefinitely.

After some further testing to isolate the problem, I reproduced
this behavior in the vanilla 2.4.17-pre1 kernel. The sysrq output showed
a number of processes with the following call trace in the devfs core:


Dec  1 17:29:26 holomorphy kernel: sh            D C02A2A00     0   821    806  
                   (NOTLB)
Dec  1 17:29:26 holomorphy kernel: Call Trace: [wait_for_devfsd_finished+170/208
] [devfs_d_revalidate_wait+135/160] [devfs_lookup+409/448] [d_alloc+27/400] [rea
l_lookup+83/192] 
Dec  1 17:29:26 holomorphy kernel:    [link_path_walk+1310/1888] [path_walk+26/3
2] [open_namei+131/1488] [filp_open+59/96] [sys_open+56/192] [system_call+51/56]


And the following call traces elsewhere:


Dec  1 17:29:26 holomorphy kernel: cron          S E3540000     0   852    633  
 853     855   827 (NOTLB)
Dec  1 17:29:26 holomorphy kernel: Call Trace: [pipe_wait+124/176] [pipe_read+17
9/512] [sys_read+150/208] [system_call+51/56] 


Dec  1 17:29:26 holomorphy kernel: procmail      S E2395ED8     0   881    880  
         882       (NOTLB)
Dec  1 17:29:26 holomorphy kernel: Call Trace: [interruptible_sleep_on_locked+11
6/192] [locks_block_on+28/48] [posix_lock_file+178/1232] [fcntl_setlk+335/512] [
do_fcntl+318/512] 


Dec  1 17:29:26 holomorphy kernel: exim          S 00000000     0   905    899  
 907               (NOTLB)
Dec  1 17:29:26 holomorphy kernel: Call Trace: [sys_wait4+862/912] [system_call+
51/56] 

 

Further diagnostic information is available upon request.

Mr. Gooch, your attention to this matter is much appreciated.



Thanks,
Bill
