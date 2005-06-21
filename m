Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVFUNbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVFUNbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVFUN3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:29:37 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:18585 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261478AbVFUN1J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:27:09 -0400
Message-ID: <42B815A1.7090303@bull.net>
Date: Tue, 21 Jun 2005 15:26:57 +0200
From: Jacky Malcles <Jacky.Malcles@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: (2.6.12) is there any reason for alarm() call to add 1 to the returned
 value?
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/06/2005 15:38:23,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/06/2005 15:38:25,
	Serialize complete at 21/06/2005 15:38:25
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've:
Linux version 2.6.12-rc6
LSB_VERSION="1.3"
Red Hat Enterprise Linux AS release 4 (Nahant)
Gnu C    gcc (GCC)     3.4.3 20041212 (Red Hat 3.4.3-9.EL4)
Gnu make               3.80
util-linux             2.12a
mount                  2.12a
modutils               3.1-pre5
e2fsprogs              1.35
pcmcia-cs              3.2.7
PPP                    2.4.2
isdn4k-utils           3.3
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4

this behavior is new:
        alarm() does not return the number of seconds  remaining  until  any
       previously  scheduled  alarm was due to be delivered
  but
         it returns (the number of seconds  remaining + 1)
(with 2.6.10 and previous, 1 was not added to the returned value)


----------------------------------------------------------------------------------
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <errno.h>
#include <string.h>
#include <signal.h>

int almreceived = 0;            /* flag to indicate SIGALRM received or not */

void setup();                   /* Main setup function of test */
void sigproc(int sig);          /* signal catching function */

int
main(int ac, char **av)
{
         int time_sec1 = 10;     /* time for which 1st alarm is set */
         int time_sec2 = 5;      /* time for which 2st alarm is set */
         int ret_val1, ret_val2; /* return values for alarm() calls */
         int ret_val3;
         int sleep_time1 = 3;    /* waiting time for the signal */
         int sleep_time2 = 6;    /* waiting time for the signal */

         /* Perform global setup for test */
         setup();

                 /*
                  * Call First alarm() with non-zero time parameter
                  * 'time_sec1' to send SIGALRM to the calling process.
                  */
                 ret_val1 = (alarm(time_sec1));

                 /* Wait for signal SIGALARM */
                 sleep(sleep_time1);

                 /*
                  * Call Second alarm() with non-zero time parameter
                  * 'time_sec2' to send SIGALRM to the calling process.
                  */
                 ret_val2 = (alarm(time_sec2));

                 /* Wait for signal SIGALRM */
                 sleep(sleep_time2);

                 /*
                  * Check whether the second alarm() call returned
                  * the amount of time previously remaining in the
                  * alarm clock of the calling process, and
                  * sigproc() executed when SIGALRM received by the
                  * process, the variable almreceived is set.
                  */
                 printf("ret_val2 returned = %d \n",ret_val2);
                 printf("ret_val2 expected = %d\n",time_sec1 - sleep_time1);
                 if ((almreceived == 1) &&
                     (ret_val2 == (time_sec1 - sleep_time1))) {

                         /*
                          *  Make sure the system cleaned up the alarm
                          *  after it delivered it.
                          */
                         ret_val3 = (alarm(0));

                         if (ret_val3 != 0) {
                                 printf("System did not "
                                        "clean up delivered "
                                        "alarm");
                         } else {
                                 printf("Functionality of "
                                        "alarm(%u) successful",
                                         time_sec2);
                         }
                 } else {
                         printf("alarm(%u) fails, returned %d, "
                                "almreceived:%d",
                                time_sec2, ret_val2, almreceived);
                 }

         return 0;
         /*NOTREACHED*/
}
/*
  * sigproc(int) - This function defines the action that has to be taken
  *                when the SIGALRM signal is caught.
  *   It also sets the variable which is used to check whether the
  *   alarm system call was successful.
  */
void
sigproc(int sig)
{
         almreceived = almreceived + 1;
}

/*
  * setup() - performs all ONE TIME setup for this test.
  *  Setup the signal handler to catch SIGALRM.
  */
void
setup()
{
         if (signal(SIGALRM, sigproc) == SIG_ERR) {
                       printf("signal() fails to catch SIGALARM, errno=%d",
                          errno);
         }
}
-----------------------------------------------------------
result:
------
ret_val2 returned = 8
ret_val2 expected = 7

I'm interested knowing what is the expected behavior ...

many thanks,



-- 
  Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
  Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
  Tel : 04.76.29.73.14
