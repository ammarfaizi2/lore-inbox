Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263003AbREaDlC>; Wed, 30 May 2001 23:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263006AbREaDkw>; Wed, 30 May 2001 23:40:52 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:28427 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263003AbREaDkn>;
	Wed, 30 May 2001 23:40:43 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105310340.f4V3eVF244481@saturn.cs.uml.edu>
Subject: Re: How to know HZ from userspace?
To: laforge@gnumonks.org (Harald Welte)
Date: Wed, 30 May 2001 23:40:30 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> from "Harald Welte" at May 30, 2001 08:37:25 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte writes:

> Is there any way to read out the compile-time HZ value of the kernel?
> 
> I had a brief look at /proc/* and didn't find anything.

Look again, this time with a sick mind. Got your barf bag?
Kubys made me do it.

/****************************************************************/
/***********************************************************************\
*   Copyright (C) 1992-1998 by Michael K. Johnson, johnsonm@redhat.com *
*                                                                      *
*      This file is placed under the conditions of the GNU Library     *
*      General Public License, version 2, or any later version.        *
*      See file COPYING for information on distribution conditions.    *
\***********************************************************************/

/* ...but Albert Cahalan wrote the really evil parts.
MKJ is only guilty for the macro */

/* Sets Hertz equal to the kernel's HZ, as seen in /proc. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include <unistd.h>
#include <fcntl.h>

#ifndef HZ
#include <netinet/in.h>  /* htons */
#endif

long smp_num_cpus;     /* number of CPUs */

#define BAD_OPEN_MESSAGE                                        \
"Error: /proc must be mounted\n"                                \
"  To mount /proc at boot you need an /etc/fstab line like:\n"  \
"      /proc   /proc   proc    defaults\n"                      \
"  In the meantime, mount /proc /proc -t proc\n"

#define STAT_FILE    "/proc/stat"
static int stat_fd = -1;
#define UPTIME_FILE  "/proc/uptime"
static int uptime_fd = -1;
#define LOADAVG_FILE "/proc/loadavg"
static int loadavg_fd = -1;
#define MEMINFO_FILE "/proc/meminfo"
static int meminfo_fd = -1;

static char buf[1024];

/* This macro opens filename only if necessary and seeks to 0 so
 * that successive calls to the functions are more efficient.
 * It also reads the current contents of the file into the global buf.
 */
#define FILE_TO_BUF(filename, fd) do{                           \
    static int local_n;                                         \
    if (fd == -1 && (fd = open(filename, O_RDONLY)) == -1) {    \
        fprintf(stderr, BAD_OPEN_MESSAGE);                      \
        fflush(NULL);                                           \
        _exit(102);                                             \
    }                                                           \
    lseek(fd, 0L, SEEK_SET);                                    \
    if ((local_n = read(fd, buf, sizeof buf - 1)) < 0) {        \
        perror(filename);                                       \
        fflush(NULL);                                           \
        _exit(103);                                             \
    }                                                           \
    buf[local_n] = '\0';                                        \
}while(0)

unsigned long Hertz;
static void init_Hertz_value(void) __attribute__((constructor));
static void init_Hertz_value(void){
  unsigned long user_j, nice_j, sys_j, other_j;  /* jiffies (clock ticks) */
  double up_1, up_2, seconds;
  unsigned long jiffies, h;
  smp_num_cpus = sysconf(_SC_NPROCESSORS_CONF);
  if(smp_num_cpus==-1) smp_num_cpus=1;
  do{
    FILE_TO_BUF(UPTIME_FILE,uptime_fd);  sscanf(buf, "%lf", &up_1);
    /* uptime(&up_1, NULL); */
    FILE_TO_BUF(STAT_FILE,stat_fd);
    sscanf(buf, "cpu %lu %lu %lu %lu", &user_j, &nice_j, &sys_j, &other_j);
    FILE_TO_BUF(UPTIME_FILE,uptime_fd);  sscanf(buf, "%lf", &up_2);
    /* uptime(&up_2, NULL); */
  } while((long)( (up_2-up_1)*1000.0/up_1 )); /* want under 0.1% error */
  jiffies = user_j + nice_j + sys_j + other_j;
  seconds = (up_1 + up_2) / 2;
  h = (unsigned long)( (double)jiffies/seconds/smp_num_cpus );
  /* actual values used by 2.4 kernels: 32 64 100 128 1000 1024 1200 */
  switch(h){
  case   30 ...   34 :  Hertz =   32; break; /* ia64 emulator */
  case   48 ...   52 :  Hertz =   50; break;
  case   58 ...   62 :  Hertz =   60; break;
  case   63 ...   65 :  Hertz =   64; break; /* StrongARM /Shark */
  case   95 ...  105 :  Hertz =  100; break; /* normal Linux */
  case  124 ...  132 :  Hertz =  128; break; /* MIPS, ARM */
  case  195 ...  204 :  Hertz =  200; break; /* normal << 1 */
  case  253 ...  260 :  Hertz =  256; break;
  case  393 ...  408 :  Hertz =  400; break; /* normal << 2 */
  case  790 ...  808 :  Hertz =  800; break; /* normal << 3 */
  case  990 ... 1010 :  Hertz = 1000; break; /* ARM */
  case 1015 ... 1035 :  Hertz = 1024; break; /* Alpha, ia64 */
  case 1180 ... 1220 :  Hertz = 1200; break; /* Alpha */
  default:
#ifdef HZ
    Hertz = (unsigned long)HZ;    /* <asm/param.h> */
#else
    /* If 32-bit or big-endian (not Alpha or ia64), assume HZ is 100. */
    Hertz = (sizeof(long)==sizeof(int) || htons(999)==999) ? 100UL : 1024UL;
#endif
    fprintf(stderr, "Unknown HZ value! (%ld) Assume %ld.\n", h, Hertz);
  }
}
/****************************************************************/





