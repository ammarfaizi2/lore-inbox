Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbSKFXK2>; Wed, 6 Nov 2002 18:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbSKFXK1>; Wed, 6 Nov 2002 18:10:27 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:48110 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S266199AbSKFXKZ>; Wed, 6 Nov 2002 18:10:25 -0500
Message-ID: <3DC9A2E6.2060700@nortelnetworks.com>
Date: Wed, 06 Nov 2002 18:16:54 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: interesting behaviour in cpu utilization accounting
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was playing around with a tool to use a certain amount of cpu time. 
The way it does this is to take a timestamp, sleep for a tick, take 
another timestamp, and then busy-loop until the desired cpu utilization 
is reached, at which point it sleeps again.

I was very confused when the running tool didn't seem to show the right 
utilization in "top", so I made it print out how much time it spent 
sleeping and how much time it spent busy-waiting.  It looked okay, but 
the "top" numbers didn't match.

Then I wrote another tool that busy-loops and prints out an index of how 
fast it busy-loops.  If you run this tool on and idle system and then 
while its being loaded it gives an accurate picture of the real system 
load.  Sure enough, the cpu utilization tool was working fine.

It looks like the pattern of behaviour of the cpu utilization tool is 
such that it minimizes how often it gets counted by the tick counter. 
This means that even though it really takes 20% of the cpu, it only 
registers 4-5% in top.

I'd love to hear what kind of results others get with these to programs 
or alternate explanations of what's going on, and whether this kind of 
thing is something we should worry about when doing sampling-based cpu 
utilization calculations.

Chris



//bsyloop
//adjust INTERVAL to change the printing interval
//adjust CONSTANT to give a convenient index
#include <iostream>
#include <asm/msr.h>
#define INTERVAL 100000000
#define CONSTANT 10
int main()
{
    double counter = 0;
    unsigned long long begin, end;
    rdtscll(begin);
    while(1)
    {
       counter++;
       if (counter == INTERVAL)
       {
          rdtscll(end);
          cout << "index: " << counter*CONSTANT / (end - begin) << endl;
          counter = 0;
          rdtscll(begin);
       }
    }
}



//cpu utilization program
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <iostream>
#include <sched.h>
#include <asm/msr.h>

void chewcpu(double percent)
{
    int blah;

    //handle 100% case first
    if (percent > 99.99)
    {
       while(1)
       {
          blah++;
       }
    }

    cout << "want to be busy " << percent << " percent" << endl;

    sched_param param;
    param.sched_priority = 50;
    sched_setscheduler(getpid(), SCHED_RR, &param);



    //anything other than 100%
    while(1)
    {
       unsigned long long begin, aftersleep, end, current;
       unsigned long long busytime;
       struct timeval delay;

       rdtscll(begin);
       delay.tv_sec = 0;
       delay.tv_usec = 10000;

       //sleep one hundredth of a second
       //this is the smallest amount possible

       select(0, NULL, NULL, NULL, &delay);

       rdtscll(aftersleep);

       //now figure out how long we need to be busy to give the desired 
percentage
       busytime = (aftersleep - begin)/(100/percent - 1);

       //cout << "want to be busy " << busytime << " ticks" << endl;

       end = aftersleep + busytime;

       do{ rdtscll(current); } while(current < end);

       //cout << "slept " << (aftersleep - begin) << " ticks" << endl;
       //cout << "busy " << (current - aftersleep) << " ticks" << endl;
    }
}

void usage(char *name)
{
    cout << "usage: " << name << " <percentage>" << endl;
    exit (-1);
}

int main(int argc, char** argv)
{
    if (argc < 2)
       usage(*argv);

    char *endptr = 0;
    double percent = strtod(argv[1],&endptr);

    if (endptr == argv[1])
    {
       cout << "died on strtod" << endl;
       usage(*argv);
    }

    chewcpu(percent);
    return 0;
}







-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

