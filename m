Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTDGFO3 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 01:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263261AbTDGFO3 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 01:14:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7174 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263259AbTDGFO2 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 01:14:28 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new syscall: flink
Date: 6 Apr 2003 22:25:51 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6r24v$f50$1@cesium.transmeta.com>
References: <3E907A94.9000305@kegel.com> <200304062156.37325.oliver@neukum.org> <1049663559.1602.46.camel@dhcp22.swansea.linux.org.uk> <b6qo2a$ecl$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <b6qo2a$ecl$1@cesium.transmeta.com>
By author:    "H. Peter Anvin" <hpa@zytor.com>
In newsgroup: linux.dev.kernel
> 
> This, I believe, is the real issue.  However, we already have that
> problem:
> 

[Sample code]

Here is a better piece of sample code that actually shows a
permissions violation happening:

[...]
mkdir("testdir", 0700)                  = 0
open("testdir/testfile", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
write(3, "Ansiktsburk\n", 12)           = 12
close(3)                                = 0
open("testdir/testfile", O_RDONLY)      = 3
chmod("testdir", 0)                     = 0
open("/proc/self/fd/3", O_RDWR)         = 4
write(4, "Tjo fidelittan hatt!\n", 21)  = 21
exit_group(0)                           = ?

----snip----

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <limits.h>

int main(int argc, char *argv[])
{
  int sfd, rfd, wfd;
  char filebuf[PATH_MAX];

  mkdir("testdir", 0700);

  /* Create the file legitimately */
  sfd = open("testdir/testfile", O_WRONLY|O_CREAT|O_TRUNC, 0666);
  write(sfd, "Ansiktsburk\n", 12);
  close(sfd);

  /* Open read-only file descriptor */
  rfd = open("testdir/testfile", O_RDONLY);

  /* Make directory inaccessible */
  chmod("testdir", 0);

  /* Open read-write file descriptor */
  sprintf(filebuf, "/proc/self/fd/%d", rfd);
  wfd = open(filebuf, O_RDWR);

  /* Clobber file */
  write(wfd, "Tjo fidelittan hatt!\n", 21);

  return 0;
}
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
