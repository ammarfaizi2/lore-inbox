Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbVFYKaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbVFYKaP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 06:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVFYKaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 06:30:15 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:106 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263390AbVFYK2x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 06:28:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RkZeBaC/KJrw5fHCnkRmj37ZQmEwdVJ0sGARSsMTOLr4lpMktC/DB3TXZDdn6i4Kg0AScTnkDcOOjvN8gq9icG8pKxF1zQKMnR0lFdFO4Ijly67CITv8SERQSyRyijaeNn3bNtr2oSYdal+LGVekHriEyUR/4ZWYGuWO+NlMhoY=
Message-ID: <98df96d305062503281efa5f5a@mail.gmail.com>
Date: Sat, 25 Jun 2005 19:28:52 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: linux-kernel@vger.kernel.org
Subject: i2o driver and OOM killer on 2.6.9
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the following OOM killer on 2.6.9 by iozone. The machine has a
i2o driver so it may have issues.

It is very easy to reproduce this OOM killer.

# iozone -CMR -i 0 -+n -+u -s 7G -t 1 -f /test/f1/io > iozone.out

I have applied the following patch but it does not solve this issue.

https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=115691
(rhel4.patch)
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=160882

# lsmod
Module                  Size  Used by
oprofile               37600  1
md5                     7936  1
ipv6                  238752  16
microcode              11808  0
dm_mod                 57348  0
button                 10384  0
battery                12804  0
ac                      8708  0
ohci_hcd               23300  0
e1000                  94340  0
floppy                 61072  0
ext3                  118536  9
jbd                    60056  1 ext3
i2o_block              16652  11
i2o_core               42140  1 i2o_block
sd_mod                 20480  0
scsi_mod              116364  1 sd_mod

The /var/log/messages is
Jun 25 14:19:02 dhcp-0251 kernel: oprofile: using NMI interrupt.
Jun 25 14:19:57 dhcp-0251 kernel: oom-killer: gfp_mask=0xd0
Jun 25 14:19:57 dhcp-0251 kernel: DMA per-cpu:
Jun 25 14:19:57 dhcp-0251 kernel: cpu 0 hot: low 2, high 6, batch 1
Jun 25 14:19:57 dhcp-0251 kernel: cpu 0 cold: low 0, high 2, batch 1
Jun 25 14:19:57 dhcp-0251 kernel: cpu 1 hot: low 2, high 6, batch 1
Jun 25 14:19:57 dhcp-0251 kernel: cpu 1 cold: low 0, high 2, batch 1
Jun 25 14:19:57 dhcp-0251 kernel: cpu 2 hot: low 2, high 6, batch 1
Jun 25 14:19:57 dhcp-0251 kernel: cpu 2 cold: low 0, high 2, batch 1
Jun 25 14:19:57 dhcp-0251 kernel: cpu 3 hot: low 2, high 6, batch 1
Jun 25 14:19:57 dhcp-0251 kernel: cpu 3 cold: low 0, high 2, batch 1
Jun 25 14:19:57 dhcp-0251 kernel: Normal per-cpu:
Jun 25 14:19:57 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:19:57 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:20:29 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:20:31 dhcp-0251 login(pam_unix)[2683]: session closed for user root
Jun 25 14:20:33 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:20:39 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:20:41 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:20:43 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:20:45 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:20:49 dhcp-0251 kernel: HighMem per-cpu:
Jun 25 14:20:51 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:20:54 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:20:58 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:01 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:03 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:06 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:09 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:11 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:12 dhcp-0251 kernel:
Jun 25 14:21:12 dhcp-0251 kernel: Free pages:      876484kB (875776kB HighMem)
Jun 25 14:21:13 dhcp-0251 kernel: Active:3419 inactive:546825
dirty:278253 writeback:79041 unstable:0 free:219121 slab:31125
mapped:3125 pagetables:175
Jun 25 14:21:13 dhcp-0251 kernel: DMA free:12kB min:16kB low:32kB
high:48kB active:0kB inactive:0kB present:16384kB
Jun 25 14:21:13 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:13 dhcp-0251 kernel: Normal free:696kB min:936kB
low:1872kB high:2808kB active:1348kB inactive:988kB present:901120kB
Jun 25 14:21:13 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:13 dhcp-0251 kernel: HighMem free:875776kB min:512kB
low:1024kB high:1536kB active:12328kB inactive:2186312kB
present:3080192kB
Jun 25 14:21:13 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:13 dhcp-0251 kernel: DMA: 1*4kB 1*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12kB
Jun 25 14:21:13 dhcp-0251 kernel: Normal: 0*4kB 1*8kB 1*16kB 1*32kB
0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 696kB
Jun 25 14:21:13 dhcp-0251 kernel: HighMem: 686*4kB 341*8kB 104*16kB
17*32kB 14*64kB 5*128kB 1*256kB 2*512kB 1*1024kB 0*2048kB 211*4096kB =
875776kB
Jun 25 14:21:13 dhcp-0251 kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Jun 25 14:21:13 dhcp-0251 kernel: Out of Memory: Killed process 2659 (xfs).
Jun 25 14:21:13 dhcp-0251 kernel: oom-killer: gfp_mask=0xd0
Jun 25 14:21:13 dhcp-0251 kernel: DMA per-cpu:
Jun 25 14:21:13 dhcp-0251 kernel: cpu 0 hot: low 2, high 6, batch 1
Jun 25 14:21:13 dhcp-0251 kernel: cpu 0 cold: low 0, high 2, batch 1
Jun 25 14:21:13 dhcp-0251 kernel: cpu 1 hot: low 2, high 6, batch 1
Jun 25 14:21:13 dhcp-0251 kernel: cpu 1 cold: low 0, high 2, batch 1
Jun 25 14:21:13 dhcp-0251 kernel: cpu 2 hot: low 2, high 6, batch 1
Jun 25 14:21:13 dhcp-0251 kernel: cpu 2 cold: low 0, high 2, batch 1
Jun 25 14:21:13 dhcp-0251 kernel: cpu 3 hot: low 2, high 6, batch 1
Jun 25 14:21:13 dhcp-0251 kernel: cpu 3 cold: low 0, high 2, batch 1
Jun 25 14:21:13 dhcp-0251 kernel: Normal per-cpu:
Jun 25 14:21:13 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: HighMem per-cpu:
Jun 25 14:21:14 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:14 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:14 dhcp-0251 kernel:
Jun 25 14:21:14 dhcp-0251 kernel: Free pages:      877660kB (876992kB HighMem)
Jun 25 14:21:14 dhcp-0251 kernel: Active:3139 inactive:546806
dirty:278253 writeback:79041 unstable:0 free:219415 slab:30776
mapped:2763 pagetables:166
Jun 25 14:21:14 dhcp-0251 kernel: DMA free:12kB min:16kB low:32kB
high:48kB active:0kB inactive:0kB present:16384kB
Jun 25 14:21:14 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:14 dhcp-0251 kernel: Normal free:656kB min:936kB
low:1872kB high:2808kB active:1276kB inactive:1060kB present:901120kB
Jun 25 14:21:14 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:14 dhcp-0251 kernel: HighMem free:876992kB min:512kB
low:1024kB high:1536kB active:11280kB inactive:2186164kB
present:3080192kB
Jun 25 14:21:14 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:14 dhcp-0251 kernel: DMA: 1*4kB 1*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12kB
Jun 25 14:21:15 dhcp-0251 kernel: Normal: 0*4kB 0*8kB 1*16kB 0*32kB
0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 656kB
Jun 25 14:21:15 dhcp-0251 kernel: HighMem: 740*4kB 360*8kB 117*16kB
21*32kB 18*64kB 5*128kB 2*256kB 2*512kB 1*1024kB 0*2048kB 211*4096kB =
876992kB
Jun 25 14:21:15 dhcp-0251 kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Jun 25 14:21:15 dhcp-0251 kernel: Out of Memory: Killed process 2668
(dbus-daemon-1).
Jun 25 14:21:15 dhcp-0251 kernel: oom-killer: gfp_mask=0xd0
Jun 25 14:21:15 dhcp-0251 kernel: DMA per-cpu:
Jun 25 14:21:15 dhcp-0251 kernel: cpu 0 hot: low 2, high 6, batch 1
Jun 25 14:21:15 dhcp-0251 kernel: cpu 0 cold: low 0, high 2, batch 1
Jun 25 14:21:15 dhcp-0251 kernel: cpu 1 hot: low 2, high 6, batch 1
Jun 25 14:21:15 dhcp-0251 kernel: cpu 1 cold: low 0, high 2, batch 1
Jun 25 14:21:15 dhcp-0251 kernel: cpu 2 hot: low 2, high 6, batch 1
Jun 25 14:21:15 dhcp-0251 kernel: cpu 2 cold: low 0, high 2, batch 1
Jun 25 14:21:15 dhcp-0251 kernel: cpu 3 hot: low 2, high 6, batch 1
Jun 25 14:21:15 dhcp-0251 kernel: cpu 3 cold: low 0, high 2, batch 1
Jun 25 14:21:15 dhcp-0251 kernel: Normal per-cpu:
Jun 25 14:21:15 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:15 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:15 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:15 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:15 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:15 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:15 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:15 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:15 dhcp-0251 kernel: HighMem per-cpu:
Jun 25 14:21:16 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:16 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:16 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:16 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:16 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:16 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:16 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:16 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:16 dhcp-0251 kernel:
Jun 25 14:21:16 dhcp-0251 kernel: Free pages:      877660kB (876992kB HighMem)
Jun 25 14:21:16 dhcp-0251 kernel: Active:3141 inactive:546772
dirty:278253 writeback:79041 unstable:0 free:219415 slab:30486
mapped:2635 pagetables:157
Jun 25 14:21:16 dhcp-0251 kernel: DMA free:12kB min:16kB low:32kB
high:48kB active:0kB inactive:0kB present:16384kB
Jun 25 14:21:16 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:16 dhcp-0251 kernel: Normal free:656kB min:936kB
low:1872kB high:2808kB active:1276kB inactive:1060kB present:901120kB
Jun 25 14:21:16 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:16 dhcp-0251 kernel: HighMem free:876992kB min:512kB
low:1024kB high:1536kB active:11288kB inactive:2186028kB
present:3080192kB
Jun 25 14:21:16 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:16 dhcp-0251 kernel: DMA: 1*4kB 1*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12kB
Jun 25 14:21:16 dhcp-0251 kernel: Normal: 0*4kB 0*8kB 1*16kB 0*32kB
0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 656kB
Jun 25 14:21:16 dhcp-0251 kernel: HighMem: 740*4kB 360*8kB 117*16kB
21*32kB 18*64kB 5*128kB 2*256kB 2*512kB 1*1024kB 0*2048kB 211*4096kB =
876992kB
Jun 25 14:21:16 dhcp-0251 kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Jun 25 14:21:16 dhcp-0251 kernel: Out of Memory: Killed process 3153 (iozone).
Jun 25 14:21:16 dhcp-0251 kernel: oom-killer: gfp_mask=0xd0
Jun 25 14:21:17 dhcp-0251 kernel: DMA per-cpu:
Jun 25 14:21:17 dhcp-0251 kernel: cpu 0 hot: low 2, high 6, batch 1
Jun 25 14:21:17 dhcp-0251 kernel: cpu 0 cold: low 0, high 2, batch 1
Jun 25 14:21:17 dhcp-0251 kernel: cpu 1 hot: low 2, high 6, batch 1
Jun 25 14:21:17 dhcp-0251 kernel: cpu 1 cold: low 0, high 2, batch 1
Jun 25 14:21:17 dhcp-0251 kernel: cpu 2 hot: low 2, high 6, batch 1
Jun 25 14:21:17 dhcp-0251 kernel: cpu 2 cold: low 0, high 2, batch 1
Jun 25 14:21:17 dhcp-0251 kernel: cpu 3 hot: low 2, high 6, batch 1
Jun 25 14:21:17 dhcp-0251 kernel: cpu 3 cold: low 0, high 2, batch 1
Jun 25 14:21:17 dhcp-0251 kernel: Normal per-cpu:
Jun 25 14:21:17 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:17 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:17 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:17 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:17 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:17 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:17 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:17 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:17 dhcp-0251 kernel: HighMem per-cpu:
Jun 25 14:21:17 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:17 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:18 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:18 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:18 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:18 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:18 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:18 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:18 dhcp-0251 kernel:
Jun 25 14:21:18 dhcp-0251 kernel: Free pages:      877692kB (876992kB HighMem)
Jun 25 14:21:18 dhcp-0251 kernel: Active:3141 inactive:546775
dirty:278253 writeback:79041 unstable:0 free:219423 slab:30210
mapped:2636 pagetables:157
Jun 25 14:21:18 dhcp-0251 kernel: DMA free:12kB min:16kB low:32kB
high:48kB active:0kB inactive:0kB present:16384kB
Jun 25 14:21:18 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:18 dhcp-0251 kernel: Normal free:688kB min:936kB
low:1872kB high:2808kB active:1276kB inactive:1072kB present:901120kB
Jun 25 14:21:18 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:18 dhcp-0251 kernel: HighMem free:876992kB min:512kB
low:1024kB high:1536kB active:11288kB inactive:2186028kB
present:3080192kB
Jun 25 14:21:18 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:18 dhcp-0251 kernel: DMA: 1*4kB 1*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12kB
Jun 25 14:21:18 dhcp-0251 kernel: Normal: 0*4kB 2*8kB 0*16kB 1*32kB
0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 688kB
Jun 25 14:21:18 dhcp-0251 kernel: HighMem: 740*4kB 360*8kB 117*16kB
21*32kB 18*64kB 5*128kB 2*256kB 2*512kB 1*1024kB 0*2048kB 211*4096kB =
876992kB
Jun 25 14:21:18 dhcp-0251 kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Jun 25 14:21:18 dhcp-0251 kernel: Out of Memory: Killed process 3155 (iozone).
Jun 25 14:21:18 dhcp-0251 kernel: oom-killer: gfp_mask=0xd0
Jun 25 14:21:18 dhcp-0251 kernel: DMA per-cpu:
Jun 25 14:21:18 dhcp-0251 kernel: cpu 0 hot: low 2, high 6, batch 1
Jun 25 14:21:18 dhcp-0251 kernel: cpu 0 cold: low 0, high 2, batch 1
Jun 25 14:21:18 dhcp-0251 kernel: cpu 1 hot: low 2, high 6, batch 1
Jun 25 14:21:18 dhcp-0251 kernel: cpu 1 cold: low 0, high 2, batch 1
Jun 25 14:21:18 dhcp-0251 kernel: cpu 2 hot: low 2, high 6, batch 1
Jun 25 14:21:18 dhcp-0251 kernel: cpu 2 cold: low 0, high 2, batch 1
Jun 25 14:21:19 dhcp-0251 kernel: cpu 3 hot: low 2, high 6, batch 1
Jun 25 14:21:19 dhcp-0251 kernel: cpu 3 cold: low 0, high 2, batch 1
Jun 25 14:21:19 dhcp-0251 kernel: Normal per-cpu:
Jun 25 14:21:19 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: HighMem per-cpu:
Jun 25 14:21:19 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:19 dhcp-0251 kernel:
Jun 25 14:21:19 dhcp-0251 kernel: Free pages:      877700kB (876992kB HighMem)
Jun 25 14:21:19 dhcp-0251 kernel: Active:3112 inactive:546809
dirty:278255 writeback:79041 unstable:0 free:219425 slab:29985
mapped:2636 pagetables:157
Jun 25 14:21:19 dhcp-0251 kernel: DMA free:12kB min:16kB low:32kB
high:48kB active:12kB inactive:0kB present:16384kB
Jun 25 14:21:19 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:19 dhcp-0251 kernel: Normal free:696kB min:936kB
low:1872kB high:2808kB active:1148kB inactive:1208kB present:901120kB
Jun 25 14:21:19 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:19 dhcp-0251 kernel: HighMem free:876992kB min:512kB
low:1024kB high:1536kB active:11288kB inactive:2186028kB
present:3080192kB
Jun 25 14:21:19 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:19 dhcp-0251 kernel: DMA: 1*4kB 1*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12kB
Jun 25 14:21:20 dhcp-0251 kernel: Normal: 0*4kB 1*8kB 1*16kB 1*32kB
0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 696kB
Jun 25 14:21:20 dhcp-0251 kernel: HighMem: 740*4kB 360*8kB 117*16kB
21*32kB 18*64kB 5*128kB 2*256kB 2*512kB 1*1024kB 0*2048kB 211*4096kB =
876992kB
Jun 25 14:21:20 dhcp-0251 kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Jun 25 14:21:20 dhcp-0251 kernel: Out of Memory: Killed process 2677 (hald).
Jun 25 14:21:20 dhcp-0251 kernel: oom-killer: gfp_mask=0xd0
Jun 25 14:21:20 dhcp-0251 kernel: DMA per-cpu:
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 hot: low 2, high 6, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 cold: low 0, high 2, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 1 hot: low 2, high 6, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 1 cold: low 0, high 2, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 2 hot: low 2, high 6, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 2 cold: low 0, high 2, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 3 hot: low 2, high 6, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 3 cold: low 0, high 2, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: Normal per-cpu:
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: HighMem per-cpu:
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:19 dhcp-0251 kernel: Free pages:      877700kB (876992kB HighMem)
Jun 25 14:21:19 dhcp-0251 kernel: Active:3112 inactive:546809
dirty:278255 writeback:79041 unstable:0 free:219425 slab:29985
mapped:2636 pagetables:157
Jun 25 14:21:19 dhcp-0251 kernel: DMA free:12kB min:16kB low:32kB
high:48kB active:12kB inactive:0kB present:16384kB
Jun 25 14:21:19 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:19 dhcp-0251 kernel: Normal free:696kB min:936kB
low:1872kB high:2808kB active:1148kB inactive:1208kB present:901120kB
Jun 25 14:21:19 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:19 dhcp-0251 kernel: HighMem free:876992kB min:512kB
low:1024kB high:1536kB active:11288kB inactive:2186028kB
present:3080192kB
Jun 25 14:21:19 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:19 dhcp-0251 kernel: DMA: 1*4kB 1*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12kB
Jun 25 14:21:20 dhcp-0251 kernel: Normal: 0*4kB 1*8kB 1*16kB 1*32kB
0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 696kB
Jun 25 14:21:20 dhcp-0251 kernel: HighMem: 740*4kB 360*8kB 117*16kB
21*32kB 18*64kB 5*128kB 2*256kB 2*512kB 1*1024kB 0*2048kB 211*4096kB =
876992kB
Jun 25 14:21:20 dhcp-0251 kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Jun 25 14:21:20 dhcp-0251 kernel: Out of Memory: Killed process 2677 (hald).
Jun 25 14:21:20 dhcp-0251 kernel: oom-killer: gfp_mask=0xd0
Jun 25 14:21:20 dhcp-0251 kernel: DMA per-cpu:
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 hot: low 2, high 6, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 cold: low 0, high 2, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 1 hot: low 2, high 6, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 1 cold: low 0, high 2, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 2 hot: low 2, high 6, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 2 cold: low 0, high 2, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 3 hot: low 2, high 6, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: cpu 3 cold: low 0, high 2, batch 1
Jun 25 14:21:20 dhcp-0251 kernel: Normal per-cpu:
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: HighMem per-cpu:
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 0 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 1 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 1 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 2 hot: low 32, high 96, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 2 cold: low 0, high 32, batch 16
Jun 25 14:21:20 dhcp-0251 kernel: cpu 3 hot: low 32, high 96, batch 16
Jun 25 14:21:21 dhcp-0251 kernel: cpu 3 cold: low 0, high 32, batch 16
Jun 25 14:21:21 dhcp-0251 kernel:
Jun 25 14:21:21 dhcp-0251 kernel: Free pages:      877708kB (876992kB HighMem)
Jun 25 14:21:21 dhcp-0251 kernel: Active:3132 inactive:546812
dirty:278255 writeback:79041 unstable:0 free:219427 slab:29732
mapped:2657 pagetables:157
Jun 25 14:21:21 dhcp-0251 kernel: DMA free:12kB min:16kB low:32kB
high:48kB active:12kB inactive:0kB present:16384kB
Jun 25 14:21:21 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:21 dhcp-0251 kernel: Normal free:704kB min:936kB
low:1872kB high:2808kB active:1148kB inactive:1220kB present:901120kB
Jun 25 14:21:21 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:21 dhcp-0251 kernel: HighMem free:876992kB min:512kB
low:1024kB high:1536kB active:11368kB inactive:2186028kB
present:3080192kB
Jun 25 14:21:21 dhcp-0251 kernel: protections[]: 0 0 0
Jun 25 14:21:21 dhcp-0251 kernel: DMA: 1*4kB 1*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12kB
Jun 25 14:21:21 dhcp-0251 kernel: Normal: 0*4kB 0*8kB 0*16kB 0*32kB
1*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 704kB
Jun 25 14:21:21 dhcp-0251 kernel: HighMem: 740*4kB 360*8kB 117*16kB
21*32kB 18*64kB 5*128kB 2*256kB 2*512kB 1*1024kB 0*2048kB 211*4096kB =
876992kB
Jun 25 14:21:21 dhcp-0251 kernel: Swap cache: add 0, delete 0, find
0/0, race 0+0
Jun 25 14:21:21 dhcp-0251 kernel: Out of Memory: Killed process 2982 (bash).

# cat /proc/meminfo
MemTotal:      3960236 kB
MemFree:       3909604 kB
Buffers:          5228 kB
Cached:          14272 kB
SwapCached:          0 kB
Active:          11616 kB
Inactive:        10432 kB
HighTotal:     3080128 kB
HighFree:      3057792 kB
LowTotal:       880108 kB
LowFree:        851812 kB
SwapTotal:     4096532 kB
SwapFree:      4096532 kB
Dirty:             260 kB
Writeback:           0 kB
Mapped:           5620 kB
Slab:            16276 kB
Committed_AS:    19776 kB
PageTables:        428 kB
VmallocTotal:   106488 kB
VmallocUsed:     21640 kB
VmallocChunk:    84684 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

# cat /proc/slabinfo
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <batchcount> <limit> <sharedfactor> :
slabdata <active_slabs> <num_slabs> <sharedavail>
dcookie_cache         39    226     16  226    1 : tunables  120   60 
  8 : slabdata      1      1      0
fib6_nodes             5    119     32  119    1 : tunables  120   60 
  8 : slabdata      1      1      0
ip6_dst_cache          4     15    256   15    1 : tunables  120   60 
  8 : slabdata      1      1      0
ndisc_cache            1     15    256   15    1 : tunables  120   60 
  8 : slabdata      1      1      0
rawv6_sock             6     10    768    5    1 : tunables   54   27 
  8 : slabdata      2      2      0
udpv6_sock             0      0    768    5    1 : tunables   54   27 
  8 : slabdata      0      0      0
tcpv6_sock             1      3   1280    3    1 : tunables   24   12 
  8 : slabdata      1      1      0
ip_fib_alias           9    226     16  226    1 : tunables  120   60 
  8 : slabdata      1      1      0
ip_fib_hash            9    119     32  119    1 : tunables  120   60 
  8 : slabdata      1      1      0
dm_tio                 0      0     16  226    1 : tunables  120   60 
  8 : slabdata      0      0      0
dm_io                  0      0     16  226    1 : tunables  120   60 
  8 : slabdata      0      0      0
ext3_inode_cache     515    749    552    7    1 : tunables   54   27 
  8 : slabdata    107    107      0
ext3_xattr             0      0     48   81    1 : tunables  120   60 
  8 : slabdata      0      0      0
journal_handle        32    135     28  135    1 : tunables  120   60 
  8 : slabdata      1      1      0
journal_head          98   1134     48   81    1 : tunables  120   60 
  8 : slabdata     14     14      0
revoke_table          18    290     12  290    1 : tunables  120   60 
  8 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60 
  8 : slabdata      0      0      0
i2o_block_req         33     33   2688    3    2 : tunables   24   12 
  8 : slabdata     11     11      0
sgpool-128            32     33   2560    3    2 : tunables   24   12 
  8 : slabdata     11     11      0
sgpool-64             32     33   1280    3    1 : tunables   24   12 
  8 : slabdata     11     11      0
sgpool-32             32     36    640    6    1 : tunables   54   27 
  8 : slabdata      6      6      0
sgpool-16             32     40    384   10    1 : tunables   54   27 
  8 : slabdata      4      4      0
sgpool-8              32     45    256   15    1 : tunables  120   60 
  8 : slabdata      3      3      0
unix_sock              3      7    512    7    1 : tunables   54   27 
  8 : slabdata      1      1      0
ip_mrt_cache           0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
tcp_tw_bucket          0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
tcp_bind_bucket        1    226     16  226    1 : tunables  120   60 
  8 : slabdata      1      1      0
tcp_open_request       0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
inet_peer_cache        2     61     64   61    1 : tunables  120   60 
  8 : slabdata      1      1      0
secpath_cache          0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60 
  8 : slabdata      0      0      0
ip_dst_cache          15     30    256   15    1 : tunables  120   60 
  8 : slabdata      2      2      0
arp_cache              0      0    256   15    1 : tunables  120   60 
  8 : slabdata      0      0      0
raw_sock               5      6    640    6    1 : tunables   54   27 
  8 : slabdata      1      1      0
udp_sock               0      0    640    6    1 : tunables   54   27 
  8 : slabdata      0      0      0
tcp_sock               0      0   1152    7    2 : tunables   24   12 
  8 : slabdata      0      0      0
flow_cache             0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
mqueue_inode_cache      1      6    640    6    1 : tunables   54   27
   8 : slabdata      1      1      0
isofs_inode_cache      0      0    372   10    1 : tunables   54   27 
  8 : slabdata      0      0      0
hugetlbfs_inode_cache      1     11    344   11    1 : tunables   54  
27    8 : slabdata      1      1      0
ext2_inode_cache       0      0    488    8    1 : tunables   54   27 
  8 : slabdata      0      0      0
ext2_xattr             0      0     48   81    1 : tunables  120   60 
  8 : slabdata      0      0      0
dquot                  0      0    144   27    1 : tunables  120   60 
  8 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60 
  8 : slabdata      0      0      0
eventpoll_epi          0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60 
  8 : slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60 
  8 : slabdata      0      0      0
fasync_cache           0      0     16  226    1 : tunables  120   60 
  8 : slabdata      0      0      0
shmem_inode_cache    746    756    444    9    1 : tunables   54   27 
  8 : slabdata     84     84      0
posix_timers_cache      0      0    112   35    1 : tunables  120   60
   8 : slabdata      0      0      0
uid_cache              0      0     64   61    1 : tunables  120   60 
  8 : slabdata      0      0      0
cfq_pool              98    238     32  119    1 : tunables  120   60 
  8 : slabdata      2      2      0
crq_pool              28    192     40   96    1 : tunables  120   60 
  8 : slabdata      2      2      0
deadline_drq           0      0     52   75    1 : tunables  120   60 
  8 : slabdata      0      0      0
as_arq                 0      0     64   61    1 : tunables  120   60 
  8 : slabdata      0      0      0
blkdev_ioc            28    185     20  185    1 : tunables  120   60 
  8 : slabdata      1      1      0
blkdev_queue          20     24    488    8    1 : tunables   54   27 
  8 : slabdata      3      3      0
blkdev_requests       28     75    160   25    1 : tunables  120   60 
  8 : slabdata      3      3      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12 
  8 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12 
  8 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27 
  8 : slabdata     52     52      0
biovec-16            256    270    256   15    1 : tunables  120   60 
  8 : slabdata     18     18      0
biovec-4             256    305     64   61    1 : tunables  120   60 
  8 : slabdata      5      5      0
biovec-1             272   1582     16  226    1 : tunables  120   60 
  8 : slabdata      7      7      0
bio                  272    527    128   31    1 : tunables  120   60 
  8 : slabdata     17     17      0
file_lock_cache        0      0     96   41    1 : tunables  120   60 
  8 : slabdata      0      0      0
sock_inode_cache      21     35    512    7    1 : tunables   54   27 
  8 : slabdata      5      5      0
skbuff_head_cache    288    345    256   15    1 : tunables  120   60 
  8 : slabdata     23     23      0
sock                   5     10    384   10    1 : tunables   54   27 
  8 : slabdata      1      1      0
proc_inode_cache      45     88    360   11    1 : tunables   54   27 
  8 : slabdata      8      8      0
sigqueue              27     27    148   27    1 : tunables  120   60 
  8 : slabdata      1      1      0
radix_tree_node     1144   8414    276   14    1 : tunables   54   27 
  8 : slabdata    601    601      0
bdev_cache            12     35    512    7    1 : tunables   54   27 
  8 : slabdata      5      5      0
mnt_cache             34     62    128   31    1 : tunables  120   60 
  8 : slabdata      2      2      0
inode_cache         1227   1430    344   11    1 : tunables   54   27 
  8 : slabdata    130    130      0
dentry_cache        2580   5174    152   26    1 : tunables  120   60 
  8 : slabdata    199    199      0
filp                 268    375    256   15    1 : tunables  120   60 
  8 : slabdata     25     25      0
names_cache            2      2   4096    1    1 : tunables   24   12 
  8 : slabdata      2      2      0
avc_node              12    600     52   75    1 : tunables  120   60 
  8 : slabdata      8      8      0
idr_layer_cache       51     87    136   29    1 : tunables  120   60 
  8 : slabdata      3      3      0
buffer_head         1427  44325     52   75    1 : tunables  120   60 
  8 : slabdata    591    591      0
mm_struct             50     50    768    5    1 : tunables   54   27 
  8 : slabdata     10     10      0
vm_area_struct       471   1260     88   45    1 : tunables  120   60 
  8 : slabdata     28     28      0
fs_cache              48    183     64   61    1 : tunables  120   60 
  8 : slabdata      3      3      0
files_cache           49     63    512    7    1 : tunables   54   27 
  8 : slabdata      9      9      0
signal_cache          77    186    128   31    1 : tunables  120   60 
  8 : slabdata      6      6      0
sighand_cache         70    100   1408    5    2 : tunables   24   12 
  8 : slabdata     20     20      0
task_struct           91    140   1408    5    2 : tunables   24   12 
  8 : slabdata     28     28      0
anon_vma             196    678     16  226    1 : tunables  120   60 
  8 : slabdata      3      3      0
pgd                   63    357     32  119    1 : tunables  120   60 
  8 : slabdata      3      3      0
pmd                   57     57   4096    1    1 : tunables   24   12 
  8 : slabdata     57     57      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4 
  0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4 
  0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4 
  0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4 
  0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4 
  0 : slabdata      0      0      0
size-32768            11     11  32768    1    8 : tunables    8    4 
  0 : slabdata     11     11      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4 
  0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4 
  0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4 
  0 : slabdata      0      0      0
size-8192             10     10   8192    1    2 : tunables    8    4 
  0 : slabdata     10     10      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12 
  8 : slabdata      0      0      0
size-4096            357    357   4096    1    1 : tunables   24   12 
  8 : slabdata    357    357      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12 
  8 : slabdata      0      0      0
size-2048             90     90   2048    2    1 : tunables   24   12 
  8 : slabdata     45     45      0
size-1620(DMA)         0      0   1664    4    2 : tunables   24   12 
  8 : slabdata      0      0      0
size-1620             15     20   1664    4    2 : tunables   24   12 
  8 : slabdata      5      5      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27 
  8 : slabdata      0      0      0
size-1024            192    192   1024    4    1 : tunables   54   27 
  8 : slabdata     48     48      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27 
  8 : slabdata      0      0      0
size-512             446   2216    512    8    1 : tunables   54   27 
  8 : slabdata    277    277      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60 
  8 : slabdata      0      0      0
size-256             309   1620    256   15    1 : tunables  120   60 
  8 : slabdata    108    108      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60 
  8 : slabdata      0      0      0
size-128            1628   4340    128   31    1 : tunables  120   60 
  8 : slabdata    140    140      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60 
  8 : slabdata      0      0      0
size-64            12675  14213     64   61    1 : tunables  120   60 
  8 : slabdata    233    233      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60 
  8 : slabdata      0      0      0
size-32             2608  16660     32  119    1 : tunables  120   60 
  8 : slabdata    140    140      0
kmem_cache           150    150    256   15    1 : tunables  120   60 
  8 : slabdata     10     10      0

vmstat log is

Sat Jun 25 14:19:02 2005: procs -----------memory---------- ---swap--
-----io---- --system-- ----cpu----
Sat Jun 25 14:19:02 2005:  r  b   swpd   free   buff  cache   si   so 
  bi    bo   in    cs us sy id wa
Sat Jun 25 14:19:02 2005:  1  1      0 3895396   8152  22008    0    0
   15   100  255    21  0  0 97  3
Sat Jun 25 14:19:03 2005:  1  0      0 3706084   8384 205856    0    0
 1444     0 1054   218  0 24 73  3
Sat Jun 25 14:19:04 2005:  2  0      0 3504228   8948 392752    0    0
    8  8332 1007   125  1 25 74  0
Sat Jun 25 14:19:05 2005:  0  3      0 3378572   9056 498464    0    0
    4 25716 1027   159  0 17 40 43
Sat Jun 25 14:19:06 2005:  0  2      0 3244172   9256 627484    0    0
    4 21672 1003   159  1 20 29 50
Sat Jun 25 14:19:07 2005:  1  3      0 3167564   9328 703072    0    0
    0 20520 1028   160  0 13 34 53
Sat Jun 25 14:19:08 2005:  2  3      0 3023372   9412 783328    0    0
    4 68348 1009   151  0 17  6 76
Sat Jun 25 14:19:09 2005:  1  4      0 2559700   9524 882796    0    0
    4 356732 1014   193  0 40  1 58
Sat Jun 25 14:19:10 2005:  0  5      0 2197460   9728 1009212    0   
0     4 229848 1005   192  2 38  0 60
Sat Jun 25 14:19:11 2005:  1  3      0 2121556   9824 1106356    0   
0     0     0 1033   162  0 13 13 74
Sat Jun 25 14:19:12 2005:  1  3      0 2097748   9868 1146352    0   
0     4     0 1013   133  0  5 25 70
Sat Jun 25 14:19:13 2005:  0  4      0 1994148   9984 1264276    0   
0     4     0 1027   151  0 16 20 64
Sat Jun 25 14:19:14 2005:  1  4      0 1972580  10032 1305828    0   
0     0   124 1015   131  0  6  0 95
Sat Jun 25 14:19:15 2005:  1  4      0 1895588  10124 1395176    0   
0     4     4 1028   180  1 12 18 70
Sat Jun 25 14:19:16 2005:  0  4      0 1783716  10252 1522188    0   
0     4     0 1015   141  0 17  0 83
Sat Jun 25 14:19:17 2005:  1  3      0 1762316  10296 1565304    0   
0     0     0 1042   157  0  6  0 94
Sat Jun 25 14:19:18 2005:  0  4      0 1690764  10384 1651276    0   
0     4     0 1014   142  1 13 16 71
Sat Jun 25 14:19:19 2005:  0  4      0 1648716  10440 1709460    0   
0     0     0 1033   150  0  9 15 76
Sat Jun 25 14:19:20 2005:  0  5      0 1653644  10456 1725824    0   
0     0     4 1018   142  0  3  0 97
Sat Jun 25 14:19:21 2005:  0  5      0 1656524  10468 1734132    0   
0     0    20 1032   153  0  1  0 99
Sat Jun 25 14:19:22 2005:  0  4      0 1650380  10500 1762700    0   
0     0     4 1016   144  0  5  0 95
Sat Jun 25 14:19:23 2005: procs -----------memory---------- ---swap--
-----io---- --system-- ----cpu----
Sat Jun 25 14:19:23 2005:  r  b   swpd   free   buff  cache   si   so 
  bi    bo   in    cs us sy id wa
Sat Jun 25 14:19:23 2005:  0  4      0 1657292  10512 1775168    0   
0     0     0 1031   160  0  2  0 98
Sat Jun 25 14:19:24 2005:  0  4      0 1669324  10520 1780100    0   
0     4     0 1018   130  0  1  0 99
Sat Jun 25 14:19:25 2005:  0  4      0 1658316  10552 1812048    0   
0     0     0 1031   158  0  5  0 95
Sat Jun 25 14:19:26 2005:  0  4      0 1652620  10592 1830728    0   
0     0     0 1011   146  0  3 24 73
Sat Jun 25 14:19:27 2005:  0  4      0 1652812  10612 1851248    0   
0     0     0 1031   169  0  3 25 72
Sat Jun 25 14:19:28 2005:  0  4      0 1655372  10628 1867612    0   
0     0     0 1014   146  0  3 25 72
Sat Jun 25 14:19:29 2005:  0  4      0 1658508  10640 1879820    0   
0     0     0 1028   166  0  2 25 73
Sat Jun 25 14:19:30 2005:  0  4      0 1660172  10660 1900340    0   
0     0     0 1018   146  0  3 25 72
Sat Jun 25 14:19:31 2005:  0  5      0 1665804  10680 1916700    0   
0     4     4 1034   164  0  3 25 72
Sat Jun 25 14:19:32 2005:  0  5      0 1664780  10692 1929168    0   
0     0     0 1012   140  0  2 25 73
Sat Jun 25 14:19:33 2005:  0  5      0 1661068  10720 1953580    0   
0     0    52 1032   166  0  4 25 71
Sat Jun 25 14:19:34 2005:  0  4      0 1659020  10744 1974096    0   
0     0     4 1014   145  0  3 25 72
Sat Jun 25 14:19:35 2005:  1  3      0 1659660  10764 1994096    0   
0     0     0 1031   173  0  3 25 72
Sat Jun 25 14:19:36 2005:  1  3      0 16594
