Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWI3QJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWI3QJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 12:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWI3QJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 12:09:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:32372 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751251AbWI3QJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 12:09:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DILXgFMD9bBKFIi5MAOAb3kgYmJvnLHuLaZGQTJYbsflBPUDt9Qz5rqle26BbbnEyefsDEEr+WlEfvg8sUJ5t9vectdX5f5ksT+ZeoTrIpmk8vrZpkYpKB0NxACHMBOc97Hm75sPILteCcuAeuuCsyBXuUYjXKFWJlG/WR02PyU=
Message-ID: <a2ebde260609300909l5f33c152xa331f7600be67f6b@mail.gmail.com>
Date: Sun, 1 Oct 2006 00:09:24 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and Nest Kernel Path?
Cc: "Christoph Lameter" <clameter@sgi.com>, "Andi Kleen" <ak@suse.de>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Paul Mackerras" <paulus@samba.org>,
       "David Howells" <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <451E8143.5030300@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com>
	 <Pine.LNX.4.64.0609290903550.23840@schroedinger.engr.sgi.com>
	 <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com>
	 <451E8143.5030300@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006, Nick Piggin wrote
>
> You should write a patch and send it to Mister Morton.
>
> --
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
>

This is a patch for your review.

--- kernel/time.c.orig	2006-09-30 23:21:29.000000000 +0800
+++ kernel/time.c	2006-09-30 23:38:18.000000000 +0800
@@ -107,7 +107,16 @@ asmlinkage long sys_gettimeofday(struct
 			return -EFAULT;
 	}
 	if (unlikely(tz != NULL)) {
-		if (copy_to_user(tz, &sys_tz, sizeof(sys_tz)))
+		struct timezone ktz;
+		unsigned long seq;
+
+		do {
+                	seq = read_seqbegin(&xtime_lock);
+			ktz.tz_minuteswest = sys_tz.tz_minuteswest;
+			ktz.tz_dsttime = sys_tz.tz_dsttime;
+        	} while (unlikely(read_seqretry(&xtime_lock, seq)));
+
+		if (copy_to_user(tz, &ktz, sizeof(ktz)))
 			return -EFAULT;
 	}
 	return 0;
@@ -164,12 +173,16 @@ int do_sys_settimeofday(struct timespec

 	if (tz) {
 		/* SMP safe, global irq locking makes it work. */
-		sys_tz = *tz;
-		if (firsttime) {
-			firsttime = 0;
-			if (!tv)
-				warp_clock();
+		write_seqlock_irq(&xtime_lock);
+		{
+			sys_tz = *tz;
+			if (firsttime) {
+				firsttime = 0;
+				if (!tv)
+					warp_clock();
+			}
 		}
+		write_sequnlock_irq(&xtime_lock);
 	}
 	if (tv)
 	{
