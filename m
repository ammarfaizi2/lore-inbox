Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318023AbSGWIRH>; Tue, 23 Jul 2002 04:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318024AbSGWIRH>; Tue, 23 Jul 2002 04:17:07 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:30416 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318023AbSGWIRF>; Tue, 23 Jul 2002 04:17:05 -0400
Importance: Normal
Sensitivity: 
Subject: gettimeofday() running backwards (again)
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF5BB04922.28DDCF7C-ONC1256BFF.002C2300@de.ibm.com>
From: "Michael Bauer" <BauerMic@de.ibm.com>
Date: Tue, 23 Jul 2002 10:20:06 +0200
X-MIMETrack: Serialize by Router on D12ML025/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 23/07/2002 10:20:07
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(my first post to lkml, so please bear with me ;)

while trying to do some performance timings on my application, i stumbled
over
a strange behaviour of gettimeofday(). When called consecutive, sometimes
the
second call gives a time prior to the first call. This affects only
tv_usecs, not tv_secs.

My System is:
IBM Thinkpad 600E (Mobile PentiumII, 400MHz)
Debian woody
gcc 2.95.4
glibc6 2.2.5
Kernel 2.4.18 (problem occurs with and without preemptible patch)

Following the links in
<http://kt.zork.net/kernel-traffic/kt20020708_174.html#1> i noticed that
behaviour is known already for quite a long time but it seems no one knows
exactly whats
going on.
So if i can do something to help hunt this bug down, here i am ;-)


Following is my sample program: (I know i am not checking tv_sec turnovers
;)

----------begin--------------
#include <sys/time.h>
#include <stdio.h>

int main(int argc, char** argv)
{
    struct timeval pre;
    struct timeval after;
    int ret;
    int count;
    int elapsed;

    if (argc != 2) {
        printf("Usage: %s <number of loops>\n", argv[0]);
        exit();
    }

    for (count = 0; count < atoi(argv[1]); count ++) {

        ret = gettimeofday(&pre, 0);
        ret = gettimeofday(&after, 0);
        elapsed = (after.tv_usec - pre.tv_usec);

        if (elapsed < 0) {
            printf("Roundtrip: %i\n", elapsed);
            printf("pre: %i,%i\n", pre.tv_sec, pre.tv_usec);
            printf("aft: %i,%i\n", after.tv_sec, after.tv_usec);
        }
    }
}
-----------end---------------

This leads to following results:

mike@debian:~/DA/code/perf$ ./a.out 20000
Roundtrip: -8584
pre: 1027331594,794432
aft: 1027331594,785848
Roundtrip: -7196
pre: 1027331594,802279
aft: 1027331594,795083
Roundtrip: -6220
pre: 1027331594,811291
aft: 1027331594,805071
Roundtrip: -2218
pre: 1027331594,817912
aft: 1027331594,815694
Roundtrip: -21128
pre: 1027331594,847674
aft: 1027331594,826546
Roundtrip: -4081
pre: 1027331594,919140
aft: 1027331594,915059
Roundtrip: -22962
pre: 1027331594,968044
aft: 1027331594,945082
Roundtrip: -12667
pre: 1027331594,997757
aft: 1027331594,985090

(Note that tv_sec is always the same.)


curious, Mike
bauermic@de.ibm.com


