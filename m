Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTFINNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 09:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTFINNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 09:13:13 -0400
Received: from engels.cs.rhbnc.ac.uk ([134.219.188.10]:22800 "EHLO
	engels.cs.rhbnc.ac.uk") by vger.kernel.org with ESMTP
	id S264256AbTFINLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 09:11:54 -0400
Date: Mon, 9 Jun 2003 14:25:26 +0100 (BST)
From: Bob Vickers <bobv@cs.rhul.ac.uk>
X-X-Sender: bobv@sartre.cs.rhbnc.ac.uk
Reply-To: Bob Vickers <R.Vickers@cs.rhul.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Locking NFS files on kernels 2.4.19 and 2.4.20
Message-ID: <Pine.OSF.4.44.0306091347560.4682-100000@sartre.cs.rhbnc.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linex kernel developers,

Forgive me for venturing rather nervously onto such an esteemed mailing
list, but I have hit a problem which looks to me very much like a kernel
bug, and much googling has so far failed to come up with any advice.

I have recently upgraded some machines and have found that it is no longer
possible to lock files on NFS file systems. It is definitely a client-side
problem: upgraded clients could no longer lock files on *any* NFS server
(including Tru64 as well as a variety of Linux servers).

If anyone knows of any bugs in this area I would be grateful to hear more.
Here are the details:

The failing clients are all running off-the-shelf SuSE kernels. They
include
	k_smp-2.4.20-40
	k_smp-2.4.19-257
	k_deflt-2.4.20-39
Programs on these clients get an ENOLCK error when they use fcntl with the
f_SETLK option on an NFS file. This blows galeon and other applications
out of the water.

If nobody has a definite solution it would be useful to know whether
others are hitting the same problem. Has anyone got NFS locking to work on
SuSE 8.0 or 8.1 systems? Does it work on non-SuSE 2.4.19 and 2.4.20
kernels?

On one occasion I enabled some NFS debug messages by typing
  echo "217" >|/proc/sys/sunrpc/nlm_debug
and this produced the following log messages (note the suspicious
arguments to xdr_encode_mon):

May 23 17:34:22 castor kernel: lockd: nlm_lookup_host(86dbbc06, p=17, v=4)
May 23 17:34:22 castor kernel: lockd: get host 134.219.188.6
May 23 17:34:22 castor kernel: lockd: nsm_monitor(134.219.188.6)
May 23 17:34:22 castor kernel: nsm: xdr_encode_mon(86dbbc06, -1249509120,
67108864, 268435456)
May 23 17:34:22 castor kernel: lockd: release host 134.219.188.6


Here is the program I used to test locking (you need to touch mylockfile
before running it):

#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>
main()
{
  int fd, stat;
  struct flock lck;
  lck.l_type = F_WRLCK;   /* setting a write lock */
  lck.l_whence = 0;       /* offset l_start from beginning of file */
  lck.l_start = 0;
  lck.l_len = 1;
  fd=open("mylockfile", O_RDWR, 0);
  if ( fd < 0 )
  {
    perror ("Open failed");
  }
  else
  {
    stat=fcntl (fd, F_SETLK, &lck);
    if ( stat == -1 )
    {
      perror ("SETLK failed");
    }
    else
    {
      printf ("SETLK worked\n");
    }
  }
}

Regards,
Bob
==============================================================
Bob Vickers                     R.Vickers@cs.rhul.ac.uk
Dept of Computer Science, Royal Holloway, University of London
WWW:    http://www.cs.rhul.ac.uk/home/bobv
Phone:  +44 1784 443691

