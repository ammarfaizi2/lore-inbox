Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274173AbRITCYh>; Wed, 19 Sep 2001 22:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274124AbRITCY1>; Wed, 19 Sep 2001 22:24:27 -0400
Received: from [208.129.208.52] ([208.129.208.52]:38156 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274010AbRITCYV>;
	Wed, 19 Sep 2001 22:24:21 -0400
Message-ID: <XFMail.20010919192804.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BA950AF.58CFCF29@kegel.com>
Date: Wed, 19 Sep 2001 19:28:04 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Dan Kegel <dank@kegel.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Christopher K. St. John" <cks@distributopia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Sep-2001 Dan Kegel wrote:
> Davide Libenzi wrote:
>> 1)      if (recv()/send() == FAIL)
>> 2)              ioctl(EP_POLL);
> 
> A lot of people, including me, were under the mistaken impression
> that /dev/epoll, like /dev/poll, provided an efficient way to
> retrieve the current readiness state of fd's.  I understand from your post
> that /dev/epoll's purpose is to retrieve state changes; in other
> words, it's exactly like F_SETSIG/F_SETOWN/O_ASYNC except that
> the readiness change indications are picked up via an ioctl
> rather than via a signal.
> 
> A scorecard for the confused (Davide, correct me if I'm wrong):
> 
> * API's that allow you to retrieve the current readiness state of
>   a set of fd's:  poll(), select(), /dev/poll, kqueue().
>   Buzzwords describing this kind of interface: level-triggered, multishot.
> 
> * API's that allow you to retrieve *changes* to the readiness state of
>   a set of fd's: F_SETSIG/F_SETOWN/O_ASYNC + sigtimedwait(), /dev/epoll, kqueue().
>   Buzzwords describing this kind of interface: edge-triggered, single-shot.
> 
> (Note that kqueue is in both camps.)
> 
> Er, I guess that means I'll rip up the /dev/epoll support I based on my
> /dev/poll code, and replace it with some based on my O_ASYNC code...


Exactly :)
Here are examples basic functions when used with coroutines :


int dph_connect(struct dph_conn *conn, const struct sockaddr *serv_addr, socklen_t addrlen) {

        if (connect(conn->sfd, serv_addr, addrlen) == -1) {
                if (errno != EWOULDBLOCK && errno != EINPROGRESS)
                        return -1;
                conn->events = POLLOUT | POLLERR | POLLHUP;
                co_resume(conn);
                if (conn->revents & (POLLERR | POLLHUP))
                        return -1;
        }
        return 0;
}

int dph_read(struct dph_conn *conn, char *buf, int nbyte) {
        int n;

        while ((n = read(conn->sfd, buf, nbyte)) < 0) {
                if (errno == EINTR)
                        continue;
                if (errno != EAGAIN && errno != EWOULDBLOCK)
                        return -1;
                conn->events = POLLIN | POLLERR | POLLHUP;
                co_resume(conn);
        }
        return n;
}

int dph_write(struct dph_conn *conn, char const *buf, int nbyte) {
        int n;

        while ((n = write(conn->sfd, buf, nbyte)) < 0) {
                if (errno == EINTR)
                        continue;
                if (errno != EAGAIN && errno != EWOULDBLOCK)
                        return -1;
                conn->events = POLLOUT | POLLERR | POLLHUP;
                co_resume(conn);
        }
        return n;
}

int dph_accept(struct dph_conn *conn, struct sockaddr *addr, int *addrlen) {
        int sfd;

        while ((sfd = accept(conn->sfd, addr, (socklen_t *) addrlen)) < 0) {
                if (errno == EINTR)
                        continue;
                if (errno != EAGAIN && errno != EWOULDBLOCK)
                        return -1;
                conn->events = POLLIN | POLLERR | POLLHUP;
                co_resume(conn);
        }
        return sfd;
}




- Davide

