Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263283AbSJOHkZ>; Tue, 15 Oct 2002 03:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263289AbSJOHkZ>; Tue, 15 Oct 2002 03:40:25 -0400
Received: from mail6.home.nl ([213.51.128.22]:15027 "EHLO mail6-sh.home.nl")
	by vger.kernel.org with ESMTP id <S263283AbSJOHkW>;
	Tue, 15 Oct 2002 03:40:22 -0400
Content-Type: text/plain;
  charset="Big5"
From: Jogchem de Groot <bighawk@kryptology.org>
To: Geoffrey Lee <glee@gnupilgrims.org>
Subject: Re: poll() incompatability with POSIX.1-2001
Date: Tue, 15 Oct 2002 09:47:00 +0200
X-Mailer: KMail [version 1.3.2]
References: <20021014145726.DFKF19708.mail8-sh.home.nl@there> <Pine.LNX.3.95.1021014110505.12302A-100000@chaos.analogic.com> <20021015033640.GA15553@anakin.wychk.org>
In-Reply-To: <20021015033640.GA15553@anakin.wychk.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20021015074616.SQGS394.mail6-sh.home.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 October 2002 05:36, you wrote:

> This is the result on a return from poll().
>
> glee@orion ~/tmp $ ./poll-new -h xx.xx.xx.xx -p 80
> connect
> connect: INPROGRESS
> poll: POLLOUT is set
> terminating
> glee@orion ~/tmp $
>
>
> So, POLLOUT is set.
>
>
> Now, we try to connect to an invalid port.
>
> n ~/tmp $ ./poll-new -h xx.xx.xx.xx -p 4
> connect
> connect: INPROGRESS
> poll: POLLERR set
> poll: POLLHUP set
> poll: POLLOUT is set
> terminating
> glee@orion ~/tmp $
>
>
> So, POLLOUT is set.

Hello, on what version did you try this? I've tried this now on 
Linux-2.4.18 and Linux-2.4.19 and both give the behaviour i described 
previously (No POLLOUT set).

The simple test program i used is as follows:
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/poll.h>
#include <sys/select.h>
#include <errno.h>

main(int argc, char **argv) {
    int sd,flags,stat,len=sizeof(int);
    struct sockaddr_in sin;
    struct pollfd pfd;

    memset(&sin, 0, sizeof(sin));

    sd = socket(AF_INET, SOCK_STREAM, 0);
    fcntl(sd, F_SETFL, fcntl(sd, F_GETFL, 0) | O_NONBLOCK);

    sin.sin_addr.s_addr = htonl(0x7f000001);
    sin.sin_port = htons(atoi(argv[1]));
    sin.sin_family = AF_INET;

    if(connect(sd, (struct sockaddr *)&sin, sizeof(sin)) == -1 && errno == 
EINPROGRESS)
        printf("connect returned EINPROGRESS\n");

    pfd.fd = sd;
    pfd.events = POLLIN | POLLOUT;
    pfd.revents = 0;

    poll(&pfd, 1, -1);
    getsockopt(sd, SOL_SOCKET, SO_ERROR, &stat, &len);
    printf("%s\n", stat ? "failed" : "succeeded");
    printf("returned events: %hd\n", pfd.revents);
}

    bighawk

