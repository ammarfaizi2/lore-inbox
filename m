Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbUEJV7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUEJV7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 17:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUEJV6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 17:58:20 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:60827 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261638AbUEJV5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:57:46 -0400
Message-ID: <409FFADD.7050204@cosmosbay.com>
Date: Mon, 10 May 2004 23:57:49 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Andre Ben Hamou <andre@bluetheta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multithread select() bug
References: <409FF38C.7080902@bluetheta.com>
In-Reply-To: <409FF38C.7080902@bluetheta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Ben Hamou wrote:

> Here's the scenario...
>
> - parent thread P creates a connected socket pair S[0, 1]
> - P spawns a child thread C and passes it S
> - C selects on S[0]
> - P closes S[0]
>
Your program is racy and have undefined behavior.

A thread should not close a handle 'used by another thread blocked in a 
sytemcall'

The race is : if a thread does a close(fd), then the fd value may be 
reused by another thread during an open()/socket()/dup()... syscall, and 
the first thread could issue the select() syscall (or 
read()/write()/...) on the bad file.

Some Unixes defines different semantics (Solaris comes to mind), but 
these semantics are not part of  standards.

Eric

> As I understand the semantics of the select call, C should now return 
> immediately in response to the closure (and it does on Mac OS X). 
> However, the following test code behaves otherwise for the two test 
> cases I've tried (2.4.21 and 2.6.5). Compilation command used: 'gcc 
> foobar.c -lpthread'.
>
> Cheers,
>
> Andre Ben Hamou
> Imperial College London
>
>
> --- BEGIN TEST CODE (foobar.c)---
>
> #include <assert.h>         // assert
> #include <pthread.h>        // pthread_create
> #include <sys/select.h>     // select
> #include <sys/types.h>      // socketpair
> #include <sys/socket.h>     // socketpair
> #include <unistd.h>         // sleep
> #include <stdio.h>          // printf
>
> void *threadFuntion (void *sockets) {
>     int socket = ((int *)sockets)[0];
>     struct timeval timeout = {tv_sec: 5, tv_usec: 0};
>
>     // Allocate a file descriptor set with the passed socket
>     fd_set fds;
>     FD_ZERO (&fds);
>     FD_SET (socket, &fds);
>
>     // Select to read / register exceptions on the FD set
>     select (socket + 1, &fds, NULL, &fds, &timeout);
>
>     return NULL;
> }
>
> int main (void) {
>     int sockets[2];
>     pthread_t thread;
>
>     // Create a connected pair of sockets
>     assert (socketpair (PF_UNIX, SOCK_STREAM, 0, sockets) != -1);
>     printf ("sockets: {%i, %i}\n", sockets[0], sockets[1]);
>
>     // Create a POSIX thread
>     // - use the default configuration
>     // - invoke 'threadFunction' as the root function of the thread
>     // - pass the socket array to 'threadFunction'
>     assert (pthread_create (&thread,
>                 NULL,
>                             threadFuntion,
>                             sockets) == 0);
>
>     // Wait for a second and then close the socket being selected on
>     sleep (1);
>     assert (close (sockets[0]) == 0);
>     printf ("Socket closed\n");
>
>     // Wait for the thread to exit - SHOULD BE ~ INSTANTANEOUS
>     assert (pthread_join (thread, NULL) == 0);
>     printf ("Thread joined\n");
>
>     assert (close (sockets[1]) == 0);
>     return 0;
> }
>
> --- END TEST CODE ---
>

