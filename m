Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVFJWbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVFJWbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVFJWbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:31:40 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:14860 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261292AbVFJWaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:30:00 -0400
Date: Sat, 11 Jun 2005 00:26:45 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Alastair Poole <alastair@unixtrix.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Unusual TCP Connect() results.
Message-ID: <20050610222645.GA1317@pcw.home.local>
References: <42A8ABDB.6080804@unixtrix.com> <42A9B193.1020602@stud.feec.vutbr.cz> <42A9C607.4030209@unixtrix.com> <42A9BA87.4010600@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A9BA87.4010600@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just tried right here with a simpler prog which only connects to its
previously bound socket (prog at the end).

After the bind(), the socket still does not appear in netstat (normal),
but right after the connect() call, the socket appears as established.

It is documented in RFC793 (p30) as the simultaneous connection initation
from 2 clients, although this mode has never been implemented by any
mainline OS (to my knowledge) as it has no real use and poses security
problems (eases spoofing a lot). Moreover, stateful firewalls don't
support it at all for the same reasons. I think that this mode was
designed for point-to-point connections such as TCP over serial lines
or things like this.

Interestingly, the network capture on the 'lo' interface shows that the
protocol does not even match the case above, as it only shows the standard
SYN-SYN/ACK-ACK mechanism and not the dual, simultaneous one :

$ sudo tcpdump -Svvni lo tcp
tcpdump: listening on lo, link-type EN10MB (Ethernet), capture size 96 bytes
00:04:03.688649 IP (tos 0x0, ttl  64, id 45241, offset 0, flags [DF], length: 60) 127.0.0.1.10000 > 127.0.0.1.10000: S [tcp sum ok] 1675767716:1675767716(0) win 32767 <mss 16396,sackOK,timestamp 2727709 0,nop,wscale 2>

00:04:03.688665 IP (tos 0x0, ttl  64, id 45243, offset 0, flags [DF], length: 60) 127.0.0.1.10000 > 127.0.0.1.10000: S [tcp sum ok] 1675767716:1675767716(0) ack 1675767717 win 32767 <mss 16396,sackOK,timestamp 2727709 2727709,nop,wscale 2>

00:04:03.688693 IP (tos 0x0, ttl  64, id 45245, offset 0, flags [DF], length: 64) 127.0.0.1.10000 > 127.0.0.1.10000: . [tcp sum ok] 1675767717:1675767717(0) ack 1675767717 win 8192 <nop,nop,timestamp 2727709 2727709,nop,nop,sack sack 1 {1675767716:1675767717} >

=> connection is ESTABLISHED

00:04:06.479729 IP (tos 0x0, ttl  64, id 45247, offset 0, flags [DF], length: 52) 127.0.0.1.10000 > 127.0.0.1.10000: F [tcp sum ok] 1675767717:1675767717(0) ack 1675767717 win 8192 <nop,nop,timestamp 2730501 2727709>

00:04:06.479781 IP (tos 0x0, ttl  64, id 45249, offset 0, flags [DF], length: 52) 127.0.0.1.10000 > 127.0.0.1.10000: . [tcp sum ok] 1675767718:1675767718(0) ack 1675767718 win 8192 <nop,nop,timestamp 2730501 2730501>

=> connection is TIME_WAIT.

It's even easier to test with netcat, which produces the same output :

   $ nc -s 127.0.0.1 -p 10000 127.0.0.1 10000

It works for any local address bound to any other interface :

   $ nc -s 10.0.0.1 -p 10000 10.0.0.1 10000

A test with hping2 between the bind() and connect() calls shows that the
connection is refused. I don't know if there's even a small window during
the connect() call during which external (spoofed) packets could validate
a connection. Even very fast local connections do not manage to steal a
connection in progress. All we can say is that it's very strange...

$ sudo hping2 -c 1 -k -a 10.0.0.1 -s 80 -I lo 10.0.0.1 -p 80 -S -M 12345678
//
$ sudo tcpdump -Svvni lo tcp
tcpdump: listening on lo, link-type EN10MB (Ethernet), capture size 96 bytes
00:16:58.274961 IP (tos 0x0, ttl  64, id 63368, offset 0, flags [none], length:
40) 10.0.0.1.80 > 10.0.0.1.80: S [tcp sum ok] 12345678:12345678(0) win 512
00:16:58.275152 IP (tos 0x0, ttl  64, id 11, offset 0, flags [DF], length: 40) 10.0.0.1.80 > 10.0.0.1.80: R [tcp sum ok] 0:0(0) ack 12345679 win 0


Regards,
Willy

--

// Annex: simple connection program.

#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define MY_PORT 10000

int
main(int argc, char *argv[])
{
  int fd;
  int val;
  struct sockaddr_in addr;

  if ((fd = socket(PF_INET, SOCK_STREAM, 0)) < 0
      || setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof val) < 0) {
    perror("socket()");
    return 1;
  }

  addr.sin_family = AF_INET;
  addr.sin_port = htons(MY_PORT);
  addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
  memset(addr.sin_zero, 0, sizeof (addr.sin_zero));

  if (bind(fd, (struct sockaddr *)&addr, sizeof (addr)) < 0) {
    perror("bind()");
    return 1;
  }
  printf("bind ok. Press a key to continue.\n"); getchar();

  if (connect(fd, (struct sockaddr *)&addr, sizeof (addr)) < 0) {
    perror("connect()");
    return 1;
  }
  printf("connected! Press a key to continue.\n"); getchar();

  return 0;
} 


