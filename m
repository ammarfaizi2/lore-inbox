Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVCPM53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVCPM53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVCPM53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:57:29 -0500
Received: from hs-grafik.net ([80.237.205.72]:25358 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S261198AbVCPM46 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:56:58 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: Fw: 2.6.11-rc5-mm1: reiser4 eating cpu time
Date: Wed, 16 Mar 2005 13:56:51 +0100
User-Agent: KMail/1.7.2
Cc: "E.Gryaznova" <grev@namesys.com>, reiserfs-dev <reiserfs-dev@namesys.com>,
       linux-kernel@vger.kernel.org
References: <20050303184456.534aedb6.akpm@osdl.org> <200503131424.33498@zodiac.zodiac.dnsalias.org> <200503150857.37419.vda@ilport.com.ua>
In-Reply-To: <200503150857.37419.vda@ilport.com.ua>
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200503161356.52085@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 15. März 2005 07:57 schrieb Denis Vlasenko:
> Use strace -tt to find out whether kwrite spends that much CPU
> by doing zillions of syscalls or not.

Actually pdflush always kicks in after a write call. Summary:
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 62.13    2.151461        1213      1774           write
 27.35    0.946942          19     49602           read
  3.52    0.121736          42      2913         2 munmap
  3.01    0.104310         385       271           close
  0.83    0.028608          10      2901           mmap2
  0.79    0.027422           6      4874           select
  0.69    0.023733           2      9804           gettimeofday
  0.43    0.014863           3      5615           ioctl
  0.41    0.014047           9      1536           lseek
  0.14    0.004890          10       505       248 open
  0.11    0.003968           6       627        60 stat64
  0.10    0.003302           6       574       223 access
  0.09    0.002997         749         4           fdatasync
  0.07    0.002380           9       280        26 lstat64
  0.06    0.002049          89        23           writev
  0.06    0.002026           8       245           brk
  0.04    0.001479           4       388           fstat64
  0.04    0.001234           8       147           old_mmap
  0.03    0.001119         224         5           rename
  0.03    0.000889          64        14         1 unlink
  0.02    0.000591         591         1           shutdown
  0.01    0.000515          32        16           getdents64
  0.01    0.000503         101         5         2 connect
  0.01    0.000293          59         5           link
  0.01    0.000185           3        72           fcntl64
  0.00    0.000170          28         6           socket
  0.00    0.000140           2        65           rt_sigaction
  0.00    0.000128           7        18           fchmod
  0.00    0.000116           9        13           readv
  0.00    0.000110           3        32         1 _llseek
  0.00    0.000080          16         5           readlink
  0.00    0.000071           3        23           uname
  0.00    0.000068           7        10           fchown32
  0.00    0.000061           2        26           getuid32
  0.00    0.000055           2        29           rt_sigprocmask
  0.00    0.000049           2        20           umask
  0.00    0.000045          23         2         1 bind
  0.00    0.000038          13         3           chdir
  0.00    0.000037           2        15           getgid32
  0.00    0.000036           5         7           getcwd
  0.00    0.000033           2        15           getpid
  0.00    0.000023           8         3           pipe
  0.00    0.000014           4         4           futex
  0.00    0.000012          12         1           accept
  0.00    0.000006           2         4           time
  0.00    0.000006           6         1           set_thread_area
  0.00    0.000005           2         3           geteuid32
  0.00    0.000004           2         2           getrlimit
  0.00    0.000003           3         1           getsockname
  0.00    0.000003           3         1           getsockopt
  0.00    0.000002           2         1           set_tid_address
  0.00    0.000002           2         1           listen
  0.00    0.000002           2         1         1 setsockopt
  0.00    0.000001           1         1           getegid32
------ ----------- ----------- --------- --------- ----------------
100.00    3.462862                 82514       565 total

UOUO. Strange again.
THe above was on ext3. I then copied the file to reiser4. Copy command exited 
quite fast, however pdflush was again taking ~20s CPU time....
Here are some strange benchmarks on reiser4:
alex@t40:/files/ipt$ cp gross  /tmp/
alex@t40:/files/ipt$ cd /tmp/
alex@t40:/tmp$ strace -ttc kwrite gross
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 75.90    4.121664        2266      1819           write
 17.45    0.947628          67     14152           read
  2.09    0.113706          39      2911         2 munmap
  2.01    0.109136         406       269           close
  0.52    0.028380          10      2899           mmap2
  0.46    0.025053           5      4903           select
  0.45    0.024209           2      9885           gettimeofday
  0.25    0.013516           9      1536           lseek
  0.24    0.013252           2      5739           ioctl
  0.12    0.006303          13       503       248 open
  0.11    0.005991        1498         4           fdatasync
  0.07    0.003825           6       627        60 stat64
  0.05    0.002853           5       572       223 access
  0.04    0.002419         105        23           writev
  0.03    0.001408         282         5           rename
  0.03    0.001374           5       279        26 lstat64
  0.02    0.001291          92        14         1 unlink
  0.02    0.001130           3       384           fstat64
  0.02    0.000939           6       147           old_mmap
  0.02    0.000926         926         1           shutdown
  0.02    0.000855           4       241           brk
  0.01    0.000690          38        18           fchmod
  0.01    0.000503          72         7           getcwd
  0.01    0.000488          31        16           getdents64
  0.01    0.000456          91         5           link
  0.01    0.000440          88         5         2 connect
  0.01    0.000312          31        10           fchown32
  0.00    0.000254         254         1           set_thread_area
  0.00    0.000188           3        72           fcntl64
  0.00    0.000181           3        65           rt_sigaction
  0.00    0.000111           9        13           readv
  0.00    0.000091          18         5           readlink
  0.00    0.000086           3        30         1 _llseek
  0.00    0.000086          14         6           socket
  0.00    0.000072           3        23           uname
  0.00    0.000070           4        20           umask
  0.00    0.000067           3        26           getuid32
  0.00    0.000050          25         2         1 bind
  0.00    0.000044           2        29           rt_sigprocmask
  0.00    0.000039           3        15           getgid32
  0.00    0.000030          10         3           chdir
  0.00    0.000030           2        15           getpid
  0.00    0.000026           9         3           pipe
  0.00    0.000017           4         4           futex
  0.00    0.000013          13         1           accept
  0.00    0.000007           2         4           time
  0.00    0.000005           2         3           geteuid32
  0.00    0.000004           2         2           getrlimit
  0.00    0.000003           3         1           listen
  0.00    0.000003           3         1           getsockname
  0.00    0.000003           3         1         1 setsockopt
  0.00    0.000003           3         1           getsockopt
  0.00    0.000002           2         1           getegid32
  0.00    0.000002           2         1           set_tid_address
------ ----------- ----------- --------- --------- ----------------
100.00    5.430234                 47322       565 total
alex@t40:/tmp$ strace -c kwrite gross
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 42.91    0.939626          69     13614         1 read
 40.34    0.883494         496      1782           write
  5.35    0.117072         434       270           close
  5.31    0.116266          40      2912         2 munmap
  1.37    0.029961          10      2900           mmap2
  1.20    0.026276           5      4863           select
  0.89    0.019557           2      9786           gettimeofday
  0.65    0.014222           9      1536           lseek
  0.59    0.012985           2      5541           ioctl
  0.29    0.006266          12       504       248 open
  0.15    0.003193           5       627        60 stat64
  0.14    0.003121           5       573       223 access
  0.14    0.002994         749         4           fdatasync
  0.09    0.002078          94        22           writev
  0.09    0.002067         413         5           rename
  0.08    0.001780         127        14         1 unlink
  0.06    0.001306           9       147           old_mmap
  0.06    0.001274           5       279        26 lstat64
  0.05    0.001178           3       386           fstat64
  0.04    0.000983           4       245           brk
  0.03    0.000731          46        16           getdents64
  0.03    0.000591         591         1           shutdown
  0.02    0.000539          30        18           fchmod
  0.02    0.000487          97         5         2 connect
  0.02    0.000371          74         5           link
  0.01    0.000258          26        10           fchown32
  0.01    0.000212           3        65           rt_sigaction
  0.01    0.000179           2        72           fcntl64
  0.01    0.000115           9        13           readv
  0.00    0.000109           4        31         1 _llseek
  0.00    0.000089          18         5           readlink
  0.00    0.000087          15         6           socket
  0.00    0.000070           3        23           uname
  0.00    0.000049           2        29           rt_sigprocmask
  0.00    0.000044          22         2         1 bind
  0.00    0.000042           2        26           getuid32
  0.00    0.000038           3        15           getgid32
  0.00    0.000036           2        20           umask
  0.00    0.000028           2        15           getpid
  0.00    0.000022           7         3           pipe
  0.00    0.000022           3         7           getcwd
  0.00    0.000015           4         4           futex
  0.00    0.000011          11         1           accept
  0.00    0.000009           3         3           chdir
  0.00    0.000008           2         4           time
  0.00    0.000005           2         3           geteuid32
  0.00    0.000005           5         1           set_thread_area
  0.00    0.000003           2         2           getrlimit
  0.00    0.000003           3         1           getsockname
  0.00    0.000003           3         1           getsockopt
  0.00    0.000002           2         1           getegid32
  0.00    0.000002           2         1           set_tid_address
  0.00    0.000002           2         1           listen
  0.00    0.000002           2         1         1 setsockopt
------ ----------- ----------- --------- --------- ----------------
100.00    2.189888                 46421       566 total
alex@t40:/tmp$ strace -c kwrite gross
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 42.39    0.953074          70     13601         1 read
 41.55    0.934274         521      1792           write
  5.19    0.116578         433       269           close
  5.02    0.112941          39      2911         2 munmap
  1.33    0.030014          10      2899           mmap2
  1.18    0.026478           5      4857           select
  0.93    0.020984           2      9777           gettimeofday
  0.54    0.012233           2      5506           ioctl
  0.50    0.011281           7      1536           lseek
  0.22    0.004967          10       503       248 open
  0.14    0.003115           5       572       223 access
  0.14    0.003112           5       627        60 stat64
  0.13    0.002998         750         4           fdatasync
  0.11    0.002375          16       147           old_mmap
  0.09    0.002057          89        23           writev
  0.07    0.001488         298         5           rename
  0.06    0.001449           5       279        26 lstat64
  0.06    0.001253         251         5         2 connect
  0.05    0.001208           3       384           fstat64
  0.05    0.001091          78        14         1 unlink
  0.04    0.000905           4       245           brk
  0.03    0.000708          39        18           fchmod
  0.03    0.000696         696         1           shutdown
  0.02    0.000532          76         7           getcwd
  0.02    0.000506          32        16           getdents64
  0.02    0.000428          86         5           link
  0.01    0.000335          34        10           fchown32
  0.01    0.000189           3        72           fcntl64
  0.01    0.000165           3        65           rt_sigaction
  0.00    0.000112           9        13           readv
  0.00    0.000090          15         6           socket
  0.00    0.000089          18         5           readlink
  0.00    0.000087           3        30         1 _llseek
  0.00    0.000074           3        23           uname
  0.00    0.000068           3        26           getuid32
  0.00    0.000057           3        20           umask
  0.00    0.000049           2        29           rt_sigprocmask
  0.00    0.000044           3        15           getgid32
  0.00    0.000042          21         2         1 bind
  0.00    0.000033          11         3           chdir
  0.00    0.000029           2        15           getpid
  0.00    0.000024           8         3           pipe
  0.00    0.000014           4         4           futex
  0.00    0.000013          13         1           accept
  0.00    0.000007           2         4           time
  0.00    0.000006           2         3           geteuid32
  0.00    0.000006           6         1           set_thread_area
  0.00    0.000004           2         2           getrlimit
  0.00    0.000003           3         1           getsockname
  0.00    0.000003           3         1         1 setsockopt
  0.00    0.000003           3         1           getsockopt
  0.00    0.000002           2         1           set_tid_address
  0.00    0.000002           2         1           listen
  0.00    0.000001           1         1           getegid32
------ ----------- ----------- --------- --------- ----------------
100.00    2.248296                 46361       566 total
alex@t40:/tmp$ sync
alex@t40:/tmp$ strace -c kwrite gross
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 60.87    2.009600        1095      1836           write
 28.08    0.927199          68     13630           read
  3.44    0.113742         423       269           close
  3.41    0.112701          39      2911         2 munmap
  0.97    0.031980           6      4926           select
  0.94    0.030976          11      2899           mmap2
  0.71    0.023333           2      9933           gettimeofday
  0.39    0.012816           8      1536           lseek
  0.36    0.011994           2      5622           ioctl
  0.15    0.004794          10       503       248 open
  0.11    0.003540           6       627        60 stat64
  0.10    0.003406           6       572       223 access
  0.07    0.002398           6       384           fstat64
  0.07    0.002280          99        23           writev
  0.04    0.001317         263         5           rename
  0.04    0.001294           5       279        26 lstat64
  0.03    0.001076          77        14         1 unlink
  0.03    0.001067           7       147           old_mmap
  0.03    0.001001         250         4           fdatasync
  0.02    0.000794           3       241           brk
  0.02    0.000778          43        18           fchmod
  0.02    0.000618         618         1           shutdown
  0.02    0.000511          32        16           getdents64
  0.01    0.000470          94         5           link
  0.01    0.000442          88         5         2 connect
  0.01    0.000363          36        10           fchown32
  0.01    0.000192           3        72           fcntl64
  0.00    0.000113           2        65           rt_sigaction
  0.00    0.000104           8        13           readv
  0.00    0.000087          15         6           socket
  0.00    0.000085          17         5           readlink
  0.00    0.000080           3        30         1 _llseek
  0.00    0.000071           3        23           uname
  0.00    0.000061           2        26           getuid32
  0.00    0.000055           3        20           umask
  0.00    0.000049           7         7           getcwd
  0.00    0.000042           3        15           getgid32
  0.00    0.000041           1        29           rt_sigprocmask
  0.00    0.000041          21         2         1 bind
  0.00    0.000031          10         3           chdir
  0.00    0.000028           2        15           getpid
  0.00    0.000022           7         3           pipe
  0.00    0.000015          15         1           accept
  0.00    0.000014           4         4           futex
  0.00    0.000008           8         1           set_thread_area
  0.00    0.000007           2         4           time
  0.00    0.000003           2         2           getrlimit
  0.00    0.000003           1         3           geteuid32
  0.00    0.000003           3         1           getsockname
  0.00    0.000003           3         1           getsockopt
  0.00    0.000002           2         1           set_tid_address
  0.00    0.000002           2         1           listen
  0.00    0.000002           2         1         1 setsockopt
  0.00    0.000001           1         1           getegid32
------ ----------- ----------- --------- --------- ----------------
100.00    3.301655                 46771       565 total



-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
