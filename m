Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRCWVWz>; Fri, 23 Mar 2001 16:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbRCWVWq>; Fri, 23 Mar 2001 16:22:46 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:19683 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129443AbRCWVWj>; Fri, 23 Mar 2001 16:22:39 -0500
Message-Id: <l0313030fb6e15a6513ac@[192.168.239.101]>
In-Reply-To: <UTC200103231829.TAA06442.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 23 Mar 2001 21:14:55 +0000
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The main point is letting malloc fail when the memory cannot be
>guaranteed.

If I read various things correctly, malloc() is supposed to fail as you
would expect if /proc/sys/vm/overcommit_memory is 0.  This is the case on
my RH 6.2 box, dunno about yours.  I can write a simple test program which
simply allocates tons of memory if you like...

...and I did.  It filled up my physical and swap memory, and got killed by
the OOM handler before malloc() failed, even though overcommit_memory was
set to 0.

*****BAD!*****

Here's my test program and output (on a Duron with 256M physical and 250M
swap):

[chromi@beryllium compsci]$ cat make_mem.c
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
  /* Allocate tons of RAM, print out how far, we get, and exit when we
malloc() fails.
   * We also access each page we allocate, to ensure we really are getting
the memory we reserve.
   * If we are killed by SIGSEGV or by OOM instead of malloc() failing, the
VM system is broken.
   */

  char *p;
  unsigned long pages = 0;

  while(1) {
    p = malloc(1024);
    if(!p)
      break;
    *p = 1;
    pages++;
    printf("%lu K\r", pages);
  }

  printf("\n*** malloc() failed!\n");

  return 0;
}
[chromi@beryllium compsci]$ gcc -O -Wall -o make_mem make_mem.c
[chromi@beryllium compsci]$ ./make_mem
493625 KKilled
[chromi@beryllium compsci]$


--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


