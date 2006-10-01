Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWJADsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWJADsL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 23:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWJADsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 23:48:10 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:58536 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751842AbWJADsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 23:48:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=j/OoOcfjEZZ5ByejtREWtxvQWlBYEqrimzO7Z9Hifg2prUVGd6HGMYUeg12VI21xwBF+FRlkxfIeTKijKRZot6xm0iSdFDfLIHvB/7yS2kUIOt/ZlWUKWs5qH0rPInZ1/L8W/3Hb/yswOG7Ukgy2b5ZgQjvv9bq43jZGcArClwM=  ;
Message-ID: <451F3A73.80800@yahoo.com.au>
Date: Sun, 01 Oct 2006 13:48:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Dong Feng <middle.fengdong@gmail.com>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and
 Nest Kernel Path?
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com>  <Pine.LNX.4.64.0609290903550.23840@schroedinger.engr.sgi.com>  <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com>  <451E8143.5030300@yahoo.com.au> <a2ebde260609300909l5f33c152xa331f7600be67f6b@mail.gmail.com> <Pine.LNX.4.64.0609301015060.3519@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609301015060.3519@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Sun, 1 Oct 2006, Dong Feng wrote:
> 
> 
>>--- kernel/time.c.orig	2006-09-30 23:21:29.000000000 +0800
>>+++ kernel/time.c	2006-09-30 23:38:18.000000000 +0800
>>@@ -107,7 +107,16 @@ asmlinkage long sys_gettimeofday(struct
>>			return -EFAULT;
>>	}
>>	if (unlikely(tz != NULL)) {
>>-		if (copy_to_user(tz, &sys_tz, sizeof(sys_tz)))
>>+		struct timezone ktz;
>>+		unsigned long seq;
>>+
>>+		do {
>>+                	seq = read_seqbegin(&xtime_lock);
>>+			ktz.tz_minuteswest = sys_tz.tz_minuteswest;
>>+			ktz.tz_dsttime = sys_tz.tz_dsttime;
>>+        	} while (unlikely(read_seqretry(&xtime_lock, seq)));
>>+
>>+		if (copy_to_user(tz, &ktz, sizeof(ktz)))
>>			return -EFAULT;
> 
> 
> I really hate adding overhead to gettimeofday() and we would have to take 
> the seqlock in all places when we reference tz. Maybe we can tolerate the 
> resulting race?
> 
> If we assume word size transfers then we only have an issue on 32 bit 
> platforms. The result of the race would be that tz_minuteswest and 
> tz_dsttime disagree. So we may get daylight savings time wrong.
> But then we are already changing the timezone and are potentially warping time.
> gettimofday may be unstable anyways. So it may be okay to leave the race 
> in. Just add some comments explaining the situation.

It is in an unlikely path though. How many apps actually pass in a
non NULL value for the timezone? Those that don't won't be affected.
Even for those that do, it doesn't introduce any atomic ops or
unpredictable branches, or cacheline pressure (because xtime lock is
already touched by do_gettimeofday). IOW: I'm sure it would be
unmeasurable.

OTOH, to be completely correct, it seems like the same xtime_lock
read section should cover both the calculation of ktv, and that of
ktz. So if it is going to be fixed at all, it should be done
properly and looks like it needs to be a bit more intrusive (but
no more expensive).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
