Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbRAMSWj>; Sat, 13 Jan 2001 13:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAMSWT>; Sat, 13 Jan 2001 13:22:19 -0500
Received: from denise.shiny.it ([194.20.232.1]:34323 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S130194AbRAMSWR>;
	Sat, 13 Jan 2001 13:22:17 -0500
Message-ID: <3A608538.4D9CF077@denise.shiny.it>
Date: Sat, 13 Jan 2001 11:41:28 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.1-pre1 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: axboe@suse.de
CC: linux-kernel@vger.kernel.org
Subject: blk-13B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I found the time to make some tests with 2.4 and the blk-13B patch.
It performs very well, no process starvation, no missed merges,
etc., but sometimes it happens dbflush and kswapd start eating
100% CPU for about 20-30 secs.:

 11:02am  up 18 min,  5 users,  load average: 2.74, 1.97, 1.15
66 processes: 60 sleeping, 6 running, 0 zombie, 0 stopped
CPU states:  2.7% user, 97.2% system,  0.0% nice,  0.0% idle
Mem:  189568K av, 188520K used,   1048K free, 209144K shrd,   1168K buff
Swap: 262136K av,      0K used, 262136K free                122764K cached

 PID USER   PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
   3 root    20   0     0    0     0 SW      0 45.1  0.0   0:21 kswapd
   5 root    14   0     0    0     0 RW      0 44.5  0.0   0:29 bdflush
 606 Giu      9   0   464  464   352 R       0  3.6  0.2   0:02 cp
 543 Giu      9   0   604  604   472 S       0  1.9  0.3   0:14 vmstat


vmstat doesn't show anything strange at the same time:

   procs                    memory    swap          io     system         cpu
 r  b  w  swpd  free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0    0   1048   1304 122564   0   0  8960  4486  156   771  11  25  64
 3  0  0    0   1048   1304 122564   0   0  9856  4996  123   622   3  30  67
 1  0  1    0   1048   1304 122564   0   0  4096  1867   62   431   1  76  23
 2  0  1    0   1048   1304 122560   0   0  1920   963   26   130   1  99   0
 4  1  2    0   1048   1304 122564   0   0  1536   647  164   271   3  97   0
 2  0  2    0   1048   1304 122564   0   0   760   516  139   482   6  94   0
 1  1  2    0   1048   1304 122560   0   0   896   461  275   932  10  90   0
 1  0  2    0   1048   1304 122552   0   0   672   452  130   988   7  93   0
 1  0  2    0   1048   1304 122552   0   0   896   520  180  1905  11  89   0
 2  0  2    0   1052   1304 122552   0   0   512   515   26   462   4  96   0
 1  1  2    0   1048   1304 122556   0   0   740   519  109   428   1  99   0
 3  0  1    0   1048   1228 122624   0   0  1052   516   23   175   4  96   0

The scsi driver reported it was writing large contiguous blocks and, 30secs
later, a few 10s of smaller non mergeable block. It's ok IMO.
ps doesn't show anything useful:

[Giu@Jay Giu]$ ps -xao cmd,wchan
CMD              WCHAN
init             do_select
[keventd]        context_thread
[kswapd]         -
[kreclaimd]      kreclaimd
[bdflush]        -
[kupdate]        kupdate
[khubd]          usb_hub_thread


The test is a large file copy from the HD to my MO. During the cp and
now there's nothing on the swap.
My config:

PowerPC 750, 192MB ram, 256MB swap, kernel 2.4.0-bitkeeper (the official
2.4 doesn't compile) + blk-13B, Adaptec 2930U, gcc 2.95.3. The rest is a
2.2.x distribution.


Bye.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
