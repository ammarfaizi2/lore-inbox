Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVKQQat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVKQQat (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVKQQat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:30:49 -0500
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:35243
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S932398AbVKQQas convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:30:48 -0500
Message-ID: <20051117163047.30293.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: <linux-kernel@vger.kernel.org>
cc: dag@newtech.fi
Subject: nanosleep with small value
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 17 Nov 2005 18:30:47 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

seeing a strange thing happening here:
using nanosleep() with a smallish value gives me a very long sleeptime?

Is this because of a context switch being forced?
Shouldn't the scheduler change affect that?

The test program:
===================================
#include <time.h>
#include <sched.h>
#include <stdio.h>

void delay_ns(unsigned long dly)
{
        static struct timespec time;
        int err;
        {
                time.tv_sec = 0;
                time.tv_nsec = dly;
                err = nanosleep(&time, NULL);
                if (err) {
                        perror( "nanosleep failed" );
                }
        }
}


main()
{
        int i;

        struct sched_param mysched;
        int err;

        if ( sched_getparam( 0, &mysched ) != 0 )
                perror( "" );
        else {
                mysched.sched_priority = sched_get_priority_max(SCHED_FIFO);
                err = sched_setscheduler(0, SCHED_FIFO, &mysched);
                if( err != 0 ) {
                        fprintf (stderr,"sched_setscheduler returned: %d\n", 
err );
                        perror( "" );
                }
        }

        for (i=0; i < 1000; i++)
                delay_ns(1000UL);
}
==================================
The result running this is:
% time ./tst

real    0m8.000s
user    0m0.000s
sys     0m0.000s

I would have expected about 1000 * 1 us + overhead,
but 8 seconds ????

Noticed this when trying to debug a PIC-programming
software where the delay_ns() routine is used.

Increasing the nanosleep() argument to something more than HZ
will give me the expected sleep times.

Best

-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


