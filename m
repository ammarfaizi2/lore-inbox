Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSGTAHq>; Fri, 19 Jul 2002 20:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSGTAHq>; Fri, 19 Jul 2002 20:07:46 -0400
Received: from jalon.able.es ([212.97.163.2]:51342 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317232AbSGTAHp>;
	Fri, 19 Jul 2002 20:07:45 -0400
Date: Sat, 20 Jul 2002 02:10:41 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1
Message-ID: <20020720001041.GA1735@werewolf.able.es>
References: <288F9BF66CD9D5118DF400508B68C4460283E2F5@orsmsx113.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <288F9BF66CD9D5118DF400508B68C4460283E2F5@orsmsx113.jf.intel.com>; from scott.feldman@intel.com on Sat, Jul 20, 2002 at 01:05:55 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.20 "Feldman, Scott" wrote:
>Jamagallon wrote:
>
>> >diff between 2.4.19rc1aa2 and 2.4.19rc1aa2:
>> >
>> >Only in 2.4.19rc1aa2: 000_e100-2.0.30-k1.gz
>> >Only in 2.4.19rc2aa1: 000_e100-2.1.6.gz
>> >Only in 2.4.19rc1aa2: 000_e1000-4.2.17-k1.gz
>> >Only in 2.4.19rc2aa1: 000_e1000-4.3.2.gz
>> >
>
>>More on this.
>
>>We have two interfaces:
>>04:04.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
>03:01.0 Ethernet
>>controller: Intel Corp. 82543GC Gigabit Ethernet Controller (rev 02)
>
>>NetPipe (tcp) shows numbers like 80Mb/s for e100 and 500Mb/s for e1000. So
>efficiency is much >much higher for e100 driver+card than e1000. I have to
>dig, perhaps e100 is doing zerocopy and >e1000 is not ?
>
>>Any ideas ?
>
>If e100 is sending from the zerocopy path, e1000 is doing the same.
>

e100.txt:
   - Support for Zero copy on 82550-based adapters. This feature provides 
     faster data throughput and significant CPU usage improvement in systems 
     that use the relevant system call (sendfile(2)).
  (does this include the on-board 82557, not even listed in e100.txt ? )

e1000.txt
   - Zero copy. This feature provides faster data throughput. Enabled by 
     default in supporting kernels. It is not supported on the Intel(R) 
     PRO/1000 Gigabit Server Adapter. (==82542)
  (so I 

>There are several factors that may be limiting your throughput on e1000.
>Assuming you have enough CPU umph and bus bandwidth, and your netpipe link
>partner and switch are willing, you should be able to approach wire speed.
>

Master/sender:
	Dual P4Xeon 1.8GHz, Pro/1000 T Server Board (64bit slot, 66MHz)
Slave/receiver:
	Dual PIII 1GHz, same board, same slot
Switch:
	Intel(R) NetStructure(TM) 470T

netpipe over e100:
Node receiver...
Master transmitter...
Latency: 0.000057
Now starting main loop
  0:      4096 bytes    7 times -->   24.96 Mbps in 0.001252 sec
  1:      8192 bytes    7 times -->   46.45 Mbps in 0.001345 sec
  2:     12288 bytes   92 times -->   46.03 Mbps in 0.002037 sec
  3:     16384 bytes   81 times -->   58.32 Mbps in 0.002143 sec
  4:     20480 bytes   87 times -->   56.26 Mbps in 0.002777 sec
  5:     24576 bytes   72 times -->   71.59 Mbps in 0.002619 sec
  6:     28672 bytes   79 times -->   62.76 Mbps in 0.003486 sec
  7:     32768 bytes   61 times -->   75.23 Mbps in 0.003323 sec
  8:     36864 bytes   65 times -->   66.52 Mbps in 0.004228 sec
  9:     40960 bytes   52 times -->   77.20 Mbps in 0.004048 sec
 10:     45056 bytes   55 times -->   69.32 Mbps in 0.004959 sec
 11:     49152 bytes   45 times -->   74.98 Mbps in 0.005002 sec
 12:     53248 bytes   45 times -->   71.41 Mbps in 0.005689 sec
 13:     57344 bytes   40 times -->   76.24 Mbps in 0.005738 sec
 14:     61440 bytes   40 times -->   73.03 Mbps in 0.006419 sec
 15:     65536 bytes   36 times -->   77.13 Mbps in 0.006483 sec
 16:     69632 bytes   36 times -->   74.10 Mbps in 0.007170 sec
 17:     73728 bytes   32 times -->   78.04 Mbps in 0.007208 sec
 18:     77824 bytes   32 times -->   75.42 Mbps in 0.007872 sec
 19:     81920 bytes   30 times -->   78.61 Mbps in 0.007950 sec
 20:     86016 bytes   29 times -->   76.45 Mbps in 0.008584 sec

(around 75Mb/s, 75% of bandwidth)

netpipe over e1000:
Node receiver...
Master transmitter...
Latency: 0.000058
Now starting main loop
  0:      4096 bytes    7 times -->  204.44 Mbps in 0.000153 sec
  1:      8192 bytes    7 times -->  303.61 Mbps in 0.000206 sec
  2:     12288 bytes  607 times -->  361.83 Mbps in 0.000259 sec
  3:     16384 bytes  643 times -->  408.76 Mbps in 0.000306 sec
  4:     20480 bytes  613 times -->  424.47 Mbps in 0.000368 sec
  5:     24576 bytes  543 times -->  458.94 Mbps in 0.000409 sec
  6:     28672 bytes  509 times -->  474.85 Mbps in 0.000461 sec
  7:     32768 bytes  465 times -->  491.99 Mbps in 0.000508 sec
  8:     36864 bytes  430 times -->  443.68 Mbps in 0.000634 sec
  9:     40960 bytes  350 times -->  448.35 Mbps in 0.000697 sec
 10:     45056 bytes  322 times -->  455.34 Mbps in 0.000755 sec
 11:     49152 bytes  301 times -->  464.07 Mbps in 0.000808 sec
 12:     53248 bytes  283 times -->  464.18 Mbps in 0.000875 sec
 13:     57344 bytes  263 times -->  467.06 Mbps in 0.000937 sec
 14:     61440 bytes  247 times -->  476.95 Mbps in 0.000983 sec
 15:     65536 bytes  237 times -->  482.73 Mbps in 0.001036 sec
 16:     69632 bytes  226 times -->  488.26 Mbps in 0.001088 sec
 17:     73728 bytes  216 times -->  473.16 Mbps in 0.001189 sec
 18:     77824 bytes  198 times -->  472.22 Mbps in 0.001257 sec
 19:     81920 bytes  188 times -->  481.13 Mbps in 0.001299 sec
 20:     86016 bytes  182 times -->  478.84 Mbps in 0.001371 sec

(peak at 491, not even 50% bandwith...)

I have not played with sysctl:
annwn:/proc/sys/net/ipv4> cat tcp_wmem
4096    16384   131072
annwn:/proc/sys/net/ipv4> cat tcp_rmem
4096    87380   174760

Something can be limiting bandwith in the switch ???

TIA

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc2-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.8mdk)
