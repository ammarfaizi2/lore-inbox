Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129797AbQJaAnX>; Mon, 30 Oct 2000 19:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129959AbQJaAnN>; Mon, 30 Oct 2000 19:43:13 -0500
Received: from lolita.speakeasy.net ([216.254.0.13]:43175 "HELO
	lolita.speakeasy.net") by vger.kernel.org with SMTP
	id <S129797AbQJaAnK>; Mon, 30 Oct 2000 19:43:10 -0500
Message-ID: <39FE16A3.5070608@speakeasy.org>
Date: Mon, 30 Oct 2000 16:47:31 -0800
From: Miles Lane <miles@speakeasy.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10 i686; en-US; m18) Gecko/20001025
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Rui Sousa <rsousa@grad.physics.sunysb.edu>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Subject: Re: Blocked processes <=> Elevator starvation?
In-Reply-To: <20001027134603.A513@suse.de> <Pine.LNX.4.21.0010280408520.1157-100000@localhost.localdomain> <20001027202710.A825@suse.de> <39FC78BF.90607@speakeasy.org> <20001029144543.D615@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Sun, Oct 29 2000, Miles Lane wrote:
> 
>>>> There were still some stalls but they only lasted a couple of
>>>> seconds. The patch did make a difference and for the better.
>>> 
>>> 
>>> Ok, still needs a bit of work. Thanks for the feedback.
>> 
>> Have you resolved this problem completely, now?
>> 
>> I am testing the USB Storage support with my ORB backup
>> drive.  When I run:
>> 
>> 	dd if=/dev/zero of=/dev/sda bs=1k count=2G
>> 
>> The drive gets data quickly for about thirty seconds.
>> Then the throughput drops off to about ten percent
>> of its previous transfer rate.  This dropoff appears to
>> be due to conflict over accessing filesystems.  Specifically,
>> I have USB_STORAGE_DEBUG enabled, which shoots a ton of
>> debugging output into my kernel log.  When the throughput
>> to the ORB drive falls off, all writing to the syslog
>> ceases.  At least, that's what "tail -f" shows.
>> 
>> I would be happy to test any patches you have for this
>> problem.
> 
> 
> Could you send vmstat 1 info from the start of the copy
> and until the i/o rate drops off?

I just reproduced the problem in test10-pre7.  Here's the
output you requested:

vmstat 1
    procs                      memory    swap          io     system         cpu
  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
  1  0  0      0 126308   5724  59480   0   0    23     9  162   306   6   2  92
  0  0  0      0 126292   5724  59480   0   0     0     0  297   786   4   4  92
  0  0  0      0 126292   5724  59480   0   0     0     0  210   593   2   1  97
  1  2  2      0  59768  64308  59508   0   0     0 17425  950 37095  11  66  23
  0  2  3      0  59460  64580  59508   0   0     0   645  317  1169   0   1  99
  0  2  2      0  58672  65272  59508   0   0     0   657  293  1928   0   2  98
  0  2  2      0  58272  65628  59508   0   0     0   647  283  1228   1   0  99
  0  2  2      0  57868  65984  59508   0   0     0   647  284  1230   0   4  96
  0  2  2      0  57464  66340  59508   0   0     0   648  284  1221   0   0 100
  1  2  2      0  56600  67100  59512   0   0     0   662  295  2062   0   0 100
  0  2  2      0  56192  67460  59512   0   0     0   522  285  1237   0   1  99
  0  2  2      0  55888  67728  59512   0   0     0   644  282  1040   0   1  99
  0  2  2      0  55484  68084  59512   0   0     0   646  285  1227   0   1  99
  0  2  2      0  54648  68820  59512   0   0     0   661  299  2019   0   2  98
  1  2  2      0  54240  69176  59512   0   0     0   648  406  1549   1   3  96
  1  2  2      0  53824  69532  59512   0   0     0   649  637  2073   6   1  93
  0  2  2      0  53424  69884  59516   0   0     0   649  466  1705   2   1  97
  2  2  2      0  52172  70380  59516   0   0     0   656 1011  3612  14   4  82
  3  2  2      0  51728  70716  59516   0   0     0   647 1994  2329   9   6  85
  1  2  2      0  51312  71064  59516   0   0     0   636 1883  1517  12   9  79
  2  2  2      0  50972  71420  59516   0   0     0   636 1092  1541  12   0  88
  0  2  2      0  50100  72176  59520   0   0     0   671  611  2266  19   6  75
  1  2  2      0  49692  72532  59520   0   0     0   638  305   682   1   1  98
  1  2  2      0  49292  72888  59520   0   0     0   650  368  1574   0   1  99
  0  2  2      0  48580  73516  59520   0   0     0   638  289   613   0   5  95
  1  2  2      0  48180  73868  59520   0   0     0   636  278   542   1   0  99
  0  2  2      0  47776  74224  59520   0   0     0   637  285   595   0   0 100
  0  2  2      0  47372  74580  59520   0   0     0   636  274   513   0   8  92
  0  2  2      0  46572  75288  59520   0   0     0   638  273   525   0   1  99
  0  2  2      0  46168  75644  59520   0   0     0   637  281   588   0   2  98
  0  2  2      0  45764  76000  59520   0   0     0   509  272   508   0   0 100
  0  2  2      0  45300  76324  59520   0   0     0   636  276   548   1   0  99
  0  2  2      0  44896  76680  59520   0   0     0   636  273   523   0   0 100
  0  2  2      0  44088  77392  59520   0   0     0   650  281  1307   0   7  93
  1  1  2      0  43736  77680  59548   0   0     0  1279  908  2637   1   8  91
  0  2  3      0  43072  78040  59592   0   0     0  1660 1281  4119   5   6  89

 >>> /var/log/kernel output stopped being emitted here <<<
 >>>  CRUNCH!  <<<

  0  2  3      0  42656  78384  59592   0   0     0   259  271   551   0   0 100
  0  2  3      0  42656  78384  59592   0   0     0     5  271   499   0   0 100
  0  2  3      0  42656  78384  59592   0   0     0     5  272   511   0   2  98
  0  2  3      0  42656  78384  59592   0   0     0     4  268   502   0   0 100
  0  2  3      0  42656  78384  59592   0   0     0     5  272   508   0   0 100
  0  2  3      0  42656  78384  59592   0   0     0     5  274   523   0   0 100
  0  2  3      0  42656  78384  59592   0   0     0     5  274   508   0   0 100
    procs                      memory    swap          io     system         cpu
  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
  1  2  3      0  42656  78384  59592   0   0     0     5  273   515   0   0 100
  0  2  3      0  42652  78384  59592   0   0     0     5  273   511   0   0 100
  0  2  3      0  42652  78384  59592   0   0     0     5  273   513   0   0 100
  0  2  3      0  42652  78384  59592   0   0     0     5  272   585   0   0 100
  0  2  3      0  42652  78384  59592   0   0     0     5  291   946   0   0 100
  1  2  3      0  42652  78384  59592   0   0     0     5  310   563   6   0  94
  0  2  3      0  42652  78384  59592   0   0     0     5  272   520   0   0 100
  1  2  3      0  42652  78384  59592   0   0     0     5  271   502   0   0 100
  1  2  3      0  42648  78384  59592   0   0     0     5  300   608   0   0 100
  1  2  3      0  42648  78384  59592   0   0     0     4  307   633   0   1  99
  0  2  3      0  42648  78384  59592   0   0     0     5  276   526   0   0 100
  1  2  3      0  42648  78384  59592   0   0     0     5  278   529   0   0 100
  0  2  3      0  42648  78384  59592   0   0     0     5  274   512   0   4  96
  1  2  3      0  42648  78384  59592   0   0     0     5  273   514   0   0 100
  0  2  3      0  42648  78384  59592   0   0     0     5  272   511   0   0 100
  1  2  3      0  42648  78384  59592   0   0     0     5  270   498   0   0 100
  0  2  3      0  42648  78384  59592   0   0     0     5  271   512   0   0 100
  1  2  3      0  42648  78384  59592   0   0     0     5  273   506   0   0 100
  0  2  3      0  42648  78384  59592   0   0     0     5  386   926   3   0  97
  1  2  3      0  42640  78384  59592   0   0     0    18  434  1072   2   2  96
  0  2  3      0  42636  78384  59592   0   0     0    30  292   759   2   0  98

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
