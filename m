Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317418AbSGOKOc>; Mon, 15 Jul 2002 06:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317419AbSGOKOb>; Mon, 15 Jul 2002 06:14:31 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:53495 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S317418AbSGOKO3>; Mon, 15 Jul 2002 06:14:29 -0400
Message-Id: <5.1.0.14.2.20020715201505.02888960@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 15 Jul 2002 20:16:02 +1000
To: linux-kernel@vger.kernel.org
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: ext2 performance in 2.5.25 versus 2.4.19pre8aa2
In-Reply-To: <20020715094915.GD34@dualathlon.random>
References: <5.1.0.14.2.20020715160245.02ad0978@mira-sjcm-3.cisco.com>
 <3D2CFF48.9EFF9C59@zip.com.au>
 <5.1.0.14.2.20020714202539.022c4270@mira-sjcm-3.cisco.com>
 <5.1.0.14.2.20020715160245.02ad0978@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:49 AM 15/07/2002 +0200, Andrea Arcangeli wrote:
> > my test app uses pthreads (one thread per disk-worker) and
> > pthread_cond_wait in the master task to wait for all workers to finish.
> > i'll switch the app to use clone() and sys_futex instead.
>
>unless you call pthread routines during the workload, pthreads cannot be
>the reason for a slowdown.

the test app does:

(parent)
         for (i=0; i < num_devices; i++) {
                 err = pthread_create(&(device[i]->thread), NULL,  (void 
*)run_tests, (void *) i);
                 ..
         }

         /* wait for all threads to exit */
         while (active_threads != 0) {
                 pthread_mutex_lock(&sync_thread_mutex);

                 gettimeofday(&now, NULL);
                 timeout.tv_sec = now.tv_sec + 5;
                 timeout.tv_nsec = now.tv_usec * 1000;
                 retcode = 0;

                 while ((active_threads != 0) && (retcode != ETIMEDOUT)) {
                         retcode = 
pthread_cond_timedwait(&sync_thread_cond, &sync_thread_mutex, &timeout);
                 }

                 if (retcode == ETIMEDOUT) {
                         print_status_update();
                 }
                 pthread_mutex_unlock(&sync_thread_mutex);
         }


(each worker, when it finishes)
         pthread_mutex_lock(&sync_thread_mutex);
         active_threads--;
         pthread_cond_broadcast(&sync_thread_cond);
         pthread_mutex_unlock(&sync_thread_mutex);
         pthread_exit(0);


no idea what the pthread_cond_timedwait does under the covers, but i bet 
its bad..

>BTW, Lincol, I still have a pending answer for you, about the mmap
>slowdown, that's because of reduced readahead mostly, you can tune it
>with page-cluster sysctl, it's not only because of the expensive page
>faults that mmap I/O implies. I've some revolutionary idea about
>replacing readahead, not that it matters for your workload that is
>reading physically contigous though.

i only added the mmap() for interests-sake; the intent of my benchmarking 
was less-so to stress linux, more-so to stress some storage-networking 
plumbing (iSCSI & FC stuff), but its been an interesting series of 
experiments nontheless.


cheers,

lincoln.

