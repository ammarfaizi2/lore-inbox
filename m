Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289338AbSBEAPK>; Mon, 4 Feb 2002 19:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289314AbSBEAPB>; Mon, 4 Feb 2002 19:15:01 -0500
Received: from relay-1v.club-internet.fr ([194.158.96.112]:26097 "HELO
	relay-1v.club-internet.fr") by vger.kernel.org with SMTP
	id <S289326AbSBEAOr>; Mon, 4 Feb 2002 19:14:47 -0500
Message-ID: <3C5F24A1.1060401@freesurf.fr>
Date: Tue, 05 Feb 2002 01:17:37 +0100
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020201
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.18-pre3-mjc3] heavy disk load and non-killable process
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I've a 2.4.18-pre3-mjc3 kernel, with preempt enabled. I was testing 
relative performance of DMA and non-DMA IDE hard disk access,
and I did the following as root:

~ # hdparm -X67 -d1 /dev/hdb
~ # time /bin/sh -c "cp foo bar; sync"
~ # time /bin/sh -c "cp foo bar; sync"
~ # time /bin/sh -c "cp foo bar; sync"
~ # hdparm -X12 -d0 /dev/hdb
~ # time /bin/sh -c "cp foo bar; sync"
~ # time /bin/sh -c "cp foo bar; sync"
~ # time /bin/sh -c "cp foo bar; sync"
(foo is a 64Mb large regular file)

I had xmms running, and during the first two tests of the non-DMA 
version, the sound stops and then restarts, but it didn't restart after 
the last cp.

What is strange (and may be a kernel bug IMHO) is that the xmms process 
stays running and non-killable:

(kilobug@drizzt, 53) ~ $ ps aux | grep xmms
kilobug   1346  0.1  0.4  5792 2424 ?        S    Feb03   3:13 wmxmms
kilobug  12452  8.4  1.3 25104 6936 ?        R    00:56   0:38 xmms -p
kilobug  12590  0.0  0.1  1732  684 pts/4    S    01:03   0:00 grep xmms
(kilobug@drizzt, 54) ~ $ kill -9 12452
(kilobug@drizzt, 55) ~ $ ps aux | grep xmms
kilobug   1346  0.1  0.4  5792 2424 ?        S    Feb03   3:13 wmxmms
kilobug  12452  8.9  1.3 25104 6936 ?        R    00:56   0:40 xmms -p
kilobug  12592  0.0  0.1  1732  684 pts/4    S    01:03   0:00 grep xmms

Top says that xmms takes half of the CPU time, the other half being used 
by a low priority process:

   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
12452 kilobug   34   0 25104 6936   384 R    48.7  1.3   3:42 xmms
   685 kilobug   39  19 50080  17M     0 R N  48.4  3.4  1932m ghclient.x

Here is a cat /proc/meminfo:

(kilobug@drizzt, 57) /var $ cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  527327232 355241984 172085248        0 43528192 109633536
Swap: 296099840 40099840 256000000
MemTotal:       514968 kB
MemFree:        168052 kB
MemShared:           0 kB
Buffers:         42508 kB
Cached:          91764 kB
SwapCached:      15300 kB
Active:         286872 kB
Inact_dirty:     22708 kB
Inact_clean:         0 kB
Inact_target:    61916 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514968 kB
LowFree:        168052 kB
SwapTotal:      289160 kB
SwapFree:       250000 kB

(kilobug@drizzt, 59) ~ $ uptime
  01:15:41 up 1 day, 14:39,  5 users,  load average: 3.33, 3.38, 3.36

I can send you additional informations if you want so (I'll try to avoid 
shuting down the box and the X server as long as needed).

All mounted partitions (including swap) are from /dev/hdb, an IDE 
Western Digital disk (cat /proc/ide/hdb/model says WDC WD300BB-00AUA1), 
and I've unmasked IRQs with hdparm on it at boot time.

lspci says:
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate] 
System Controller (rev 13)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate] AGP 
Bridge
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.4 Non-VGA unclassified device: VIA Technologies, Inc. VT82C686 
[Apollo Super ACPI] (rev 40)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
00:0b.1 Input device controller: Creative Labs SB Live! (rev 01)
00:0c.0 Multimedia video controller: Brooktree Corporation Bt848 TV with 
DMA push (rev 12)
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon QD

Hoping I can help you,

-- 
** Gael Le Mignot "Kilobug", Ing3 EPITA - http://kilobug.free.fr **
Home Mail   : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

"Software is like sex it's better when it's free.", Linus Torvalds

