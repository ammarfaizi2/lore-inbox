Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284768AbRLEWdi>; Wed, 5 Dec 2001 17:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284773AbRLEWda>; Wed, 5 Dec 2001 17:33:30 -0500
Received: from uucp.cistron.nl ([195.64.68.38]:4876 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S284771AbRLEWdU>;
	Wed, 5 Dec 2001 17:33:20 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: Random "File size limit exceeded" under 2.4
Date: Wed, 5 Dec 2001 22:33:19 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9um7bf$lsp$1@ncc1701.cistron.net>
In-Reply-To: <1007573331.1809.6.camel@two> <3C0E813D.F5B1F84E@zip.com.au>
X-Trace: ncc1701.cistron.net 1007591599 22425 195.64.65.67 (5 Dec 2001 22:33:19 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C0E813D.F5B1F84E@zip.com.au>,
Andrew Morton  <akpm@zip.com.au> wrote:
>Derek Glidden wrote:
>> 
>> I've been experiencing random and occasional encounters with "File size
>> limit exceeded" errors under 2.4 kernels when trying to make
>> filesystems.
>
>I don't know if anyone has come forth to fix this yet.
>
>Apparently it's something to do with your shell setting
>rlimits, and block devices are (bogusly) honouring those
>settings.

Perhaps the old app is calling sys_old_getrlimit() from
linux/kernel/sys.c. It truncates rlimits to 0x7FFFFFFF
if it's bigger than that. 0x7FFFFFFF used to be the old
RLIM_INFINITY in 2.2 [actually, ((long)(~0UL>>1))]. In
2.4, RLIM_INFINITY is (~0UL).

So if you call sys_setrlimit() with the old RLIM_INFINITY from 2.2
OR with the result from sys_old_getrlimit(), then the new limit
will be 0x7FFFFFFF instead of unlimited.

Looks like someone forgot to implement sys_old_setrlimit(),
which would have been the right thing to do.

Now all we can do is to hack sys_setrlimit and let it translate
0x7FFFFFFF to RLIM_INFINITY.

The following untested and uncompiled patch might do it, or not...

--- linux-2.4.17-pre2/kernel/sys.c.orig	Tue Sep 18 23:10:43 2001
+++ linux-2.4.17-pre2/kernel/sys.c	Wed Dec  5 23:30:50 2001
@@ -1120,6 +1120,16 @@
 		return -EINVAL;
 	if(copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
 		return -EFAULT;
+#if !defined(__ia64__)
+	/*
+	 * 	In 2.2, RLIMIT_INFINITY was defined as ((long)(~0UL>>1)).
+	 * 	Reckognize it and translate it to the new RLIMIT_INFINITY.
+	 */
+	if ((long)new_rlim.rlim_cur == ((long)(~0UL>>1)))
+		new_rlim.rlim_cur = RLIMIT_INFINITY;
+	if ((long)new_rlim.rlim_max == ((long)(~0UL>>1)))
+		new_rlim.rlim_max = RLIMIT_INFINITY;
+#endif
 	old_rlim = current->rlim + resource;
 	if (((new_rlim.rlim_cur > old_rlim->rlim_max) ||
 	     (new_rlim.rlim_max > old_rlim->rlim_max)) &&

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

