Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbULQRNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbULQRNU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbULQRNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:13:20 -0500
Received: from fmr13.intel.com ([192.55.52.67]:64191 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262081AbULQRJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:09:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Patch] Fix a race condition in pty.c
Date: Fri, 17 Dec 2004 09:09:15 -0800
Message-ID: <CBDB88BFD06F7F408399DBCF8776B3DC0322102A@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] Fix a race condition in pty.c
Thread-Index: AcTkE3csrMQFe3kxRdGVW9d+Rcfo8wARzH2w
From: "Lu, Hongjiu" <hongjiu.lu@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Dec 2004 17:09:16.0981 (UTC) FILETIME=[23F7B650:01C4E45B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I didn't mention that my testcase hang:

11540 pts/0    S      0:00 ./pty
11541 ?        Zs     0:00 [true] <defunct>

Both parent and child are sleeping. They will never wake up. I updated
my bug report

http://bugzilla.kernel.org/show_bug.cgi?id=3894

with the config file for P4 SMP machine.


H.J. Lu
Intel Corporation


>-----Original Message-----
>From: Andrew Morton [mailto:akpm@osdl.org]
>Sent: Friday, December 17, 2004 12:36 AM
>To: Zou, Nanhai
>Cc: linux-kernel@vger.kernel.org; Lu, Hongjiu
>Subject: Re: [Patch] Fix a race condition in pty.c
>
>"Zou, Nanhai" <nanhai.zou@intel.com> wrote:
>>
>>  <<pty_close-race-fix.patch>> There is a race condition int pty.c
>>  when pty_close wakes up waiter on its pair device before set
>>  TTY_OTHER_CLOSED flag.
>>
>>  It is possible on SMP or preempt kernel, waiter wakes up too early
>that
>>  it will not get TTY_OTHER_CLOSED flag then fall into sleep again.
>>
>>  Lu hong jiu report this bug will hang some expect scripts on SMP
>>  machines.
>
>The patch looks good (apart from the application/octet-stream encoding.
>grr.)
>
>But on my test box it still doesn't fix the testcase which hj attached
>to
>bug 3894:
>
>select (3) returns: 1
>Read -1 characters.
>errno: Input/output error
>334
>select (3) returns: 1
>Read -1 characters.
>errno: Input/output error
>335
>
>In fact the same happens on a non-preempt uniprocessor kernel, so I
>must be
>seeing something different.
>
>#include <sys/types.h>
>#include <sys/select.h>
>#include <stdio.h>
>#include <unistd.h>
>#include <pty.h>
>
>int
>main ()
>{
>  pid_t pid;
>  int fd;
>  char slave_name [20];
>  char buffer [1000];
>  int count;
>  fd_set readfds;
>  int ret;
>
>  pid = forkpty (&fd, slave_name, NULL, NULL);
>  switch (pid)
>    {
>    case 0: /* Child process. */
>      if (execlp ("true", "true", NULL))
>	perror ("execlp");
>      return 1;
>      break;
>
>    default: /* Parent process. */
>      break;
>    }
>
>  FD_ZERO (&readfds);
>  FD_SET (fd, &readfds);
>  ret = select (1024, &readfds, NULL, NULL, NULL);
>  printf ("select (%d) returns: %d\n", fd, ret);
>  if (ret < 0)
>    perror ("select");
>  else if (FD_ISSET (fd, &readfds))
>    {
>      count = read (fd, buffer, 999);
>      printf ("Read %d characters.\n", count);
>      perror("errno");
>    }
>  return 0;
>}

