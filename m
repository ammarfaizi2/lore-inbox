Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTFDXU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTFDXU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:20:26 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:38817 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264289AbTFDXUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:20:22 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: select for UNIX sockets?
References: <m3llwkauq5.fsf@defiant.pm.waw.pl>
	<1054651886.9233.35.camel@dhcp22.swansea.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 05 Jun 2003 01:27:20 +0200
In-Reply-To: <1054651886.9233.35.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <m3n0gxfmp3.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Sort of. The wakeup may occur for several reasons and you need to check
> the return (for signals). Also the wakeup can occur when there is room
> but another thread fills it, or return room but not enough for a large
> datagram. Those don't seem to be the case on your example

I've traced the problem to datagram_poll(). This function doesn't
check if the receiver queue has at least one slot empty, it only
checks sock_writeable() i.e. if:
        atomic_read(&sk->wmem_alloc) < (sk->sndbuf / 2);

unix_dgram_sendmsg() can then block on:

        if (unix_peer(other) != sk &&
            skb_queue_len(&other->receive_queue) > other->max_ack_backlog) {
                if (!timeo) {
                        err = -EAGAIN;
                        goto out_unlock;

Now the question is how should the problem be fixed?
I've tried using modified datagram_poll():

+       unix_socket *other = NULL;

-       if (sock_writeable(sk))
+       other = unix_peer_get(sk);
+       if (sock_writeable(sk) && other &&
+           skb_queue_len(&other->receive_queue) <= other->max_ack_backlog)
                mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
        else
                set_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);

but unix_peer_get(sk) returns NULL.
How can I examine the receiver queue length?
Should I worry about "restarts" as in unix_dgram_sendmsg()?
Maybe someone has a fix ready?

I've attached the userspace tests, a modified version of someone's real
program - recv should be run first, send should be straced.

The problem is present in both 2.5.70 and 2.4.20rc7.
-- 
Krzysztof Halasa
Network Administrator

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=recv.c

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <fcntl.h>

int                 socketUn;
struct sockaddr_un  addrUn;
int                 lenUn;
int                 size = 1;
char                datagram[2000];

void sockInit();

int main() {
  sockInit();

  while(1) {
    sleep(30);

    while(size != -1){
      size = recvfrom(socketUn, &datagram, sizeof(datagram), 0,
                      (struct sockaddr*)NULL, (socklen_t *)NULL);
    /*  if (size == -1) perror("recvfrom failed: ");
        else printf("DATAGRAM: size: %d\n", size);*/
    }
    size = 0;
  }
}


void sockInit() {
  if ( unlink("/tmp/tempUn") == -1) perror("unlink failed\n");

  socketUn = socket(AF_UNIX, SOCK_DGRAM, 0);
  if (socketUn == -1) perror("socket failed");

  addrUn.sun_family = AF_UNIX;

  strcpy(addrUn.sun_path, "/tmp/tempUn");

  lenUn = strlen(addrUn.sun_path) + sizeof(addrUn.sun_family);

  if ( bind(socketUn, (struct sockaddr *)&addrUn, lenUn) == -1)
    perror("bind failed");

  fcntl(socketUn, F_SETFL, O_APPEND|O_NONBLOCK);
}


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=send.c

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <fcntl.h>

int                 socketUn;
struct sockaddr_un  addrUn;
int                 lenUn;
int                 size;
char                datagram[1];
int                 dgramCounter = 0;
int                 maxFdToWatch;
fd_set              writeFdToWatch;


void sockInit();


int main() {

  sockInit();

  maxFdToWatch = socketUn + 1;

  while(1) {
    FD_ZERO(&writeFdToWatch);
    FD_SET(socketUn, &writeFdToWatch);

    select(FD_SETSIZE, NULL, &writeFdToWatch, NULL, NULL);
    sleep(1);

    if (FD_ISSET(socketUn, &writeFdToWatch)) {
      size = sendto(socketUn, &datagram, sizeof(datagram), 0, (struct
sockaddr *)&addrUn, lenUn);
      if (size == -1) perror("sendto failed");
      sleep(1);
    }

    dgramCounter++;

    FD_ZERO(&writeFdToWatch);
  }
}

void sockInit() {
  socketUn = socket(AF_UNIX, SOCK_DGRAM, 0);
  if (socketUn == -1) perror("socket failed");
  addrUn.sun_family = AF_UNIX;
  strcpy(addrUn.sun_path, "/tmp/tempUn");
  lenUn = strlen(addrUn.sun_path) + sizeof(addrUn.sun_family);
}


--=-=-=--
