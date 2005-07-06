Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVGFAgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVGFAgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 20:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVGFAgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 20:36:25 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:61646 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262023AbVGFAfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 20:35:33 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jens Axboe <axboe@suse.de>
Cc: Ondrej Zary <linux@rainbow-software.org>,
       =?ISO-8859-1?Q?=20Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
Date: Wed, 06 Jul 2005 10:35:13 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com>
References: <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org> <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de>
In-Reply-To: <20050705142122.GY1444@suse.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005 16:21:26 +0200, Jens Axboe <axboe@suse.de> wrote:
># gcc -Wall -O2 -o oread oread.c
># time ./oread /dev/hda

Executive Summary
``````````````````
Comparing 'oread' with hdparm -tT on latest 2.4 vs 2.6 stable on 
various x86 boxen.  Performance drops for 2.6, sometimes:
        2.4.31-hf1  2.6.12.2
peetoo: 26MB/s   -> 20MB/s,  oread similar    120GB + 80GB
silly:  22MB/s   -> 8.5MB/s, oread similar    13GB
tosh:   35MB/s   -> 23MB/s,  oread similar    40GB 2.5"
pooh:   17MB/s   -> 14MB/s,  oread 30 -> 24   40GB
menace: 11.5MB/s -> 13MB/s,  oread similar     6GB 2.5"

--Grant

The details, config, dmesg, etc from linked resources:

Intel SE440BX-2 with pII 400/100/512/2.0 CPU/FSB/L2/Vccp 
512MB SDRAM on 440BX + PIIX4
  http://scatter.mine.nu/test/linux-2.6/peetoo/

peetoo:~$ uname -r
2.4.31-hf1
peetoo:~$ time /home/share/install/oread /dev/hda

real    0m20.065s
user    0m0.010s
sys     0m0.810s
peetoo:~$ time /home/share/install/oread /dev/hdc

real    0m18.484s
user    0m0.000s
sys     0m0.800s
peetoo:~$ hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   444 MB in  2.00 seconds = 222.00 MB/sec
 Timing buffered disk reads:   84 MB in  3.06 seconds =  27.45 MB/sec
peetoo:~$ hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   456 MB in  2.01 seconds = 226.87 MB/sec
 Timing buffered disk reads:   76 MB in  3.00 seconds =  25.33 MB/sec
peetoo:~$ hdparm -tT /dev/hdc

/dev/hdc:
 Timing cached reads:   464 MB in  2.01 seconds = 230.85 MB/sec
 Timing buffered disk reads:   76 MB in  3.00 seconds =  25.33 MB/sec
peetoo:~$ hdparm -tT /dev/hdc

/dev/hdc:
 Timing cached reads:   460 MB in  2.00 seconds = 230.00 MB/sec
 Timing buffered disk reads:   82 MB in  3.00 seconds =  27.33 MB/sec
- - -
peetoo:~$ uname -r
2.6.12.2b
peetoo:~$ time /home/share/install/oread /dev/hda

real    0m21.428s
user    0m0.003s
sys     0m0.436s
peetoo:~$ time /home/share/install/oread /dev/hdc

real    0m17.588s
user    0m0.001s
sys     0m0.455s

peetoo:~$ cat /sys/block/hda/queue/scheduler
noop [deadline]
peetoo:~$ cat /sys/block/hdc/queue/scheduler
noop [deadline]
peetoo:~$ time /home/share/install/oread /dev/hda

real    0m21.417s
user    0m0.005s
sys     0m0.462s
peetoo:~$ time /home/share/install/oread /dev/hda

real    0m18.626s
user    0m0.006s
sys     0m0.440s
peetoo:~$ time /home/share/install/oread /dev/hdc

real    0m17.555s
user    0m0.005s
sys     0m0.422s
peetoo:~$ df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda3              2586348    563000   2023348  22% /
/dev/hdc3              2586348   1582716   1003632  62% /usr
/dev/hdc6              2586348   1217568   1368780  48% /usr/src
/dev/hda9             20562504  10821500   9741004  53% /home/install
/dev/hdc9             20562504   3634700  16927804  18% /home/public
/dev/hda10            41446344  39676256   1770088  96% /home/archive
deltree:/home/share    2064256   1042952   1021304  51% /home/share

peetoo:~$ hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   448 MB in  2.00 seconds = 223.81 MB/sec
 Timing buffered disk reads:   62 MB in  3.07 seconds =  20.17 MB/sec
peetoo:~$ hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   472 MB in  2.01 seconds = 234.40 MB/sec
 Timing buffered disk reads:   54 MB in  3.01 seconds =  17.97 MB/sec
peetoo:~$ hdparm -tT /dev/hdc

/dev/hdc:
 Timing cached reads:   456 MB in  2.01 seconds = 226.56 MB/sec
 Timing buffered disk reads:   62 MB in  3.08 seconds =  20.11 MB/sec
peetoo:~$ hdparm -tT /dev/hdc

o o o

EPoX EP-61LXA-M: Intel 440LX chipset with pentiumII/266 
on 66MHz FSB (4 x 66) with 128MB SDRAM
  http://scatter.mine.nu/test/linux-2.6/silly/

root@silly:~# uname -r
2.4.31-hf1
root@silly:~# time /home/share/install/oread /dev/hda

real    0m23.657s
user    0m0.000s
sys     0m1.300s
root@silly:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   356 MB in  2.02 seconds = 176.24 MB/sec
 Timing buffered disk reads:   68 MB in  3.04 seconds =  22.37 MB/sec
root@silly:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   344 MB in  2.00 seconds = 172.00 MB/sec
 Timing buffered disk reads:   68 MB in  3.03 seconds =  22.44 MB/sec
- - -
root@silly:~# uname -r
2.6.12.2a
root@silly:~# time /home/share/install/oread /dev/hda

real    0m23.569s
user    0m0.005s
sys     0m0.563s

root@silly:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   336 MB in  2.00 seconds = 167.77 MB/sec
 Timing buffered disk reads:   50 MB in  3.05 seconds =  16.37 MB/sec
root@silly:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   340 MB in  2.01 seconds = 169.01 MB/sec
 Timing buffered disk reads:   28 MB in  3.22 seconds =   8.70 MB/sec
root@silly:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   336 MB in  2.01 seconds = 167.44 MB/sec
 Timing buffered disk reads:   26 MB in  3.05 seconds =   8.52 MB/sec
root@silly:~# echo deadline > /sys/block/hda/queue/scheduler
root@silly:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   336 MB in  2.01 seconds = 166.77 MB/sec
 Timing buffered disk reads:   26 MB in  3.19 seconds =   8.14 MB/sec
root@silly:~#

o o o

Intel Celeron (coppermine pIII) 500MHz with 192MB SDRAM
on Intel 440BX/ZX + PIIX4E (Toshiba laptop)
  http://scatter.mine.nu/test/linux-2.6/tosh/

root@tosh:~# uname -r
2.4.31-hf1
root@tosh:~# time /home/share/install/oread /dev/hda

real    0m18.079s
user    0m0.000s
sys     0m0.680s
root@tosh:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   516 MB in  2.00 seconds = 258.00 MB/sec
 Timing buffered disk reads:   74 MB in  3.02 seconds =  24.50 MB/sec
root@tosh:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   520 MB in  2.01 seconds = 258.71 MB/sec
 Timing buffered disk reads:   84 MB in  3.03 seconds =  27.72 MB/sec
- - -
root@tosh:~# uname -r
2.6.12.2a
root@tosh:~# time /home/share/install/oread /dev/hda

real    0m17.692s
user    0m0.004s
sys     0m0.319s
root@tosh:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   500 MB in  2.00 seconds = 249.54 MB/sec
 Timing buffered disk reads:   70 MB in  3.03 seconds =  23.11 MB/sec
root@tosh:~# echo deadline > /sys/block/hda/queue/scheduler
root@tosh:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   520 MB in  2.01 seconds = 258.75 MB/sec
 Timing buffered disk reads:   70 MB in  3.06 seconds =  22.88 MB/sec

o o o

Gigabyte GA-5AA Ali Aladdin V AGPset (1542/1543C) with AMD K6-2/500
on 100MHz FSB with 192MB SDRAM
  http://scatter.mine.nu/test/linux-2.6/pooh/

root@pooh:~# uname -r
2.4.31-hf1
root@pooh:~# time /home/share/install/oread /dev/hda

real    0m29.786s
user    0m0.000s
sys     0m0.910s
root@pooh:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   248 MB in  2.00 seconds = 124.00 MB/sec
 Timing buffered disk reads:   54 MB in  3.11 seconds =  17.36 MB/sec
- - -
root@pooh:~# uname -r
2.6.12.2a
root@pooh:~# time /home/share/install/oread /dev/hda

real    0m23.566s
user    0m0.004s
sys     0m0.370s
root@pooh:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   236 MB in  2.02 seconds = 117.02 MB/sec
 Timing buffered disk reads:   44 MB in  3.10 seconds =  14.20 MB/sec

o o o

Gigabyte GA-586TX3: Intel 430TX chipset with AMD K6-2/400
on 66MHz FSB (6 x 66) with 64MB SDRAM
  http://scatter.mine.nu/test/boxen/menace/

root@menace:~# uname -r
2.4.31-hf1
root@menace:~# time /home/share/install/oread /dev/hda

real    0m39.490s
user    0m0.010s
sys     0m1.090s
root@menace:~# time /home/share/install/oread /dev/hda

real    0m39.329s
user    0m0.010s
sys     0m1.090s
root@menace:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   176 MB in  2.03 seconds =  86.70 MB/sec
 Timing buffered disk reads:   36 MB in  3.14 seconds =  11.46 MB/sec
root@menace:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   172 MB in  2.02 seconds =  85.15 MB/sec
 Timing buffered disk reads:   36 MB in  3.13 seconds =  11.50 MB/sec

- - -
root@menace:~# uname -r
2.6.12.2a
root@menace:~# time /home/share/install/oread /dev/hda

real    0m38.861s
user    0m0.004s
sys     0m0.515s
root@menace:~# time /home/share/install/oread /dev/hda

real    0m39.391s
user    0m0.005s
sys     0m0.522s
root@menace:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   172 MB in  2.01 seconds =  85.42 MB/sec
 Timing buffered disk reads:   40 MB in  3.03 seconds =  13.20 MB/sec
root@menace:~# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   168 MB in  2.04 seconds =  82.16 MB/sec
 Timing buffered disk reads:   40 MB in  3.03 seconds =  13.21 MB/sec

