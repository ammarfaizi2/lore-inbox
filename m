Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVHRAug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVHRAug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVHRAug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:50:36 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:34771 "HELO
	develer.com") by vger.kernel.org with SMTP id S1751329AbVHRAuf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:50:35 -0400
Message-ID: <4303DB48.8010902@develer.com>
Date: Thu, 18 Aug 2005 02:50:16 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.6-4 (X11/20050815)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, OpenLDAP-devel@OpenLDAP.org
CC: Giovanni Bajo <rasky@develer.com>, Simone Zinanni <simone@develer.com>
Subject: sched_yield() makes OpenLDAP slow
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been investigating a performance problem on a
server using OpenLDAP 2.2.26 for nss resolution and
running kernel 2.6.12.

When a CPU bound process such as GCC is running in the
background (even at nice 10), many trivial commands such
as "su" or "groups" become extremely slow and take a few
seconds to complete.

strace revealed that data exchange over the slapd socket
was where most of the time was spent.  Looking at the
slapd side, I see several calls to sched_yield() like this:


[pid  8780]      0.000033 stat64("gidNumber.dbb", 0xb7b3ebcc) = -1 EACCES (Permission denied)
[pid  8780]      0.000059 pread(20, "\0\0\0\0\1\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\2\0\344\17\2\3"..., 4096, 4096) = 4096
[pid  8780]      0.000083 pread(20, "\0\0\0\0\1\0\0\0\4\0\0\0\3\0\0\0\0\0\0\0\222\0<\7\1\5\370"..., 4096, 16384) = 4096
[pid  8780]      0.000078 time(NULL)    = 1124322520
[pid  8780]      0.000066 pread(11, "\0\0\0\0\1\0\0\0\250\0\0\0\231\0\0\0\235\0\0\0\16\0000"..., 4096, 688128) = 4096
[pid  8780]      0.000241 write(19, "0e\2\1\3d`\4$cn=bernie,ou=group,dc=d"..., 103) = 103
[pid  8780]      0.000137 sched_yield( <unfinished ...>
[pid  8781]      0.050020 <... sched_yield resumed> ) = 0
[pid  8780]      0.000025 <... sched_yield resumed> ) = 0
[pid  8781]      0.000060 futex(0x925ab20, FUTEX_WAIT, 33, NULL <unfinished ...>
[pid  8780]      0.000026 write(19, "0\f\2\1\3e\7\n\1\0\4\0\4\0", 14) = 14
[pid  8774]      0.000774 <... select resumed> ) = 1 (in [19])


The relative timestamp reveals that slapd is spending 50ms
after yielding.  Meanwhile, GCC is probably being scheduled
for a whole quantum.

Reading the man-page of sched_yield() it seems this isn't
the correct behavior:

   Note: If the current process is the only process in the
   highest priority list at that time, this process will
   continue to run after a call to sched_yield.

I also think OpenLDAP is wrong.  First, it should be calling
pthread_yield() because slapd is a multithreading process
and it just wants to run the other threads.  See:

int
ldap_pvt_thread_yield( void )
{
#if HAVE_THR_YIELD
        return thr_yield();

#elif HAVE_PTHREADS == 10
        return sched_yield();

#elif defined(_POSIX_THREAD_IS_GNU_PTH)
        sched_yield();
        return 0;

#elif HAVE_PTHREADS == 6
        pthread_yield(NULL);
        return 0;
#else
        pthread_yield();
        return 0;
#endif
}


-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

