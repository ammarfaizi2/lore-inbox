Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSFYQcs>; Tue, 25 Jun 2002 12:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSFYQcr>; Tue, 25 Jun 2002 12:32:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:65248 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315593AbSFYQcq>; Tue, 25 Jun 2002 12:32:46 -0400
Date: Tue, 25 Jun 2002 11:30:52 -0500
From: Amos Waterland <apw@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: O_ASYNC question
Message-ID: <20020625113052.A7510@kvasir.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The man page for fcntl() says:

    If you set the O_ASYNC status flag on a file descriptor (either by
    providing this flag with the open(2) call, or by using the F_SETFL
    command of fcntl), a SIGIO signal is sent whenever input or output
    becomes possible on that file descriptor.

On a 2.4.18 kernel, this test program waits forever in sigwaitinfo():

    #include <fcntl.h>
    #include <signal.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <unistd.h>

    int main(int argc, char *argv[])
    {
      const int BYTES = 5000000;
      int i, fd;
      char buff[BYTES];
      char name[] = "/tmp/aio8.XXXXXX";
      sigset_t sigset;
      siginfo_t siginfo;

      if ((fd = open(name, O_CREAT|O_WRONLY|O_NONBLOCK|O_ASYNC, 0600)) < 0 ||
          unlink(name)) {
        perror("creating temp file"); exit(1);
      }

      for (i = 0; i < BYTES; i++) buff[i] = 'Z';

      if (sigemptyset(&sigset) || sigaddset(&sigset, SIGIO) ||
          sigprocmask(SIG_BLOCK, &sigset, NULL)) {
        perror("setting up signal mask"); exit(2);
      }

      if (write(fd, buff, BYTES) < 0) {
        perror("writing to temp file"); exit(3);
      }

      printf("recv sig: %i\n", sigwaitinfo(&sigset, &siginfo));

      return 0;
    }

Shouldn't SIGIO be raised when the write() completes?  (Is O_ASYNC only
valid for sockets, maybe?)  Thanks in advance.

Amos Waterland
