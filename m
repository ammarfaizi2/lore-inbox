Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUFNTQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUFNTQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 15:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUFNTQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 15:16:25 -0400
Received: from mail.aknet.ru ([217.67.122.194]:58378 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S263795AbUFNTQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 15:16:21 -0400
Message-ID: <40CDF984.9030503@aknet.ru>
Date: Mon, 14 Jun 2004 23:16:20 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug: debugging with GDB is broken under 2.6.6
Content-Type: multipart/mixed;
 boundary="------------000806020008030801000904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------000806020008030801000904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hello.

It seems some bug in 2.6.6 (and up to
2.6.7-rc3-mm2) makes gdb useless - it
is no longer possible to produce even
a simple stack trace for any program.
Attached it the test-case to demonstrate
the bug. Its output under any 2.6.6 kernels
is:
---
(gdb) #0  0xffffe410 in ?? ()
#1  0xbffffa88 in ?? ()
#2  0x00000000 in ?? ()
---
Absolutely broken backtrace.

And under 2.6.5 (the one that comes with
RedHat FC2 at least) and under 2.4 kernels:
---
(gdb) #0  0x00558402 in ?? ()
#1  0x0041ce83 in __waitpid_nocancel () from /lib/tls/libc.so.6
#2  0x08048645 in main (argc=1, argv=0xfef20f84) at gdb_tst.c:26
---
Perfect backtrace.

Any ideas what have caused this? As I am
using gdb very frequently, this bug gives
me some headache.


--------------000806020008030801000904
Content-Type: text/x-csrc;
 name="gdb_tst.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gdb_tst.c"


#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
  char buf[255];
  int s;
  FILE *f;
  pid_t pid;
  switch((pid = fork())) {
    case 0:
      sprintf(buf, "gdb %s %i", argv[0], getppid());
      f = popen(buf, "w");
      fprintf(f, "bt\n");
      fprintf(f, "quit\n");
      fflush(f);
      wait(&s);
      pclose(f);
      break;
    case -1:
      return 1;
    default:
      waitpid(pid, &s, 0);
  }
  return 0;
}

--------------000806020008030801000904
Content-Type: text/plain


Scanned by evaluation version of Dr.Web antivirus Daemon 
http://drweb.ru/unix/


--------------000806020008030801000904--
