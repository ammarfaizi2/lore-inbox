Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266887AbRGFW7W>; Fri, 6 Jul 2001 18:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbRGFW7M>; Fri, 6 Jul 2001 18:59:12 -0400
Received: from mysql.sashanet.com ([209.181.82.108]:40875 "EHLO
	mysql.sashanet.com") by vger.kernel.org with ESMTP
	id <S266887AbRGFW65>; Fri, 6 Jul 2001 18:58:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Sasha Pachev <sasha@mysql.com>
Organization: MySQL
To: linux-kernel@vger.kernel.org
Subject: memory allocation mystery
Date: Fri, 6 Jul 2001 16:59:28 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0107061659281B.17811@mysql>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been investigating kernel behavior ( I am running 2.4.3) in out of 
memory conditions with swap completely disabled and discovered a rather 
interesting behavior. If you run the following code:

#include <stdio.h>
#include <stdlib.h>

#define LEAK_BLOCK (1024*1024)
#define MB (1024*1024)

int main()
{
  unsigned long total = 0;
  for (;;)
  {
    char* p, *p_end;
    if(!(p=malloc(LEAK_BLOCK)))
    {
      fprintf(stderr, "malloc() failed\n");
      exit(1);
    }
    p_end = p + LEAK_BLOCK;
    while(p < p_end)
      *p++ = 0;
    total += LEAK_BLOCK;
    printf("Allocated %d MB\n", total/MB);
  }
  
  return 0;   
}


the process eventually gets killed by the kernel, rather than getting an 
error from malloc() as you would logically expect

I have straced the process and see just a bunch of old_mmap() calls like this:

old_mmap(NULL, 1052672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0)
= 0x46b6a000

( in addition to writes to stdout, of course). So it looks like old_mmap() 
never returns an error.

Can somebody explain this behavior? To me it looks like a bug...

-- 
MySQL Development Team
For technical support contracts, visit https://order.mysql.com/
   __  ___     ___ ____  __ 
  /  |/  /_ __/ __/ __ \/ /   Sasha Pachev <sasha@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__  MySQL AB, http://www.mysql.com/
/_/  /_/\_, /___/\___\_\___/  Provo, Utah, USA
       <___/                  
