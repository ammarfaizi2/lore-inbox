Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVEaPEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVEaPEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEaPEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:04:46 -0400
Received: from odin2.bull.net ([192.90.70.84]:22994 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261504AbVEaPEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:04:39 -0400
Subject: RT : 2.6.12rc5 + realtime-preempt-2.6.12-rc5-V0.7.47-15
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: multipart/mixed; boundary="=-0ETsQf8wH4gpgiJMl7Jd"
Organization: BTS
Message-Id: <1117551231.19367.48.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Tue, 31 May 2005 16:53:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0ETsQf8wH4gpgiJMl7Jd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have a test program which made a loop in RT to mesure the system
perturbation.
It works finely in a tty environment.
When I run it in an X environment ( xterm ), I get something like if I
click the Enter key in the active window.
If I open a new xterm, this is the new active window which receive these
events.
These events stop when the program stop.

I tried with X in RT and no RT : I have the problem.

I send you the program in copy to reproduce.
I have this problem in all version of RT.

--=-0ETsQf8wH4gpgiJMl7Jd
Content-Disposition: attachment; filename=test_tsc.c
Content-Type: text/x-c; name=test_tsc.c; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fonctions.h"

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h> /* for mmap and MCL_CURRENT */
#include <stdlib.h> /* for atoi */
#include <asm/msr.h> /* for rdtsc */

#define __USE_GNU=20
#include <sched.h> /* for sched_xxxx */

//#define NB_TEST 60000000000ULL
#define NB_TEST 60000000ULL

float get_cpu_clock_speed()
{
  FILE *fp;
  char buffer[1024];
  size_t bytes_read;
  char *match;
  float clock_speed;

  fp =3D fopen ("/proc/cpuinfo", "r");
  bytes_read =3D fread (buffer, 1, sizeof (buffer), fp);
  fclose (fp);
  if (bytes_read =3D=3D 0 || bytes_read =3D=3D sizeof (buffer))
    return 0;
  buffer[bytes_read] =3D '\0';
  match =3D strstr (buffer, "cpu MHz");
  if (match =3D=3D NULL)
    return 0;
  sscanf (match, "cpu MHz : %f", &clock_speed);
  return clock_speed;
}

int main(int argc,char **argv)
{
 unsigned long long max,dt;
 float frequency;
 int cptr;
 long long i;
 struct sched_param sched_param;
 double duree;
 union {
   unsigned long long total;
   struct {
     unsigned long MSL;
     unsigned long LSL;
   };
 } tempsdeb,tempsfin,t1,t2,tmax1,tmax2;
 cpu_set_t new_mask;
 pid_t p =3D 0;
 int ret;

  if (argc!=3D2)
  {
     fprintf(stderr,"Usage:%s <NUM_CPU>\n",argv[0]);
     return -1;
  }
  CPU_ZERO(&new_mask);
  CPU_SET(atoi(argv[1]),&new_mask);
  ret =3D sched_setaffinity(p,sizeof(cpu_set_t) , &new_mask);
  rdtsc(tempsdeb.MSL,tempsdeb.LSL);
  printf(" Start time %Lx \n",tempsdeb.total);
  sched_param.sched_priority =3D99;
  cptr =3D sched_setscheduler(getpid(), SCHED_FIFO,&sched_param );
  cptr =3D mlockall(MCL_CURRENT);
  printf("mlockall cptr %d\n",cptr);
=20
 max=3D0;
 rdtsc(t1.MSL,t1.LSL);
 for (i =3D 0; i < NB_TEST; i++)
   {
	 rdtsc(t2.MSL,t2.LSL);
	 dt =3D t2.total - t1.total;
	 if ( dt > max)=20
	 { max =3D dt;
	  tmax1.total =3D t1.total;
	  tmax2.total =3D t2.total;
	  }
	 t1.total =3D t2.total;
   }
 rdtsc(tempsfin.MSL,tempsfin.LSL);
 printf(" End time  %Lx \n",tempsfin.total);
 printf(" Max time 1  %Lx \n",tmax1.total);
 printf(" Max time 2  %Lx \n",tmax2.total);
 frequency =3D get_cpu_clock_speed();
  if (frequency =3D=3D 0)
	  return -1;
 duree =3D((double) (tempsfin.total - tempsdeb.total))/(frequency*1000000);
 printf("Test duration is %f s max detected %.0f =B5s\n",duree,((double)max=
)/(frequency));

 return 0;
}

--=-0ETsQf8wH4gpgiJMl7Jd--

