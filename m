Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284778AbRLPTm4>; Sun, 16 Dec 2001 14:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284779AbRLPTmq>; Sun, 16 Dec 2001 14:42:46 -0500
Received: from mx2.port.ru ([194.67.57.12]:59140 "EHLO smtp2.port.ru")
	by vger.kernel.org with ESMTP id <S284778AbRLPTmf>;
	Sun, 16 Dec 2001 14:42:35 -0500
Date: Sun, 16 Dec 2001 22:39:09 +0300
From: Dmitry Volkoff <vdb@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Unfreeable buffer/cache problem in 2.4.17-rc1 still there
Message-ID: <20011216223909.A230@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Below is simple test case which I think is related to "memory disappear"
problem.

My real program is doing something like this:

// test.c
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int main(void) 
{
  int fd;
  int r;
  char data[10] = "0123456789";
  int i;
  int end = 30;
  for (i=0;i<end;i++) {
    fd = open("testfile", O_WRONLY | O_NDELAY | O_TRUNC | O_CREAT, 0644);
    if (fd == -1) {
      printf("unable to open\n");
      return;
    }
    r = write(fd,data,sizeof data);
    if (r == -1) {
      printf("unable to write\n");
      close(fd);
      return;
    }
    close(fd);
    sleep(1);
  }
}
// end test.c

Each time I run `free; ./test; free` I see evergrowing memory usage. 
I mean used memory + buffers. At some point system just starts swapping 
even if no other processes are running. Tested on 2.4.13 and 
2.4.17-pre4aa1. I think something is wrong here because the very same 
test program does not show such behaviour on 2.2.19. It does not lose 
any single byte of memory. I've even tested this on freebsd-4.4 with 
the same result as on 2.2.19. 

Example output on 2.4.17-pre4aa1:

bash-2.03$ free; ./test; free
total       used       free     shared    buffers     cached
Mem:        514528     212508     302020          0       7952     150664
-/+ buffers/cache:      53892     460636
Swap:      1028120          0    1028120
total       used       free     shared    buffers     cached
Mem:        514528     212616     301912          0       8000     150664
-/+ buffers/cache:      53952     460576
Swap:      1028120          0    1028120

bash-2.03$ free; ./test; free
total       used       free     shared    buffers     cached
Mem:        514528     212616     301912          0       8008     150664
-/+ buffers/cache:      53944     460584
Swap:      1028120          0    1028120
total       used       free     shared    buffers     cached
Mem:        514528     212700     301828          0       8056     150664
-/+ buffers/cache:      53980     460548
Swap:      1028120          0    1028120

The results are very consistent. I lose 30-40 byte per run.

-- 

    DV
