Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131108AbRAWSHr>; Tue, 23 Jan 2001 13:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131106AbRAWSH1>; Tue, 23 Jan 2001 13:07:27 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:51224 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S131105AbRAWSH0>; Tue, 23 Jan 2001 13:07:26 -0500
Message-ID: <3A6DC816.9AE801A1@sgi.com>
Date: Tue, 23 Jan 2001 12:06:14 -0600
From: Aaron Laffin <alaffin@sgi.com>
Reply-To: alaffin@sgi.com
Organization: Silicon Graphics, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.15-3SGI_39 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: using open() on a looping symlink with O_CREAT set fails incorrectly.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We've found a case on 2.4.0 where an open performed on a looping symlink
(a symlink that points to itself) does not fail correctly when the open
flag O_CREAT is set.  When opening the looping link with only one of
O_RDONLY, O_RDWR, or O_WRONLY, open() fails as expected with an ELOOP. 
Using O_CREAT or'ed with one of O_RDONLY, O_RDWR, or O_WRONLY fails as
follows.  All of these should fail with an ELOOP (apparently):

open("link",O_RDONLY|O_CREAT) : reports a successful open.  Examination
of /proc/<pid>/fd indicates that the opened descriptor refers to the
directory the link is in.  
open("link",O_WRONLY|O_CREAT) : fils with errno EISDIR (21) "Is a
directory"
open("link",O_WRONLY|O_RDWR) : fils with errno EISDIR (21) "Is a
directory"

ver_linux output:

Linux greenhouse 2.4.0 #1 SMP Thu Jan 4 18:27:27 CST 2001 i686 unknown
Kernel modules         2.3.23
Gnu C                  egcs-2.91.66
Binutils               2.9.5.0.22
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ipx nfs autofs nfsd lockd sunrpc eepro100
ncr53c8xx

Illustration code

All of the test cases in this code should fail with an ELOOP.  They do
fail correctly on 2.2.16.  On our 2.4 system, the last three cases with
O_CREAT fail unexpectedly (discussed above):

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>

void call_open(int mode, char *strmode)
{
  int fd;

  fd = open("testlink",mode);
  
  if (fd<0)
  {
    printf("open(%s) of looping symlink failed: %d:
%s\n",strmode,errno,strerror(errno));
  }
  else
  {
    printf("hmm, open(%s) should have failed\n",strmode);
    close(fd);
  }
}

int main()
{
  int fd;

  symlink("testlink","testlink");

  call_open(O_RDONLY,"O_RDONLY");
  call_open(O_WRONLY,"O_WRONLY");
  call_open(O_RDWR,"O_RDWR");
  call_open(O_RDONLY|O_CREAT,"O_RDONLY|O_CREAT");
  call_open(O_WRONLY|O_CREAT,"O_WRONLY|O_CREAT");
  call_open(O_RDWR|O_CREAT,"O_RDWR|O_CREAT");

  unlink("testlink");
}

I'm not subscribed directly to the list, please CC me in responses.

--aaron

-- 
Aaron Laffin
SGI Linux Test Project http://oss.sgi.com/projects/ltp/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
