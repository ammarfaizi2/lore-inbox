Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSK1CvR>; Wed, 27 Nov 2002 21:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSK1CvR>; Wed, 27 Nov 2002 21:51:17 -0500
Received: from tantale.fifi.org ([216.27.190.146]:41622 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S265099AbSK1CvQ>;
	Wed, 27 Nov 2002 21:51:16 -0500
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>
Subject: Wierd listen/connect: accept queue never fills up
From: Philippe Troin <phil@fifi.org>
Date: 27 Nov 2002 18:58:33 -0800
Message-ID: <87y97ee6xy.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Andi, I've CC'ed you since you're listed as the author of the `new
listen' code in net/ipv4/tcp_ipv4.c]

Seen on linux 2.4.20rc2.

This program is always able to establish new connections to itself:
the accept queue never fills up and connections always succeed
(although they take quite some time after the first four):

  #include <stdio.h>
  #include <sys/types.h>
  #include <sys/socket.h>
  #include <netinet/in.h>

  int main(void)
  {
    int fd;
    struct sockaddr_in sin;
    socklen_t sinlen;

    if ((fd = socket(PF_INET, SOCK_STREAM, 0)) == -1)
      perror("socket"), exit(1);

    sin.sin_family      = AF_INET;
    sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
    sin.sin_port	      = htons(0);
    if (bind(fd, (struct sockaddr*)&sin, sizeof(sin)) == -1)
      perror("bind"), exit(1);
    if (listen(fd, 1) == -1)
      perror("listen"), exit(1);

    sinlen = sizeof(sin);
    getsockname(fd, (struct sockaddr*)&sin, &sinlen);

    while (1)
      {
        int fdc;

        if ((fdc = socket(PF_INET, SOCK_STREAM, 0)) == -1)
  	perror("socket"), exit(1);
        printf("%c", connect(fdc, (struct sockaddr*)&sin, sinlen) == -1
  	     ? 'F' : '.');
        fflush(stdout);
      }

    exit(0);
  }

I've tried enabling and disabling tcp_syncookies, without any effect.

The same program starts returning errors after two successful connects
on Solaris and one on HP-UX. Linux keeps returning new connections...

Phil.
