Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTKDQpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 11:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbTKDQpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 11:45:35 -0500
Received: from [193.112.238.6] ([193.112.238.6]:60590 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S262397AbTKDQpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 11:45:30 -0500
Message-ID: <3FA7D7A1.2030307@xisl.com>
Date: Tue, 04 Nov 2003 16:45:21 +0000
From: John M Collins <jmc@xisl.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Semaphores and threads anomaly and bug?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC me in any reply as I'm not subscribed)

I know this isn't defined anywhere but the seems to be an ambiguity and 
discrepancy between versions of Unix and Linux over threads and semaphores.

Do the "SEM_UNDO"s get applied when a thread terminates or when the 
"whole thing" terminates?

I tried the following C++ program

#include <iostream>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <pthread.h>

using    namespace  std;

int    semchan;

union semun {
      int val;                  /* value for SETVAL */
      struct semid_ds *buf;     /* buffer for IPC_STAT, IPC_SET */
      unsigned short *array;    /* array for GETALL, SETALL */
                                /* Linux specific part: */
      struct seminfo *__buf;    /* buffer for IPC_INFO */
};

int    getsemv()
{
    return  semctl(semchan, 0, GETVAL, 0);
}

void    *tfunc(void *arg)
{
    cout << "About to set sema4 current=" << getsemv() << endl;
    sembuf  sv;
    sv.sem_op = 77;
    sv.sem_flg = SEM_UNDO;
    sv.sem_num = 0;
    semop(semchan, &sv, 1);
    cout << "Done,sem now=" << getsemv() << endl;
    return  0;
}

int    main()
{
    semchan = semget(999, 1, 0666 | IPC_CREAT);
    semun  z;
    z.val = 1;
    semctl(semchan, 0, SETVAL, z);
    cout << "Created sema4 initial value=" << getsemv() << endl;
    cout << "Creating thread" << endl;
    pthread_t  th;
    pthread_create(&th, 0, tfunc, 0);
    pthread_join(th, 0);
    cout << "After thread value=" << getsemv() << endl;
    return  0;
}

Trying it on Linux (2.4.21 kernel) it says:

Created sema4 initial value=1
Creating thread
About to set sema4 current=1
Done,sem now=78
After thread value=1

Implying that the thread exit applies the SEM_UNDOs whereas trying on 
Solaris 2.9 and HP/UX 11 I get

Created sema4 initial value=1
Creating thread
About to set sema4 current=1
Done,sem now=78
After thread value=78

After which the value is 1, implying that the SEM_UNDOs get applied on 
process exit.

There is another anomaly which applies to SEM_UNDO in that when a 
process exits, every semaphore in the set has its "sempid" set to the 
process id of the exiting process, even ones that the process left 
alone. I think that in ipc/sem.c line 1062 the line should be made 
conditional on "u->semadj[i]" being non-zero.

I know all this isn't defined anywhere but I hit on this trying to write 
an application involving a server process using threads and a 
semaphore-protected shared memory segment accessed by client processes. 
The semaphore might be set to "locked" by a different thread from the 
one that "unlocks" it (I'm using "Mutexes" inside the server process). I 
know you probably don't want SEM_UNDO in a fully-debugged server 
process, only in the clients but it's all a question of getting the said 
server process into the glorious state of being "fully-debugged" or 
somewhere near there.

There is a potential problem here in that the code in ipc/sem.c doesn't 
allow the adjustment to yield a negative value but what if it starts at 
zero, thread A increments it, thread B decrements it back to zero (both 
with SEM_UNDO) and thread A exits first? Thread A's undo won't work and 
then thread B's undo will increment it again leaving it in an incorrect 
state which is different from thread B exiting first.

-- 
John Collins Xi Software Ltd www.xisl.com


