Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319110AbSHFNBq>; Tue, 6 Aug 2002 09:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319115AbSHFNBq>; Tue, 6 Aug 2002 09:01:46 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:14216 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S319110AbSHFNBp>; Tue, 6 Aug 2002 09:01:45 -0400
Date: Tue, 6 Aug 2002 15:04:47 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-Id: <20020806150447.2af350b0.us15@os.inf.tu-dresden.de>
In-Reply-To: <200208061253.g76CrOT05986@karaya.com>
References: <20020806131356.61ece6ca.us15@os.inf.tu-dresden.de>
	<200208061253.g76CrOT05986@karaya.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Aug 2002 08:53:24 -0400
Jeff Dike <jdike@karaya.com> wrote:

> > On iret it would have to change ownership of the socket to another
> > task, i.e. process with kernel_pid wants to set task_pid as the owner
> > of the socket. The above code fragment doesn't permit this, as far as
> > I can see.
> 
> Why not?  There is nothing there that prevents that.

In the following code the parent (i.e. kernel) tries to set the child (i.e. task)
as owner for the socket. Does this work for you? It doesn't for me, for the
reason I described earlier.

#include <sys/types.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <unistd.h>

int main (void) {

  int sockets[2], flags;
  pid_t pid;

  if (socketpair (AF_UNIX, SOCK_STREAM, 0, sockets)) {
    perror ("socketpair");
    return -1;
  }

  switch (pid = fork ()) {

    case -1:
      perror ("fork");
      return -1;

    case 0:
      pause ();

    default:
      if ((flags = fcntl (sockets[0], F_GETFL)) < 0) {
        perror ("fcntl, GETFL");
        return -1;
      }
      if (fcntl (sockets[0], F_SETFL, flags | O_NONBLOCK | O_ASYNC) < 0) {
        perror ("fcntl, SETFL");
        return -1;
      }
      if (fcntl (sockets[0], F_SETOWN, pid) < 0) {
        perror ("fcntl, SETOWN");
        return -1;
      }
  }

  return 0;
}
