Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTJHQJZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 12:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTJHQJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 12:09:25 -0400
Received: from odalix.ida.liu.se ([130.236.186.10]:15531 "EHLO
	odalix.ida.liu.se") by vger.kernel.org with ESMTP id S261732AbTJHQJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 12:09:22 -0400
Date: Wed, 8 Oct 2003 18:09:19 +0200
From: Magnus Andersson <magan029@student.liu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 O_DIRECT memory leak?!?
Message-ID: <20031008180919.A6172@student.liu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

If I open one file a lot of times using the flag O_DIRECT,
memory seems to be be lost and never given back to the system.
This is happening on some kernels, see below for which ones I tried.

Attached program will produce this behavior, also attached 
is the output from vmstat while running the program.

Affected:
2.4.22
2.4.22-ac4
2.4.23-pre6

Not affected:
2.4.22-aa1
2.6.0-test6

/Magnus

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="open_odirect.c"

#define _GNU_SOURCE

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

#define NFDS 1000

#define ERR(args...) fprintf(stderr, args);

int main()
{
  int i, fds[NFDS];

  for(i = 0; i < NFDS; i++) {
    if((fds[i] = open("./file", O_RDONLY | O_DIRECT)) < 0) {
      ERR("main(): open(): %s\n", strerror(errno));
      exit(1);
    }
  }
  
  for(i = 0; i < NFDS; i++) {
    if(close(fds[i]) < 0) {
      ERR("main(): close(): %s\n", strerror(errno));
      exit(1);
    }
  }
}

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vmstat.output"

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 498324    916   7632    0    0    54     9  109    22  1 19 80  0
 0  0      0 498320    916   7632    0    0     0     0  101     2  0  0 100  0
 0  0      0 498320    916   7632    0    0     0     0  101     2  0  0 100  0
 0  0      0 498320    916   7632    0    0     0     0  101     2  0  0 100  0
 0  0      0 498320    916   7632    0    0     0     0  101     2  0  0 100  0
 1  0      0 485072    916   7632    0    0     0     0  104    11  0  6 94  0
 0  0      0 386276    916   7632    0    0     0     0  116     7  0 41 59  0
 0  0      0 386276    916   7632    0    0     0     0  101     2  0  0 100  0
 0  0      0 386276    916   7632    0    0     0     0  101     2  0  0 100  0
 0  0      0 386276    916   7632    0    0     0     0  101     2  0  0 100  0

--Kj7319i9nmIyA2yE--
