Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281726AbRLOCYt>; Fri, 14 Dec 2001 21:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281779AbRLOCYl>; Fri, 14 Dec 2001 21:24:41 -0500
Received: from mail2.mx.voyager.net ([216.93.66.201]:32776 "EHLO
	mail2.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S281726AbRLOCYg>; Fri, 14 Dec 2001 21:24:36 -0500
Message-ID: <3C1AB4B4.A24A0A5@megsinet.net>
Date: Fri, 14 Dec 2001 20:25:56 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Andrea Arcangeli <andrea@suse.de>, davej@suse.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] - Taming OOM killer, 2.4.17-rc1
In-Reply-To: <20011212094246.O4801@athlon.random>
Content-Type: multipart/mixed;
 boundary="------------A70695F7AD102D81ADA0FDB4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A70695F7AD102D81ADA0FDB4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Marcelo,

I tested your VM changes in rc1 and it still "feels" wrong...subjective;)

Dave pointed out in a previous thread that the OOM killer has been over
enthusiastic on his boxes,  same here.

The attached patch changes the attributes of the out_of_memory function to:

1. wait longer before attempting to kill processes;  "MB of cache" seconds.
2. OOM occurrences must be 10*(MB of cache) once "1." is satisfied.

This allows the system to be less likely to kill processes when there is still cache
memory available, i.e. the OOM killer is dynamic based on the system cache size.

We probably should be killing processes without a least first shrinking cache size
somewhat first.  It would be much better to have processes run at the expense of
cache than the other way around, i.e.. a predictably slow system due to low memory
thus little cache is better than a fast system that unpredictably keeps killing
processes because large amount of memory are held in cache.

The DEBUG output below is just from compiling kdebase, w/o this OOM killer taming my
system fail to compile most large packages.  That has been true since OOM killer
was re-enable in the 2.4.X series sometime after the 2.4.10 VM changes.
(also running 1 setiathome, kde desktop and other minor small apps)

Dual C-466, 192M RAM, no swap.

Below is the DEBUG output from my change that shows the system failing to release
page cache for quite sometime.  I split up the output for easier reading.

There are also long pauses (display/mouse freezes) in the system when this is happening.

I realize this patch is just chasing a symptom, but it is self tuning so seems to
be a good change regardless.  Yes, it still kills ;) (patch attached as binary file)

Martin



This is:         Cache size,    Time in Seconds since first OOM report,
                                restarted if > 5 seconds since the
                                last OOM report.

out_of_memory: cache size 17 Mb, since = 0.80
out_of_memory: cache size 17 Mb, since = 1.15
out_of_memory: cache size 17 Mb, since = 1.19
out_of_memory: cache size 17 Mb, since = 2.64
out_of_memory: cache size 17 Mb, since = 3.14
out_of_memory: cache size 17 Mb, since = 3.20
out_of_memory: cache size 17 Mb, since = 3.26
out_of_memory: cache size 17 Mb, since = 3.27
out_of_memory: cache size 17 Mb, since = 3.67
out_of_memory: cache size 17 Mb, since = 4.42  << Previous system would have killed a process
out_of_memory: cache size 17 Mb, since = 4.44     and we haven't even touched the cache size.
out_of_memory: cache size 16 Mb, since = 5.19
out_of_memory: cache size 16 Mb, since = 5.52
out_of_memory: cache size 16 Mb, since = 5.76
out_of_memory: cache size 15 Mb, since = 6.79
out_of_memory: cache size 15 Mb, since = 8.04
out_of_memory: cache size 14 Mb, since = 8.20
---------------------------------------------------------------
out_of_memory: cache size 10 Mb, since = 1.91
out_of_memory: cache size 8 Mb, since = 6.81
out_of_memory: cache size 8 Mb, since = 6.83
---------------------------------------------------------------
out_of_memory: cache size 45 Mb, since = 1.31
out_of_memory: cache size 45 Mb, since = 2.23
out_of_memory: cache size 45 Mb, since = 2.30
out_of_memory: cache size 45 Mb, since = 2.38
out_of_memory: cache size 45 Mb, since = 3.43
out_of_memory: cache size 45 Mb, since = 3.56
out_of_memory: cache size 45 Mb, since = 3.67
out_of_memory: cache size 45 Mb, since = 3.67
out_of_memory: cache size 45 Mb, since = 3.73
out_of_memory: cache size 45 Mb, since = 3.78 << Previous system would have killed a process
out_of_memory: cache size 45 Mb, since = 3.82
out_of_memory: cache size 45 Mb, since = 3.84
out_of_memory: cache size 45 Mb, since = 3.93
out_of_memory: cache size 44 Mb, since = 5.02
out_of_memory: cache size 44 Mb, since = 5.03
out_of_memory: cache size 44 Mb, since = 5.04
out_of_memory: cache size 44 Mb, since = 5.11
out_of_memory: cache size 44 Mb, since = 5.31
out_of_memory: cache size 44 Mb, since = 7.05
out_of_memory: cache size 44 Mb, since = 7.12
--------------------------------------------------------------------
out_of_memory: cache size 41 Mb, since = 0.06
out_of_memory: cache size 41 Mb, since = 0.11
out_of_memory: cache size 41 Mb, since = 0.74
out_of_memory: cache size 41 Mb, since = 0.83
out_of_memory: cache size 40 Mb, since = 1.29
out_of_memory: cache size 40 Mb, since = 1.48
out_of_memory: cache size 40 Mb, since = 1.57
out_of_memory: cache size 40 Mb, since = 2.37
out_of_memory: cache size 40 Mb, since = 2.40
out_of_memory: cache size 40 Mb, since = 2.43 << and here
out_of_memory: cache size 40 Mb, since = 2.54
out_of_memory: cache size 40 Mb, since = 2.58
out_of_memory: cache size 40 Mb, since = 2.85
out_of_memory: cache size 40 Mb, since = 4.35
out_of_memory: cache size 40 Mb, since = 4.40
out_of_memory: cache size 40 Mb, since = 4.63
out_of_memory: cache size 40 Mb, since = 4.77
out_of_memory: cache size 40 Mb, since = 5.12
out_of_memory: cache size 40 Mb, since = 5.33
out_of_memory: cache size 40 Mb, since = 5.49
out_of_memory: cache size 40 Mb, since = 5.54
out_of_memory: cache size 40 Mb, since = 5.55
out_of_memory: cache size 40 Mb, since = 5.97
out_of_memory: cache size 40 Mb, since = 6.26
out_of_memory: cache size 40 Mb, since = 6.62
out_of_memory: cache size 40 Mb, since = 6.92
out_of_memory: cache size 40 Mb, since = 7.17
out_of_memory: cache size 40 Mb, since = 7.50
out_of_memory: cache size 40 Mb, since = 7.74
out_of_memory: cache size 40 Mb, since = 7.85
out_of_memory: cache size 40 Mb, since = 8.21
out_of_memory: cache size 40 Mb, since = 8.81
out_of_memory: cache size 40 Mb, since = 8.85
out_of_memory: cache size 40 Mb, since = 8.92
out_of_memory: cache size 40 Mb, since = 9.07
out_of_memory: cache size 40 Mb, since = 9.47
out_of_memory: cache size 40 Mb, since = 9.81
out_of_memory: cache size 40 Mb, since = 9.84
out_of_memory: cache size 40 Mb, since = 9.94
out_of_memory: cache size 40 Mb, since = 10.49
out_of_memory: cache size 40 Mb, since = 10.80
out_of_memory: cache size 40 Mb, since = 10.81
out_of_memory: cache size 40 Mb, since = 10.88
out_of_memory: cache size 40 Mb, since = 11.40
out_of_memory: cache size 40 Mb, since = 11.77
out_of_memory: cache size 40 Mb, since = 11.81
out_of_memory: cache size 40 Mb, since = 11.81
out_of_memory: cache size 40 Mb, since = 12.01
out_of_memory: cache size 40 Mb, since = 12.04
out_of_memory: cache size 40 Mb, since = 12.24
out_of_memory: cache size 40 Mb, since = 12.60
out_of_memory: cache size 40 Mb, since = 12.90
out_of_memory: cache size 40 Mb, since = 12.94
out_of_memory: cache size 40 Mb, since = 13.40
out_of_memory: cache size 40 Mb, since = 13.55
out_of_memory: cache size 40 Mb, since = 14.16
out_of_memory: cache size 40 Mb, since = 14.16
out_of_memory: cache size 40 Mb, since = 14.16
out_of_memory: cache size 40 Mb, since = 14.26
out_of_memory: cache size 40 Mb, since = 14.27
out_of_memory: cache size 40 Mb, since = 14.81
out_of_memory: cache size 40 Mb, since = 14.88
out_of_memory: cache size 40 Mb, since = 15.43
out_of_memory: cache size 40 Mb, since = 15.58
out_of_memory: cache size 40 Mb, since = 15.79
out_of_memory: cache size 40 Mb, since = 16.28
out_of_memory: cache size 40 Mb, since = 16.44
out_of_memory: cache size 40 Mb, since = 16.48
out_of_memory: cache size 40 Mb, since = 16.93
out_of_memory: cache size 40 Mb, since = 17.02
out_of_memory: cache size 40 Mb, since = 17.12
out_of_memory: cache size 40 Mb, since = 17.76
out_of_memory: cache size 40 Mb, since = 17.80
out_of_memory: cache size 40 Mb, since = 17.87
out_of_memory: cache size 40 Mb, since = 18.01
out_of_memory: cache size 40 Mb, since = 18.29
out_of_memory: cache size 40 Mb, since = 18.46
out_of_memory: cache size 40 Mb, since = 18.48
out_of_memory: cache size 40 Mb, since = 18.50
out_of_memory: cache size 40 Mb, since = 18.70
out_of_memory: cache size 40 Mb, since = 19.21
out_of_memory: cache size 40 Mb, since = 19.27
out_of_memory: cache size 40 Mb, since = 19.46
out_of_memory: cache size 40 Mb, since = 19.56
out_of_memory: cache size 40 Mb, since = 19.91
out_of_memory: cache size 40 Mb, since = 20.07
out_of_memory: cache size 40 Mb, since = 20.71
out_of_memory: cache size 40 Mb, since = 20.86
out_of_memory: cache size 40 Mb, since = 21.43
out_of_memory: cache size 40 Mb, since = 21.58
out_of_memory: cache size 40 Mb, since = 21.78
out_of_memory: cache size 40 Mb, since = 21.98
out_of_memory: cache size 40 Mb, since = 22.00
out_of_memory: cache size 40 Mb, since = 22.11
out_of_memory: cache size 40 Mb, since = 22.67
out_of_memory: cache size 40 Mb, since = 22.78
out_of_memory: cache size 40 Mb, since = 22.84
out_of_memory: cache size 40 Mb, since = 22.95
out_of_memory: cache size 40 Mb, since = 22.98
out_of_memory: cache size 40 Mb, since = 23.05
out_of_memory: cache size 40 Mb, since = 23.18
out_of_memory: cache size 40 Mb, since = 23.18
out_of_memory: cache size 40 Mb, since = 23.32
out_of_memory: cache size 40 Mb, since = 23.53
out_of_memory: cache size 40 Mb, since = 23.60
out_of_memory: cache size 40 Mb, since = 23.69
out_of_memory: cache size 40 Mb, since = 24.03
out_of_memory: cache size 40 Mb, since = 24.06
out_of_memory: cache size 40 Mb, since = 24.17
out_of_memory: cache size 40 Mb, since = 24.40
out_of_memory: cache size 40 Mb, since = 24.52
out_of_memory: cache size 40 Mb, since = 24.79
out_of_memory: cache size 40 Mb, since = 27.42
out_of_memory: cache size 40 Mb, since = 27.73
out_of_memory: cache size 40 Mb, since = 27.86
out_of_memory: cache size 40 Mb, since = 28.14
out_of_memory: cache size 40 Mb, since = 28.25
out_of_memory: cache size 40 Mb, since = 28.28
out_of_memory: cache size 40 Mb, since = 28.68
out_of_memory: cache size 40 Mb, since = 28.73
out_of_memory: cache size 40 Mb, since = 29.43
out_of_memory: cache size 40 Mb, since = 29.46
out_of_memory: cache size 40 Mb, since = 29.52
out_of_memory: cache size 40 Mb, since = 30.04
out_of_memory: cache size 40 Mb, since = 30.41
out_of_memory: cache size 40 Mb, since = 30.78 << ~29 SECONDS AND NO CACHE SHRINKAGE!!??!! ***
out_of_memory: cache size 39 Mb, since = 31.11
out_of_memory: cache size 39 Mb, since = 31.25
out_of_memory: cache size 39 Mb, since = 31.34
out_of_memory: cache size 39 Mb, since = 31.44
out_of_memory: cache size 39 Mb, since = 31.63
-----------------------------------------------------------
out_of_memory: cache size 19 Mb, since = 1.30
out_of_memory: cache size 19 Mb, since = 3.38
out_of_memory: cache size 19 Mb, since = 4.40
out_of_memory: cache size 18 Mb, since = 5.11
out_of_memory: cache size 18 Mb, since = 5.66
out_of_memory: cache size 18 Mb, since = 6.01
out_of_memory: cache size 18 Mb, since = 6.08
out_of_memory: cache size 18 Mb, since = 6.14
out_of_memory: cache size 18 Mb, since = 6.81
out_of_memory: cache size 18 Mb, since = 6.89 << and here
out_of_memory: cache size 18 Mb, since = 6.89
out_of_memory: cache size 18 Mb, since = 7.77
out_of_memory: cache size 18 Mb, since = 8.00
out_of_memory: cache size 18 Mb, since = 8.00
out_of_memory: cache size 18 Mb, since = 8.46
out_of_memory: cache size 18 Mb, since = 8.57
out_of_memory: cache size 18 Mb, since = 8.66
out_of_memory: cache size 18 Mb, since = 8.71
out_of_memory: cache size 18 Mb, since = 9.30
out_of_memory: cache size 18 Mb, since = 9.65
out_of_memory: cache size 18 Mb, since = 9.80
out_of_memory: cache size 18 Mb, since = 9.93
out_of_memory: cache size 18 Mb, since = 10.51
out_of_memory: cache size 18 Mb, since = 10.92
out_of_memory: cache size 18 Mb, since = 11.00
out_of_memory: cache size 18 Mb, since = 11.15
out_of_memory: cache size 18 Mb, since = 11.28
out_of_memory: cache size 18 Mb, since = 11.38
out_of_memory: cache size 18 Mb, since = 11.40
out_of_memory: cache size 18 Mb, since = 11.65
out_of_memory: cache size 18 Mb, since = 11.72
out_of_memory: cache size 18 Mb, since = 11.75
out_of_memory: cache size 18 Mb, since = 12.21
out_of_memory: cache size 18 Mb, since = 12.46
out_of_memory: cache size 18 Mb, since = 12.56
out_of_memory: cache size 18 Mb, since = 12.89
out_of_memory: cache size 18 Mb, since = 13.36
out_of_memory: cache size 18 Mb, since = 13.77
out_of_memory: cache size 18 Mb, since = 14.04
out_of_memory: cache size 18 Mb, since = 14.23
out_of_memory: cache size 18 Mb, since = 14.46
out_of_memory: cache size 18 Mb, since = 14.58
out_of_memory: cache size 18 Mb, since = 14.60
out_of_memory: cache size 18 Mb, since = 14.61
out_of_memory: cache size 18 Mb, since = 14.67
out_of_memory: cache size 18 Mb, since = 14.92
out_of_memory: cache size 18 Mb, since = 15.24
out_of_memory: cache size 18 Mb, since = 15.36
out_of_memory: cache size 18 Mb, since = 15.43
out_of_memory: cache size 18 Mb, since = 16.06
out_of_memory: cache size 18 Mb, since = 16.51
out_of_memory: cache size 18 Mb, since = 16.63
out_of_memory: cache size 18 Mb, since = 16.68
out_of_memory: cache size 18 Mb, since = 16.74
out_of_memory: cache size 18 Mb, since = 16.75
out_of_memory: cache size 18 Mb, since = 17.60
out_of_memory: cache size 18 Mb, since = 17.98
------------------------------------------------------------------------------
out_of_memory: cache size 59 Mb, since = 2.09
out_of_memory: cache size 59 Mb, since = 2.32
out_of_memory: cache size 59 Mb, since = 2.44
out_of_memory: cache size 57 Mb, since = 3.50
out_of_memory: cache size 57 Mb, since = 3.52
out_of_memory: cache size 57 Mb, since = 3.94
out_of_memory: cache size 56 Mb, since = 4.97
out_of_memory: cache size 56 Mb, since = 5.13
out_of_memory: cache size 56 Mb, since = 5.20
out_of_memory: cache size 56 Mb, since = 5.28 << and here
out_of_memory: cache size 56 Mb, since = 5.28
out_of_memory: cache size 55 Mb, since = 6.40
out_of_memory: cache size 55 Mb, since = 6.66
out_of_memory: cache size 54 Mb, since = 9.09
out_of_memory: cache size 54 Mb, since = 9.11
out_of_memory: cache size 54 Mb, since = 9.17
out_of_memory: cache size 54 Mb, since = 9.30
out_of_memory: cache size 54 Mb, since = 9.65
out_of_memory: cache size 54 Mb, since = 9.67
-----------------------------------------------------------------
out_of_memory: cache size 47 Mb, since = 0.67
out_of_memory: cache size 47 Mb, since = 0.86
out_of_memory: cache size 47 Mb, since = 0.91
out_of_memory: cache size 47 Mb, since = 0.91
out_of_memory: cache size 47 Mb, since = 0.95
out_of_memory: cache size 47 Mb, since = 0.96
out_of_memory: cache size 47 Mb, since = 1.22
out_of_memory: cache size 46 Mb, since = 2.13
out_of_memory: cache size 46 Mb, since = 2.25
out_of_memory: cache size 46 Mb, since = 2.32 << etc
out_of_memory: cache size 46 Mb, since = 2.37
out_of_memory: cache size 46 Mb, since = 2.53
out_of_memory: cache size 46 Mb, since = 2.58
out_of_memory: cache size 46 Mb, since = 2.59
out_of_memory: cache size 46 Mb, since = 2.67
out_of_memory: cache size 46 Mb, since = 2.69
out_of_memory: cache size 46 Mb, since = 4.35
out_of_memory: cache size 46 Mb, since = 4.67
out_of_memory: cache size 46 Mb, since = 4.91
out_of_memory: cache size 46 Mb, since = 4.91
out_of_memory: cache size 45 Mb, since = 5.62
out_of_memory: cache size 44 Mb, since = 8.21
--------------A70695F7AD102D81ADA0FDB4
Content-Type: application/octet-stream;
 name="oom_kill.c.patch2.4.17rc1"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="oom_kill.c.patch2.4.17rc1"

LS0tIG9vbV9raWxsLmMub3JpZwlXZWQgRGVjIDEyIDIyOjE2OjA2IDIwMDEKKysrIG9vbV9r
aWxsLmMJVGh1IERlYyAxMyAyMjozMTowMSAyMDAxCkBAIC0yMiw2ICsyMiw3IEBACiAjaW5j
bHVkZSA8bGludXgvdGltZXguaD4KIAogLyogI2RlZmluZSBERUJVRyAqLworI2RlZmluZSBE
RUJVRzEKIAogLyoqCiAgKiBpbnRfc3FydCAtIG9vbV9raWxsLmMgaW50ZXJuYWwgZnVuY3Rp
b24sIHJvdWdoIGFwcHJveGltYXRpb24gdG8gc3FydApAQCAtMjAwLDYgKzIwMSw3IEBACiB7
CiAJc3RhdGljIHVuc2lnbmVkIGxvbmcgZmlyc3QsIGxhc3QsIGNvdW50OwogCXVuc2lnbmVk
IGxvbmcgbm93LCBzaW5jZTsKKwlpbnQgbWVnYTsKIAogCS8qCiAJICogRW5vdWdoIHN3YXAg
c3BhY2UgbGVmdD8gIE5vdCBPT00uCkBAIC0yMTUsMjMgKzIxNywzMCBAQAogCSAqIElmIGl0
J3MgYmVlbiBhIGxvbmcgdGltZSBzaW5jZSBsYXN0IGZhaWx1cmUsCiAJICogd2UncmUgbm90
IG9vbS4KIAkgKi8KLQlsYXN0ID0gbm93OworCiAJaWYgKHNpbmNlID4gNSpIWikKIAkJZ290
byByZXNldDsKIAogCS8qCi0JICogSWYgd2UgaGF2ZW4ndCB0cmllZCBmb3IgYXQgbGVhc3Qg
b25lIHNlY29uZCwKKwkgKiBJZiB3ZSBoYXZlbid0IHRyaWVkIGZvciBhdCBsZWFzdCBtZWdh
KnNlY29uZHMsCiAJICogd2UncmUgbm90IHJlYWxseSBvb20uCisJICogV2hlcmUgbWVnYSBp
cyB0aGUgbnVtYmVyIG9mIG1lZ2FieXRlcyBvZiBvdXRzdGFuZGluZyBjYWNoZS4KIAkgKi8K
KworCW1lZ2EgPSBhdG9taWNfcmVhZCgmcGFnZV9jYWNoZV9zaXplKSA+PiAoMjAgLSBQQUdF
X1NISUZUKTsKIAlzaW5jZSA9IG5vdyAtIGZpcnN0OwotCWlmIChzaW5jZSA8IEhaKQorCWlm
IChzaW5jZSA8IG1lZ2EgKiBIWikgeworI2lmZGVmIERFQlVHMQorCQlwcmludGsoS0VSTl9E
RUJVRyAib3V0X29mX21lbW9yeTogY2FjaGUgc2l6ZSAlZCBNYiwgc2luY2UgPSAlbHUuJTAy
bHVcbiIsbWVnYSwgc2luY2UvSFosIHNpbmNlJUhaKTsKKyNlbmRpZgogCQlyZXR1cm47CisJ
fQogCiAJLyoKIAkgKiBJZiB3ZSBoYXZlIGdvdHRlbiBvbmx5IGEgZmV3IGZhaWx1cmVzLAog
CSAqIHdlJ3JlIG5vdCByZWFsbHkgb29tLiAKIAkgKi8KLQlpZiAoKytjb3VudCA8IDEwKQor
CWlmICgrK2NvdW50IDwgbWVnYSAqIDEwKQogCQlyZXR1cm47CiAKIAkvKgo=
--------------A70695F7AD102D81ADA0FDB4--

