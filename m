Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSE0MJK>; Mon, 27 May 2002 08:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316590AbSE0MJJ>; Mon, 27 May 2002 08:09:09 -0400
Received: from mout0.freenet.de ([194.97.50.131]:44694 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S316589AbSE0MJH>;
	Mon, 27 May 2002 08:09:07 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: Memory management in Kernel 2.4.x
Date: Mon, 27 May 2002 14:10:49 +0200
Organization: Privat
Message-ID: <act7oa$5cl$1@ID-44327.news.dfncis.de>
In-Reply-To: <fa.huj8e2v.10ggghn@ifi.uio.no> <fa.o5cc8mv.12h4to1@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1022501450 5525 192.168.1.3 (27 May 2002 12:10:50 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.1
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Mon, 2002-05-27 at 10:40, Andreas Hartmann wrote:
>> Unfortunately, the memory management of kernel 2.4.x didn't get better
>> until today. It is very easy to make a machine dead. Take the following
>> script:
>> 
>> 
http://groups.google.com/groups?q=malloc+bestie&hl=de&lr=&selm=slrn8aiglm.tqd.pfk@c.zeiss.de&rnum=2
>> 
>> 
>> The result with kernel 2.4.19pre8ac4:
>> 
>> May 27 11:04:21 athlon kernel: Out of Memory: Killed process 763 (knode).
> 
> This appears to be correct behaviour. You allocated astronomical amounts
> of memory and had memory overcommit enabled so it broke. Thats
> configurable and you can if you wish disable overcommit in the -ac
> kernel by setting /proc/sys/vm/overcommit_memory to 2 (thats not
> supported by the base 2.4 kernels yet). If you can make it OOM in that
> mode then I am interested indeed.

I tested it and got in the result the same problem. Well, no processes got 
killed by the kernel and the virtual memory didn't grow up to the end (as 
far as I could see it).
But every (other, regular) process crashed when it wanted to have some 
memory because it didn't get the memory. Or I wasn't able to start any new 
process - I even couldn't do a logon via ssh or a local login at the 
console.


May 27 13:37:12 athlon login: PAM unable to 
dlopen(/lib/security/pam_pwdb.so)
May 27 13:37:12 athlon login: PAM [dlerror: libpwdb.so.0: failed to map 
segment from shared object: Cannot allocate memory]
May 27 13:37:12 athlon login: PAM adding faulty module: 
/lib/security/pam_pwdb.so
May 27 13:37:13 athlon out of memory [198out of me]
May 27 13:37:15 athlon login: PAM unable to 
dlopen(/lib/security/pam_pwdb.so)
May 27 13:37:15 athlon login: PAM [dlerror: libpwdb.so.0: failed to map 
segment from shared object: Cannot allocate memory]
May 27 13:37:15 athlon login: PAM adding faulty module: 
/lib/security/pam_pwdb.so
May 27 13:37:15 athlon out of memory [2617out of m]
May 27 13:37:15 athlon last message repeated 29 times
May 27 13:37:23 athlon login: PAM unable to 
dlopen(/lib/security/pam_pwdb.so)
May 27 13:37:23 athlon login: PAM [dlerror: libpwdb.so.0: failed to map 
segment from shared object: Cannot allocate memory]
May 27 13:37:23 athlon login: PAM adding faulty module: 
/lib/security/pam_pwdb.so
May 27 13:37:23 athlon out of memory [2620out of m]
May 27 13:37:23 athlon last message repeated 29 times
May 27 13:37:27 athlon login: PAM unable to 
dlopen(/lib/security/pam_pwdb.so)
May 27 13:37:27 athlon login: PAM [dlerror: libpwdb.so.0: failed to map 
segment from shared object: Cannot allocate memory]
May 27 13:37:27 athlon login: PAM adding faulty module: 
/lib/security/pam_pwdb.so
May 27 13:37:27 athlon out of memory [199out of me]
May 27 13:39:36 athlon login: PAM unable to 
dlopen(/lib/security/pam_pwdb.so)
May 27 13:39:36 athlon login: PAM [dlerror: libpwdb.so.0: failed to map 
segment from shared object: Cannot allocate memory]
May 27 13:39:36 athlon login: PAM adding faulty module: 
/lib/security/pam_pwdb.so
May 27 13:39:36 athlon out of memory [2629out of m]
May 27 13:39:36 athlon last message repeated 29 times
May 27 13:42:01 athlon sshd[124]: error: fork: Cannot allocate memory

All in all, the overcommitment - option seems to work fine (the machine 
responded well :-)), but it should restrict just the process which leads 
the machine to death. All other processes should be as free as before.

> The rsync one is more interesting, it could be something doing huge
> amounts of memory allocations it could also be excessive kernel usage or
> wrong OOM semantics somewhere.

rsync allocates all of the memory the machine has (256 MB RAM, 128 MB swap). 
When this occures, processes get killed like described in the posting 
before. The machine doesn't respond as long as the rsync - process isn't 
killed, because it fetches all the memory which gets free after a process 
has been killed.


Regards,
Andreas Hartmann
