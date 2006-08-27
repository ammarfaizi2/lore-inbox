Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWH0Ef3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWH0Ef3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 00:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWH0Ef3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 00:35:29 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:6552 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1751153AbWH0Ef3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 00:35:29 -0400
From: Kandan Venkataraman <kven709@cse.unsw.EDU.AU>
To: linux-kernel@vger.kernel.org
Date: Sun, 27 Aug 2006 14:35:25 +1000 (EST)
X-X-Sender: kven709@williams.orchestra.cse.unsw.EDU.AU
Subject: tracking shared dirty pages in a mmap file
Message-ID: <Pine.LNX.4.64.0608271434130.20575@williams.orchestra.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi
I want to track pages of a mmap file that has been written to,
using a segv handler.

I have given an example program below to illustrate my idea.


What I want to know is whether the modifications to the mmap file will
be guaranteed to be unaffected by the interruption of the signal
handler, i.e. would the resultant changes in the mmap file be as if the
mmap file had write access set.


It can also be assumped that only the current process would be writing
to the mmap file.


Thanks
Kandan


#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <string.h>
#include <assert.h>
#include <signal.h>


typedef struct TwoInts_tag {
    int i;
    int j;



} TwoInts;


const int maxPages = 10;

char* start = 0;
int fd;
TwoInts *array = 0;
int pageSize;
int max;
int elemsPerPage;


void memory_fault(int signum, siginfo_t *info, void *ptr)
{
    char *faultAddr  = (char *)info->si_addr;


    /* we only handle the faults within our known range , anything else
is really an illegal access */
    if (faultAddr >= start && faultAddr < start + (pageSize * maxPages))
{


       int faultPageIdx = (faultAddr - start)/pageSize;


       fprintf(stderr, "fault at page index %d\n", faultPageIdx);


       if (mprotect(start + (faultPageIdx * pageSize), pageSize,
PROT_READ | PROT_WRITE)) {
          perror("mprotect failed");
          abort();
       }
    }
    else
       abort();



}


int main()
{
    struct sigaction act;

    act.sa_sigaction = memory_fault;
    act.sa_flags = SA_SIGINFO;
    sigemptyset (&act.sa_mask);


    int status = sigaction (SIGSEGV, &act, NULL);
    if (status) {
       perror ("sigaction");
       exit (1);
    }


    pageSize = getpagesize();


    elemsPerPage = pageSize/sizeof(TwoInts);


    max = elemsPerPage * maxPages;


    fprintf(stderr, "max elements is %d\n", max);


    assert(pageSize % sizeof(TwoInts) == 0);


    /* open/create the file */
    if ((fd = open ("kandan", O_RDWR | O_CREAT | O_TRUNC, S_IRWXU)) < 0)
{
       fprintf(stderr, "can't create file for writing");
       exit(1);
    }


    /* set the lenght of file */
    if (ftruncate(fd, maxPages * pageSize) == -1) {
       fprintf(stderr, "error on ftruncate\n");
       exit(1);
    }


    /* mmap the file with read access*/


    if ((start = mmap(0, maxPages * pageSize, PROT_READ, MAP_SHARED, fd,
0)) == MAP_FAILED) {


       perror("mmap error");
       exit(1);
    }


    array = (TwoInts *)start;

    /* this would case a seg fault */
    array[0].i = 5;

    fprintf(stderr, "value = %d\n", array[0].i);

    /* this will not cause a seg fault */
    array[0].i = 7;

    fprintf(stderr, "value = %d\n", array[0].i);


    array[1].i = 9;


    fprintf(stderr, "value = %d\n", array[1].i);


    array[elemsPerPage].i = 14;


    fprintf(stderr, "value = %d\n", array[elemsPerPage].i);


    close(fd);


    return 0;


}
