Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVAKWV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVAKWV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVAKWUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:20:34 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:23997 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262670AbVAKWRs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:17:48 -0500
Message-ID: <41E45089.4010006@us.ibm.com>
Date: Tue, 11 Jan 2005 16:17:45 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, paulus@samba.org,
       benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com> <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com> <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com> <1105454259.15794.7.camel@localhost.localdomain> <20050111173332.GA17077@muc.de>
In-Reply-To: <20050111173332.GA17077@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, Jan 11, 2005 at 02:37:40PM +0000, Alan Cox wrote:
> 
>>On Llu, 2005-01-10 at 22:57, Brian King wrote:
>>
>>>>For this I would add a semaphore or a lock bit to pci_dev.
>>>>Probably a simple flag is good enough that is checked by sysfs/proc
>>>>and return EBUSY when set. 
>>>
>>>How about something like this... (only compile tested at this point)
>>
>>
>>User space does not expect to get dumped with -EBUSY randomly on PCI
> 
> 
> I think it's a reasonable thing to do.  If you prefer you could fake a
> 0xffffffff read, that would look like busy or non existing hardware.
> But the errno would seem to be cleaner to me.

We can certainly go either way. I decided to go the way I did simply 
because that was what was suggested.

> There may be other reasons to have error codes here in the future
> too - e.g. with the upcomming support for real PCI error handling
> it would make a lot of sense to return EIO in some cases. User space
> will just have to cope with that.
> 
> 
>>accesses. Not a viable option in that form _but_ making them sleep would
>>work - even with a simple global wait queue
>>for the pci_unblock_.. path
>>
>>ie add the following (oh and uninlined probably for compatcness)
>>
>>static int pci_user_wait_access(struct pci_dev *pdev) {
>>	wait_event(&pci_ucfg_wait, dev->block_ucfg_access == 0);
>>}
> 
> 
> I don't like this very much. What happens when the device 
> doesn't get out of BIST for some reason? 
> 
> I think it's better to keep this simple, and an error is fine for that.

Also, Ben Herrenschmidt expressed a desire to use this interface in 
dealing with some power management issues on G5's. The issue is that 
when some devices are powered off on G5 they will not respond to config 
cycles and may even deadlock the system. This usage would require the 
ability to block userspace for an indefinite period of time and also 
make use of the config space caching code that is in my patch.

-Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
