Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbUKDR3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUKDR3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbUKDR3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:29:44 -0500
Received: from gw.morinfr.org ([81.57.171.53]:33231 "EHLO bender.morinfr-int")
	by vger.kernel.org with ESMTP id S262293AbUKDR3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:29:39 -0500
Message-ID: <1099589372.418a66fc54599@mail.morinfr.org>
Date: Thu,  4 Nov 2004 18:29:32 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: linux-kernel@vger.kernel.org
Cc: gmorin1@bloomberg.net
Subject: [NPTL] situation where pthread_exit() makes the whole process exit
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 199.172.169.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Linux 2.6.9, I am having a problem with pthread_exit(). 

My test program creates a thread from the main thread, detaches it, then
call pthread_exit(). The remaining thread should execute and then only 
the process should exit. It is not what's happening right now. The
program returns right away

To figure out easily where we are, the spawned thread prints some stuff,
sleeps for 5 seconds and then prints something else.

If you launch that program, it will not print anything and return
right away. If you pass a parameter to the program, the main thread
will call sched_yield() before calling pthread_exit(). In this case, it
will work:

gmorin@linux:~> time ./foo

real    0m0.001s
user    0m0.000s
sys     0m0.001s
gmorin@linux:~> time ./foo yield
In f, sleeping 5 secs
Reached

real    0m5.003s
user    0m0.000s
sys     0m0.002s
gmorin@linux:~>

So it looks like the problem only appears if the spawned thread was not
scheduled.

FYI, Linuxthreads works well:

gmorin@linux:~> LD_ASSUME_KERNEL=2.4.1 ./foo
In f, sleeping 5 secs
Reached

Here is the source of the program:

#include <pthread.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

void * f(void * arg) {
    puts("In f, sleeping 5 secs");
    fflush(stdout);
    sleep(5);
    puts("Reached");
    return NULL;
}

int main(int argc,char *argv[]) {
    pthread_t t;
    if (pthread_create(&t, NULL, f, NULL)) {
        printf("error %s\n", strerror(errno));
        return 1;
    }
    if (pthread_detach(t)) {
        printf("error %s\n", strerror(errno));
        return 1;
    }
    if (argc > 1)
        sched_yield();
    pthread_exit(0);

    // not reached
    return 2;
}

HTH. Guillaume.

PS: please keep all the CCs. Thanks in advance.

-- 
Guillaume Morin <guillaume@morinfr.org>

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
