Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVBATCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVBATCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 14:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVBATCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 14:02:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:43136 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261908AbVBATBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 14:01:40 -0500
Message-ID: <41FFD20D.4030105@us.ibm.com>
Date: Tue, 01 Feb 2005 13:01:33 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
References: <41ED27CD.7010207@us.ibm.com> <1106161249.3341.9.camel@localhost.localdomain> <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston> <1106841228.14787.23.camel@localhost.localdomain> <41FA4DC2.4010305@us.ibm.com> <20050201072746.GA21236@kroah.com> <41FF9C78.2040100@us.ibm.com> <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk> <41FFBDC9.2010206@us.ibm.com> <20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Tue, Feb 01, 2005 at 11:35:05AM -0600, Brian King wrote:
> 
>>>If we've done a write to config space while the adapter was blocked,
>>>shouldn't we replay those accesses at this point?
>>
>>I did not think that was necessary.
> 
> 
> We have to do *something*.  We can't just throw away writes.
> 
> I see a few options:
> 
>  - Log all pending writes to config space and replay the log when the
>    device is unblocked.

This would need to be dynamic in size, as a device could be blocked for 
a long time. In the scenario that this is used for power management and 
the device could be blocked for a long time, its unclear that we would 
still want all the writes accumulated to be written out when the device 
becomes unblocked.

>  - Fail writes to config space while the device is blocked.

This would be nice and simple. I know Alan had some issue with returning 
failures on reads when blocked.

Alan - do you have the same issue on writes?

>  - Write to the saved config space and then blat the saved config space
>    back to the device upon unblocking.

Would also be pretty simple to do and seems a little safer than 
potentially assaulting the recently unblocked device with who knows what 
values. The only problem I see with this is that we could end up 
returning strange values on cached reads if the writes update the cache. 
If userspace wrote to a read only register, we would end up returning 
that value on the read, which may not be the right thing to do.

> Any other ideas?

We could go back to Alan's idea of putting userspace reads/writes to 
sleep when the device is blocked, although this has additional 
complications as well...

> BTW, you know things like XFree86 go completely around the kernel's PCI
> accessors and poke at config space directly?

The purpose of this API is to provide a way for the kernel to stop 
userspace from accessing PCI devices when the results of doing so would 
be catastrophic, such as a PCI bus error. The only users of this API so 
far are device drivers running BIST on an adapter (which shouldn't 
happen on a video card AFAIK) and for PPC power management (Ben - will 
this be an issue for you?)

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
