Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbTJJLYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 07:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTJJLYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 07:24:39 -0400
Received: from odalix.ida.liu.se ([130.236.186.10]:53668 "EHLO
	odalix.ida.liu.se") by vger.kernel.org with ESMTP id S262064AbTJJLYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 07:24:35 -0400
Date: Fri, 10 Oct 2003 13:23:26 +0200
From: Magnus Andersson <magan029@student.liu.se>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 O_DIRECT memory leak?!?
Message-ID: <20031010132326.A8903@student.liu.se>
References: <20031008180919.A6172@student.liu.se> <Pine.LNX.4.44.0310091637270.3040-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0310091637270.3040-100000@logos.cnet>; from marcelo.tosatti@cyclades.com on Thu, Oct 09, 2003 at 04:37:52PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2003 at 04:37:52PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Wed, 8 Oct 2003, Magnus Andersson wrote:
> 
> > Hello!
> > 
> > If I open one file a lot of times using the flag O_DIRECT,
> > memory seems to be be lost and never given back to the system.
> > This is happening on some kernels, see below for which ones I tried.
> > 
> > Attached program will produce this behavior, also attached 
> > is the output from vmstat while running the program.
> 
> Magnus,
> 
> That memory will be freed as soon as there's memory pressure so its not a 
> memory leak.

Ok. It's not a leak. But it looks like the memory never goes back to the system.
The kernel has killed some processes of mine, thats why I suspect this.

Attached are a program, malloc_mem.
Before running open_odirect, malloc_mem succeeds in allocating 450 000 000 bytes.
After running open_odirect, malloc_mem fails.

It is working on the 2.4.22-aa1 kernel, but not on 2.4.22

The test is run with this amount of memory, and no swap.

Memory: 515752k/524204k available (1593k kernel code, 8064k reserved, 334k data, 264k init, 0k highmem)

/Magnus

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="run.log"

foo:~> ./malloc_mem 
All ok!
foo:~> ./open_odirect 
foo:~> ./malloc_mem
Could not malloc 450000000 bytes
foo:~>

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="malloc_mem.c"

#include <stdio.h>

#define MEM_SIZE 450000000

int main()
{
  int i;
  char *mem;
  
  mem = (char *)malloc(MEM_SIZE);

  if(mem == NULL) {
    printf("Could not malloc %d bytes\n", MEM_SIZE);
    exit(1);
  }

  memset(mem, 1, MEM_SIZE);

  printf("All ok!\n");
}

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vmstat.output"

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 496804    940   7936    0    0     0     0  101     2  0  0 100  0
 0  0      0 496800    940   7940    0    0     0     0  101     6  0  0 100  0
 0  0      0 496800    940   7940    0    0     0     0  101     4  0  0 100  0
 0  0      0 496800    940   7940    0    0     0     0  101     2  0  0 100  0
 0  0      0 496800    940   7940    0    0     0     0  101     2  0  0 100  0
 1  0      0 438912    940   7940    0    0     0     0  104    14 71 28  1  0
 1  0      0 379896    940   7940    0    0     0     0  101     4 76 24  0  0
 1  0      0 320880    940   7940    0    0     0     0  101     4 78 22  0  0
 1  0      0 261868    940   7940    0    0     0     0  101     2 74 26  0  0
 1  0      0 202848    940   7940    0    0     0     0  101     2 77 23  0  0
 1  0      0 143836    940   7940    0    0     0     0  101     2 73 27  0  0
 1  0      0  84856    940   7940    0    0     0     0  101     8 76 24  0  0
 0  0      0 496716    940   7940    0    0     0     0  105    13 35 17 49  0
 0  0      0 496716    940   7940    0    0     0     0  101     2  0  0 100  0
 0  0      0 496716    940   7940    0    0     0     0  101     2  0  0 100  0
 0  0      0 496716    940   7940    0    0     0     0  107    16  0  0 100  0
 0  0      0 496716    940   7940    0    0     0     0  104    11  0  0 100  0
 1  0      0 461916    940   7940    0    0     0   128  137    27  0 17 83  0
 0  0      0 385028    940   7940    0    0     0     0  103     7  0 50 50  0
 0  0      0 385028    940   7940    0    0     0     0  101     2  0  0 100  0
 0  0      0 385028    940   7940    0    0     0     0  101     4  0  0 100  0
 0  0      0 385028    940   7940    0    0     0     0  107    20  0  0 100  0
 0  0      0 385028    940   7940    0    0     0    76  126    22  0  0 100  0
 0  0      0 385028    940   7940    0    0     0     0  101     2  0  0 100  0
 0  0      0 385028    940   7940    0    0     0     0  101     2  0  0 100  0
 0  0      0 385024    940   7944    0    0     0     0  101     2  0  0 100  0
 0  0      0 385024    940   7944    0    0     0     0  101     4  0  0 100  0
 0  0      0 385024    940   7944    0    0     0     0  101     4  0  0 100  0

--rwEMma7ioTxnRzrJ--
