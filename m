Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287591AbSBCTEJ>; Sun, 3 Feb 2002 14:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSBCTEA>; Sun, 3 Feb 2002 14:04:00 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:56806 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S287591AbSBCTDw>;
	Sun, 3 Feb 2002 14:03:52 -0500
Date: Sun, 3 Feb 2002 19:03:44 +0000 (GMT)
From: Matej Pfajfar <mp292@cam.ac.uk>
X-X-Sender: <mp292@red.csi.cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PF_UNIX socket problem in 2.4
In-Reply-To: <E16X5v4-0000H9-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.33.0202031856050.21647-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > After upgrading to kernel 2.4.18pre7 (from 2.2.19), a recv() operation on
> > a UNIX socket returns 11 (EGAIN) even though the socket is blocking. My
> > code worked fine on 2.2.19.
> >
> > I am doing some more debugging to see why this happens but I would like to
> > ask whether anyone else has had similar problems? Is this a known bug?
>
> Not a known one. A small test case would be good
The problem was caused when my code tried to read 0 bytes from a unix
socket (my fault, didn't specifically check for wanting to read 0 bytes,
assumed recv() would just return 0 ...).

When there is no data available, the code blocks. If, however, data is
available, recv() returns EGAIN. Is this correct behaviour? In kernel
2.2.19, recv() did in fact return 0;

Test example below.

Matej

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <sys/types.h>
#include <sys/un.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

int main(int argc, char *argv[])
{
  char buf[1];
  int s;
  int retval;
  struct sockaddr_un server;

  if (argc < 2)
    printf("Usage : test socketname");

  s = socket(PF_UNIX, SOCK_STREAM, 0);
  if (s < 0)
    perror("socket :");
  else
  {
    server.sun_family = PF_LOCAL;
    strncpy(server.sun_path, argv[1], sizeof(server.sun_path));

    if (connect(s,(struct sockaddr *)&server,SUN_LEN(&server)) < 0)
      perror("connect :");
    else
    {
      retval = recv(s,buf,0, 0);
      if (retval < 0)
        perror("recv :");
      else
        printf("Received %u bytes.",retval);

      close(s);
      return 0;
    }
  }
}


Matej Pfajfar
St John's College, University of Cambridge, UK

GPG Public Key @ http://matejpfajfar.co.uk/keys
Most people are good people, the rest of us are going to
run the world. -- badbytes


