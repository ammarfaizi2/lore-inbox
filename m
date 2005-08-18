Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVHRA5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVHRA5V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbVHRA5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:57:21 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:36324 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932067AbVHRA5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:57:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Bernardo Innocenti <bernie@develer.com>
Subject: Re: sched_yield() makes OpenLDAP slow
Date: Thu, 18 Aug 2005 10:47:25 +1000
User-Agent: KMail/1.8.2
Cc: lkml <linux-kernel@vger.kernel.org>, OpenLDAP-devel@openldap.org,
       Giovanni Bajo <rasky@develer.com>, Simone Zinanni <simone@develer.com>
References: <4303DB48.8010902@develer.com>
In-Reply-To: <4303DB48.8010902@develer.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508181047.26008.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005 10:50 am, Bernardo Innocenti wrote:
> Hello,
>
> I've been investigating a performance problem on a
> server using OpenLDAP 2.2.26 for nss resolution and
> running kernel 2.6.12.
>
> When a CPU bound process such as GCC is running in the
> background (even at nice 10), many trivial commands such
> as "su" or "groups" become extremely slow and take a few
> seconds to complete.
>
> strace revealed that data exchange over the slapd socket
> was where most of the time was spent.  Looking at the
> slapd side, I see several calls to sched_yield() like this:
>
>
> [pid  8780]      0.000033 stat64("gidNumber.dbb", 0xb7b3ebcc) = -1 EACCES
> (Permission denied) [pid  8780]      0.000059 pread(20,
> "\0\0\0\0\1\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\2\0\344\17\2\3"..., 4096, 4096) =
> 4096 [pid  8780]      0.000083 pread(20,
> "\0\0\0\0\1\0\0\0\4\0\0\0\3\0\0\0\0\0\0\0\222\0<\7\1\5\370"..., 4096,
> 16384) = 4096 [pid  8780]      0.000078 time(NULL)    = 1124322520
> [pid  8780]      0.000066 pread(11,
> "\0\0\0\0\1\0\0\0\250\0\0\0\231\0\0\0\235\0\0\0\16\0000"..., 4096, 688128)
> = 4096 [pid  8780]      0.000241 write(19,
> "0e\2\1\3d`\4$cn=bernie,ou=group,dc=d"..., 103) = 103 [pid  8780]     
> 0.000137 sched_yield( <unfinished ...>
> [pid  8781]      0.050020 <... sched_yield resumed> ) = 0
> [pid  8780]      0.000025 <... sched_yield resumed> ) = 0
> [pid  8781]      0.000060 futex(0x925ab20, FUTEX_WAIT, 33, NULL <unfinished
> ...> [pid  8780]      0.000026 write(19, "0\f\2\1\3e\7\n\1\0\4\0\4\0", 14)
> = 14 [pid  8774]      0.000774 <... select resumed> ) = 1 (in [19])
>
>
> The relative timestamp reveals that slapd is spending 50ms
> after yielding.  Meanwhile, GCC is probably being scheduled
> for a whole quantum.
>
> Reading the man-page of sched_yield() it seems this isn't
> the correct behavior:
>
>    Note: If the current process is the only process in the
>    highest priority list at that time, this process will
>    continue to run after a call to sched_yield.
>
> I also think OpenLDAP is wrong.  First, it should be calling
> pthread_yield() because slapd is a multithreading process
> and it just wants to run the other threads.  See:

sched_yield behaviour changed in 2.5 series more than 3 years ago and 
applications that use this as a locking primitive should be updated.

Cheers,
Con
