Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272393AbTGYXxt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 19:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272395AbTGYXxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 19:53:49 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:27866
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S272393AbTGYXxr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 19:53:47 -0400
Message-ID: <3F21C68E.4080209@candelatech.com>
Date: Fri, 25 Jul 2003 17:08:46 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Sipek <jeffpc@optonline.net>
CC: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Net device byte statistics
References: <E19fqMF-0007me-00@calista.inka.de> <20030725105818.6bc97653.rddunlap@osdl.org> <20030725215548.GB25838@pegasys.ws> <200307251852.03441.jeffpc@optonline.net>
In-Reply-To: <200307251852.03441.jeffpc@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Sipek wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Friday 25 July 2003 17:55, jw schultz wrote:
> 

>>My thought would be to use 96bits for each counter.  In-kernel
>>code would run periodically doing something like this:
>>
>>	curval = counter.in_kernel;
>>			/* get it in a register for atomicity */
>>	if (counter.user_low < curval)
>>		++counter.user_high;
>>	counter.user_low = curval;

What about every 30 seconds or so, detect wraps, and bump the 'high' counter
if it wraps.  (Check more often if you can wrap more than once in 30 secs).

Then, upon read by user-space (or whatever needs 64-bit counters):

1) check wrap
2) grab low bits and OR them with the high bits.
3) check wrap again.  If wrap happened, try again.  Assumption is it could never wrap
    more than once during the time you are checking.

I think this could give us very low overhead, and extremely precise 64-bit
reads.  And, I think it would not need locks in the fast path..but I could
also be missing something :)




-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


