Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbTDGCWe (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 22:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTDGCWe (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 22:22:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6919 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263194AbTDGCWd (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 22:22:33 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new syscall: flink
Date: 6 Apr 2003 19:33:46 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6qo2a$ecl$1@cesium.transmeta.com>
References: <3E907A94.9000305@kegel.com> <200304062156.37325.oliver@neukum.org> <1049663559.1602.46.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1049663559.1602.46.camel@dhcp22.swansea.linux.org.uk>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> It is actually rather more complicated. Suppose I give you a pipe
> pair handle. You can flink what was a private object and has no
> meaning as a name.
> 
> Suppose I give you a socket what does the call man ?
> 
> Suppose I give you a handle to an anonymous mapping ?
> 

-EXDEV

> Suppose I give you a handle to data, how do you know what disk
> it belongs to ?

f_ino->i_sb should give you that information.

> Suppose I give you an O_RDONLY handle to a file which you then
> flink and gain write access too ?

This, I believe, is the real issue.  However, we already have that
problem:

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <limits.h>

int main(int argc, char *argv[])
{
  int rfd, wfd;
  char filebuf[PATH_MAX];

  rfd = open("testfile", O_RDONLY|O_CREAT, 0666);
  /* Now rfd is a read-only file descriptor */

  sprintf(filebuf, "/proc/self/fd/%d", rfd);
  wfd = open(filebuf, O_RDWR);
  /* Now wfd is a read-write file descriptor */

  write(wfd, "Tjo fidelittan hatt!\n", 21);

  return 0;
}


	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
