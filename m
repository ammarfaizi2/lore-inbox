Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWEKUre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWEKUre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 16:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWEKUre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 16:47:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:18578 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750784AbWEKUrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 16:47:33 -0400
Date: Thu, 11 May 2006 13:47:41 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, staubach@redhat.com
Subject: Re: Linux poll() <sigh> again
Message-ID: <20060511204741.GG22741@us.ibm.com>
References: <Pine.LNX.4.61.0605111023030.3729@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605111023030.3729@chaos.analogic.com>
X-Operating-System: Linux 2.6.17-rc2 (x86_64)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.2006 [10:25:29 -0400], linux-os (Dick Johnson) wrote:
> 
> 
> Hello,
> 
> I'm trying to fix a long-standing bug which has a
> work-around that has been working for a year or
> so.

<snip valiant efforts>

> Here is relevent code:
> 
>              for(;;) {
>                  mem->pfd.fd = fd;
>                  mem->pfd.events = POLLIN|POLLERR|POLLHUP|POLLNVAL;
>                  mem->pfd.revents = 0x00;

Hrm, in looking at the craziness that is sys_poll() for a bit, I think
it's the underlying f_ops that are responsible for not setting POLLHUP,
that is:

                        if (file != NULL) {
                                mask = DEFAULT_POLLMASK;
                                if (file->f_op && file->f_op->poll)
                                        mask = file->f_op->poll(file, *pwait);
                                mask &= fdp->events | POLLERR | POLLHUP;
                                fput_light(file, fput_needed);
                        }

and file->f_op->poll(file, *pwait) is not setting POLLHUP on the
disconnect. What filesystem is this?

On an independent note, it seems like the relatively recent cleanups to
sys_poll() made the negative case a bit inefficient (and reliant on
msecs_to_jiffies() dealing with negative values, which I don't think it
was really ever designed to (it's mostly used for converting time
values, which can never go negative)). Maybe the following would make
sense? Peter, I know you had been looking at poll() issues earlier, does
this change make sense?

Description: Rather than make msecs_to_jiffies() deal with negative
values, just send them on to do_sys_poll(), which (eventually in
do_poll()) explicitly checks for them.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff -urpN 2.6.17-rc3-git18/fs/select.c 2.6.17-rc3-git18-dev/fs/select.c
--- 2.6.17-rc3-git18/fs/select.c	2006-05-11 12:17:15.000000000 -0700
+++ 2.6.17-rc3-git18-dev/fs/select.c	2006-05-11 12:38:16.000000000 -0700
@@ -727,9 +727,9 @@ out_fds:
 asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 			long timeout_msecs)
 {
-	s64 timeout_jiffies = 0;
+	s64 timeout_jiffies;
 
-	if (timeout_msecs) {
+	if (timeout_msecs > 0) {
 #if HZ > 1000
 		/* We can only overflow if HZ > 1000 */
 		if (timeout_msecs / 1000 > (s64)0x7fffffffffffffffULL / (s64)HZ)
@@ -737,6 +737,8 @@ asmlinkage long sys_poll(struct pollfd _
 		else
 #endif
 			timeout_jiffies = msecs_to_jiffies(timeout_msecs);
+	} else {
+		timeout_jiffies = timeout_msecs;
 	}
 
 	return do_sys_poll(ufds, nfds, &timeout_jiffies);

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
