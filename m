Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265049AbTLaII7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 03:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266152AbTLaII7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 03:08:59 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:32684 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S265049AbTLaIIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 03:08:53 -0500
Message-ID: <3FF1DADC.1070404@sedal.usyd.edu.au>
Date: Wed, 31 Dec 2003 07:06:52 +1100
From: sena <auntvini@sedal.usyd.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rusty@rustcorp.com.au
CC: linux-kernel@vger.kernel.org
Subject: task_struct and uid of a task 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rusty,

Thank you for your previous reply. I feel like you would be able to 
assist me.

Say a computer has 5 user logins name1(500), name2(501), 
name3(502).........name5(504) apart from root. If these 5 people 
remotely login and runs there jobs, then the user name of those jobs are 
name1,name2 and name3.

Say if they use telnet to remotely login then those Tasks will be 
started under telnet server as children.

As the children inherits uid, euid etc of the parents. That means telnet 
is run as root and it inherits uid<500.

task_struct has uid and it is updated accordingly.


I have built the kernel 2.4.19sena1 successfully but this is my problem. 
The problem because child process inherits uid etc if I start any 
process through telnet

My code is as follows:

unsigned long a; //for root uid<500, I am getting this uidArray[0] is 
for storing uid (assumed 100 for all <500)
unsigned long b; //for 500
unsigned long c; //for 501
unsigned long d; //for 502
unsigned long e; //for 503
unsigned long f; // for 504

unsigned int uidArray[7];

static unsigned long count_active_tasks(void)
{
    struct task_struct *p;
    unsigned long nr = 0;

    int s = 0;
   
    int i=0;
    int j=0;
    int k=0;
    int m=0;

    a=b=c=d=e=f=0;
   
       read_lock(&tasklist_lock);

    for_each_task(p)
    {
        if ((p->state == TASK_RUNNING ||
             (p->state & TASK_UNINTERRUPTIBLE)))
    {

        nr += FIXED_1; //nr total tasks
       
        if(i==0)
        {
            uidArray[0] = 100;

            if(p->uid < 500)
            {
           
            a += FIXED_1;
            }
            else
            {
            uidArray[1] = p->uid;
            b += FIXED_1;
            k++;
            }
         k++;
        }
        else
        {
           for(j=0; j < k ; j++)
           {
               
            if((j==0)&& (p->uid < 500) && (s==0))
            {
                a += FIXED_1;
                s = 1;
                break;
            }
            else if((uidArray[j] == p->uid) && s==0)
            {
                if(j==1){
                b += FIXED_1;}
                if(j==2){
                c += FIXED_1;}
                if(j==3){
                d += FIXED_1;}
                if(j==4){
                e += FIXED_1;}
                if(j==5){
                f += FIXED_1;}
                s=1;
                break;
            }
            }
   
            if(s==0)
            {

            if(k < 6)
               {
                k++;
                j = k-1;
                uidArray[j] = p->uid;
                if(j==1){
                b += FIXED_1;}
                if(j==2){
                c += FIXED_1;}
                if(j==3){
                d += FIXED_1;}
                if(j==4){
                e += FIXED_1;}
                if(j==5){
                f += FIXED_1;}
               }
               

            }

        s=0;
          }
       
        i++;
   
    }

    }
           
    read_unlock(&tasklist_lock);
    return nr;

}

unsigned long avenrun[6];

unsigned long avenrunT;

static inline void calc_load(unsigned long ticks)
{
    unsigned long active_tasks;  /*fixed-point */
    static int count = LOAD_FREQ;

    count -= ticks;
    if (count < 0) {
        count += LOAD_FREQ;
        active_tasks = count_active_tasks();

        CALC_LOAD(avenrunT, EXP_5, active_tasks);
        CALC_LOAD(avenrun[0], EXP_5, a);
        CALC_LOAD(avenrun[1], EXP_5, b);
        CALC_LOAD(avenrun[2], EXP_5, c);
        CALC_LOAD(avenrun[3], EXP_5, d);
        CALC_LOAD(avenrun[4], EXP_5, e);
        CALC_LOAD(avenrun[5], EXP_5, f);
       
    }
}

I have updated all the other places(all .h and .c files) to suit this code.

And the result is stored in    proc/loadavg as

        0.21   0.21   100   0.00     0       0.00      0        0.00     
0        0.00     0            0.00        0
          T        a 1      uid     b1    500        c 1     501      d1 
     502      e1      503          f1         504

T- for totall
a1- root or uid < 500
b1,c1,di etc for uid>=500

In this perticular case I have login as root so that uid 100 is seen. 
There is no 500 or above. they are all 0.

But even if I start login remotely those processors started through 
telnet inherits uid <500. Then they will be shown under a1

I get uids from task_struct

Thanks
Sena Seneviratne
Computer Engineering Lab
School of Electrical and Information Engineering
Sydney University

