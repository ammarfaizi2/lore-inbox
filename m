Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRJPLlF>; Tue, 16 Oct 2001 07:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275994AbRJPLkp>; Tue, 16 Oct 2001 07:40:45 -0400
Received: from elin.scali.no ([62.70.89.10]:41743 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S275990AbRJPLkg>;
	Tue, 16 Oct 2001 07:40:36 -0400
Subject: Q: A reliable way of testing if O_DIRECT is supported
From: Terje Eggestad <terje.eggestad@scali.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 16 Oct 2001 13:41:07 +0200
Message-Id: <1003232468.1964.6.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a reliable way of testing if O_DIRECT is supported by the
kernel?

I've a test program as follows:

======================================================================
#include <errno.h>
#include <unistd.h>

#define __USE_GNU
#include <fcntl.h>

int main()
{
  int fd, flags, rc;
  char * buffer;

  buffer = (char *) malloc(getpagesize()*2);
  buffer = (char *) (((long)buffer) / getpagesize() * getpagesize()) +
getpagesize();
  fd = open ("/tmp/checkdirect.dat", O_RDWR|O_CREAT|O_TRUNC|O_DIRECT,
0600);
  if (fd == -1) {
    printf("open failed with errno=%d\n", errno);
    exit(errno);
  };

  printf("open OK\n", errno);
  unlink ("/tmp/checkdirect.dat");

  flags = fcntl(fd, F_GETFL);	
  printf("fcntl(fd, F_GETFL) retuned %#o \n", flags);

  printf("setting O_DIRECT(=%#o) flag with fcntl()\n", O_DIRECT);
  fcntl(fd, F_SETFL, O_DIRECT|flags);	

  flags = fcntl(fd, F_GETFL);	
  printf("fcntl(fd, F_GETFL) retuned %#o \n", flags, O_DIRECT);
  if (!(flags & O_DIRECT)) {
    printf("failed to set O_DIRECT flag errno=%d\n", errno);
    exit(errno);
  };

  rc = write(fd, buffer, getpagesize());
  if (rc !=  getpagesize()) {
    printf("aligned write failed with errno=%d\n", errno);
    exit(errno);
  };
  printf("aligned write OK\n", errno);
  rc = write(fd, buffer+100, 100);
  if (rc !=  100) {
    printf("unaligned write failed with errno=%d\n", errno);
    exit(errno);
  };
  printf("unaligned write OK\n", errno);
};
======================================================================

Now on a 2.4.10 kernel it produces (correctly)

open OK
fcntl(fd, F_GETFL) retuned 040002 
setting O_DIRECT(=040000) flag with fcntl()
fcntl(fd, F_GETFL) retuned 040002 
aligned write OK
unaligned write failed with errno=22

But on both a RH6.2 with a 2.2.19 and a RH7.1 with 2.4.3 (both non
stock) it gives:

open OK
fcntl(fd, F_GETFL) retuned 040002 
setting O_DIRECT(=040000) flag with fcntl()
fcntl(fd, F_GETFL) retuned 040002 
aligned write OK
unaligned write OK


I guess the open(,,O_DIRECT) *should* have failed on earlier kernels,
but since they don't I need another way of testing if directio is
supported.

TJ
 
-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

