Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUCaTAI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 14:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUCaTAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 14:00:07 -0500
Received: from [63.107.13.101] ([63.107.13.101]:30374 "EHLO mail.metavize.com")
	by vger.kernel.org with ESMTP id S262351AbUCaS74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:59:56 -0500
Message-ID: <406B1522.9050204@metavize.com>
Date: Wed, 31 Mar 2004 10:59:46 -0800
From: Dirk Morris <dmorris@metavize.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Rusty Russell <rusty@rustcorp.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.2] Badness in futex_wait revisited
References: <40311703.8070309@metavize.com> <20040217051911.6AC112C066@lists.samba.org> <20040331165656.GG19280@mail.shareable.org> <406B0219.3000309@metavize.com> <20040331183243.GA20418@mail.shareable.org>
In-Reply-To: <20040331183243.GA20418@mail.shareable.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>If you have a small test program (or pair of programs) that
>consistently triggers this message on any machine running 2.6.4, that
>would be very helpful indeed.
>  
>
Here ya go. :)

* $Id: foo.c,v 1.00 2004/03/31 10:51:19 dmorris Exp $ */
/* gcc foo.c -o foo -pthread */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

sem_t sem;

void* make_system_call (void* arg)
{
    while(1) {
        sleep(1);
        system("/bin/true");
    }
    return NULL;
}

int main(void)
{
    pthread_t id;
    sem_init(&sem,0,0);
    pthread_create(&id,NULL,make_system_call,NULL);
    while (sem_wait(&sem)<0)
        perror("sem_wait");
    return 0;
}



Output for me is :
~ # uname 
-a                                                                                        
[dmorris @ gobbles]
Linux gobbles 2.6.4 #2 SMP Mon Mar 29 17:15:08 PST 2004 i686 GNU/Linux
~ # 
./foo                                                                                           
[dmorris @ gobbles]
sem_wait: Interrupted system call
sem_wait: Interrupted system call
sem_wait: Interrupted system call
sem_wait: Interrupted system call
...


meanwhile kern.log spits out:
Mar 30 16:40:23 gobbles kernel: Badness in futex_wait at kernel/futex.c:508
Mar 30 16:40:23 gobbles kernel: Call Trace:
Mar 30 16:40:23 gobbles kernel:  [<c0139a28>] futex_wait+0x1a8/0x1c0
Mar 30 16:40:23 gobbles kernel:  [<c011efc0>] default_wake_function+0x0/0x20
Mar 30 16:40:23 gobbles kernel:  [<c011efc0>] default_wake_function+0x0/0x20
Mar 30 16:40:23 gobbles kernel:  [<c012d020>] do_timer+0xc0/0xd0
Mar 30 16:40:23 gobbles kernel:  [<c0139d30>] do_futex+0x70/0x80
Mar 30 16:40:23 gobbles kernel:  [<c0139e64>] sys_futex+0x124/0x140
Mar 30 16:40:23 gobbles kernel:  [<c015ef11>] sys_write+0x61/0x70
Mar 30 16:40:23 gobbles kernel:  [<c01095db>] syscall_call+0x7/0xb
Mar 30 16:40:23 gobbles kernel:


I can do this on multiple machines, so I won't include all the box info.
If you need it let me know.

Thanks! :)
-Dirk



