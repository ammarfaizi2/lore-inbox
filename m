Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314102AbSDQOvc>; Wed, 17 Apr 2002 10:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSDQOvb>; Wed, 17 Apr 2002 10:51:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55314 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S314100AbSDQOv3>; Wed, 17 Apr 2002 10:51:29 -0400
Date: Wed, 17 Apr 2002 16:51:30 +0200
From: Jan Hubicka <jh@suse.cz>
To: bugtraq@securityfocus.com, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>, jakub@redhat.com,
        aj@suse.de, ak@suse.de
Subject: SSE related security hole
Message-ID: <20020417145130.GA29952@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
while debugging GCC bugreport, I noticed following behaviour of simple
program with no syscalls:

hubicka@nikam:~$ ./a.out
sum of 7 ints: 28
hubicka@nikam:~$ ./a.out
sum of 7 ints: 56
Bad sum (seen with gcc -O -march=pentiumpro -msse)
hubicka@nikam:~$ ./a.out
sum of 7 ints: 84
Bad sum (seen with gcc -O -march=pentiumpro -msse)
hubicka@nikam:~$ ./a.out
sum of 7 ints: 112
Bad sum (seen with gcc -O -march=pentiumpro -msse)
hubicka@nikam:~$ echo

hubicka@nikam:~$ ./a.out
sum of 7 ints: 28


ie it always returns different value, moreover when something else
is run in meantime (verified by loading WWW page served by same machine),
the counter is reinitialized to 28.

I am attaching the source, but it needs to be compiled by cfg-branch GCC
with settings -O2 -march=pentium3 -mfpmath=sse, so I've placed static
binary to http://atrey.karlin.mff.cuni.cz/~hubicka/badsum.bin

The problem appears to be reproducible only on pentium3 and athlon4 systems,
not pentium4 system, where it appears to work as expected.  Reproduced on
both 2.4.9-RH and 2.4.16 kernels.

Honza

--k1lZvvs/B4yU6o8G
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="badsum.c"

#include <stdlib.h>
#include <stdio.h>

#define t(x) asm("rdtsc":"=A"(x));
	char str[256],b;
int m(){
	long long a,b,c,d;
int i,n=7;	//choose any n < sqrt(1/FLT_EPSILON)
    float comp,sum=0;
	sin(1);
    for(i=1;i<=n;++i)
	sum += i;
    sprintf(str,"sum of %d ints: %g\n",n,sum);
    comp = n*(n*.5f+.5f);
    if(sum != comp){
	    b=1;
	}
    printf(str);
    if (b)
	printf("Bad sum (seen with gcc -O -march=pentiumpro -msse)\n");
    return 0;
}
main()
{
	/*sin(1);*/
	asm("finit");
	m();
}

--k1lZvvs/B4yU6o8G--
