Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWGLOr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWGLOr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWGLOr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:47:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42933 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751383AbWGLOr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:47:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	<p73ac7fok13.fsf@verdi.suse.de>
	<m1sll7ecr4.fsf@ebiederm.dsl.xmission.com>
	<200607121532.05227.ak@suse.de>
Date: Wed, 12 Jul 2006 08:47:17 -0600
In-Reply-To: <200607121532.05227.ak@suse.de> (Andi Kleen's message of "Wed, 12
	Jul 2006 15:32:05 +0200")
Message-ID: <m1ac7edgne.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Wednesday 12 July 2006 05:13, Eric W. Biederman wrote:
>> Andi Kleen <ak@suse.de> writes:
>> > ebiederm@xmission.com (Eric W. Biederman) writes:
>> >> Since sys_sysctl is deprecated start allow it to be compiled out.
>> >> This should catch any remaining user space code that cares,
>> >
>> > I tried this long ago, but found that glibc uses sysctl in each
>> > program to get the kernel version. It probably handles ENOSYS,
>> > but there might be slowdowns or subtle problems from it not knowing
>> > the kernel version.
>> >
>> > So I think it's ok to remove the big sysctl, but at a very minimal
>> > replacement that just handles (CTL_KERN, KERN_VERSION) is needed.
>>
>> If glibc is looking at kernel.osrelease it might make sense.
>> If glibc is looking at kernel.version which is just the build number
>> and date I can't imagine a correct usage.
>
> It's KERN_VERSION 
>
>>From my /bin/ls:
>
> _sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfc8e1e0, 30, (nil), 0}) = 0

Yep. I found it.

In glibc (2.3.6, 2.4, and CVS) nptl/sysdeps/unix/sysv/linux/smp.h
>
> /* Test whether the machine has more than one processor.  This is not the
>    best test but good enough.  More complicated tests would require `malloc'
>    which is not available at that time.  */
> static inline int
> is_smp_system (void)
> {
>   static const int sysctl_args[] = { CTL_KERN, KERN_VERSION };
>   char buf[512];
>   size_t reslen = sizeof (buf);
> 
>   /* Try reading the number using `sysctl' first.  */
>   if (__sysctl ((int *) sysctl_args,
> 		sizeof (sysctl_args) / sizeof (sysctl_args[0]),
> 		buf, &reslen, NULL, 0) < 0)
>     {
>       /* This was not successful.  Now try reading the /proc filesystem.  */
>       int fd = open_not_cancel_2 ("/proc/sys/kernel/version", O_RDONLY);
>       if (__builtin_expect (fd, 0) == -1
> 	  || (reslen = read_not_cancel (fd, buf, sizeof (buf))) <= 0)
> 	/* This also didn't work.  We give up and say it's a UP machine.  */
> 	buf[0] = '\0';
> 
>       close_not_cancel_no_status (fd);
>     }
> 
>   return strstr (buf, "SMP") != NULL;
> }

So it will correctly handle that sysctl being compiled out, and
the fallback to using /proc.  The code seems to have been
doing that since it was added to glibc in 2000.

It only uses it to see if it should busy wait when taking a mutex.

If the kernel has SMP support is lousy predictor if it makes sense
for glibc to busy wait.  Darn optimizations for the contended case.

>> If this usage is still common in glibc we can decide what to do
>> when the warnings pop up.
>
> printk for everything would annoy basically everybody. Not a good idea.

Well everything isn't using pthreads.  Why ls uses pthreads
is beyond me.

Anyway it looks like it's time to send of a patch.

Eric

