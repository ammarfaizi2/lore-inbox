Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbRHJIEH>; Fri, 10 Aug 2001 04:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265810AbRHJID6>; Fri, 10 Aug 2001 04:03:58 -0400
Received: from ftp.mb.ru ([195.133.152.251]:49162 "EHLO mb.ru")
	by vger.kernel.org with ESMTP id <S265277AbRHJIDp>;
	Fri, 10 Aug 2001 04:03:45 -0400
Message-ID: <3B739598.BC4091DB@mb.ru>
Date: Fri, 10 Aug 2001 12:04:40 +0400
From: Eduard Phetisov <wert@mb.ru>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, haible@ma2s2.mathematik.uni-karlsruhe.de,
        osrc@pell.chi.il.us, quintela@fi.udc.es, dwmw2@redhat.com
Subject: BUG in the kernels 2.4.x
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think what I find a bug in the kernels 2.4.x.
Bug apears then several processes allocates some memory. If size of the
free memory less then size of claimed memory by processes, system went
down. Such phenomenon apears on the several Linux systems.
Affected systems
Servers:
Compaq Proliant 8500 (CPU 8xXeon 600, 8Gb RAM, Raid Compaq 5300, OS
RedHat 7.0, 7.1, kernels 2.4.2 2.4.3 2.4.4 2.4.5 2.4.7), start.sh
parameters 200 50 10
WIT (CPU 8xXeon 700, 8Gb RAM, Raid Mylex DAC960 OS RedHat 6.2, 7.0, 7.1,
SuSe 7.2, Mandrake 8.0, kernels 2.4.2 2.4.4 2.4.7 2.4.8) start.sh
parameters 200 50 10
IBM (CPU 2xPentium III 500, RAM 1Gb, OS RedHat 6.2, kernels 2.4.2 2.4.3
2.4.4 2.4.5) start.sh parameters 200 10 10

Workstantions:
Cpu Pentium III 600 , RAM 128Mb, OS RedHat 7.0, kernels 2.4.1 2.4.2
2.4.3 2.4.4 2.4.5 2.4.7, start.sh parameters 70 10 2
Cpu Celeron (Copermine) 600, RAM 64Mb, OS RedHat 7.1, kernels 2.4.1
2.4.2 2.4.3 2.4.4 2.4.5 2.4.7, start.sh parameters 70 10 2
Cpu Celeron (Copermine) 900, RAM 128Mb, OS RedHat 7.1, kernels 2.4.1
2.4.2 2.4.3 2.4.4 2.4.5 2.4.7, start.sh parameters 70 10 2
Cpu Celeron (Copermine) 912, RAM 128Mb, OS Mandrake 8.0, kernels 2.4.3
2.4.4, start.sh parameters 70 10 2

with following programs

// Memuse.c is a very funny programm
#include <malloc.h>
#include <stdio.h>

main(int argc, char **argv)
{
  int ms, rss, i, sum;
  char * arr;

  if (argc < 2)
  {
    printf("usage %s MS(MB) RSS(MB)\n", argv[0]);
    exit(255);
  }
  ms = atoi(argv[1])*1024*1024;
  rss = atoi(argv[2])*1024*1024;
  printf("MS=%d bytes, RSS=%d bytes\n", ms, rss);
  printf("Allocating memory ...\n");
  arr = malloc(ms);
  if (arr==NULL)
    exit(printf("Malloc returns NULL\n"));
  for(i=0;i<ms;arr[i]=(i++ & 255));
  printf("Memory Allocated\n");
  while(1)
  {
      for(sum=i=0;i<rss;arr[i] = (i++) & 255);
      sleep(3);
  }
}

and with shell script
#!/bin/bash
i=0
if [ $# -ne 3 ]
then
        echo Usage $0 Count Use RSS
        exit -1
fi
while [ $i -ne $1 ]
do
        memuse $2 $3 &
        echo $i
        i=`expr $i + 1`
done;

Analogous situation must appear every morning, because we have a big
database in our busines (Oarcle, database size is about 100Gb and
awerage transaction activity about 1000 transactions per second), which
used by over then 400 people.  Kernels 2.2.x (we use 2.2.19 with several
cenges, which allow to use 1.6Gb in the shared memory) works properly in
this situation, but it can't use more then 4Gb of memory, so please help
us and solve this problem.

