Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUEKTvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUEKTvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUEKTvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:51:11 -0400
Received: from mail.aknet.ru ([217.67.122.194]:47876 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S263555AbUEKTuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:50:39 -0400
Message-ID: <40A12E83.7030209@aknet.ru>
Date: Tue, 11 May 2004 23:50:27 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040410
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in VM accounting code, probably exploitable
Content-Type: multipart/mixed;
 boundary="------------010703050208040502050502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------010703050208040502050502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hello.

As far as I know, if overcommit is
disabled, the OOM kill should never
happen.
It seems to be the bug in the linux
kernel though (any version I think,
probably also including 2.4.x), which
makes it possible to overcommit almost
arbitrary and provoke an OOM kill
afterwards.
Attached is a program that demonstrates
the bug. Don't forget to "swapoff -a"
before starting it, or touching pages
will take eternity. And the amount of
RAM must be <1Gb, or the prog will not
work:)

On 2.4.25 I get:
---
May 11 22:28:18 lin kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
May 11 22:28:20 lin syslogd: /var/log/debug: Cannot allocate memory
May 11 22:28:18 lin kernel: VM: killing process mozilla-bin
May 11 22:28:18 lin kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1f0/0)
May 11 22:28:20 lin kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
May 11 22:28:21 lin kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
May 11 22:28:21 lin kernel: VM: killing process X
May 11 22:28:21 lin gnome-name-server[1254]: input condition is: 0x11, 
exiting
May 11 22:29:00 lin kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
May 11 22:29:00 lin kernel: VM: killing process overc_test
---
As you can see, the program caused many
other processes to be killed, before it
died itself.

2.6.6 seems to kill only the test
program itself, but there is one
nasty side-effect here, that mprotect()
fails to merge VMAs because one VMA can
end up with VM_ACCOUNT flag set, and
another - without that flag. That makes
several apps of mine to malfuncate.
Also it might be possible to bypass the
security_vm_enough_memory() checks, which
may probably be exploitable in some other
ways.

I am also attaching the fix for 2.6
kernels.

Would be nice if someone can confirm
the bug and verify the fix. Perhaps
I am missing something obvious here,
at least the fact that both 2.6 and 2.4
behaves similar, confuses me. And the
fix looks also very strange, but it
seems to work.

--------------010703050208040502050502
Content-Type: text/plain;
 name="overc_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="overc_test.c"


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <asm/page.h>
#include <errno.h>

#define SIZE (1024 * 1024 * 1024)

int main(int argc, char *argv[])
{
  char *addr;
  int i;

  if ((addr = mmap(0, SIZE, PROT_READ | PROT_WRITE,
      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0)) != MAP_FAILED) {
    printf("You have more than %i memory, increase SIZE\n", SIZE);
    return 1;
  }
  perror("mmap()");
  printf("OK, now trying uncommited...\n");
  if ((addr = mmap(0, SIZE, PROT_NONE,
      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0)) == MAP_FAILED) {
    perror("mmap()");
    return 1;
  }
  if (mprotect(addr, SIZE, PROT_READ | PROT_WRITE) == -1) {
    perror("mprotect()");
    return 1;
  }

  printf("Memory of size %i successfully committed!\n", SIZE);
  printf("overcommit_memory: ");
  fflush(stdout);
  system("cat /proc/sys/vm/overcommit_memory");

  for (i = 0; i < SIZE; i += PAGE_SIZE) {
    addr[i] = 1;
  }

  return 0;
}

--------------010703050208040502050502
Content-Type: text/plain;
 name="vm_acct.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm_acct.diff"


--- linux/include/linux/mm.h	2004-04-14 09:41:36.000000000 +0400
+++ linux/include/linux/mm.h	2004-05-11 15:29:00.447968384 +0400
@@ -126,7 +126,7 @@
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 
 /* It makes sense to apply VM_ACCOUNT to this vma. */
-#define VM_MAYACCT(vma) (!!((vma)->vm_flags & VM_HUGETLB))
+#define VM_MAYACCT(vma) (!((vma)->vm_flags & VM_HUGETLB))
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS

--------------010703050208040502050502
Content-Type: text/plain


Scanned by evaluation version of Dr.Web antivirus Daemon 
http://drweb.ru/unix/


--------------010703050208040502050502--
