Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316514AbSEOWyg>; Wed, 15 May 2002 18:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316515AbSEOWyf>; Wed, 15 May 2002 18:54:35 -0400
Received: from bag-2.mail.algx.net ([204.91.99.101]:25004 "EHLO
	bag-2.mail.algx.net") by vger.kernel.org with ESMTP
	id <S316514AbSEOWyd>; Wed, 15 May 2002 18:54:33 -0400
From: "Brad Kemp" <Brad.Kemp@seranoa.com>
To: <linux-kernel@vger.kernel.org>
Subject: MPC8260 memory corruption
Date: Wed, 15 May 2002 18:54:32 -0400
Message-ID: <AKEOKOILIJFBAOBKOEPFMEDLDEAA.Brad.Kemp@seranoa.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have uncovered a problem with mapped files on Linux 2.4.16 and 2.4.18.
The program at the end of this messages
will reproduce the error. To reproduce the error,  run the program in a
while loop
while true
do
run_program
done
to see the corruption, cat /proc/slabinfo.
The problem should appear between 1 and 15 minutes into the test.
The corruption is non-deterministic. It seems to start with the name of a
cache, but it varies.
Eventually the size (objsize) of a cache object is corrupted and the next
allocation for that cache produces an oops.
If it is a allocation at interupt time, it is a non-recoverable oops.
The problem is most like caused at exit since this program can be run with
the loop set to forever and not
cause the problem.
We have seen this only on mpc8260 based platforms not on other powerpc or
intel platforms.
Has anyone else seen this?
Brad Kemp

<--- cut here ---->
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <stdio.h>


char filename[] = "/tmp/crashLinux";
#define MYMAPSIZE 360448
#define MYPROT   PROT_READ | PROT_WRITE
#define MYFLAGS MAP_SHARED

#define MYLEN 40
#define MYLOOP 1000  /* set to -1 to loop forever */

int do_open(char * filename);
void * do_map(int fd);
main()
{

	int fd;
	void * vp1;
	void * vp2;
	unsigned char * cp1;
	unsigned char * cp2;
	unsigned char * p;
	mode_t mask;
	char buffer[4096];
	unsigned int i, j;

	mask = umask(0);
	fd = do_open(filename);
	vp1 = do_map(fd);

	write(fd, buffer, MYLEN);
	close(fd);
	printf("vp1 %p\n", vp1);

	fd = do_open(filename);
	vp2 = do_map(fd);
	printf("vp2 %p\n", vp2);
	close(fd);
	cp1 = (unsigned char *)vp1;
	cp2 = (unsigned char *)vp2;
#ifdef LONG_TEST
	p = cp2;
	for(j = 0;j< 40; j++)
		*p++ = 2;
#endif
	for(i = 0; i< MYLOOP; i++) {
#ifdef LONG_TEST
		p = cp1;
		for(j = 0;j< MYLEN; j++){
			if(*p != 2)
				printf("bad cp1 %x\n",*cp1);
			*p++ = 1;
		}

		p = cp2;
		for(j = 0; j < MYLEN; j++) {
			if(*p != 1)
				printf("bad cp2 %x\n",*cp2);
			*p++ = 2;
		}
#else
		*cp1 = 1;
		if(*cp2 != 1)
			printf("bad cp2 %x\n",*cp1);
		*cp2 = 2;
		if(*cp1 != 2)
			printf("bad cp1 %x\n",*cp1);
#endif
	}



	unlink(filename);
	umask(mask);


}
int do_open(char * filename)
{
	int fd;

	fd = open(filename, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP
| S_IROTH | S_IWOTH);
	if(fd < 0) {
		perror("open");
		exit(-2);
	}
	return fd;
}

void * do_map(int fd)
{
	void * vp;
	vp = mmap(NULL, MYMAPSIZE, MYPROT, MYFLAGS, fd, 0);
	if(vp == MAP_FAILED) {
		perror("mmap");
		exit(-3);
	}
	return vp;
}




