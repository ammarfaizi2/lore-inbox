Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUEJV0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUEJV0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 17:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUEJV0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 17:26:53 -0400
Received: from finch.doc.ic.ac.uk ([146.169.1.194]:32407 "EHLO
	finch.doc.ic.ac.uk") by vger.kernel.org with ESMTP id S261914AbUEJV0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:26:37 -0400
Message-ID: <409FF38C.7080902@bluetheta.com>
Date: Mon, 10 May 2004 22:26:36 +0100
From: Andre Ben Hamou <andre@bluetheta.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Multithread select() bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the scenario...

- parent thread P creates a connected socket pair S[0, 1]
- P spawns a child thread C and passes it S
- C selects on S[0]
- P closes S[0]

As I understand the semantics of the select call, C should now return 
immediately in response to the closure (and it does on Mac OS X). 
However, the following test code behaves otherwise for the two test 
cases I've tried (2.4.21 and 2.6.5). Compilation command used: 'gcc 
foobar.c -lpthread'.

Cheers,

Andre Ben Hamou
Imperial College London


--- BEGIN TEST CODE (foobar.c)---

#include <assert.h>         // assert
#include <pthread.h>        // pthread_create
#include <sys/select.h>     // select
#include <sys/types.h>      // socketpair
#include <sys/socket.h>     // socketpair
#include <unistd.h>         // sleep
#include <stdio.h>          // printf

void *threadFuntion (void *sockets) {
     int socket = ((int *)sockets)[0];
     struct timeval timeout = {tv_sec: 5, tv_usec: 0};

     // Allocate a file descriptor set with the passed socket
     fd_set fds;
     FD_ZERO (&fds);
     FD_SET (socket, &fds);

     // Select to read / register exceptions on the FD set
     select (socket + 1, &fds, NULL, &fds, &timeout);

     return NULL;
}

int main (void) {
     int sockets[2];
     pthread_t thread;

     // Create a connected pair of sockets
     assert (socketpair (PF_UNIX, SOCK_STREAM, 0, sockets) != -1);
     printf ("sockets: {%i, %i}\n", sockets[0], sockets[1]);

     // Create a POSIX thread
     // - use the default configuration
     // - invoke 'threadFunction' as the root function of the thread
     // - pass the socket array to 'threadFunction'
     assert (pthread_create (&thread,
			    NULL,
                             threadFuntion,
                             sockets) == 0);

     // Wait for a second and then close the socket being selected on
     sleep (1);
     assert (close (sockets[0]) == 0);
     printf ("Socket closed\n");

     // Wait for the thread to exit - SHOULD BE ~ INSTANTANEOUS
     assert (pthread_join (thread, NULL) == 0);
     printf ("Thread joined\n");

     assert (close (sockets[1]) == 0);
     return 0;
}

--- END TEST CODE ---

-- 

...and, on the seventh day, God switched off his Mac.
