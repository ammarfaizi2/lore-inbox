Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312425AbSDEJu5>; Fri, 5 Apr 2002 04:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312431AbSDEJus>; Fri, 5 Apr 2002 04:50:48 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:20964 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S312425AbSDEJuk>; Fri, 5 Apr 2002 04:50:40 -0500
Date: Fri, 5 Apr 2002 11:50:39 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: socket write(2) after remote shutdown(2) problem ?
Message-ID: <20020405095038.GB16595@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Is the following behaviour correct on a tcp connection: 
	* the server issues a shutdown(sock, RW)
	* the client side socket passes in CLOSE-WAIT state
	* the client issues a write on the socket which succeds.

I expected the last write to fail, since the other side is not
capable any more to receive data. Can someone confirm to me one
of the following:
	1. behaviour is correct and why.
	2. shutdown is buggy.
	3. write is buggy.

Thanks.

Attached are sample codes for the "server" and the "client". Test
was done on latest 2.4 and 2.5 kernels.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="client.c"

#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/select.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <signal.h>

char buf[1024];

int main()
{
  int fd;
  char * ptr;
  struct sockaddr_in addr;
  int ready = 0;
  fd_set rfds, efds;
  int nread;

  /* establish connection */

  fd = socket (PF_INET, SOCK_STREAM, 0);
  if ( -1 == fd) {
    perror ("socket");
    exit (1);
  }

  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = htonl (INADDR_ANY);
  addr.sin_port = 0;
  if (bind (fd, (struct sockaddr*)&addr, sizeof (struct sockaddr_in)) != 0) {
    perror ("bind");
    exit (1);
  }

  ptr = (char*)&addr.sin_addr.s_addr;
  /*  ptr[0] = 162; ptr[1] = 0; ptr[2] = 120; ptr[3] = 98;*/
  ptr[0] = 127; ptr[1] = 0; ptr[2] = 0; ptr[3] = 1;
  addr.sin_port = htons(9999);
  if (connect (fd, (struct sockaddr*)&addr, sizeof(addr)) != 0) {
    perror ("connect");
    exit (1);
  }
  
  FD_ZERO (&rfds);
  FD_SET (fd, &rfds);
  select (fd+1, &rfds, 0, 0, 0);

  /* read everything from socket and print it to stdout */

  while (!ready) {
    struct timeval tv;

    FD_ZERO (&rfds);
    FD_SET (fd, &rfds);
    FD_ZERO (&efds);
    FD_SET (fd, &efds);
    memset (&tv, 0, sizeof(tv));

    switch (select (fd+1, &rfds, 0, &efds, &tv)) {
    case -1:
      perror("select");
      exit (1);
    case 0:
      ready = 1;
      break;
    case 1:
      if (FD_ISSET (fd, &efds)) {
	fprintf (stderr, "select found exception");
      }
      nread = read (fd, &buf, 1024);
      if (nread == 0)
	ready = 1;
      else
	write (1, &buf, nread);
      break;
    }
  }

  /* here lsof will show CLOSE_WAIT */
  raise (SIGSTOP);

{
int ret;

  if ((ret = write (fd, "QUIT\n", 5)) == -1) {
    perror ("write");
    exit (1);
  }
  printf("write ok, ret=%d\n", ret);
}

  /* here the socket is orphaned, after write succeeded */
  raise (SIGSTOP);

  return 0;
}

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="server.c"

#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/select.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <signal.h>

char buf[1024];

int main()
{
  int fd, conn;
  struct sockaddr_in addr;
  socklen_t size;

  /* get socket to client, listening on 9999 */

  fd = socket (PF_INET, SOCK_STREAM, 0);
  if ( -1 == fd) {
    perror ("socket");
    exit (1);
  }

  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = htonl (INADDR_ANY);
  addr.sin_port = htons(9999);
  if (bind (fd, (struct sockaddr*)&addr, sizeof (struct sockaddr_in)) != 0) {
    perror ("bind");
    exit (1);
  }

  if (-1 == listen (fd, 1)) {
    perror ("listen");
    exit (1);
  }

  if (-1 == (conn = accept(fd, (struct sockaddr*)&addr, &size))) {
    perror ("accept");
    exit (1);
  }

  /* send some info */

  if (write (conn, "Hello client !\n", 15) == -1) {
    perror ("write");
    exit (1);
  }

  /* finish */

  if (-1 == shutdown (conn, SHUT_RDWR)) {
    perror ("shutdown");
    exit (1);
  }

  return 0;
}

--lrZ03NoBR/3+SXJZ--
