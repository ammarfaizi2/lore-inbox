Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUEZSyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUEZSyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 14:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUEZSyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 14:54:21 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:49651 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S265772AbUEZSyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 14:54:18 -0400
Message-ID: <40B4E90C.6000202@easyco.com>
Date: Wed, 26 May 2004 11:59:24 -0700
From: Doug Dumitru <doug@easyco.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Hard Hang with __alloc_pages: 0-order allocation failed (gfp=0x20/1)
 - Not out of memory
References: <40B3C816.6030802@easyco.com> <20040525161212.6478216e.davem@redhat.com> <20040526125921.GJ6439@logos.cnet>
In-Reply-To: <20040526125921.GJ6439@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> On Tue, May 25, 2004 at 04:12:12PM -0700, David S. Miller wrote:
> 
>>On Tue, 25 May 2004 15:26:30 -0700
>>Doug Dumitru <doug@easyco.com> wrote:
>>
>>
>>>This is the original trap dump from a __page_alloc error
>>>
>>>__alloc_pages: 0-order allocation failed (gfp=0x20/1)
>>
>>0x20 means GFP_ATOMIC which means it's fine to fail
>>and e1000 is doing nothing wrong.  GFP_ATOMIC in interrupts
>>is a fine condition.
> 
> 
> Yeap, but the crash is not a fine condition... I suspect
> what can be happening is extreme gigabit traffic resulting in 
> memory shortage.
> 
> Doug said the load average is really high. Doug, you're not
> using NAPI, right? Can you try it?

Prior to the __page_alloc hang, the loadavg shoots way up, so something 
is spinning, but it is hard to tell what.  This has persisted for as 
long as 8-10 minutes on one hang, although it is usually shorter (1-2 
minutes).  One of my concerns is that the e1000 issue might only be a 
symptom of the page tables getting clobbered by something else.  I have 
been trying to get the system to hang during more "controlled" usage, 
but have been unable to.  I have even run tsl (telnet scripting 
language) scripts to logon 250 processes and beat the CPU and disk up, 
creating and destroying processes along the way.  I was able to drive 
loadavg > 50 and LowFree to < 5000K, but could never create a hang.  I 
suspect that I might need truely "random" inbound traffic to find the 
bug (but this is a guess).

In terms of network traffic, the system is busy, but not obnoxiously so. 
  The load on the server is primarily terminal traffic from about 200 
"real humans", so there are a lot of small, random packets.  In terms of 
network bandwidth, it is not all that bad, maybe 2-3 megabits (a guess). 
  The arp table is reasonably big (> 200 entries) but this is not that 
bad either.  I have not looked for arp storms or other network anomolies 
on the LAN.  The system is on a local LAN and gets no internet traffic.

I am unfamiliar with NAPI, so I have not tried it.

On another topic, I am trying to build a 2.4.26 kernel that reserves 
more LowFree.  The mm/page_alloc.c file describes a boot parameter 
called "lower_zone_reserve" that should tune this.  Unfortunately, this 
parameter seems to be read after the zone tables are initialized (which 
is probably a bug).

-- 

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------
