Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbUCERVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 12:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUCERVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 12:21:44 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:5617 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262668AbUCERVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 12:21:42 -0500
Message-ID: <4048B720.4010403@nortelnetworks.com>
Date: Fri, 05 Mar 2004 12:21:36 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: problem with cache flush routine for G5?
References: <40479A50.9090605@nortelnetworks.com>	 <1078444268.5698.27.camel@gaston>  <4047CBB3.9050608@nortelnetworks.com>	 <1078452637.5700.45.camel@gaston>  <404812A2.70207@nortelnetworks.com> <1078465612.5704.52.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>Assuming that I really did want to flush the whole cache, how would I go 
>>about doing that from userspace? 
>>
> 
> I don't think you can do it reliably, but again, that do not make
> sense, so please check with those folks what's exactly going on.

I've gotten some more information on what's going on.

We have a proprietary OS (originally written for custom hardware) that 
is running on a thin emulation layer on top of linux.

This OS allows runtime patching of code.  After changing the 
instruction(s), it then has to make sure that the icache doesn't contain 
stale instructions.

The original code was written for ppc hardware that had the ability to 
flush the whole dcache and invalidate the whole icache, all at once, so 
that's what they used.  The code doesn't track the address/size of what 
was changed.  For our existing products, we are using the 74xx series, 
and they've got hardware cache flush/invalidate as well, so we just kept 
using that.  For the 970 however, that hardware mechanisms seem to be 
absent, which started me on this whole path.

After doing some digging in the 970fx specs, it seems that we may not 
need to explicitly force a store of the L1 dcache at all.  According to 
the docs, the L1 dcache is unconditionally store-through. Thus, for a 
brute-force implementation we should be able to just invalidate the 
whole icache, do the appropriate sync/isync, and it should pick up the 
changed instructions from the L2 cache.  Do you see any problems with 
this?  Do I actually still need the store?

Of course, the proper fix is to change the code in the OS running on the 
emulator to track the addresses that got changed and just do the minimal 
work required.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

