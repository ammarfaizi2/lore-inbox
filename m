Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRIOEoD>; Sat, 15 Sep 2001 00:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268926AbRIOEnx>; Sat, 15 Sep 2001 00:43:53 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:60055 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S268071AbRIOEnl>; Sat, 15 Sep 2001 00:43:41 -0400
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>
Subject: Re: Feedback on preemptible kernel patch
Date: Sat, 15 Sep 2001 06:25:12 +0200
X-Mailer: KMail [version 1.3]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>,
        "DRI-Devel" <dri-devel@lists.sourceforge.net>
In-Reply-To: <200109140302.f8E32LG13400@zero.tech9.net> <1000442113.3897.19.camel@phantasy>
In-Reply-To: <1000442113.3897.19.camel@phantasy>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_0ASOLC9JZ60D64F52N7P"
Message-Id: <20010915044345Z268071-760+12940@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_0ASOLC9JZ60D64F52N7P
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Subject: 

Am Freitag, 14. September 2001 06:35 schrieb Robert Love:
> On Thu, 2001-09-13 at 22:47, Dieter Nützel wrote:

> > > -- ReiserFS may be another problem.
> >
> > Can't wait for that.

Most wanted, now.

> >
> > > third, you may be experiencing problems with a kernel optimized for
> > > Athlon.  this may or may not be related to the current issues with an
> > > Athlon-optimized kernel.  Basically, functions in arch/i386/lib/mmx.c
> > > seem to need some locking to prevent preemption.  I have a basic patch
> > > and we are working on a final one.
> >
> > Can you please send this stuff along to me?
> > You know I own an Athlon (since yester Athlon II 1 GHz :-) and need some
> > input...
>
> Yes, find the Athlon patch below.  Please let me know if it works.

Tried it and it works so far.

It seems to be that kswap put some additional "load" on the disk from time to 
time. Or is it the ReiserFS thing, again?

> > Mobo is MSI MS-6167 Rev 1.0B (AMD Irongate C4, yes the very first one)
> >
> > Kernel with preempt patch and mmx/3dnow! optimization crash randomly.
> > Never had that (without preempt) during the last two years.
>
> Oh, I did not remember you having problems with Athlon.  I try to keep a
> list of what problems are being had.

Have you a copy of my posted ksymoops file?
But the oopses seems to be cured.

> Are there any other configurations where you have problems?

I don't know exactly 'cause kernel hacking is not my main focus.

But have you thought about the MMX/3DNow! stuff in Mesa/OpenGL (XFree86 DRI)?
And what do you think about the XFree86 Xv extentions (video) or the whole 
MPEG2/3/4, Ogg-Vorbis, etc. (multimedia stuff)?

Do all these libraries (progs) need some preempt patches?
That's why I cross posted to the DRI-Devel List (sorry).


> Before applying, note there are new patches at
> http://tech9.net/rml/linux - a patch for 2.4.10-pre9 and a _new_ patch
> for 2.4.9-ac10.  These include everything (highmem, etc) except the
> Athlon patch.

> The problem with Athlon compiled kernels is that MMX/3DNow routines used
> in the kernel are not preempt safe (but SMP safe, so I missed them).
> This patch should correct it.

I understand ;-)
It seems to calm it.

> diff -urN linux-2.4.10-pre8/arch/i386/kernel/i387.c
> linux/arch/i386/kernel/i387.c ---
> linux-2.4.10-pre8/arch/i386/kernel/i387.c	Thu Sep 13 19:24:48 2001 +++
> linux/arch/i386/kernel/i387.c	Thu Sep 13 20:00:57 2001
> @@ -10,6 +10,7 @@
>
>  #include <linux/config.h>
>  #include <linux/sched.h>
> +#include <linux/spinlock.h>
>  #include <asm/processor.h>
>  #include <asm/i387.h>
>  #include <asm/math_emu.h>
> @@ -65,6 +66,8 @@
>  {
>  	struct task_struct *tsk = current;
>
> +	ctx_sw_off();
> +
>  	if (tsk->flags & PF_USEDFPU) {
>  		__save_init_fpu(tsk);
>  		return;
> diff -urN linux-2.4.10-pre8/include/asm-i386/i387.h
> linux/include/asm-i386/i387.h ---
> linux-2.4.10-pre8/include/asm-i386/i387.h	Thu Sep 13 19:27:28 2001 +++
> linux/include/asm-i386/i387.h	Thu Sep 13 20:01:30 2001
> @@ -12,6 +12,7 @@
>  #define __ASM_I386_I387_H
>
>  #include <linux/sched.h>
> +#include <linux/spinlock.h>
>  #include <asm/processor.h>
>  #include <asm/sigcontext.h>
>  #include <asm/user.h>
> @@ -24,7 +25,7 @@
>  extern void restore_fpu( struct task_struct *tsk );
>
>  extern void kernel_fpu_begin(void);
> -#define kernel_fpu_end() stts()
> +#define kernel_fpu_end() stts(); ctx_sw_on()
>
>
>  #define unlazy_fpu( tsk ) do { \

Now, here are my results.

Athlon II 1 GHz (0.18 µm)
MSI MS-6167 Rev 1.0B (Irongate C4)
640 MB PC100-2-2-2 SDRAM
IBM DDYS 18 GB U160 (on AHA-2940UW)
ReiserFS 3.6 on all partitions

dbench-1.1 32 clients

2.4.10-pre9
Throughput 22.8881 MB/sec (NB=28.6102 MB/sec  228.881 MBit/sec)
15.000u 52.710s 3:05.59 36.4%   0+0k 0+0io 911pf+0w
load: 3168

2.4.10-pre9 + patch-rml-2.4.10-pre9-preempt-kernel-1
Throughput 22.7157 MB/sec (NB=28.3946 MB/sec  227.157 MBit/sec)
15.070u 52.730s 3:06.97 36.2%   0+0k 0+0io 911pf+0w
load: 2984


bonnie++

2.4.10-pre
Version 1.92a       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec 
%CP
SunWave1      1248M   117  95 14510  16  6206   6   189  98 27205  16 289.8   
4
Latency               107ms    2546ms     720ms   99241us   75832us    3449ms
Version 1.92a       ------Sequential Create------ --------Random 
Create--------
SunWave1            -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec 
%CP
                 16  4215  38 +++++ +++ 14227  93  8885  79 +++++ +++  4324  
35
Latency               584ms    8221us   14158us    7681us   14274us     794ms
load: 321


2.4.10-pre9 + patch-rml-2.4.10-pre9-preempt-kernel-1
Version 1.92a       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec 
%CP
SunWave1      1248M    98  96 14716  18  6190   6   181  98 27945  17 291.2   
5
Latency               127ms    4241ms     726ms   97889us   63321us    3071ms
Version 1.92a       ------Sequential Create------ --------Random 
Create--------
SunWave1            -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec 
%CP
                 16  5781  54 +++++ +++ 14733  95  5899  54 +++++ +++ 11785  
96
Latency               510ms    2160us    4501us    8917us    2130us    6299us
load: 302

Deleting with ReiserFS and the preempt kernel is GREAT!
But I get some hiccup during noatun (mp3, ogg, etc. player for KDE-2.2) or 
plaympeg together with dbench (16, 32). ReiserFS needs some preemption fixes, 
too?

I've attached two small compressed bonnie++ HTML files.

-Dieter
--------------Boundary-00=_0ASOLC9JZ60D64F52N7P
Content-Type: application/x-bzip2;
  name="2.4.10-pre9-bonnie++.html.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="2.4.10-pre9-bonnie++.html.bz2"

QlpoOTFBWSZTWWpPKKcAAXXfgHAQegv//z/v37A/7//6UAOr27i6CA6EEkkTU2KDQ9TPSn6oekek
DQAGgD1HqAGg0Joam1RHpAHogaAAeoNAaAAAEiRNE1J6jbSNTTCNGTQ2o8mgaNDKMhoNBzTIyGTB
DRhMEaaNGIGmTIwABBFJGpqeFTzQ1GU8mkZAaNANAbU09INA0bMwyWsilVT+e7XbK9+IusJKgFIW
WNHLETXeYALNgnYGBWBp5GtUeqcwAUwZBmqu46x2hi27cEiBiy+fE8qxS2IWAO2j74lxQAFwncB2
JdBIIKQGI3AL3DDg4YRvIMfWZj3oUpYxkksjJJI9GRLWuXQwYXp/TBrzOAgeH03jIxsK6oVHtFe0
xlVs1K3aOEYpZSxwskzyICgBOQMEhAyDTQaLUYUOcsZ170rs0Bul5XilHyY5UYSappQa4UkmilGq
pTMC8kYwVwznCc1fLozKrOZGssJcIGb7QAthhvhPFe64Gw+AKBEf6dksFkIkH9YtYnHyIDJQEp4s
N0Yd/nNvJkOHhqiumU6ZFGu0szX333wDzwoAYEYLSKCmYAMxobaBY2l0TkvcCyg0uRxEQ2QyGNob
GDbB6BfbOibKmkHrYYpirRO9QALXFlBCtGDGJCbCkFZVOEE6SkWjVIUqiqVpqseNiAyizC7TilKp
vEtNl3cZx0IVsISNTLGMviEkTad12nz2FZiwPvABh9b18ss+YLQ5FzgBMVv1GFNBTK0qrzHUAFV6
cwaeGIxEuDSWnAgG8ctQTxCBxZSoVasdhkQDAVZb9+XJAgX1A01mTJAld2fFiSAAsT4Qi4TmE4d8
VaaYAC+FWn0shGkFSGIzGkKAoSDKX6kd6nH7S0ytoAcf2e8j1vu2hqOs8u0UKg7ZqNQlFkAhtoDL
+ToaBQ+TuXRXUZaiTCkHT2DP+l9QUwxuwMFOcOdEOPDYeGwsR+qRRVl9IcH3ezWM+ND46kqA7VuF
r+wcMjRrlO17VuuQejTknIcDFRamnHcA7HvzFDoz1E01HIJriI2Z+rp3S+u6rxBWXMNxhKfNMCWo
zCchmzfyYmjSOHBjlcgXMBkJLsDhlPuTztusr2d3ZoIiIYKYsmKE0HlBy11pouFCe9Z2BOLjRp3j
EUSChGUJ3LDPLefcuRX8qdkrKVJac7eOLjOrTKoTLBFByIF8pAoA/xdyRThQkGpPKKc=

--------------Boundary-00=_0ASOLC9JZ60D64F52N7P
Content-Type: application/x-bzip2;
  name="2.4.10-pre9-preempt-bonnie++.html.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="2.4.10-pre9-preempt-bonnie++.html.bz2"

QlpoOTFBWSZTWeOU/b8AAXVfgHAQegv//z/v37A/7//6UAOvdrSQhRprBJQhTYoND1PNCh6mahpo
ADIA9RoABzTIyGTBDRhMEaaNGIGmTIwABBIkENTVDwmk0zUyNAGmnihpo0yAAAc0yMhkwQ0YTBGm
jRiBpkyMAAQSSRpkmjGqbQ00mkeo0yGgD1AeQ1A0GJgkGJa6KVZL5Yrc0b37ZeYJKYFEXXMgjcSX
uYALuVVRGC0OSvZS3haACgMiMacm+03EVz+zjoQxhqbhXkSc1ZBYBdMvrVKrADERxAu2jFkAyYDC
BoC9g2qKh1BUw+YseKp6WMYkllYkkjzYiWTMuZgwwn5suWfK3m2T70tye9jc132PXGDqzDfNhbUw
xXTireqSujHCdzVWaEgiCqQwnIZFbGmEasLEV6Xn8uXAyWJaDLmqhuK57K+imOC+t04pfWKw31my
tMK0d0XTz33q9qdLyONcoaftINkuPgI+M+rEbDnBOEO754zYRciZHayKid3mHB6qASnz68zrzabM
jPcZ9N8Z36aNVU81G/LKUpMC2skAGYbMlOJBXaAG06G2gXI0uacloBawaWyHEENQMYMTGxps6BfL
nRJlGkG4w7MxXInhUALOL6iFYYMYkJsKwXFJwgnWUiw1WFKhSVj4XvkYgNYtouk8MpUb3V778/Uc
46kK0ISOtiLDGQQkidk3FxdVcSBnk33ABg4U5COLpBKZWJZQAeJK3AunmJ3VEKeI+wAQtRyhfxs1
A7PeVGdAETyQB9AgOSRASShXiLEAXCSTs1srGEBbAFPSWWMIpx5aKEMAGJHzZCV1KBRrSJJTmwAy
tJKexQIUwSQ03nN4JgmQxItwQoz1/AqJKoANn4XjQuxfHeGB2HRvEggGkwMBE2JgQb5gl+zcphIP
quCWimBKA5MkMdXcJ/aWwCdk3C4uSNobUINl2s5sRwR+KJOtJ0hofV/PYaMCHwWJTB2LdMz+saMR
p2thlWSrU4PXfY9wriiapF9eMBa1yvEg3ZYD0YHiEamZteXp4b+tqOYIlSZVGVz+h4DtJIRsJS/z
xGfQLRp68YoDFMOwQlqDginDTQsm+YauLdNTbTbm7UEgegXlBSppRoxiQPji7ge2M0XxKCZwXI7w
larJY774YXT/ybkwlKi9cOC0c3gOjVLK5FQ6tqKycpAmA/xdyRThQkOOU/b8

--------------Boundary-00=_0ASOLC9JZ60D64F52N7P--
