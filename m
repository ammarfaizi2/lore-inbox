Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWCNPdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWCNPdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWCNPdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:33:51 -0500
Received: from tag.witbe.net ([81.88.96.48]:60107 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S1751836AbWCNPdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:33:51 -0500
From: "Paul Rolland" <rol@witbe.net>
To: "'Robert Hancock'" <hancockr@shaw.ca>,
       "'Herbert Rosmanith'" <kernel@wildsau.enemy.org>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: procfs uglyness caused by "cat"
Date: Tue, 14 Mar 2006 16:33:28 +0100
Organization: Witbe.net
Message-ID: <001901c6477c$a46b4c90$b600a8c0@cortex>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcZHdJd9xrGCC+FSR3uigoeLHs89UwAAj36w
In-Reply-To: <4416D4A3.9070705@shaw.ca>
x-ncc-regid: fr.witbe
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > static int uptime_read_proc(char *page, char **start, off_t off,
> >                                  int count, int *eof, void *data)
> > {
> >         struct timespec uptime;
> >         struct timespec idle;
> >         int len;
> >         cputime_t idletime;
> > 
> > +	if (off)
> > +		return 0;
> 
> Except that this is wrong - if you try to advance the offset 
> a bit from 
> the start of the file and read something, you'll get nothing. This is 
> inconsistent with normal file behavior.

Right... What's weird is : what do we get if a process decides to read
this using a 1 byte buffer, asking for 1 char at a time ?
And what we'll be the result if you read 1 char every 1 second ?

#include <stdio.h>

int main(int argc, char * argv[])
{
  FILE * f;
  char lChar;

  f = fopen("/proc/uptime", "r");
  if (f == NULL) {
    exit(0);
  } /* endif */

  while (!feof(f)) {
    fread(&lChar, 1, 1, f);
    fprintf(stdout, "%c", lChar); fflush(stdout);
    sleep(1);
  } /* endwhile */

  close(f);

  exit(0);
}

is funny enough...

2.2.x :
58 [15:30] rol@www-dev:/tmp> cat /proc/uptime ; ./test
13849305.25 13555633.92
13849312.38 13555635.64

2.4.31 :
bash-2.05# cat /proc/uptime ; ./test
100711.77 100366.30
100711.77 100366.30

Paul

