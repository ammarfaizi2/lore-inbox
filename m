Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVJSPBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVJSPBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVJSPBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:01:10 -0400
Received: from mail.dvmed.net ([216.237.124.58]:61346 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751014AbVJSPBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:01:08 -0400
Message-ID: <43565FB1.50301@pobox.com>
Date: Wed, 19 Oct 2005 11:01:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dsaxena@plexity.net
CC: linux-kernel@vger.kernel.org, jgarzik@pobox.net, akpm@osdl.org,
       tony@atomide.com
Subject: Re: [patch 0/5] RNG cleanup & new drivers attempt #1
References: <20051019081906.615365000@omelas>
In-Reply-To: <20051019081906.615365000@omelas>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dsaxena@plexity.net wrote:
> - Allow a fastpath where we don't even have the user space portion
>   and the HW drivers just feed the entropy pool directly. While
>   this bypasses the FIPS tests and such, there are some applications
>   where this is OK or where we really don't want the extra proccess 
>   context switching. This is specially true on ARM. I'll have to add 
>   IRQ driven support to the drivers to that, but that's trivial. There 
>   is also some HW (MPC8xxx for example) that does periodic self-tests 
>   in HW and lists itself as "FIPs-compliant" and will trigger an error if 
>   data should no longer be trusted and in that case doing a software
>   test might also be undesirable. But...we should let the user decide
>   at build time (or runtime?).

Not interesting in pursuing this path.  This has been discussed 
endlessly, check the archives.

We want the FIPS tests.  Hardware (especially cheap hardware) is often 
known to go haywire.  Trusting hardware to do the FIPS tests is pretty 
silly, since you're trusting the piece that might go haywire to tell you 
its OK.  RNGs have a history of suddenly providing non-random data, for 
a variety of reasons (usually poor board wiring).

We also want the userspace daemon because that gives the sysadmin far 
more control over how much entropy is added to the system.  99.9% of the 
cases in the real world, we don't want the RNG pumping entropy into the 
pool at full speed.  That will likely pump in more data than a system 
needs, chewing CPU.  The admin can't even kill the daemon to reclaim his 
CPU, if its all in-kernel.

It's not brain surgery, to concoct a method by which an interrupt-driven 
device is used from userspace.

	Jeff


