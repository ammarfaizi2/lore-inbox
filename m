Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131415AbRCKMuJ>; Sun, 11 Mar 2001 07:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131416AbRCKMt7>; Sun, 11 Mar 2001 07:49:59 -0500
Received: from ppp-96-244-an01u-dada6.iunet.it ([151.35.96.244]:40964 "HELO
	home.bogus") by vger.kernel.org with SMTP id <S131415AbRCKMtx>;
	Sun, 11 Mar 2001 07:49:53 -0500
Message-ID: <XFMail.20010311151257.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <oup4rx1tv9m.fsf@pigdrop.muc.suse.de>
Date: Sun, 11 Mar 2001 15:12:57 +0100 (CET)
From: Davide Libenzi <davidel@xmailserver.org>
To: Andi Kleen <ak@suse.de>
Subject: Re: sys_sched_yield fast path
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10-Mar-2001 Andi Kleen wrote:
> Davide Libenzi <davidel@xmailserver.org> writes:
> 
> 
>> Probably the rate at which is called sys_sched_yield() is not so high to let
>> the performance improvement to be measurable.
> 
> LinuxThreads mutexes call sched_yield() when a lock is locked, so when you 
> have a  multithreaded program with some lock contention it'll be called a
> lot.

This is the linux thread spinlock acquire :


static void __pthread_acquire(int * spinlock)
{
  int cnt = 0;
  struct timespec tm;

  while (testandset(spinlock)) {
    if (cnt < MAX_SPIN_COUNT) {
      sched_yield();
      cnt++;
    } else {
      tm.tv_sec = 0;
      tm.tv_nsec = SPIN_SLEEP_DURATION;
      nanosleep(&tm, NULL);
      cnt = 0;
    }
  }
}


Yes, it calls sched_yield() but this is not a std wait for mutex but for
spinlocks that are hold a very short time.
Real wait are implemented using signals.
More, with the new implementation of sys_sched_yield() the task release all its
time quantum so, even in a case where a task repeatedly calls sched_yield() the
call rate is not so high if there is at least one process to spin.
And if there isn't one task with goodness() > 0, nobody cares about
sched_yield() performance.




- Davide

