Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130321AbRBAS3b>; Thu, 1 Feb 2001 13:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130291AbRBAS3V>; Thu, 1 Feb 2001 13:29:21 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.138.204]:61714 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S130321AbRBAS2v>; Thu, 1 Feb 2001 13:28:51 -0500
Date: Thu, 1 Feb 2001 18:28:45 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
cc: <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: Serious reproducible 2.4.x kernel hang
In-Reply-To: <20010201165247.D27009@sable.ox.ac.uk>
Message-ID: <Pine.LNX.4.30.0102011826060.397-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[cc: davem because of the severity]

On Thu, 1 Feb 2001, Malcolm Beattie wrote:

> rid of the hang. So it looks as though some combination of
> shutdown(2) and SIGABRT is at fault. After the hang the kernel-side

Nope - I've nailed it to a _really_ simple test case. It looks like a
read() on a shutdown() unix dgram socket just kills the kernel. Demo code
below. I wonder if this affects UP or is SMP only?

Malcolm, does the below code reproduce the problem for you?

Cheers
Chris

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>

int
main(int argc, const char* argv[])
{
  int retval;
  int sockets[2];
  char buf[1];

  retval = socketpair(PF_UNIX, SOCK_DGRAM, 0, sockets);
  if (retval != 0)
  {
    perror("socketpair");
    exit(1);
  }
  shutdown(sockets[0], SHUT_RDWR);
  read(sockets[0], buf, 1);
}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
