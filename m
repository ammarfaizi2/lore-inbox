Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbVKCC0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbVKCC0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 21:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbVKCC0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 21:26:08 -0500
Received: from www.eclis.ch ([144.85.15.72]:18847 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1030281AbVKCC0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 21:26:06 -0500
Message-ID: <43697550.7030400@eclis.ch>
Date: Thu, 03 Nov 2005 03:26:24 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dean@arctic.org
Subject: Re: NTP broken with 2.6.14
References: <4369464B.6040707@eclis.ch>	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>	 <43694DD1.3020908@eclis.ch>	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>	 <43695D94.10901@eclis.ch> <1130980031.27168.527.camel@cog.beaverton.ibm.com>
In-Reply-To: <1130980031.27168.527.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz a écrit :

>>talla:~# uname -a
>>Linux talla 2.6.14-1 #2 PREEMPT Thu Nov 3 00:54:44 CET 2005 i686 GNU/Linux
>>talla:~# ntpdate -uq 10.0.0.1
>>server 10.0.0.1, stratum 3, offset -14.893095, delay 0.02644
>>  3 Nov 01:31:59 ntpdate[8186]: step time server 10.0.0.1 offset 
>>-14.893095 sec
> 
> 
> Hmm. Ok, so network wise you seem to be communicating with the server
> without an issue. The other reasons for a reject condition are sync-loop
> (your NTP server isn't synced to your box I'd assume), or your host is
> drifting too severely from the NTP server for ntpd to compensate.
> 
> Attached is a cruddy python script I wrote that should provide you with
> your ppm drift from your server.
> To run:
> o Disable ntpd
> o Run "./drift-test.py <server>"
> o Let it run for 10 minutes to get a decent drift value.

Ok. First I purged (remove the config files and binary) the adjtimex 
installation. Then I rebooted with the old 2.6.8 kernel and watch the 
first 5 polls of ntpd:

ntpq> pe
      remote           refid      st t when poll reach   delay   offset 
  jitter
==============================================================================
*10.0.0.1        129.132.2.21     3 u    2   64   37    1.082  -45.761 
24.670
ntpq> rv 54820
assID=54820 status=9614 reach, conf, sel_sys.peer, 1 event, event_reach,
srcadr=10.0.0.1, srcport=123, dstadr=10.0.33.10, dstport=123, leap=00,
stratum=3, precision=-17, rootdelay=35.065, rootdispersion=46.066,
refid=129.132.2.21, reach=037, unreach=0, hmode=3, pmode=4, hpoll=6,
ppoll=6, flash=00 ok, keyid=0, ttl=0, offset=-45.761, delay=1.082,
dispersion=438.994, jitter=24.670,
reftime=c713e731.c00053e2  Thu, Nov  3 2005  2:32:33.750,
org=c713e7b0.6cbe0ded  Thu, Nov  3 2005  2:34:40.424,
rec=c713e7b0.7bdb5d89  Thu, Nov  3 2005  2:34:40.483,
xmt=c713e7b0.7b72606f  Thu, Nov  3 2005  2:34:40.482,
filtdelay=     1.13    1.08    1.17    1.13    1.14    0.00    0.00    0.00,
filtoffset=  -58.48  -45.76  -32.77  -20.31   -7.60    0.00    0.00    0.00,
filtdisp=      0.01    0.96    1.92    2.86    3.82 16000.0 16000.0 16000.0

So with 2.6.8 this machine have a working ntpd. Now I stopped ntpd and 
used your script with the server 10.0.0.1:

03 Nov 02:36:32         offset: -6.9e-05        drift: -77.0 ppm
03 Nov 02:37:32         offset: -0.005162       drift: -84.7540983607 ppm
03 Nov 02:38:32         offset: -0.011573       drift: -95.7107438017 ppm
03 Nov 02:39:32         offset: -0.019045       drift: -105.26519337 ppm
03 Nov 02:40:32         offset: -0.02732        drift: -113.394190871 ppm
03 Nov 02:41:32         offset: -0.036287       drift: -120.581395349 ppm
03 Nov 02:42:32         offset: -0.045824       drift: -126.958448753 ppm
03 Nov 02:43:32         offset: -0.055755       drift: -132.45368171 ppm
03 Nov 02:44:33         offset: -0.065992       drift: -136.929460581 ppm
03 Nov 02:45:33         offset: -0.076472       drift: -141.10701107 ppm
03 Nov 02:46:33         offset: -0.087156       drift: -144.790697674 ppm

After, I rebooted the machine with the 2.6.14 kernel and watched the 
first 5 polls of ntpd:

ntpq> pe
      remote           refid      st t when poll reach   delay   offset 
  jitter
==============================================================================
  10.0.0.1        129.132.2.21     3 u    2   64   37    1.106  -6989.1 
3351.11
ntpq> rv 51860
assID=51860 status=9014 reach, conf, 1 event, event_reach,
srcadr=10.0.0.1, srcport=123, dstadr=10.0.33.10, dstport=123, leap=00,
stratum=3, precision=-17, rootdelay=36.804, rootdispersion=52.307,
refid=129.132.2.21, reach=037, unreach=0, hmode=3, pmode=4, hpoll=6,
ppoll=6, flash=00 ok, keyid=0, ttl=0, offset=-6989.157, delay=1.106,
dispersion=438.355, jitter=3351.111,
reftime=c713eb31.d4be1eb4  Thu, Nov  3 2005  2:49:37.831,
org=c713ec29.241b64e0  Thu, Nov  3 2005  2:53:45.141,
rec=c713ec30.21790752  Thu, Nov  3 2005  2:53:52.130,
xmt=c713ec30.21121251  Thu, Nov  3 2005  2:53:52.129,
filtdelay=     1.11    1.14    1.16    1.16    1.22    0.00    0.00    0.00,
filtoffset= -6989.1 -6239.9 -5482.4 -4133.2 -1164.0    0.00    0.00    0.00,
filtdisp=      0.01    0.97    1.95    2.91    3.88 16000.0 16000.0 16000.0

As before, the ntpd is not working properly with the 2.6.14 kernel. Now 
I stopped ntpd and used your script with the 10.0.0.1 server:

03 Nov 02:54:56         offset: -0.008247       drift: -4236.0 ppm
03 Nov 02:55:56         offset: -0.828716       drift: -13519.7540984 ppm
03 Nov 02:56:57         offset: -1.593172       drift: -13025.9098361 ppm
03 Nov 02:57:57         offset: -2.817531       drift: -15458.9010989 ppm
03 Nov 02:58:57         offset: -3.442019       drift: -14206.6446281 ppm
03 Nov 02:59:57         offset: -4.070492       drift: -13465.1688742 ppm
03 Nov 03:00:57         offset: -4.658962       drift: -12858.980663 ppm
03 Nov 03:01:57         offset: -5.267374       drift: -12472.4241706 ppm
03 Nov 03:02:57         offset: -5.843858       drift: -12115.8651452 ppm
03 Nov 03:03:57         offset: -7.052287       drift: -13004.199262 ppm
03 Nov 03:04:58         offset: -7.564786       drift: -12538.5986733 ppm

Interresting! So if I understand correctly the ntpd problem is because 
the kernel 2.6.14 kernel show a drift about 100 time bigger than with 
the kernel 2.6.8 on the same hardware. For information the mainboard is 
the MSI K7N2 (nForce 2). Here is the cpuinfo in case that matter:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm)
stepping        : 0
cpu MHz         : 2004.860
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4013.69


>>citron:~# uname -a
>>Linux citron 2.6.12-nfs-1 #1 Fri Jun 24 18:23:39 CEST 2005 i686 GNU/Linux
>>citron:~# ntpdate -uq 10.0.0.1
>>server 10.0.0.1, stratum 3, offset 0.003676, delay 0.02647
>>  3 Nov 01:32:06 ntpdate[13476]: adjust time server 10.0.0.1 offset 
>>0.003676 sec
>>citron:~# ntpdate -uq 129.132.2.21
>>server 129.132.2.21, stratum 2, offset -0.010485, delay 0.04341
>>  3 Nov 01:32:11 ntpdate[13477]: adjust time server 129.132.2.21 offset 
>>-0.010485 sec
>>
>>So this could to be something after the 2.6.12. All machines run the 
>>same version of ntpd and use the same configuration file.
> 
> 
> Would you mind confirming 2.6.12 does not have the issue on the same
> hardware?

The kernel 2.6.12 run on a different hardware and is not configured to 
work on the hardware that have the problem with 2.6.14, so I can't 
confime exactly your question yet. If you don't have any better idea, I 
can try several kernel version to find when the problem start. But I 
will make that after I sleep because I you look at the time field into 
the test result this is very late now for me...

Thanks for you support, I hope we will quicky find to solution.
-- 
Jean-Christian de Rivaz
