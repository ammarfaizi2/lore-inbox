Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVA2DhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVA2DhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 22:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVA2DhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 22:37:14 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:61891 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S261427AbVA2DhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 22:37:06 -0500
Date: Sat, 29 Jan 2005 05:36:57 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Impossible to renice threaded NPTL programs on 2.6.10
To: linux-kernel@vger.kernel.org
Message-id: <200501290536.59393.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those times when a threaded program runs amok, and I still have
some hope that it will eventually stop being a pig, but would like to
actually use my computer in the meanwhile, the idea of renicing this
runaway program to nice 19 comes to mind.

Except, it doesn't actually work. Only the main thread seems to get
reniced, and the threads created with pthread_create seem to merrily
go on with their plundering of CPU cycles.

Test code at the end of the mail.

To reproduce this, I start the test program, and observe in top that it
is indeed consuming all CPU like it was intended to. Then I renice it
in top, to nice 19. Effect is, '% ni value in top still stays the same, and
these hog threads are still consuming nearly all CPU and not sharing
with other nice 19 processes, indicating that they were not reniced
to 19.

Tested on Fedora Core 2's  kernel 2.6.10-1.9 + procps 3.2.5 from sf.net
Tested on kernel 2.6.10-ck4 + procps 3.2.1

Here for the test case:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#define THREADS 10
void *hog(void*p);
int main(int argc, char** argv)
{
  pthread_t *threads;
  int i;
  threads = malloc(sizeof(pthread_t) * THREADS);
  for(i=0;i<THREADS;i++)
    pthread_create(&threads[i], NULL, hog, NULL);
  fprintf(stderr, "The hogs are loose!\n");
  while(1)
      sleep(3600);
}
void *hog(void*p)
{
  fprintf(stderr, "Oink oink!\n");
  while(1);
}
