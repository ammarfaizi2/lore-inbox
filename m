Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWI3R0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWI3R0c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWI3R0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:26:32 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:12249 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751318AbWI3R0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:26:31 -0400
Date: Sat, 30 Sep 2006 10:26:06 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Dong Feng <middle.fengdong@gmail.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and
 Nest Kernel Path?
In-Reply-To: <a2ebde260609300909l5f33c152xa331f7600be67f6b@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609301015060.3519@schroedinger.engr.sgi.com>
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com> 
 <Pine.LNX.4.64.0609290903550.23840@schroedinger.engr.sgi.com> 
 <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com> 
 <451E8143.5030300@yahoo.com.au> <a2ebde260609300909l5f33c152xa331f7600be67f6b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006, Dong Feng wrote:

> --- kernel/time.c.orig	2006-09-30 23:21:29.000000000 +0800
> +++ kernel/time.c	2006-09-30 23:38:18.000000000 +0800
> @@ -107,7 +107,16 @@ asmlinkage long sys_gettimeofday(struct
> 			return -EFAULT;
> 	}
> 	if (unlikely(tz != NULL)) {
> -		if (copy_to_user(tz, &sys_tz, sizeof(sys_tz)))
> +		struct timezone ktz;
> +		unsigned long seq;
> +
> +		do {
> +                	seq = read_seqbegin(&xtime_lock);
> +			ktz.tz_minuteswest = sys_tz.tz_minuteswest;
> +			ktz.tz_dsttime = sys_tz.tz_dsttime;
> +        	} while (unlikely(read_seqretry(&xtime_lock, seq)));
> +
> +		if (copy_to_user(tz, &ktz, sizeof(ktz)))
> 			return -EFAULT;

I really hate adding overhead to gettimeofday() and we would have to take 
the seqlock in all places when we reference tz. Maybe we can tolerate the 
resulting race?

If we assume word size transfers then we only have an issue on 32 bit 
platforms. The result of the race would be that tz_minuteswest and 
tz_dsttime disagree. So we may get daylight savings time wrong.
But then we are already changing the timezone and are potentially warping time.
gettimofday may be unstable anyways. So it may be okay to leave the race 
in. Just add some comments explaining the situation.
