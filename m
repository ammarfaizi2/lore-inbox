Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269315AbUIYM1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269315AbUIYM1K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 08:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269316AbUIYM1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 08:27:10 -0400
Received: from cs.rice.edu ([128.42.1.30]:20418 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id S269315AbUIYM0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 08:26:30 -0400
To: linux-kernel@vger.kernel.org
Subject: Sluggishness in 2.6.7 caused by IDE stack
From: Scott A Crosby <scrosby@cs.rice.edu>
Organization: Rice University
Date: Sat, 25 Sep 2004 07:26:19 -0500
Message-ID: <oydsm964jro.fsf@bert.cs.rice.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was burning a DVD-R on a new brand of media and I was experience
fairly high system sluggishness. I've burned other DVD's on a
different brand of media on this drive at a slower speed without this
effect.

The system is an Athlon XP 2500+ running 2.6.7 with a Liteon 832s dvd
burner.

Much of the CPU time was spent in system mode. I setup a quick
oprofile, which blamed the function task_no_data_intr, but an
opannotate reports confusing results, possibly from interrupts? dmesg
reported nothing interesting.


Scott


*** vmstat output ***

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 1  1 410496   8520  14224 1253716    0    0  2180    16  409   633 10 43  0 48
 7  1 410496   6920  14236 1255380    0    0  1668    20  589   832  9 18  0 73
 3  0 410496   8264  14232 1253988    0    0  2436    80  334   438 18 82  0  0
 0  1 410496   8384  14244 1253860    0    0  1932     0  464   706 13 35  0 52
 5  1 410496   8056  14264 1253872  328    0  2280     0  717   965 14 20  0 65
 8  1 410496   7352  14268 1254640    0    0  2692     0  351   485 17 83  0  0
 2  2 410496   6968  14264 1255036   32    0  2336     0  332   522 17 83  0  0
 5  0 410496   8568  14276 1253384    0    0  2192    12  464   794 19 33  0 48

*** oprofile output ***

samples  %        app name                 symbol name
1217485  94.2994  vmlinux                  task_no_data_intr
7714      0.5975  firefox-bin              (no symbols)
5975      0.4628  libc-2.3.2.so            (no symbols)
5199      0.4027  vmlinux                  pci_bus_match_dynids
3798      0.2942  XFree86                  (no symbols)


*** opreport -d output ***

c022f520 1218267  89.3898  task_no_data_intr
  c022f530 2        1.6e-04
  c022f535 30        0.0025
  c022f53a 2186      0.1794
  c022f54a 90        0.0074
  c022f561 2        1.6e-04
  c022f56d 1196860  98.2428
  c022f570 19037     1.5626
  c022f571 1        8.2e-05
  c022f584 2        1.6e-04
  c022f589 57        0.0047

*** Relevant assembly code in task_no_data_intr ***

c022f520 <task_no_data_intr>: /* task_no_data_intr total: 1218267 89.3898 */
               :c022f520:       sub    $0x1c,%esp
               :c022f523:       mov    %edi,0x14(%esp,1)
               :c022f527:       mov    %ebx,0xc(%esp,1)
               :c022f52b:       mov    %esi,0x10(%esp,1)
               :c022f52f:       mov    0x20(%esp,1),%edi
               :c022f533:       mov    %ebp,0x18(%esp,1)
               :c022f537:       mov    0x70(%edi),%esi
  2186  0.1604 :c022f53a:       mov    0x8(%esi),%eax
               :c022f53d:       mov    0x20(%eax),%eax
               :c022f540:       mov    0x68(%eax),%ebp
               :c022f543:       sti    
               :c022f544:       mov    0x70(%edi),%eax
               :c022f547:       mov    0x34(%eax),%eax
    90  0.0066 :c022f54a:       mov    %eax,(%esp,1)
               :c022f54d:       call   *0x4b8(%esi)
               :c022f553:       movzbl %al,%ebx
               :c022f556:       mov    %ebx,%eax
               :c022f558:       and    $0xc9,%eax
               :c022f55d:       cmp    $0x40,%eax
               :c022f560:       je     c022f58b <task_no_data_intr+0x6b>
               :c022f562:       mov    0x1c(%edi),%eax
               :c022f565:       mov    %edi,(%esp,1)
               :c022f568:       movl   $0xc02dfecf,0x4(%esp,1)
 19037  1.3968 :c022f570:       mov    %ebx,0x8(%esp,1)
               :c022f574:       call   *0x20(%eax)
               :c022f577:       mov    0xc(%esp,1),%ebx
               :c022f57b:       mov    0x10(%esp,1),%esi
               :c022f57f:       mov    0x14(%esp,1),%edi
               :c022f583:       mov    0x18(%esp,1),%ebp
               :c022f587:       add    $0x1c,%esp
               :c022f58a:       ret    
               :c022f58b:       test   %ebp,%ebp
               :c022f58d:       je     c022f5b1 <task_no_data_intr+0x91>
               :c022f58f:       mov    0x70(%edi),%eax
               :c022f592:       mov    0x1c(%eax),%eax
               :c022f595:       mov    %eax,(%esp,1)
               :c022f598:       call   *0x4b8(%esi)
               :c022f59e:       mov    %edi,(%esp,1)
               :c022f5a1:       mov    %ebx,0x4(%esp,1)
               :c022f5a5:       movzbl %al,%eax
               :c022f5a8:       mov    %eax,0x8(%esp,1)
               :c022f5ac:       call   c0229b90 <ide_end_drive_cmd>
               :c022f5b1:       xor    %eax,%eax
               :c022f5b3:       jmp    c022f577 <task_no_data_intr+0x57>
               :c022f5b5:       lea    0x0(%esi,1),%esi
               :c022f5b9:       lea    0x0(%edi,1),%edi
               :

** Source code for function ***
**     drivers/ide/ide-taskfile.c:278

ide_startstop_t task_no_data_intr (ide_drive_t *drive)
{
        ide_task_t *args        = HWGROUP(drive)->rq->special;
        ide_hwif_t *hwif        = HWIF(drive);
        u8 stat;

        local_irq_enable();
        if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),READY_STAT,BAD_STAT)) {
                DTF("%s: command opcode 0x%02x\n", drive->name,
                        args->tfRegister[IDE_COMMAND_OFFSET]);
                return DRIVER(drive)->error(drive, "task_no_data_intr", stat);
                /* calls ide_end_drive_cmd */
        }
        if (args)
                ide_end_drive_cmd(drive, stat, hwif->INB(IDE_ERROR_REG));

        return ide_stopped;
}
