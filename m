Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVGFGVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVGFGVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 02:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVGFGUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 02:20:31 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:7137 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262077AbVGFE4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 00:56:23 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Ondrej Zary <linux@rainbow-software.org>,
       =?ISO-8859-1?Q?=20Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
Date: Wed, 06 Jul 2005 14:56:09 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <nljmc1h40t2bv316ufij10o2am5607hpse@4ax.com>
References: <42CA5A84.1060005@rainbow-software.org> <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com> <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005 17:51:50 -0700 (PDT), Linus Torvalds <torvalds@osdl.org> wrote:
>
>Btw, can you try this same thing (or at least a subset) with a large file
>on a filesystem? Does that show the same pattern, or is it always just the 
>raw device?
>
Sure, take a while longer to vary by block size.  One effect seems 
to be wrong is interaction between /dev/hda and /dev/hdc in 'peetoo', 
the IDE channels not independent?

write:	time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
read:	time dd of=/dev/null bs=1M if=/zeroes

summary		2.4.31-hf1	2.6.12.2
boxen \ time ->	 w 	 r	 w	 r
---------------	----	----	----	----
menace		58.5	50	57	47.5
pooh		24	24	22.5	27
peetoo		33	20	26.5	22
(simultaneuous	57	37.5	52	38.5)
silly		54	24	49	25
tosh		30	19.5	27	19.5

filesystem: reiserfs 3.6, distro: slackware-10.1 + updates
hardware config, etc: http://scatter.mine.nu/test/

--Grant

the long story:
	
root@menace:~# uname -r
2.4.31-hf1
root@menace:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda3              1991992   1074516    917476  54% /
deltree:/home/share    2064256   1042968   1021288  51% /home/share

root@menace:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m57.830s
user    0m0.050s
sys     0m20.940s
root@menace:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m59.041s
user    0m0.030s
sys     0m21.780s
root@menace:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m49.963s
user    0m0.000s
sys     0m15.510s
- - -
root@menace:~# uname -r
2.6.12.2a
root@menace:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m57.199s
user    0m0.022s
sys     0m15.040s
root@menace:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m56.825s
user    0m0.024s
sys     0m14.893s
root@menace:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m47.560s
user    0m0.017s
sys     0m15.533s
root@menace:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m47.842s
user    0m0.012s
sys     0m15.647s

o o o
root@pooh:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda3              3084380   2018240   1066140  66% /
/dev/hda6              2056220   1049544   1006676  52% /usr/src
/dev/hda7               256996     34260    222736  14% /usr/local
/dev/hda8               256996     33896    223100  14% /home
/dev/hda14            20562536     32840  20529696   1% /home/pooh
deltree:/home/share    2064256   1042968   1021288  51% /home/share

root@pooh:~# uname -r
2.4.31-hf1
root@pooh:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m23.912s
user    0m0.010s
sys     0m19.820s
root@pooh:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m24.302s
user    0m0.020s
sys     0m16.760s
- - -
root@pooh:~# uname -r
2.6.12.2a
root@pooh:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m22.449s
user    0m0.017s
sys     0m13.576s
root@pooh:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m26.780s
user    0m0.010s
sys     0m13.398s

o o o

peetoo:~$ df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda3              2586348   1075652   1510696  42% /
/dev/hdc3              2586348   2044228    542120  80% /usr
/dev/hdc6              2586348   1217568   1368780  48% /usr/src
/dev/hda9             20562504  10821500   9741004  53% /home/install
/dev/hdc9             20562504   4329320  16233184  22% /home/public
/dev/hda10            41446344  39676256   1770088  96% /home/archive
deltree:/home/share    2064256   1042968   1021288  51% /home/share

peetoo:~$ uname -r
2.4.31-hf1
peetoo:~$ time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m33.322s
user    0m0.000s
sys     0m13.650s
peetoo:~$ time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m32.983s
user    0m0.010s
sys     0m13.740s
peetoo:~$ time $(dd if=/dev/zero bs=1M count=500 of=/usr/zeroes; sync)
500+0 records in
500+0 records out

real    0m30.775s
user    0m0.000s
sys     0m13.600s
peetoo:~$ time $(dd if=/dev/zero bs=1M count=500 of=/usr/zeroes; sync)
500+0 records in
500+0 records out

real    0m33.077s
user    0m0.010s
sys     0m13.740s
peetoo:~$ time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m18.877s
user    0m0.000s
sys     0m5.600s
peetoo:~$ time dd of=/dev/null bs=1M if=/usr/zeroes
500+0 records in
500+0 records out

real    0m21.413s
user    0m0.000s
sys     0m5.360s
peetoo:~$ time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m18.940s
user    0m0.000s
sys     0m5.390s
peetoo:~$ time dd of=/dev/null bs=1M if=/usr/zeroes
500+0 records in
500+0 records out

real    0m22.120s
user    0m0.000s
sys     0m5.520s
peetoo:~$ time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m36.991s
user    0m0.000s
sys     0m5.810s
peetoo:~$ time $(dd if=/dev/zero bs=1M count=500 of=/usr/zeroes; sync)
500+0 records in
500+0 records out

real    0m57.718s
user    0m0.000s
sys     0m13.580s

	simultaneous:
	peetoo:~$ time dd of=/dev/null bs=1M if=/usr/zeroes
	500+0 records in
	500+0 records out
	
	real    0m38.057s
	user    0m0.010s
	sys     0m5.790s
	peetoo:~$ time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
	500+0 records in
	500+0 records out
	
	real    0m57.164s
	user    0m0.020s
	sys     0m13.660s
- - -
peetoo:~$ uname -r
2.6.12.2b
peetoo:~$ time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m26.779s
user    0m0.017s
sys     0m5.634s
peetoo:~$ time $(dd if=/dev/zero bs=1M count=500 of=/usr/zeroes; sync)
500+0 records in
500+0 records out

real    0m26.112s
user    0m0.017s
sys     0m5.358s
peetoo:~$ time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m21.630s
user    0m0.005s
sys     0m5.405s
peetoo:~$ time dd of=/dev/null bs=1M if=/usr/zeroes
500+0 records in
500+0 records out

real    0m22.489s
user    0m0.013s
sys     0m5.378s

simultaneous with other drive:

peetoo:~$ time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m38.149s
user    0m0.007s
sys     0m5.559s
peetoo:~$ time $(dd if=/dev/zero bs=1M count=500 of=/usr/zeroes; sync)
500+0 records in
500+0 records out

real    0m52.272s
user    0m0.012s
sys     0m5.461s
	- - -
	second terminal:
	peetoo:~$ time dd of=/dev/null bs=1M if=/usr/zeroes
	500+0 records in
	500+0 records out
	
	real    0m38.998s
	user    0m0.006s
	sys     0m5.517s
	peetoo:~$ time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
	500+0 records in
	500+0 records out
	
	real    0m51.610s
	user    0m0.018s
	sys     0m5.470s
o o o

root@silly:~# uname -r
2.4.31-hf1
root@silly:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda3              3084380    755932   2328448  25% /
/dev/hda5              3084348   1168428   1915920  38% /usr/src
/dev/hda6               256996     39768    217228  16% /usr/local
/dev/hda7               514028     32864    481164   7% /home
deltree:/home/share    2064256   1042968   1021288  51% /home/share
root@silly:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m58.657s
user    0m0.020s
sys     0m16.810s
root@silly:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m50.276s
user    0m0.040s
sys     0m17.240s
root@silly:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m23.814s
user    0m0.010s
sys     0m8.470s
root@silly:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m23.834s
user    0m0.020s
sys     0m8.500s
- - -
root@silly:~# uname -r
2.6.12.2a
root@silly:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m49.564s
user    0m0.021s
sys     0m7.556s
root@silly:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m48.234s
user    0m0.016s
sys     0m7.466s
root@silly:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m24.900s
user    0m0.009s
sys     0m8.430s
root@silly:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m25.205s
user    0m0.015s
sys     0m8.394s

o o o

root@tosh:~# uname -r
2.4.31-hf1
root@tosh:~# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda3              4112508   2997808   1114700  73% /
/dev/hda6               124427       996    117007   1% /usr/local
/dev/hda7               124427        99    117904   1% /home
deltree:/home/share    2064256   1042968   1021288  51% /home/share
root@tosh:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m33.789s
user    0m0.040s
sys     0m9.430s
root@tosh:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m27.702s
user    0m0.000s
sys     0m9.940s
root@tosh:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m19.878s
user    0m0.000s
sys     0m4.510s
root@tosh:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m19.288s
user    0m0.000s
sys     0m4.580s
- - -
root@tosh:~# uname -r
2.6.12.2a
root@tosh:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m27.120s
user    0m0.010s
sys     0m4.937s
root@tosh:~# time $(dd if=/dev/zero bs=1M count=500 of=/zeroes; sync)
500+0 records in
500+0 records out

real    0m27.015s
user    0m0.010s
sys     0m4.844s
root@tosh:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m19.301s
user    0m0.006s
sys     0m4.558s
root@tosh:~# time dd of=/dev/null bs=1M if=/zeroes
500+0 records in
500+0 records out

real    0m19.513s
user    0m0.009s
sys     0m4.574s

o o o
end :)

