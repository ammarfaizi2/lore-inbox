Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUCBLNm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 06:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUCBLNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 06:13:42 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:49580 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261608AbUCBLNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 06:13:32 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Known problems with megaraid under 2.4.25 highmem?
Date: Tue, 2 Mar 2004 12:16:20 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, Atul Mukker <atulm@lsil.com>
References: <200402271107.42050.tvrtko@croadria.com> <Pine.LNX.4.58L.0402271548290.18958@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402271548290.18958@logos.cnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_E0GRARE8Ffaf69X"
Message-Id: <200403021216.20805.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_E0GRARE8Ffaf69X
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 27 February 2004 19:52, Marcelo Tosatti wrote:
> Hi,
>
> Not known to me...
>
> Can you get any traces from the lockup? NMI watchdog or sysrq+p and +t?
>
> Did any previous 2.4.x work reliably?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Ok I have pinpointed the bug. This time I was unable to reproduce the actual 
lockup in a way which disables me from issuing additional commands, but I 
think that the sole reason for that was that everything I need was already 
running.

Everything I describe below is regardless of irqbalance being run or not. 
Attached logs and outputs are from my first test w/ irqbalance. But the 
second test wo/ it is 100% the same except for the interrupts being solely on 
the CPU0.

These are the disks:

megaraid: v1.18k (Release Date: Thu Aug 28 10:05:11 EDT 2003)
megaraid: found 0x1000:0x1960:idx 0:bus 4:slot 2:func 0
scsi2 : Found a MegaRAID controller at 0xf8842000, IRQ: 52
scsi2 : Enabling 64 bit support
megaraid: [1L19:1.04] detected 2 logical drives
megaraid: supports extended CDBs.
megaraid: channel[1] is raid.
megaraid: channel[2] is raid.
scsi2 : LSI Logic MegaRAID 1L19 254 commands 15 targs 5 chans 7 luns
scsi2: scanning virtual channel 0 for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID1 35002R  Rev: 1L19
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7dff018, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: MegaRAID  Model: LD1 RAID5 70004R  Rev: 1L19
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7bd3c18, I/O limit 4095Mb (mask 0xffffffff)
scsi2: scanning virtual channel 1 for logical drives.
scsi2: scanning virtual channel 2 for logical drives.
scsi2: scanning physical channel 0 for devices.
scsi2: scanning physical channel 1 for devices.
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi2, channel 0, id 1, lun 0
SCSI device sda: 71684096 512-byte hdwr sectors (36702 MB)
Partition check:
 sda: sda1
SCSI device sdb: 143368192 512-byte hdwr sectors (73405 MB)
 sdb: sdb1 sdb2 sdb3 sdb4

What did I do is start two instances of tarring the root fs (sda) to home fs 
(sdb). While tar is working, I try to run lilo. Then it is stuck until tar's 
finish their jobs.

I abrupted them with 2x kill to prove that. After tar's vanish, it takes for 
some time until cache gets written out to the disk (see vmstat) and only then 
lilo finishes its job.

You can see detailed logs attached below. I think everything will be clear to 
you after that. 

I you need more hw info on our server I will be glad to get them from you.

Regards,
Tvrtko A. Ursulin






--Boundary-00=_E0GRARE8Ffaf69X
Content-Type: text/plain;
  charset="iso-8859-2";
  name="hydra-io-report-1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hydra-io-report-1.txt"


[root@hydra tmp]# tar -clf root1.tar / &
[1] 32724
[root@hydra tmp]# tar: Removing leading `/' from member names

[root@hydra tmp]# tar -clf root2.tar / &
[2] 32741
[root@hydra tmp]# tar: Removing leading `/' from member names

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  5  4   1940  10376  10548 828296   0   0 20700 18116  874  1087   1   8  90
 0  3  3   1940  10468  10240 828964   0   0 18504 14888  865  1198   2   8  90
 0  3  3   1940  10544   9936 828764   0   0 19164 18424  888   975   1   8  91
 0  6  5   1940  10300   9864 827884   0   0 22308 17436  912  1354   1   9  90
 0  5  4   1940  10672   9784 826580   0   0 19728 15900  865  1289   6   9  85
 0  7  4   1940  10464   9796 824024   0   0 14792 16912  778  1307   3   9  88
 0  7  4   1940  10616   9752 823656   0   0 21396 16832  945  1628   2   9  89
 0  6  4   1940  10436   9704 822980   0   0 17260 14764  830  1399   3   7  90
 0  7  3   1940  10380   9664 823300   0   0 14576 16496  800  1612   1   6  93
 0  3  3   1940  10408   9652 823340   0   0 15684 15624  831  1123   0   6  94
 3  4  4   1940  11428   9604 820984   0   0 18352 14080  809  1300   5   9  86
 0  4  4   1940  10364   9576 823272   0   0 18116 18392  898  1608   4   9  87
 0  5  4   1940  10392   9536 824252   0   0 20804 18340  858  1082   0   7  93
 0  4  4   1940  10712   9520 824100   0   0 17580 13620  765  1403   1   8  91
 0  4  4   1940  10484   9484 824280   0   0 20164 17532  829  1277   2   9  89
 0  3  3   1940  10432   9456 824404   0   0 15196 16220  707  1079   0   7  93
 0  4  3   1940  10392   9416 824472   0   0 13568 18888  707   868   0   3  96
 0  4  3   1940  10396   9340 824280   0   0 27672 18884  988  1400   1  10  89
 0  4  3   1940  10512   9312 824268   0   0 19560 17568  795  1073   1   7  91
 0  5  4   1940  10292   9336 824692   0   0 18952 17616  823  1184   2   9  89
 0  4  3   1940  10296   9344 824156   0   0 17996 13096  734  1396   1   9  90
 0  3  3   1940  10688   9304 824464   0   0 21440 20312  895  1106   0   9  91
 0  3  3   1940  10444   9296 824704   0   0 17080 17824  765   992   0   6  94
 3  2  4   1940  11952   9268 823044   0   0 20716 19656  955  1290   1   8  91
 0  6  4   1940  10280   9260 824624   0   0 18536 18956  917  1079   1   9  90
 0  3  2   1940  12068   9236 823064   0   0 21776 17744  942   871   2   9  89
 0  4  2   1940  13088   9212 822196   0   0 16796 17348  756   629   0   5  95

[root@hydra root2]# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:     797950      33055      33034      32696    IO-APIC-edge  timer
  1:          2          0          0          0    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  4:          3          0          0          0    IO-APIC-edge  serial
  8:          1          0          0          0    IO-APIC-edge  rtc
 14:          4          0          1          0    IO-APIC-edge  ide0
 30:         30          0          0          0   IO-APIC-level  aic79xx
 31:         30          0          0          0   IO-APIC-level  aic79xx
 52:    1324531          0     390080     135281   IO-APIC-level  megaraid
 58:     461362          0          0          0   IO-APIC-level  eth0
 59:       4907        829          0          0   IO-APIC-level  eth1
NMI:          0          0          0          0
LOC:     896466     896459     896446     896469
ERR:          0
MIS:          0

[root@hydra tmp]# lilo
Added linux-old
Added linux
Added 2.4.25 *
Added 2.4.25-grsec
<stuck here>

root     32724 15.5  0.0  2124  936 pts/1    D    11:39   0:07 tar -clf root1.tar /
root     32741 14.1  0.0  2124  940 pts/1    D    11:39   0:05 tar -clf root2.tar /
root       754  4.5  0.0  1584  592 pts/1    D    11:40   0:01 lilo

 0  7  3   1940  14112   8960 825020   0   0 14888 14764  708   745   0   7  93
 0  4  3   1940  12892   8980 827044   0   0 18324 17004  799   787   1   5  94
 0  5  3   1940  12772   9004 826904   0   0 17564 18652  827   691   0   7  93
 0  5  2   1940  13164   9024 826492   0   0 17328 16584  764   871   1   4  95
 0  5  4   1940  13080   9068 826224   0   0 18716 18652  836   814   1   6  93
 0  7  3   1940  13684   9104 824524   0   0 15032 15576  765   852   2   5  92
 0  5  3   1940  13268   9128 824384   0   0 18084 18420  840   772   1   7  92
 0  4  3   1940  13300   9148 826000   0   0 15136 15528  666   575   0   5  95
 0  4  3   1940  12968   9176 826312   0   0 15752 14696  675   484   0   5  94
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  5  2   1940  13424   9200 825276   0   0 14584 16296  668   605   1   5  93
 0  4  2   1940  13652   9216 825004   0   0 20788 19496  838   691   0   6  94
 0  4  3   1940  13180   9224 825456   0   0 21260 21368  872   729   1   9  90
 0  4  3   1940  13348   9244 825328   0   0 17804 17840  756   649   1   7  92
 0  4  4   1940  14348   9284 824448   0   0 15620 15832  690   570   1   5  94
 0  4  3   1940  13444   9292 825616   0   0 16528 17196  739   649   0   6  94
 1  4  3   1940  13236   9320 825780   0   0 15500 14540  651   503   0   4  95
 0  3  2   1940  13004   9348 826076   0   0 15496 15460  673   585   1   6  93
 0  3  2   1940  13540   9372 825528   0   0 17928 20168  855   691   0   6  94
 1  4  3   1940  13292   9400 825792   0   0 22008 20176  879   840   1   5  94
 0  6  3   1940  11720   9452 827348   0   0 16236 17032  785   634   1   6  93
 0  7  2   1940  12856   9476 826184   0   0 19352 19072  813   684   1   6  93


kill 32724
kill 32741

 0  4  3   1940  13248  10804 819868   0   0 20524 21448  921   947   1   6  93
 0  4  2   1940  13216  10840 819820   0   0 17304 17504  785   633   0   5  94
 0  5  3   1940  13120  10876 819672   0   0 22176 22380  935   983   2   9  89
 0  3  2   1940  13280  10836 819292   0   0 17300 16540  787   663   0   7  93
 0  4  4   1940  13660  10848 818620   0   0 16400 17292  767   700   1   5  94
 0  3  2   1940  13368  10900 818792   0   0 18968 18384  815   808   2   6  91
 0  3  2   1940  13196  10920 819268   0   0 19340 21400  868   755   0   6  94
 0  2  2   1940  12736  10936 819608   0   0 10936 18572  682   531   0   3  97
 0  1  2   1940  15232  10952 817080   0   0    16 15432  480   495   1   1  98
 0  1  2   1940  15744  10976 817088   0   0     8 17336  468   194   0   0  99
 0  5  3   1940  15604  10976 817140   0   0    48 20228  539   207   0   1  99
 0  1  2   1940  15512  10984 817160   0   0    16 15084  424   169   0   0 100
 0  1  2   1940  15728  10984 817164   0   0     0 17380  457   132   0   0 100
 0  2  3   1940  15696  10988 817168   0   0     4 19924  501   171   0   1  99
 0  2  3   1940  15512  11036 817176   0   0     4 10556  502   533   3   2  95
 0  2  2   1940  15256  11108 817180   0   0     4  8268  409   187   2   2  95
 0  1  2   1940  15512  11116 817184   0   0     0  9244  378   155   0   0  99
 0  1  2   1940  15328  11140 817196   0   0     8 16056  470   319   2   1  97
 0  2  2   1940  15100  11144 817196   0   0     4 16848  495   227   1   0  99
 0  2  2   1940  13900  11188 818212   0   0  1024 15548  529   306   2   1  97
 0  3  3   1940  14380  11204 817660   0   0   160 13336  481   484   1   1  98
 0  1  2   1940  14328  11240 817736   0   0    68 13960  493   307   2   0  98
 0  1  2   1940  14268  11256 817748   0   0    16 17888  498   215   0   0  99
 0  2  2   1940  14260  11256 817760   0   0     4 18792  532   190   0   0  99
 0  2  3   1940  14800  11288 817768   0   0     4 19048  555   260   1   1  98
 0  1  2   1940  15336  11296 817808   0   0    44 16468  456   163   0   0 100
 0  1  1   1940  15324  11312 817856   0   0    56 17584  485   169   1   0  99
 0  3  1   1940  15180  11324 817856   0   0    12 19984  496   250   1   1  98
 0  2  1   1940  15060  11336 817916   0   0    56  9492  367   150   0   0  99
 0  3  1   1940  14764  11388 817960   0   0    40 14960  474   312   1   1  97
 0  1  1   1940  14664  11404 818016   0   0    48  8640  347   190   0   1  99
 0  1  1   1940  14576  11448 818128   0   0   124 17324  495   296   1   1  98
 0  1  1   1940  14496  11456 818168   0   0    36 13792  410   142   0   0  99
 0  1  1   1940  14404  11456 818184   0   0    12 14284  406   273   1   0  99
 0  1  1   1940  14300  11496 818188   0   0     0 14364  454   188   1   0  99
 0  1  1   1940  13504  11504 818196   0   0     0  9828  352   227   2   1  97
 0  3  1   1940  14700  11524 816712   0   0    28 12372  397   217   1   1  98
 0  4  0   1940  15592  11628 816780   0   0    80  4400  775   378   1   5  94
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0   1940  15796  11656 816800   0   0    16   192  207   155   1   0  98
 0  0  0   1940  14676  11656 816836   0   0    28     0  196   369   2   0  97
 0  0  0   1940  15364  11656 816844   0   0     4     0  176    74   0   0  99

[1]-  Terminated              tar -clf root1.tar /
[2]+  Terminated              tar -clf root2.tar /
[root@hydra tmp]#


--Boundary-00=_E0GRARE8Ffaf69X--
