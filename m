Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272927AbTHKRw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272973AbTHKRuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:50:09 -0400
Received: from ip144-173-busy.ott.istop.com ([66.11.173.144]:45833 "EHLO
	worf.vpn") by vger.kernel.org with ESMTP id S272974AbTHKRtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:49:40 -0400
Date: Mon, 11 Aug 2003 13:49:34 -0400
From: Christian Mautner <linux@mautner.ca>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4: Allocation of >1GB in one chunk
Message-ID: <20030811174934.GA7569@mautner.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

please forgive me to ask this (perhaps newbie?) question here on
l-k, but I'm desperate. This is my problem:

I am running various kinds of EDA software on 32-bit Linux, and they
need substantial amounts of memory. I am running 2.4.21 with with
PAGE_OFFSET at 0xc0000000, so I can run processes just over 3GB. The
machine (a dual Xeon) has 4GB memory and 4GB swap.

But there is this one program now that dies because it's out of
memory. No surprise, as this happens frequently with tasks that would
need 4GB or more.

But this one needs less than 3GB. But what it does need (I strace'ed
this), is 1.3GB in one whole chunk.

I wrote a test program to mimic this:

The attached program allocates argv[1] MB in 1MB chunks and argv[2] MB
in one big chunk. (The original version also touched every page, but
this makes no difference here.)

[chm@trex7:~/C] ./foo 2500 500
Will allocate 2621440000 bytes in 1MB chunks...
Will allocate 524288000 bytes in one chunk...
Succeeded.

[chm@trex7:~/C] ./foo 1500 1000
Will allocate 1572864000 bytes in 1MB chunks...
Will allocate 1048576000 bytes in one chunk...
malloc: Cannot allocate memory
Out of memory.

The first call allocated 3GB and succeeds, the second one only 2.5GB
but fails!

The thing that comes to my mind is memory fragmentation, but how could
that be, with virtual memory? 

rlimit is also unlimited (and it happens for root as well).

Skimming through the kernel sources shows too many places where memory
allocation could fail, unfortunately I don't know _where_ it fails. The
machine is used for production, I cannot simply take it down and run a
debugging kernel on it.

I have played with /proc/sys/vm/overcommit_memory, to no avail.

I have watched /proc/slabinfo, and /proc/sys/vm/* while
allocating. Still no idea.

Is there anything I can do to make this work?

Grateful for any help or pointers,
chm.

PS: Will the behaviour be different in 2.6?

----------------------------------------------------------------------
This is my test program (the sleep(60) is there to be able to peek
around in /proc after the memory has been allocated):

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
  unsigned int i;
  unsigned long n1=0;
  unsigned long n2=0;
  char * p;

  if ( argc >= 2 )
    {
      n1=strtol(argv[1], 0, 10)*1024*1024;
    }

  if ( argc >= 3 )
    {
      n2=strtol(argv[2], 0, 10)*1024*1024;
    }

  fprintf(stderr, "Will allocate %lu bytes in 1MB chunks...\n", n1);

  for(i=0; i<n1; i+=1024*1024)
    {
      p=(char*)malloc(1024*1024);
      if ( p == 0 )
        {
          perror("malloc");
          fprintf(stderr, "Out of memory (%d).\n", i);
          sleep(60);
          exit(1);
        }
    }      

  fprintf(stderr, "Will allocate %lu bytes in one chunk...\n", n2);

  p=(char*)malloc(n2);
    
  if ( p == 0 )
    {
        perror("malloc");
        fprintf(stderr, "Out of memory.\n");
        sleep(60);
        exit(1);
    }
  
  fprintf(stderr, "Succeeded.\n");

  sleep(60);
        
  return 0;
} 


-- 
christian mautner -- chm bei istop punkt com -- ottawa, canada
