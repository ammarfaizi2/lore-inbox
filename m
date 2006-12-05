Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760022AbWLEV53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760022AbWLEV53 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759947AbWLEV53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:57:29 -0500
Received: from web26707.mail.ukl.yahoo.com ([217.146.176.70]:38583 "HELO
	web26707.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759940AbWLEV52 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:57:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6c0TvoloLaRp/Zin/t3GV1ckzDvTNuCdk20zftZFgBYE0QBDu2lX6FS/ebVr+jiaFugszhBLjP1TmLvEF/TEwx1498P1H/+zUFyaDtAcTDgIT4FQEuntA+erCtJKclcKRsbGqc6T0yaQWQ2/gvvqND9ECRHe4enZQYwCxDQwdtg=  ;
Message-ID: <20061205215725.26053.qmail@web26707.mail.ukl.yahoo.com>
Date: Tue, 5 Dec 2006 21:57:25 +0000 (GMT)
From: gregfe <gregfe2002@yahoo.fr>
Reply-To: gregfe <gregfe2002@yahoo.fr>
Subject: Scheduling a higher priority thread returning from clock_nanosleep()
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,



The following test program intends to implement periodic threads based on POSIX API.



According to a POSIX recommendation found in clock_nanosleep() man page (3p), this system call is prefered to POSIX timers. I used  the absolute time version of clock_nanosleep.



Scenario is the following:  a high priority (p=50) thread executes a clock_nanosleep. At the timespec clock_nanosleep() is supposed to return, a low priority (p=1) CPU-intensive thread may be executing (this happens on a regular basis since the low priority periodic thread performs a +1 second busy wait). Unfortunately, although the high priority thread becomes eligible, the low priority CPU-intensive thread is not preemted.



Behavior is the same with both SCHED_FIFO and SCHED_RR.



Kernel is  2.6.12.



Can anyone tell me whether I am misusing the API, or if this is a known pitfall of linux's POSIX port  (or - who knows ? - if this is behavior is conformant with POSIX ?)



If my kernel is too old, could you recommend a release / patch ?



I would very much appreciate your help.



Gregory Haik





--



Compile with g++ test.c -lm -lrt

Run as root.



test.c :



#define ONE_MILLION    1000000

#define ONE_BILLION 1000000000



#include <time.h>     // clock_nanosleep()

#include <sys/time.h> // gettimeofday() in busy wait implem

#include <pthread.h>

#include <errno.h>

#include <math.h>

#include <iostream>



using namespace std;



int nb_iters_loop = 100000;

float  duration_loop;



void calibrate_busy_wait()

{

  nb_iters_loop = 100000;

  struct timeval begin;

  struct timeval  end;



  gettimeofday( &begin, 0 );



  double value;



  for( int ct = 0; ct < nb_iters_loop; ct++ )

    {

      value += 

    value + log( 10 + value + log( 10 + value + log( 10 + value ) ) );

    }



  gettimeofday( &end, 0 );



  duration_loop = 

    ( end.tv_sec - begin.tv_sec ) + 1e-6 * ( end.tv_usec - begin.tv_usec );

}



void do_busy_wait( float seconds )

{



  int nb_iterations_to_do = nb_iters_loop * ( seconds / duration_loop );



  float value;



  for( int ct = 0; ct < nb_iterations_to_do; ct++ )

    {

      value +=

    value + log( 10 + value + log( 10 + value + log( 10 + value ) ) );

    }

}



void * main_thread_high (void * arg)

{

  int c = 0;

   struct timespec ts;

  int period = 10; // ms



  int status = clock_gettime(CLOCK_REALTIME, &ts);

  if (status != 0)

    {

      perror("clock_gettime");

      exit(123);

    }

    

  

  unsigned long period_ms_ulong = (unsigned long) period;

  unsigned long one_million_ulong = (unsigned long) ONE_MILLION;

  unsigned long period_ns_ulong = (unsigned long) (period_ms_ulong * one_million_ulong);

  unsigned long one_billion_ulong = (unsigned long) ONE_BILLION;

  unsigned long additional_nanoseconds = (unsigned long) (period_ns_ulong % one_billion_ulong);



  time_t additional_seconds = period / 1000;



  while (true)

    {

      int status = clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &ts,  NULL);

      if (status != 0)

    {

      switch (status)

        {

        case EINTR:

          perror("clock_nanosleep() returned EINTR");

          break;

        case EINVAL:

          perror("clock_nanosleep() returned EINVAL");

          break;

        case ENOTSUP:

          perror("clock_nanosleep() returned ENOTSUP");

        }

      exit(1243);

    }



      ts.tv_nsec += additional_nanoseconds;

      ts.tv_sec +=  additional_seconds;

      if (ts.tv_nsec >= one_billion_ulong)

    {

      ts.tv_sec++;

      ts.tv_nsec -= one_billion_ulong;

    }



     

      do_busy_wait((float) (period / 2000));

      {  int sched_policy;

    sched_param sp;

    pthread_getschedparam(pthread_self(), &sched_policy, &sp);

    

    cerr << __FILE__ << " : " << __LINE__ << " busy wait done, prio = " << sp.sched_priority << ", " << c++ << endl;

      }



    }

}



void * main_thread_low (void * arg)

{

  int c = 0;

  struct timespec ts;

  int period = 2050; // ms



  int status =  clock_gettime(CLOCK_REALTIME, &ts);

  if (status != 0)

    {

      perror("clock_gettime");

      exit(123);

    }

    

  

  unsigned long period_ms_ulong = (unsigned long) period;

  unsigned long one_million_ulong = (unsigned long) ONE_MILLION;

  unsigned long period_ns_ulong = (unsigned long) (period_ms_ulong * one_million_ulong);

  unsigned long one_billion_ulong = (unsigned long) ONE_BILLION;

  unsigned long additional_nanoseconds = (unsigned long) (period_ns_ulong % one_billion_ulong);



  time_t additional_seconds = period / 1000;



  while (true)

    {



      int status = clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &ts, NULL);

      if (status != 0)

    {

       switch (status)

        {

        case EINTR:

          perror("clock_nanosleep() returned EINTR");

          break;

        case EINVAL:

          perror("clock_nanosleep() returned EINVAL");

          break;

        case ENOTSUP:

          perror("clock_nanosleep() returned ENOTSUP");

        }

      exit(1243);

    }



      ts.tv_nsec += additional_nanoseconds;

      ts.tv_sec += additional_seconds;

      if (ts.tv_nsec >=  one_billion_ulong)

    {

      ts.tv_sec++;

      ts.tv_nsec -= one_billion_ulong;

    }



      do_busy_wait((float) (period / 2000));

      {  int sched_policy;

    sched_param sp;

    pthread_getschedparam(pthread_self(), &sched_policy, &sp);

    

    cerr << __FILE__ << " : " << __LINE__ << " busy wait done, prio = " << sp.sched_priority << ", " << c++ << endl;

      }

    }

}



int main()

{

  

  calibrate_busy_wait();



  pthread_t periodic_thread_high;

  {

    pthread_attr_t thread_attributes;

    int status;

    

     pthread_attr_init(&thread_attributes);

    if (status != 0) perror("pthread_attr_init failed ");

    

    status = pthread_attr_setschedpolicy(&thread_attributes, SCHED_FIFO);

    if (status != 0) perror("pthread_set_schedpolicy failed ");

    

    struct sched_param sched_parameter;

    sched_parameter.sched_priority = 50;

    status = pthread_attr_setschedparam(&thread_attributes, &sched_parameter);

    if (status != 0) perror("pthread_setschedparam falied ");

    

    status = pthread_attr_setinheritsched(&thread_attributes, PTHREAD_EXPLICIT_SCHED);

    if (status != 0) perror("pthread_attr_setinheritsched failed");

    

    status = pthread_attr_setscope( &thread_attributes, PTHREAD_SCOPE_SYSTEM  );

    if (status != 0) perror("pthread_attr_setscope failed ");

    

    status = pthread_create(&periodic_thread_high, &thread_attributes, main_thread_high, NULL);

    if (status != 0) perror("pthread_create failed ");

  }



  pthread_t periodic_thread_low;

  {

    pthread_attr_t thread_attributes;

    int status;

    

    pthread_attr_init(&thread_attributes);

    if (status != 0) perror("pthread_attr_init failed ");

    

    status = pthread_attr_setschedpolicy(&thread_attributes, SCHED_FIFO);

    if (status != 0) perror("pthread_set_schedpolicy failed ");

    

    struct sched_param sched_parameter;

    sched_parameter.sched_priority = 1;

     status = pthread_attr_setschedparam(&thread_attributes, &sched_parameter);

    if (status != 0) perror("pthread_setschedparam falied ");

    

    status = pthread_attr_setinheritsched(&thread_attributes, PTHREAD_EXPLICIT_SCHED);

    if (status != 0) perror("pthread_attr_setinheritsched failed");

    

    status = pthread_attr_setscope( &thread_attributes, PTHREAD_SCOPE_SYSTEM );

    if (status != 0) perror("pthread_attr_setscope failed ");

    

    status = pthread_create(&periodic_thread_low, &thread_attributes, main_thread_low, NULL);

    if (status != 0) perror("pthread_create failed ");



  }



  pthread_join(periodic_thread_high, NULL);

  pthread_join(periodic_thread_low, NULL);



  cout << "Hopefully this message will never  be issued." << endl;

}







/// sorry for the Yoohoo ad below...




	

	
		
___________________________________________________________________________ 
Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! 
Profitez des connaissances, des opinions et des expériences des internautes sur Yahoo! Questions/Réponses 
http://fr.answers.yahoo.com
