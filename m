Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSLQQxb>; Tue, 17 Dec 2002 11:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbSLQQxb>; Tue, 17 Dec 2002 11:53:31 -0500
Received: from mx0.gmx.net ([213.165.64.100]:48738 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S264839AbSLQQx2>;
	Tue, 17 Dec 2002 11:53:28 -0500
Date: Tue, 17 Dec 2002 18:01:20 +0100 (MET)
From: Michael Kerrisk <m.kerrisk@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Shutdown(), TCP sockets, and select() discrepancy
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0005657596@gmx.net
X-Authenticated-IP: [212.18.21.202]
Message-ID: <20192.1040144480@www24.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After an offline discussion with Andi Kleen, I thought I'd bring this topic
here.

I have been experimenting with shutdown() and select() on TCP sockets and
noted a clear discrepancy from (seemingly all) other Unix flavours.  On most
implementations, if we do a SHUT_WR or SHUT_RDWR, then the socket should test
as writable when we call select(), since a write() etc. will fail with a
SIGPIPE signal or an EPIPE error.  

On Linux this doesn't happen - is there a reason why Linux differs in this
respect from other implementations?  Given that FreeBSD, Solaris 8, HP/UX 11,
Irix 6.5, and OSF 5.1/a all do mark a socket as writable in this case, things
appear to be broken, de facto, on Linux.

At the foot of this mail is a test program I wrote which 
demonstrates the disrepancy.  When I run this on SuSE 8.0 (kernel 2.4.18)
and SuSE 7.2 (kernel 2.2.19) I see the following:

$ ./is_shutdown_select 1
Listening socket (fd=3) set up okay
Active socket (fd=4) set up okay
Connection established (fd=5)
shutdown(4, 1)
3:
4:
5: r w
$ ./is_shutdown_select 2
Listening socket (fd=3) set up okay
Active socket (fd=4) set up okay
Connection established (fd=5)
shutdown(4, 2)
3:
4: r
5: r w


But On FreeBSD 4.7 I see the following (which is what I expected to see on
Linux):

$ ./is_shutdown_select 1
Listening socket (fd=3) set up okay
Active socket (fd=4) set up okay
Connection established (fd=5)
shutdown(4, 1)
3:
4: w
5: r w
$ ./is_shutdown_select 2
Listening socket (fd=3) set up okay
Active socket (fd=4) set up okay
Connection established (fd=5)
shutdown(4, 2)
3:
4: r w
5: r w

Solaris 8, HP/UX 11, Irix 6.5, and OSF 5.1/a (I had to modify the header
files included slightly for the latter OSes) give the same results as FreeBSD
4.7.  

Cheers

Michael

============================

/* is_shutdown_select.c

   Experiment to determine behaviour of select() after a shutdown()
   is performed on one or both ends of a TCP socket pair.
*/
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <sys/select.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

#define errExit(msg) { perror(msg); exit(EXIT_FAILURE); }

#define PORT_NUM 50000          /* Port number for server */

int
main(int argc, char *argv[])
{
    struct sockaddr_in svaddr;
    int fd[3], optval, j;
    fd_set rfds, wfds;
    int nfds;
    struct timeval tmo = { 0, 0 };      /* For polling select() */

    if (argc > 1 && strcmp(argv[1], "--help") == 0) {
        fprintf(stderr, "%s active-how accept-how\n", argv[0]);
        exit(EXIT_FAILURE);
    } /* if */

    fd[0] = socket(AF_INET, SOCK_STREAM, 0);    /* Listening socket */ 
    if (fd[0] == -1) errExit("socket");

    optval = 1;
    if (setsockopt(fd[0], SOL_SOCKET, SO_REUSEADDR, &optval,
                sizeof(optval)) == -1) errExit("setsockopt");

    /* Bind to wildcard host address + well-known port, and mark as
       listening socket */

    memset(&svaddr, 0, sizeof(svaddr));
    svaddr.sin_family = AF_INET;
    svaddr.sin_addr.s_addr = htonl(INADDR_ANY); /* Wildcard address */
    svaddr.sin_port = htons(PORT_NUM); if (bind(fd[0], (struct sockaddr *)
            &svaddr, sizeof(svaddr)) == -1)
        errExit("bind");

    if (listen(fd[0], 5) == -1) errExit("listen");

    printf("Listening socket (fd=%d) set up okay\n", fd[0]);

    /* Active sockets */

    fd[1] = socket(AF_INET, SOCK_STREAM, 0);
    if (fd[1] == -1) errExit("socket");
    svaddr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    if (connect(fd[1], (struct sockaddr *) &svaddr, sizeof(svaddr)) == -1)
        errExit("connect");

    printf("Active socket (fd=%d) set up okay\n", fd[1]);

    fd[2] = accept(fd[0], NULL, NULL);
    if (fd[2] == -1) errExit("accept");

    printf("Connection established (fd=%d)\n", fd[2]);

    if (argc > 1) {     /* Do a shutdown on active socket */
        if (shutdown(fd[1], atoi(argv[1])) == -1)
            errExit("shutdown (active socket)");
        printf("shutdown(%d, %d)\n", fd[1], atoi(argv[1]));
    } /* if */

    if (argc > 2) {     /* Do a shutdown on accepted socket */
        if (shutdown(fd[2], atoi(argv[2])) == -1)
            errExit("shutdown (accepted socket)");
         printf("shutdown(%d, %d)\n", fd[2], atoi(argv[2]));
    } /* if */

    FD_ZERO(&rfds);
    FD_ZERO(&wfds);
    nfds = 0;

    for (j = 0; j < 3; j++) {
        FD_SET(fd[j], &rfds);
        FD_SET(fd[j], &wfds);

        if (fd[j] >= nfds)
            nfds = fd[j] + 1;
    } /* for */

    if (select(nfds, &rfds, &wfds, NULL, &tmo) == -1) errExit("select");

    for (j = 0; j < 3; j++) {
        printf("%d: ", fd[j]);
        if (FD_ISSET(fd[j], &rfds))
            printf("r ");
        if (FD_ISSET(fd[j], &wfds))
            printf("w ");
        printf("\n");
    } /* for */

    exit(EXIT_SUCCESS);
} /* main */


-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr für 1 ct/ Min. surfen!

