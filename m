Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVFZXHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVFZXHB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVFZXHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:07:01 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:26260 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261664AbVFZXFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:05:48 -0400
From: Andreas Kies <andikies@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: A Bug in gcc or asm/string.h ?
Date: Mon, 27 Jun 2005 01:05:28 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506270105.28782.andikies@t-online.de>
X-ID: T-GLVvZaoexjG6QUtS2w3rOI2anr9zgUxkyx8kK3iLPCrizVkNKCYJ
X-TOI-MSGID: d70c5078-2f8c-4290-b57a-947e84737b06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When running a kernel module compiled with gcc 3.3.5, I think I've found a bug 
in either the compiler or the kernel definition of strcmp in 
asm-i386/string.h . The exact compiler version is :

Reading specs from /usr/lib/gcc-lib/i586-suse-linux/3.3.5/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --infodir=/usr/share/info 
--mandir=/usr/share/man --enable-languages=c,c++,f77,objc,java,ada 
--disable-checking --libdir=/usr/lib --enable-libgcj --with-slibdir=/lib 
--with-system-zlib --enable-shared --enable-__cxa_atexit i586-suse-linux
Thread model: posix
gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)

I was able to construct a small pure usermode program.
If you compile the included test program with optimization level 1 or less it 
works, if compiled with level 2 it fails. Failing means the strcmp result 
is != 0 because char ptr has valid contents at the time strcmp is expanded.
Other platforms besides i386 might be affected, too.
In the case of a failure you get "Unrecognized" as output on stdout.

So, here are my questions :
- Is this a bug in the compiler ?
In Documentation/Changes version 2.95.x is still recommended, I guess this is 
outdated.
- Is it a bug in the definition of strcmp ? Maybe an addition volatile is 
missing.

Thanks for reading.

Andreas.

Please CC me, as I'm not on the list.

------test program-----

/* taken from <asm-i386/string.h> */
static inline int strcmp(const char * cs,const char * ct)
{
 int d0, d1;
 register int __res;
 __asm__ __volatile__(
   "1:\tlodsb\n\t"
   "scasb\n\t"
   "jne 2f\n\t"
   "testb %%al,%%al\n\t"
   "jne 1b\n\t"
   "xorl %%eax,%%eax\n\t"
   "jmp 3f\n"
   "2:\tsbbl %%eax,%%eax\n\t"
   "orb $1,%%al\n"
   "3:"
   :"=a" (__res), "=&S" (d0), "=&D" (d1)
   :"1" (cs),"2" (ct));
 return __res;
}
/* end of code from <asm-i386/string.h> */

int oem;

int main(void)
{
   char ptr[2];

   ptr[0] = 'G';
   ptr[1] = '\0';

   if (strcmp(ptr, "G") == 0) {
      oem = 0; /* this branch should always be executed*/
   } else {
      printf("Unrecognized\n");
      oem = 1;
   }
   return oem;
}
