Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbSJAJru>; Tue, 1 Oct 2002 05:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261537AbSJAJru>; Tue, 1 Oct 2002 05:47:50 -0400
Received: from inje.iskon.hr ([213.191.128.16]:8703 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S261526AbSJAJrt>;
	Tue, 1 Oct 2002 05:47:49 -0400
To: akpm@zip.com.au, hugh@veritas.com
Cc: linux-kernel@vger.kernel.org
Subject: Shared memory shmat/dt not working well in 2.5.x
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Tue, 01 Oct 2002 11:52:59 +0200
Message-ID: <dny99icwp0.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi, Andrew, Hugh & others.

Still having problems with Oracle on 2.5.x (it can't even be started),
I devoted some time trying to pinpoint where the problem is. Reading
many traces of Oracle, and rebooting a dozen times, I finally found
that the culprit is weird behaviour of shmat/shmdt functions in 2.5,
when combined with mprotect() calls. I wrote a simple test app
(attached) and I'm also appending output of it below (running on
2.4.19 & 2.5.39 kernels, see the difference).

Hopefully, somebody will know how to help resolve that issue, so I can
finally benchmark Oracle on 2.4 vs Oracle on 2.5. ;)

Best regards,


{2.4.19} % shm-bug
First shmat & protects done: 50000000
50000000-51000000 rw-s 00000000 00:04 327974932  /SYSV01478e7f (deleted)
51000000-51001000 r--s 01000000 00:04 327974932  /SYSV01478e7f (deleted)
51001000-51081000 rw-s 01001000 00:04 327974932  /SYSV01478e7f (deleted)
51081000-51082000 r--s 01081000 00:04 327974932  /SYSV01478e7f (deleted)
51082000-51083000 rw-s 01082000 00:04 327974932  /SYSV01478e7f (deleted)
Second shmat done: 50000000
50000000-51083000 rw-s 00000000 00:04 327974932  /SYSV01478e7f (deleted)

{2.5.39} % shm-bug
First shmat & protects done: 50000000
50000000-51000000 rw-s 00000000 00:06 2457614    /SYSV01478e7f (deleted)
51000000-51001000 r--s 00000000 00:06 2457614    /SYSV01478e7f (deleted)
51001000-51081000 rw-s 00001000 00:06 2457614    /SYSV01478e7f (deleted)
51081000-51082000 r--s 00001000 00:06 2457614    /SYSV01478e7f (deleted)
51082000-51083000 rw-s 00002000 00:06 2457614    /SYSV01478e7f (deleted)
shmat 2: Invalid argument


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: attachment; filename=shm-bug.c

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/mman.h>

#define SIZE 17313792

void xperror(char *error_string)
{
	perror(error_string);
	exit(EXIT_FAILURE);
}

int main(int argc, char **argv)
{
	int shmid, *addr;
	char buffer[64];

	if ((shmid = shmget(21466751, SIZE, IPC_CREAT | IPC_EXCL | 0640)) < 0)
		xperror("shmget");
	addr = (int *) shmat(shmid, (char *) 0x50000000, 0);
	if (addr == (int *) -1)
		xperror("shmat 1");
	if (mprotect((char *) 0x51000000, 4096, PROT_READ) < 0)
		xperror("mprotect 1");
	if (mprotect((char *) 0x51081000, 4096, PROT_READ) < 0)
		xperror("mprotect 2");
	printf("First shmat & protects done: %08lx\n", (unsigned long) addr);
	sprintf(buffer, "cat /proc/%d/maps | grep /SYSV", getpid());
	system(buffer);
	if (shmdt(addr) < 0)
		xperror("shmdt 1");
	addr = (int *) shmat(shmid, (char *) 0x50000000, 0);
	if (addr == (int *) -1) {
		perror("shmat 2");
		shmctl(shmid, IPC_RMID, NULL);
		exit(EXIT_FAILURE);
	}
	printf("Second shmat done: %08lx\n", (unsigned long) addr);
	system(buffer);
	if (shmdt(addr) < 0)
		xperror("shmdt 2");
	shmctl(shmid, IPC_RMID, NULL);
	exit(EXIT_SUCCESS);
}

--=-=-=


-- 
Zlatko

--=-=-=--
