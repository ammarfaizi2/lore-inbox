Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131194AbRCKCUf>; Sat, 10 Mar 2001 21:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131196AbRCKCUZ>; Sat, 10 Mar 2001 21:20:25 -0500
Received: from s057.dhcp212-109.cybercable.fr ([212.198.109.57]:62728 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131194AbRCKCUP>; Sat, 10 Mar 2001 21:20:15 -0500
Message-ID: <3AAAE073.4C18B7F8@baretta.com>
Date: Sun, 11 Mar 2001 03:18:27 +0100
From: Alex Baretta <alex@baretta.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible bug with poll syscall
In-Reply-To: <3AAA2ADE.E8FF41E3@baretta.com> <3AAA5273.67DC90EF@baretta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Baretta wrote:
> 
> Alex Baretta wrote:
> >
> > I am using poll with the POLLIN flag to wait for connection
> > requests on a set of listening sockets in a server process.
> > Although clients attempt to connect to those sockets, poll does
> > returns zero after the expiration of the timeout.
...

There was a bug in my code. I am unable to find it, but I wrote a
minimal to case to prove my point, and actually I proved myself
wrong. Test case follows. If I ever find the time I'll try to
experiment and discover why in "the real thing" poll did not work
for me.


#include <sys/poll.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>

int main(int argc, char **argv) {
  struct pollfd fds;
  int res1, res2, nevents;
  struct sockaddr_in sockaddr;

  fds.fd = socket(PF_INET, SOCK_STREAM, 0);
  fds.events = POLLIN;
  
  
  sockaddr.sin_family = AF_INET;
  sockaddr.sin_addr.s_addr = htonl(INADDR_ANY);
  sockaddr.sin_port = htons(50000);
  
  res1 = bind(fds.fd, (struct sockaddr *)&sockaddr,
sizeof(sockaddr));
  res2 = listen(fds.fd, 20);

  if (fds.fd == -1 || res1 == -1 || res2 == -1) {
    fprintf(stderr, "The program failed miserably.\n");
    exit(1);
  }
  
  fprintf(stderr, "I'm about to suspend myself on a poll
syscall!\n");
  nevents = poll(&fds, 1, -1);
  fprintf(stderr, "Waking up: nevents = %d\n", nevents);
  
  return 0;
};
