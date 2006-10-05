Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWJEWQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWJEWQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWJEWQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:16:43 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:22146 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932343AbWJEWQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:16:42 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4525842F.3040109@s5r6.in-berlin.de>
Date: Fri, 06 Oct 2006 00:16:15 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net
Subject: Re: ohci1394 regression in 2.6.19-rc1 (was Re: Merge window closed:
 v2.6.19-rc1)
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <45255574.5020203@s5r6.in-berlin.de> <200610052130.28610.s0348365@sms.ed.ac.uk> <200610052132.11544.s0348365@sms.ed.ac.uk>
In-Reply-To: <200610052132.11544.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Thursday 05 October 2006 21:30, Alistair John Strachan wrote:
> [snip]
>> I haven't tried to use it, but I agree that the outcome is similar. I
>> recompiled with excessive debug output on 2.6.19-rc1, and uploaded the
>> configs for 2.6.19-rc1 and 2.6.18, and the corresponding dmesg outputs. As
>> you can see, 2.6.18 does not exhibit any problems.
> 
> Forgetting the URL; apologies:
> 
> http://devzero.co.uk/~alistair/ieee1394/

Thanks. From the 2.6.19-rc1 dmesg: The ieee1394 core inserts a packet
before there was the first bus reset and first self ID stage completed.
This shouldn't happen. Also, the packet looks a bit weird but that is
probably because some base variables are still zero when this packet is
sent:

[   39.513301] ieee1394: send packet at S100: ffc00140 0000ffff f0000234

destination = ffc0: node 0 on local FireWire bus (this is the host's
node; there isn't any other one anyway)
transaction label = 0: OK
retry code = 1: bogus, should be 0 as the first attempt
transaction code = 4: quadlet read request (usually used "much" later by
higher-level code, i.e. ieee1394's nodemgr, after self ID stage was
properly completed plus a pause)
pri = 0: OK
source ID = 0000: not OK, should be ffc0 on proper packets
destination offset = ffff f000 0234: this is the address of the
BROADCAST_CHANNEL register (usually read "much" later by ieee1394's
nodemgr to probe capabilities of an IRM: nodemgr_check_irm_capability()
calls this.)

It does indeed look like the nodemgr kicked in prematurely. After some
other messages from lower levels and from different contexts, there is
also a sign of nodemgr_check_irm_capability() failing (it can only fail
this early):

[   40.298112] ieee1394: Current remote IRM is not 1394a-2000 compliant,
resetting...

OK. Enough with the boring details. Maybe the following patch doesn't
work entirely as I intended:
"ieee1394: nodemgr: switch to kthread api, replace reset semaphore"
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=d2f119fe319528da8c76a1107459d6f478cbf28c

I think if you revert the next patch first...
"ieee1394: nodemgr: convert nodemgr_serialize semaphore to mutex"
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=cab8d154e2ed43fe1495aa0e18103e747552891b

...you can then revert the 'switch to kthread' patch and see if the
message "Running dma failed because Node ID is not valid" disappears.
Would be nice if you could test that.
-- 
Stefan Richter
-=====-=-==- =-=- --=-=
http://arcgraph.de/sr/
