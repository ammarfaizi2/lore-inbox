Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132427AbRCaPpl>; Sat, 31 Mar 2001 10:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132428AbRCaPpd>; Sat, 31 Mar 2001 10:45:33 -0500
Received: from ix.netsoft.ro ([193.226.123.26]:21001 "EHLO ix.netsoft.ro")
	by vger.kernel.org with ESMTP id <S132427AbRCaPpS>;
	Sat, 31 Mar 2001 10:45:18 -0500
From: Radu Greab <radu@netsoft.ro>
Message-ID: <15045.64340.14915.404305@ix.netsoft.ro>
Date: Sat, 31 Mar 2001 18:44:20 +0300 (EEST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CV065puJCK"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: radu@netsoft.ro
Subject: bug report: select on unconnected sockets
X-Mailer: VM 6.75 under 21.1 (patch 4) "Arches" XEmacs Lucid
Organization: NetSoft srl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CV065puJCK
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit


Sorry if this is already known: on a RH 7.0 system with kernel 2.4.2
or 2.4.3, a select on an unconnected socket incorrectly says that the
socket is ready for input and output. Of course, reading from the socket
file descriptor returns -1 and errno is set to ENOTCONN as shown in
the strace output:

socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
select(4, [3], [3], [3], {0, 0})        = 2 (in [3], out [3], left {0, 0})
read(3, 0xbffff668, 1024)               = -1 ENOTCONN (Transport endpoint is not connected)

I attached a small example program to reproduce the bug.


Thanks,
Radu Greab

PS: please CC me your eventual replies as I'm not subscribed to the
list.



--CV065puJCK
Content-Type: text/plain
Content-Description: example program
Content-Disposition: inline;
	filename="t3.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>

int main(int argc, char **argv) {
  fd_set rfds, wfds, efds;
  int s, rc;
  struct timeval timeout;
  char buf[1025];

  s = socket(PF_INET, SOCK_STREAM, 0);
  if (s == -1) {
    perror("couldn't create socket");
    return -1;
  }

  FD_ZERO(&rfds);
  FD_SET(s, &rfds);
  FD_ZERO(&wfds);
  FD_SET(s, &wfds);
  FD_ZERO(&efds);
  FD_SET(s, &efds);
  timeout.tv_sec = timeout.tv_usec = 0;
  rc = select(s + 1, &rfds, &wfds, &efds, &timeout);
  if (rc == -1) {
    perror("select");
    return -1;
  }
  printf("select result=%d\n", rc);
  if (FD_ISSET(s, &rfds)) {
    rc = read(s, buf, 1024);
    if (rc == -1) {
      perror("read");
      return -1;
    }
    printf("read result=%d\n", rc);
  }

  return 0;
}

--CV065puJCK--
