Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbUKCN3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbUKCN3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 08:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUKCN3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 08:29:15 -0500
Received: from [217.89.113.142] ([217.89.113.142]:12293 "EHLO
	fl-relay.orga.com") by vger.kernel.org with ESMTP id S261590AbUKCN27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 08:28:59 -0500
Message-ID: <4188DC90.9030503@orga-systems.com>
Date: Wed, 03 Nov 2004 14:26:40 +0100
From: =?ISO-8859-1?Q?Gerrit_Bruchh=E4user?= 
	<gbruchhaeuser@orga-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.3) Gecko/20040913
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: gbruchhaeuser@orga-systems.com
Subject: accept does not return in case a signal arrives
X-MIMETrack: Itemize by SMTP Server on PBCOM1/Paderborn/ORGA(Release 5.0.6a |January 17, 2001) at
 03.11.2004 14:28:47,
	Serialize by Router on PBCOM1/Paderborn/ORGA(Release 5.0.6a |January 17, 2001) at
 03.11.2004 14:28:49,
	Serialize complete at 03.11.2004 14:28:49,
	Itemize by SMTP Server on FLCOM1/FL/ORGA(Release 5.0.12  |February 13, 2003) at
 11/03/2004 02:28:49 PM,
	Serialize by Router on FLCOM1/FL/ORGA(Release 5.0.12  |February 13, 2003) at
 11/03/2004 02:28:50 PM,
	Serialize complete at 11/03/2004 02:28:50 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel-team,

on Linux, 'accept' system call does not return in case I send SIGTERM to 
my application; while it does on OSF-Alpha.

Given the following sample:

,----[ main.cc ]
| #include <sys/types.h>
| #include <sys/socket.h>
| #include <errno.h>
| #include <string.h>
| #include <stdio.h>
| #include <stdlib.h>
| #include <resolv.h>
| #include <signal.h>
|
| #define CHECK_RET_M(arg, x) \
|   if (-1 == (x) && errno != EINTR) { \
|      printf("System call '%s' failed: %s\n", #arg, strerror(errno)); \
|      exit(1); \
|   }
|
| typedef struct sockaddr SA;
|
| static void TermHandler(int signu)
| {
|    // Nothing
| }
|
| int main(int argc, char *argv[])
| {
|   // Create signal handler 4 SIGTERM
|   signal(SIGTERM, &TermHandler);
|
|   // Create listening socket...
|   // argv[1] will be the port number!
|   int port = atoi(argv[1]);
|   int listen_fd = socket(AF_INET, SOCK_STREAM, 0); CHECK_RET_M(socket, 
listen_fd);
|
|   struct sockaddr_in servaddr;
|   bzero((char *) &servaddr, sizeof(servaddr));
|   servaddr.sin_family      = AF_INET;
|   servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
|   servaddr.sin_port        = htons(port);
|
|   // Bind the socket and switch its state to 'listen'...
|   int r = bind(listen_fd, (SA *) &servaddr, sizeof(servaddr)); 
CHECK_RET_M(bind, r);
|   int backlog = 1000;
|   r = listen(listen_fd, backlog); CHECK_RET_M(listen, r);
|
|   // Wait until client tries to connect...
|   struct sockaddr_in cliaddr;
|   socklen_t clilen = (socklen_t) sizeof(cliaddr);
|   int conn_fd = accept(listen_fd, (SA *) &cliaddr, &clilen);
|
|   // If SIGTERM arrives ... the following message should be printed!
|   printf("EXIT NOW\n");
|   return 0;
| }
`----

Compiled once on each of the systems:
    $> g++ -D_POSIX_PII_SOCKET -o main main.cc

Execute in 1st shell:
    $> ./main 10000

Execute in 2nd shell:
    $> ps -ef | grep -v grep | grep main
    $> kill -TERM <pid-of-main>

Results (in 1st shell, on OSF):
    EXIT NOW
    $>

Linux exectutes the signal handlers code - but 'accept' does not return. 
So I've no chance to quit my application in case I have to.

Is there any workaround for my problem?


As I did not subscribe to the list; can you please put me on CC personally?

Many thanks and cheers,
Gerrit
