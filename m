Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291279AbSCONak>; Fri, 15 Mar 2002 08:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292294AbSCONa0>; Fri, 15 Mar 2002 08:30:26 -0500
Received: from mail.spylog.com ([194.67.35.220]:662 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S291279AbSCONaF>;
	Fri, 15 Mar 2002 08:30:05 -0500
Date: Fri, 15 Mar 2002 16:30:38 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <551905871007.20020315163038@spylog.ru>
To: mysql@lists.mysql.com
Cc: linux-kernel@vger.kernel.org
Subject: MYSQL,Linux & large threads number
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello mysql,

  Some time ago I wrote about slow down of mysql with large number of
  threads, which is quite common in Linux-Apache-Mysql-PHP enviroment.

  The test was simulating the worst case of concurrency - all the
  threads are modified global variable in a loop 5000000 times in
  total, using standard mutex for synchronization. The yeild is used
  in a loop to force even more fair distribution of lock usage by
  threads and increase context switches, therefore it did not change
  much with large number of threads. I.e with 64 threads time without
  yeild is 1:33.5

  Test was run on PIII-500 1G RAM Kernel 2.4.18. 3 runs were made for
  each number of threads and best results were taken:

 Num threads.       Time      Peak cs rate.
    2               53.4          179518
    4               53.8          144828
    16              1:06.3         85172
    64              1:48.1         48394
    256             8:10.6         10235
    1000           36:46.2          2602


The surprising thing is the time grows in less then linear way for up
to 64 threads but later it stars to go linear way or even worse. May
be this is because some other process are sleeping in the system which
also is used in scheduling.


For Next test I'll try to use Ingo's scheduler to see if it helps to
solve the problem, also I'll try to test real mysql server to see
which slowdown it will have.




CODE: (Dumb one just for test)

  
#include <stdio.h>
#include <pthread.h>
#include <time.h>
#define NUM_TH 1000

#define TOTAL_VALUE 5000000

#define LOOP (TOTAL_VALUE/NUM_TH)

pthread_t th[NUM_TH];
int thread_data[NUM_TH];

int rc,rc2;

int global=0;

pthread_mutex_t mut = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t start = PTHREAD_MUTEX_INITIALIZER;


void f(int *thn)
 {
 int i;  
 pthread_mutex_lock(&start);
 pthread_mutex_unlock(&start);
 for (i=0;i<LOOP;i++)
  { 
   pthread_mutex_lock(&mut);
   global++;
   pthread_yield();
   pthread_mutex_unlock(&mut);
  }
 } 



main()
 { 
  int i;
  pthread_mutex_lock(&start);                                                                                                 
  for (i=0;i<NUM_TH;i++)
  {
   thread_data[i]=i;
   rc=pthread_create(&th[i],NULL,f,&thread_data[i]);
   if (rc!=0)
    {
      printf("Failed to create thread #%d errorcode:%d\n",i,rc);
    } 
  }
  pthread_mutex_unlock(&start); 

 for (i=0;i<NUM_TH;i++)
  {
   rc2=pthread_join(th[i],NULL);    
  }
 printf("Global Value: %d\n",global); 

 }   

-- 
Best regards,
 Peter                          mailto:pz@spylog.ru

