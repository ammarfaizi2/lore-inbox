Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbULQIsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbULQIsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 03:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbULQIsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 03:48:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:31198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262781AbULQIgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 03:36:12 -0500
Date: Fri, 17 Dec 2004 00:35:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: linux-kernel@vger.kernel.org, hongjiu.lu@intel.com
Subject: Re: [Patch] Fix a race condition in pty.c
Message-Id: <20041217003549.6bd66810.akpm@osdl.org>
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013CA24@pdsmsx402.ccr.corp.intel.com>
References: <894E37DECA393E4D9374E0ACBBE7427013CA24@pdsmsx402.ccr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zou, Nanhai" <nanhai.zou@intel.com> wrote:
>
>  <<pty_close-race-fix.patch>> There is a race condition int pty.c 
>  when pty_close wakes up waiter on its pair device before set
>  TTY_OTHER_CLOSED flag.
> 
>  It is possible on SMP or preempt kernel, waiter wakes up too early that
>  it will not get TTY_OTHER_CLOSED flag then fall into sleep again.
> 
>  Lu hong jiu report this bug will hang some expect scripts on SMP
>  machines.

The patch looks good (apart from the application/octet-stream encoding.  grr.)

But on my test box it still doesn't fix the testcase which hj attached to
bug 3894:

select (3) returns: 1
Read -1 characters.
errno: Input/output error
334
select (3) returns: 1
Read -1 characters.
errno: Input/output error
335

In fact the same happens on a non-preempt uniprocessor kernel, so I must be
seeing something different.

#include <sys/types.h> 
#include <sys/select.h>
#include <stdio.h>
#include <unistd.h>
#include <pty.h>

int
main ()
{
  pid_t pid;
  int fd;
  char slave_name [20];
  char buffer [1000];
  int count;
  fd_set readfds;
  int ret;

  pid = forkpty (&fd, slave_name, NULL, NULL);
  switch (pid)
    {
    case 0: /* Child process. */     
      if (execlp ("true", "true", NULL))
	perror ("execlp");
      return 1;
      break;

    default: /* Parent process. */
      break;
    } 

  FD_ZERO (&readfds);
  FD_SET (fd, &readfds);
  ret = select (1024, &readfds, NULL, NULL, NULL);
  printf ("select (%d) returns: %d\n", fd, ret);
  if (ret < 0)
    perror ("select");
  else if (FD_ISSET (fd, &readfds))
    {
      count = read (fd, buffer, 999);
      printf ("Read %d characters.\n", count);
      perror("errno");
    }
  return 0;
}

