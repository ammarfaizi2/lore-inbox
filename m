Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbSIXXWc>; Tue, 24 Sep 2002 19:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbSIXXWc>; Tue, 24 Sep 2002 19:22:32 -0400
Received: from ip66-105-100-132.z100-105-66.customer.algx.net ([66.105.100.132]:57265
	"HELO godzilla.whitewlf.net") by vger.kernel.org with SMTP
	id <S261845AbSIXXWa>; Tue, 24 Sep 2002 19:22:30 -0400
Date: Tue, 24 Sep 2002 19:27:40 -0400
Subject: Very High Load, kernel 2.4.18, apache/mysql
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v543)
Cc: Adam Taylor <iris@servercity.com>
To: linux-kernel@vger.kernel.org
From: Adam Goldstein <Whitewlf@Whitewlf.net>
Content-Transfer-Encoding: 7bit
Message-Id: <37EF12D6-D015-11D6-AD2E-000502C90EA3@Whitewlf.net>
X-Mailer: Apple Mail (2.543)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to find an answer to this for the past couple weeks, 
but I have finally
broken down and must post this to this list. ;)

I am running a high user load site (>20million hits/month stamp auction 
site) which runs entirely on apache/php with mysql. It was running 
smoothly (for the most part) on as a virtual server on a relatively 
nice box(see Moya below), but started needing more and more disk space 
(from uploads, logs, etc) and kept running out of space on the root 
partition (including /var...which has mysql & weblogs)

I decided to build a new box for it, which we were shipping to a 
highspeed colo facility.

While this unit was slightly less powerful, it was a clean install with 
a larger root partition (See Anubis below).  This unit started acting 
pathetic, and had less other loads on it (old box also has lots of 
samba sharing and other low-traffic websites). The system load kept at 
high rates constantly, 5-8 during non-peak hours , average of 10-20 
during most times, and spikes >100... needless to say, any load  over 
5-10 made the unit a pile of dung.

My partner is running a similar site, under debian, on similar hardware 
(almost identical, actually) and is having -very- similar problems.

I stripped the old server, packed it into a new 4U case (-packed!-) and 
moved just the one site (29G including pictures and sql data) to it, 
and the results are no better. This unit has even more ram, and, more 
hard drive space. (See Nosferatu below)

We are at the end of our ropes, and are clearing our chalkboards to 
start testing pieces of our systems... problem is, testing these system 
is difficult due to needing to put live loads on them. We need to 
narrow down the search, and need your help... please...

We also see high amounts of apache children segfaulting under load... 
as high as 2-10/minute at times. I have tried turning off atimes, and 
reducing tcp timeouts, etc. The big users of CPU are typically apache 
and mysql. About 110+ instances of apache and mysqld each run in top at 
high load. CPU use bounces wildly, with most in user space.

Also the amount of open files/handlers on the machines is staggering.

[root@nosferatu whitewlf]# lsof | wc -l
   42068
[root@nosferatu whitewlf]# cat /proc/sys/fs/inode-nr
84976   36563
[root@nosferatu whitewlf]# cat /proc/sys/fs/fil
file-max  file-nr
[root@nosferatu whitewlf]# cat /proc/sys/fs/file-max
8192
[root@nosferatu whitewlf]# cat /proc/sys/fs/file-
file-max  file-nr
[root@nosferatu whitewlf]# cat /proc/sys/fs/file-nr
4198    1052    8192

Machines:
Moya (Which ran OK):
Dual Thunder K7 1900+MPs, 1.5Gddr/ecc/reg ram
dual u160 scsi,   3x18G soft raid 5 /home(ext3), 9G / (ext3) & /boot 
(ext2) & 512Mb swap
Mandrake 8.1, kernel 2.4.8,  40G ide backup
Apache 1.3.23, mod_ssl/2.8.7 OpenSSL/0.9.6c PHP/4.1.2
Mysql 3.23.47 (large & huge my.conf files)

Anubis:
Dual PIII  440lx, 1.0Gpc100/ecc ram
dual u2 scsi,   3x18G soft raid 5 /home(ext3), 18G / (ext3) & /boot 
(ext2)
Mandrake 8.2, kernel 2.4.18,   80G ide backup
Apache 1.3.23, mod_ssl/2.8.7 OpenSSL/0.9.6c PHP/4.1.2
Mysql 3.23.47 and 3.23.52 (large & huge my.conf files)

Nosferatu:
Dual Thunder K7 1900+MPs, 2.0Gddr/ecc/reg ram
dual u160 scsi,   7x18G soft raid 5 /(ext3) & (250 MB/boot sda & 250MB 
swap on others)
Mandrake 8.2, kernel 2.4.18,   80G ide backup
Apache 1.3.23, mod_ssl/2.8.7 OpenSSL/0.9.6c PHP/4.1.2
Mysql 3.23.47 (large & huge my.conf files)

Current snap use shots (low usage at this hour)
(Threads: 55  Questions: 13038219  Slow queries: 12879  Opens: 620  
Flush tables: 1  Open tables: 512 Queries per second avg: 90.952)

7:01pm  up 1 day, 15:54,  2 users,  load average: 20.51, 17.21, 15.78

   7:04pm  up 1 day, 15:56,  2 users,  load average: 18.95, 17.81, 16.21
236 processes: 223 sleeping, 13 running, 0 zombie, 0 stopped
CPU0 states: 89.1% user, 10.5% system,  0.0% nice,  0.0% idle
CPU1 states: 84.2% user, 15.4% system,  0.0% nice,  0.0% idle
Mem:  2061772K av, 1949428K used,  112344K free,       0K shrd,  
290984K buff
Swap: 1493808K av,   48420K used, 1445388K free                  
882200K cached

Server uptime: 2 hours 10 minutes 6 seconds
43 requests currently being processed, 13 idle servers

KK_WW_WW_K_KWLWWWKW_KKKK.__K_WWW_WWW_K_WWWWK_WKWW_WKK.W...W....W...W..

(My partner's boxes have been similar to above, except first was 
TigerMPX, 1G ram, ide drives (first--ran ok.. ran out of space as 
well), second nearly identical to Anubis except Debian Woody, no PHP 
used, mostly CGIs, 35million+hits. Same System loads, sometimes 
spiraling out of control, needing apache shutdown.)
-- 
Adam Goldstein
White Wolf Networks

