Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWAKBhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWAKBhs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWAKBhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:37:48 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:52723 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S932762AbWAKBhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:37:47 -0500
Message-ID: <43C4614B.40002@mvista.com>
Date: Tue, 10 Jan 2006 17:37:15 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: john stultz <johnstul@us.ibm.com>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Subject: Re: new time code problem
References: <Pine.LNX.4.61.0512220019330.30882@scrub.home> <1136935211.2890.11.camel@cog.beaverton.ibm.com> <43C44A3C.6010803@mvista.com> <200601110023.35374.tglx@linutronix.de>
In-Reply-To: <200601110023.35374.tglx@linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Tuesday 10 January 2006 23:58, George Anzinger wrote:
> 
>>The 64-bit conversion routine to convert 64-bit nsec time to a time spec.
>>gives an unnormalized result if the value being converted is negative.  I
>>think there are two ways to go about fixing this.  Most systems will give a
>>negative remainder and so need to just normalize.  On the other hand, some
>>systems will use div64 to do the division and, I think, it expects unsigned
>>numbers.  The attached patch uses the conservative approach of expecting
>>the div to be set up for unsigned numbers.
>>
>>I came accross this when one of my tests set a time near 1 Jan 1970, i.e.
>>it is a real problem.
> 
> 
>> kernel/time.c |   13 ++++++++-----
>> 1 files changed, 8 insertions(+), 5 deletions(-)
>>
>>Index: linux-2.6.16-rc/kernel/time.c
>>===================================================================
>>--- linux-2.6.16-rc.orig/kernel/time.c
>>+++ linux-2.6.16-rc/kernel/time.c
>>@@ -702,16 +702,19 @@ void set_normalized_timespec(struct time
>>  *
>>  * Returns the timespec representation of the nsec parameter.
>>  */
>>-inline struct timespec ns_to_timespec(const nsec_t nsec)
>>+struct timespec ns_to_timespec(const nsec_t nsec)
>> {
>>        struct timespec ts;
>> 
>>-       if (nsec)
>>+       if (nsec) return (struct timespec){0, 0};
> 
> 
> Err, you mean propably
> 
> 	if(!nsec)
> 		return (struct timespec){0, 0};

Why yes I do.  I even found that and fixed it, but then failed to refresh the 
patch.  Thanks...

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
