Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318352AbSGaNPE>; Wed, 31 Jul 2002 09:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318368AbSGaNPE>; Wed, 31 Jul 2002 09:15:04 -0400
Received: from sunny.pacific.net.au ([203.25.148.40]:5579 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S318352AbSGaNPD>; Wed, 31 Jul 2002 09:15:03 -0400
From: "David Luyer" <david@luyer.net>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Date: Wed, 31 Jul 2002 23:18:10 +1000
Message-ID: <00c501c23894$b774de00$638317d2@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <1028125599.7886.68.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2002-07-31 at 13:59, David Luyer wrote:
> >   printf("%d\n", sysconf(_SC_NPROCESSORS_CONF));
> > }
> > luyer@praxis8:~$ ./cpus
> > 4
> > luyer@praxis8:~$ grep 'processor        ' /proc/cpuinfo
> > processor       : 0
> > processor       : 1
> 
> In which case I suggest you file a glibc bug. sysconf looks 
> at the /proc stuff as I understand it

Great, got it, thanks: sysconf(_SC_NPROCESSORS_CONF) parses
/proc/cpuinfo
using a simple parser:

#ifndef GET_NPROCS_PARSER
# define GET_NPROCS_PARSER(FP, BUFFER, RESULT)
\
  do
\
    {
\
      (RESULT) = 0;
\
      /* Read all lines and count the lines starting with the string
\
         "processor".  We don't have to fear extremely long lines since
\
         the kernel will not generate them.  8192 bytes are really
\
         enough.  */
\
      while (fgets_unlocked (BUFFER, sizeof (BUFFER), FP) != NULL)
\
        if (strncmp (BUFFER, "processor", 9) == 0)
\
          ++(RESULT);
\
    }
\
  while (0)
#endif

It's being tricked by this:

luyer@praxis8:~$ cat /proc/cpuinfo | grep '^processor'
processor       : 0
processor id    : 0
processor       : 1
processor id    : 0

The "processor id" line, only present with SMP enabled, is being counted
as a processor.

David.

