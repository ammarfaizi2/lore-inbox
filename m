Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129288AbRBBCDb>; Thu, 1 Feb 2001 21:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129548AbRBBCDV>; Thu, 1 Feb 2001 21:03:21 -0500
Received: from ns1.BayNetworks.COM ([134.177.3.20]:24983 "EHLO
	baynet.baynetworks.com") by vger.kernel.org with ESMTP
	id <S129288AbRBBCDJ>; Thu, 1 Feb 2001 21:03:09 -0500
From: "Paul D. Smith" <pausmith@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14970.5436.897143.934189@lemming.engeast.baynetworks.com>
Date: Thu, 1 Feb 2001 21:02:36 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SO_REUSEADDR redux
In-Reply-To: <E14OSOC-0005FD-00@the-village.bc.nu>
In-Reply-To: <14969.57896.331183.374489@lemming.engeast.baynetworks.com>
	<E14OSOC-0005FD-00@the-village.bc.nu>
X-Mailer: VM 6.89 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

%% Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

  >> This application uses SO_REUSEADDR in conjunction with INADDR_ANY.  What
  >> it does is bind() to INADDR_ANY, then listen().  Then, it proceeds to
  >> bind (but _not_ listen) various other specific addresses.

  ac> That should be ok if its setting SO_REUSEADDR

I agree, and so does Solaris/FreeBSD, but Linux doesn't.  See below for
a test program.  Maybe I'm doing something screwed up.

-------------------------8>< snip ><8-------------------------
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define MY_PORT     10000


int
main(int argc, char *argv[])
{
  int any_fd, this_fd;
  int val = 1;
  struct sockaddr_in addr;

  if ((any_fd = socket(PF_INET, SOCK_STREAM, 0)) < 0
      || fcntl(any_fd, F_SETFL, O_NONBLOCK) < 0
      || setsockopt(any_fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof val) < 0) {
    perror("setup(any)");
    return 1;
  }

  if ((this_fd = socket(PF_INET, SOCK_STREAM, 0)) < 0
      || fcntl(this_fd, F_SETFL, O_NONBLOCK) < 0
      || setsockopt(this_fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof val) < 0) {
    perror("setup(this)");
    return 1;
  }

  addr.sin_family = AF_INET;
  addr.sin_port = MY_PORT;
  memset(addr.sin_zero, 0, sizeof (addr.sin_zero));

  addr.sin_addr.s_addr = INADDR_ANY;

  if (bind(any_fd, (struct sockaddr *)&addr, sizeof (addr)) < 0) {
    perror("bind(any)");
    return 1;
  }

  if (listen(any_fd, 10) < 0) {
    perror("listen(any)");
    return 1;
  }

  addr.sin_addr.s_addr = INADDR_LOOPBACK;

  if (bind(this_fd, (struct sockaddr *)&addr, sizeof (addr)) < 0) {
    perror("bind(this)");
    return 1;
  }

  return 0;
}
-------------------------8>< snip ><8-------------------------

  solaris$ gcc -o reuseaddr{,.c} -lsocket -lnsl
  solaris$ ./reuseaddr

Works.  Now:

  linux$ gcc -o reuseaddr{,.c}
  linux$ ./reuseaddr
  bind(this): Cannot assign requested address

:(  The real code doesn't use LOOPBACK, of course.

This is Linux 2.2.17, but I tried with 2.2.18 too.  I haven't tried
2.4.x.


Thanks...

-- 
-------------------------------------------------------------------------------
 Paul D. Smith <psmith@baynetworks.com>    HASMAT--HA Software Methods & Tools
 "Please remain calm...I may be mad, but I am a professional." --Mad Scientist
-------------------------------------------------------------------------------
   These are my opinions---Nortel Networks takes no responsibility for them.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
