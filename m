Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263231AbUERMwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUERMwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 08:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUERMwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 08:52:25 -0400
Received: from portal.beam.ltd.uk ([62.49.82.227]:18573 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id S263231AbUERMwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 08:52:03 -0400
Message-ID: <40AA06ED.50203@beam.ltd.uk>
Date: Tue, 18 May 2004 13:51:57 +0100
From: Terry Barnaby <terry1@beam.ltd.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Mike Black <mblack@csi-inc.com>
CC: Terry Barnaby <terry1@beam.ltd.uk>, linux-kernel@vger.kernel.org
Subject: Re: Problem with mlockall() and Threads: memory usage
References: <40A9E105.7080907@beam.ltd.uk> <041501c43cc9$28aaed00$c8de11cc@black>
In-Reply-To: <041501c43cc9$28aaed00$c8de11cc@black>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for that.
I have done some more investigating, and on my system (Standard RedHat 9)
the stack ulimit is set to 8192 KBytes. So it appears that the thread
library/kernel threads pre-allocates, and writes to, 8129 KBytes of stack per
thread and so then mlockall() locks all of this in memory.

Should'nt the Thread library grow the stack rather than preallocate it all even
with mlockall() like malloc ?

I also notice that if I set the pre-thread stack with pthread_attr_setstacksize()
this sets the hard limit for stack size rather than the initial stack size
as stated in the pthread.h include file. Maybe there is another way to
set the initial stack size per thread ?

Anyway I presume this stack manipulation is done in the user level threads
library rather than the kernel (even on NPTL). So I guess I should move this
question to the list for Linux Threads. Any ideas where this list is ?

Cheers

Terry

Mike Black wrote:
> I compiled your program on my system and it behaves like you would expect.  Looks like about 2Meg per thread overhead..
> t5 is with mlock and t5a is without -- I've attached a static compile of t5 so you can test it on your system.
> That way it will tell whether it's just your compiler/library setup or the OS.
> I'm running Linux 2.6.6, libc-2.3.2, libpthread-0.10
> 
> The zip file password is "t5"
> 
> 
> ----- Original Message ----- 
> From: "Terry Barnaby" <terry1@beam.ltd.uk>
> To: <linux-kernel@vger.kernel.org>
> Sent: Tuesday, May 18, 2004 6:10 AM
> Subject: Problem with mlockall() and Threads: memory usage
> 
> 
> 
>>Hi,
>>
>>We have a problem with a soft real-time program that uses mlockall
>>to improve its latency.
>>
>>The basic problem, which can be seen with a simple test example, is
>>that if we have a program that uses a large amount of memory, uses multiple
>>threads and uses mlockall() the physical memory usage goes through the
>>roof. This problem/feature is present using RedHat 7.3 (2.4.x libc user level
>>threads), RedHat 9 (2.4.20 kernel threads) and Fedora Core 2 (2.6.5).
>>
>>Our simple test program first does a mlockall(MCL_CURRENT | MCL_FUTURE),
>>mallocs 10MBytes and then creates 8 threads all which pause.
>>
>>The memory usage with the mlockall() call is:
>>  PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
>>2251 pts/1    SL     0:00      0     2 95921 95924 37.3 ./t2 8
>>
>>The memory usage without the mlockall() call is:
>>  PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
>>2275 pts/1    S      0:00      0     2 95929 11152  4.3 ./t2 8
>>
>>It appears that the kernel is allocating physical memory for each
>>of the Threads shared data area's rather than allocating just
>>the one shared area.
>>
>>Are we doing something wrong ?
>>Is this the correct behaviour ?
>>Is this a kernle or glibc bug ?
>>
>>Example code follows:
>>
>>Terry
>>
>>/*******************************************************************************
>>  * T2.c Test Threads
>>  * T.Barnaby, BEAM Ltd, 18/5/04
>>  *******************************************************************************
>>  */
>>#include <stdio.h>
>>#include <stdlib.h>
>>#include <string.h>
>>#include <unistd.h>
>>#include <pthread.h>
>>#include <sys/mman.h>
>>#include <sys/statfs.h>
>>
>>const int memSize = (10 * 1024*1024);
>>
>>void* threadFunc(void* arg){
>>while(1){
>>printf("Thread::function: loop: Pid(%d)\n", getpid());
>>pause();
>>}
>>}
>>
>>void test1(int n){
>>pthread_t* threads;
>>void* mem;
>>int i;
>>
>>threads = (pthread_t*)malloc(n * sizeof(pthread_t));
>>mem = malloc(memSize);
>>memset(mem, 0, memSize);
>>printf("Mem: %p\n", mem);
>>
>>for(i = 0; i < n; i++){
>>pthread_create(&threads[i], 0, threadFunc, 0);
>>} 
>>pause();
>>}
>>
>>
>>int main(int argc, char** argv){
>>if(argc != 2){
>>fprintf(stderr, "Usage: t2 <numberOfThreads>\n");
>>return 1;
>>}
>>
>>#ifndef ZAP
>>// Lock in all of the pages of this application
>>if(mlockall(MCL_CURRENT | MCL_FUTURE) < 0)
>>fprintf(stderr, "Warning: unable to lock in memory pages\n");
>>#endif
>>
>>test1(atoi(argv[1]));
>>return 0;
>>}
>>
>>-- 
>>Dr Terry Barnaby                     BEAM Ltd
>>Phone: +44 1454 324512               Northavon Business Center, Dean Rd
>>Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
>>Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
>>BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
>>                       "Tandems are twice the fun !"
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Dr Terry Barnaby                     BEAM Ltd
Phone: +44 1454 324512               Northavon Business Center, Dean Rd
Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
                       "Tandems are twice the fun !"
