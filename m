Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267724AbSLGFoN>; Sat, 7 Dec 2002 00:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267731AbSLGFoN>; Sat, 7 Dec 2002 00:44:13 -0500
Received: from gen3-newburypark5-192.vnnyca.adelphia.net ([207.175.226.192]:13559
	"EHLO dave.home") by vger.kernel.org with ESMTP id <S267724AbSLGFoL>;
	Sat, 7 Dec 2002 00:44:11 -0500
Date: Fri, 6 Dec 2002 21:51:52 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200212070551.gB75pqj06406@dave.home>
To: tadams-lists@myrealbox.com
Subject: Re: 2.4.18 beats 2.5.50 in hard drive access????
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hdparm -t yields similiar results on 2.4.18 and 2.5.50. What is a huge
difference is the scattered reads from a disk. At least it is good to
see other people experiencing similiar kernel messages. Would it help to
post the program? Here it is anyway:

Thanks--
Dave

//compile with
//gcc t.c -o t -lpthread

#include <stdio.h>
#include <stdlib.h>
#include <linux/fcntl.h>
#include <unistd.h>
#include <linux/unistd.h>
#include <sys/time.h>
#include <pthread.h>

char DEVNAME[128];
extern long long lseek64(int,long long,int);
unsigned char *tbuff;

long long now(void)
{
struct timeval tv;
	gettimeofday(&tv,0);
	return tv.tv_sec*1000000ll + tv.tv_usec;
}
int intcomp(const void *v1,const void *v2)
{
	return *(unsigned long *)v1 - *(unsigned long *)v2;
}
#define NUM 250
#define BLOCK (188*128*4ll)
int fd;
long long l;
char state[NUM];
void *readfunc(void *a)
{
long long off;
int lfd;
int r;
	lfd=open(DEVNAME,O_RDONLY|O_LARGEFILE|O_SYNC);
	off=(rand()&0x7fffffff)%l*BLOCK;
	lseek64(lfd,off,SEEK_SET);
	r=read(lfd,tbuff,BLOCK);
	state[(int)a]=1;
	close(lfd);
	return 0;
}


int main(int argc,char **argv)
{
long long lres;
int res;
int i,j;
long long start,off;
unsigned char *p;

if(argc<2) {printf("specify device to test\n");exit(0);}
strcpy(DEVNAME,argv[1]);
tbuff=malloc(BLOCK+4096);
fd=open(argv[1],O_RDONLY|O_LARGEFILE);
printf("fd=%d\n",fd);
if(fd<0) exit(0);
while((int)tbuff & 4095) ++tbuff; // align to PAGE_SIZE


l=lseek64(fd,0ll,SEEK_END);
printf("Total volume size=%lld megabytes\n",l/0x100000);
l/=BLOCK;
printf("%d blocks\n",l);
	start=now();
	srand((int)start);
	for(i=0;i<NUM;++i)
	{
		pthread_t tt;
		memset(&tt,0,sizeof(tt));
		pthread_create(&tt,0,readfunc,(void *)i);
	}
	for(;;)
	{
		for(i=0;i<NUM;++i)
			if(!state[i]) break;
		if(i==NUM) break;
		usleep(10000);
	}
	start=now()-start;
	printf("%f seconds\n",start/(float)1000000.0);
	printf("%f mbytes/second\n",(float)BLOCK*NUM/start);
	return 0;
}
