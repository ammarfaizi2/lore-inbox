Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTJXIqI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 04:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbTJXIqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 04:46:08 -0400
Received: from smtp3.Stanford.EDU ([171.64.14.172]:8624 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262076AbTJXIqD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 04:46:03 -0400
Message-ID: <3F98E674.6090104@stanford.edu>
Date: Fri, 24 Oct 2003 01:44:36 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b; MultiZilla v1.5.0.1) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, glasgow@beer.net,
       albert@users.sourceforge.net
Subject: Re: posix capabilities inheritance
References: <fa.n4rmmgg.2423pm@ifi.uio.no> <fa.l1oevhb.1s5k583@ifi.uio.no>
In-Reply-To: <fa.l1oevhb.1s5k583@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to everyone for making me realize just how complex / screwed up all of 
this is.  I think it's fair to say that something should be fixed/changed, but I 
don't think that a quick patch is a good idea -- currently capabilities are so 
limited that there is little userspace use, and the use that exists is pretty 
much limited to Ernie's example.  Witness the fact that my patch, as well as 
others, appear to break _nothing_.  That means that we have the opportunity (2.7 
timeframe here) to overhaul the system _once_.


At the risk of premature discussion, here are some thoughts:


1. pI is currently almost useless.  If a process really wants a capability to be 
dropped after exec, it can drop it itself.  So redefine pI to mean "these are 
the only capabilities that this process or its children may _ever_ hold."

2. fE is useless.  It doesn't seem to have much of a point, and it just adds 
complexity.  (e.g. look at Windows privileges.  they start unenabled, and 
programs have to jump through hoops to use them.  I see no security benefit.) 
So remove fE entirely.

3. The current use of the capability bits is not as fine-grained as it could be, 
and lacks the ability to restrict normal users.  Redefine it as:
  Capability range             Function
  ----------------             -----------------
  <0                           On by default
  0-31                         Legacy bounds (see below)
  >=32                         Off by default

All of the current capabilities retain their current values.  New capabilities 
above 32 can have a "legacy bound" associated with them, like this:

_u32 legacy_bounds[] = {...};

bool capable(int cap)
{
	if(x<32) return (cap in effective set);
	else return ( (legacy_bounds[cap] & (bits 0-31 of effective set))
	 && (cap in effective set) );
}

This ensures that existing programs that think they have dropped capabilities 
(using the old numbering) really have dropped those capabilities.  New programs 
can do whatever they want, using the new numbering.  Some random thoughts of 
what the "new" capabilities might look like (where CAP_USER_ means <0 and 
CAP_ADM_ means >=32):

Completely new things:
CAP_USER_FSUID /* permission checks can use fsuid */
CAP_USER_FSGID /* permission checks can use fsgid */
CAP_USER_FSWRITE /* can write files */
Saner version of existing features (CAP_SYS_ADMIN, anyone?)
CAP_ADM_MOUNT_BLOCK /* can mount block devices */
CAP_ADM_MOUNT_NONE /* can mount things that are not block devices */

This could be very nice for administrators.  Maybe a large block of capability 
space could be reserved for userspace use.  (Make capabilities 64 bits?  Fun!) 
Albert -- this fixes one of your complaints.


Capability evolution might look like this:
pI' = pI & fI
pP' = ((fP & X) | pP) & pI'
pE' = pP' & (pE|fP) & (only caps <0 if uid==0 and setuid nonroot)

By the way, even if people are scared of programs mishandling fP!=0, this still 
seems very useful just to adjust "per-user" rights.

If there's enough interest, I might try to implement this in the next few weeks 
and get it ready for 2.7.  There's the risk that if any new scheme goes into a 
mainline development kernel, then people will start using it, and it will be 
impossible to change it, which is why I'm floating this around now.  I don't see 
any reason to keep the current system, and, given that there is no de-facto *nix 
capability standard, Linux might as well have the best capability system out there.

Any thoughts/suggestions/flames?

Andy

