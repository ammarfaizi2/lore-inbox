Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSGFT7j>; Sat, 6 Jul 2002 15:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSGFT7i>; Sat, 6 Jul 2002 15:59:38 -0400
Received: from adsl-65-69-128-164.dsl.rcsntx.swbell.net ([65.69.128.164]:1279
	"EHLO keyser.soze.net") by vger.kernel.org with ESMTP
	id <S315856AbSGFT7h>; Sat, 6 Jul 2002 15:59:37 -0400
Date: Sat, 6 Jul 2002 20:02:14 +0000
From: Justin Guyett <justin@soze.net>
To: linux-kernel@vger.kernel.org
Subject: dead processes in 2.4.7-10smp and 2.4.19-rc1 (percraid problem?)
Message-ID: <20020706200214.GB12813@dreams.soze.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: 9AE2 9FC3 D98B 9AE2 EE83  15CC 9C7D 1925 4568 5243
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An smp + percraid machine that was running fine with 2.2 kernels was
recently reinstalled (rh 7.2).  Now a variety of processes like cp,
mv, chmod, mail, and even a simply constructed program[1] (just
created to verify there wasn't something broken with the other
programs) occassionally (probably 20% of the time or less) stick
around indefinately as a pair[2] of process entries.  This happens
with all combinations I've tried:

2.4.7-10smp (rpm) + glibc-2.2.4-24 (rpm)
2.4.19-rc1 + glibc 2.2.4-24 (rpm)
2.4.19-rc1 + glibc 2.2.5

Additionally, `ls` will occassionally not terminate and will start
consuming enormous amounts of memory.  I haven't gotten a process
trace of this, yet.

The entire boot log and process trace is at http://www.soze.net/bootlog.txt
The bit below ([2]) is in broken.txt, and the .config is named broken.config

[1]
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
int main(int argc, char **argv) {
  int fd;
  fd = open("./test.test", O_RDWR | O_CREAT | O_NONBLOCK);
  if (fd == -1) {
    perror("unable to open file");
    exit(1);
  }
  write(fd, "test", 4);
  close(fd);
  fd = unlink("./test.test");
  return(0);
}


[2]
Jul  6 14:38:55 broken kernel: chmod         T F7547500  5772   179 1   185     210   138 (NOTLB)
Jul  6 14:38:55 broken kernel: Call Trace: [do_signal+166/688] [dev_ifsioc+31/1104] [sock_ioctl+63/128] [sys_ioctl+193/527] [signal_return+20/24]
Jul  6 14:38:55 broken kernel: chmod         Z F75475A0  5840   185 179                     (L-TLB)
Jul  6 14:38:55 broken kernel: Call Trace: [do_exit+711/768] [sig_exit+195/208] [dequeue_signal+100/208] [do_signal+450/688] [sock_write+174/208]
Jul  6 14:38:55 broken kernel:    [sys_write+265/352] [signal_return+20/24]

