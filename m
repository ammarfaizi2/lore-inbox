Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268008AbUI1S2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268008AbUI1S2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 14:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUI1S2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 14:28:35 -0400
Received: from [63.107.13.101] ([63.107.13.101]:14995 "EHLO mail.metavize.com")
	by vger.kernel.org with ESMTP id S268008AbUI1S2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 14:28:31 -0400
Message-ID: <4159AD4E.7020402@metaloft.com>
Date: Tue, 28 Sep 2004 11:28:30 -0700
From: Dirk Morris <dmorris@metaloft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: miscellaneous interrupted system call.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting random threads woken up when other threads make a 
system("foo") call.

I've been having the sympton since the 2.5 series.
It does not happen in the 2.4 series.
I thought it was somehow related to the futex_badness, but now I think 
it may be some libc NPTL issue.

Any ideas?

Sample program:
/* $Id: foo.c,v 1.00 2004/03/31 10:51:19 dmorris Exp $ */
/* gcc foo.c -o foo -pthread */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

sem_t sem;

void* make_system_call (void* arg)
{
   while(1) {
       sleep(1);
       system("/bin/true");
   }
   return NULL;
}

int main(void)
{
   pthread_t id;
   sem_init(&sem,0,0);
   pthread_create(&id,NULL,make_system_call,NULL);
   while (sem_wait(&sem)<0)
       perror("sem_wait");
   return 0;
}

Output:
~/misc # ./foo 
                                                                                

sem_wait: Interrupted system call
sem_wait: Interrupted system call
...

Machine info:
It happens on all my 2.5/2.6 machines, all running debian 
testing/unstable in some flavor.
Here's one example:

~/misc # uname 
-a                                                                                     

Linux bebe 2.6.8.1 #2 SMP Fri Aug 20 13:32:31 PDT 2004 i686 GNU/Linux
~/misc # gcc 
-v                                                                                     

Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.4/specs
Configured with: ../src/configure -v 
--enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr 
--mandir=/usr/share/man --infodir=/usr/share/info 
--with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared 
--with-system-zlib --enable-nls --without-included-gettext 
--enable-__cxa_atexit --enable-clocale=gnu --enable-debug 
--enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.4 (Debian 1:3.3.4-6sarge1)


Thanks,

-Dirk


