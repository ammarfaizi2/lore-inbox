Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271718AbTGXQyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 12:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271717AbTGXQyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 12:54:05 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:31885 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S271718AbTGXQwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 12:52:35 -0400
Message-ID: <3F2012F8.8030103@pacbell.net>
Date: Thu, 24 Jul 2003 10:10:16 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: weissg@vienna.at, kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] OHCI problems with suspend/resume
References: <20030723220805.GA278@elf.ucw.cz> <3F1F342F.70701@pacbell.net> <20030724102432.GB228@elf.ucw.cz>
In-Reply-To: <20030724102432.GB228@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!

Good morning to you too!


>>>In 2.6.0-test1, OHCI is non-functional after first suspend/resume, and
>>>kills machine during secon suspend/resume cycle.
>>
>>Hmm, last time I tested suspend/resume it worked fine.
>>That was 2.5.67, but the OHCI code hasn't had any
>>relevant changes since then.
> 
> 
>>Evidently your system used different suspend/resume paths
>>than mine did ... :)
> 
> 
> Can you try echo 4 > /proc/acpi/sleep? echo 3 breaks it, too, but that
> is little harder to set up.

I usually test with "apm -s" ... since I've yet to come up with
an ACPI configuration that works properly.  IRQ misconfiguration
for USB is still a blocking issue for many people (not just me).

Going through ACPI would certainly explain some breakage; it's
been sufficiently troublesome with USB that it's not gotten much
testing at all.  I happened to notice this morning that ACPI's
USB IRQ problems are one of the longest-standing open 2.6 bugs:
http://bugme.osdl.org/show_bug.cgi?id=10 ... and it's now been
migrated into the 2.4.22-pre series (sigh).

Could you try reproducing this failure using just APM?  I could
believe there's a generic PM issue (I've been expecting 2.6-test
to eventually start shaking PM out); but given the amount of
trouble ACPI has caused, we should first rule that factor out.


>>>What happens is that ohci_irq gets ohci->hcca == NULL, and kills
>>>machine. Why is ohci->hcca == NULL? ohci_stop was called from
>>>hcd_panic() and freed ohci->hcca.
>>
>>Then the problem is that an IRQ is still coming in after the
>>HCD panicked.
> 
> 
> Actually, as PCI interrupts are shared, I do not find that too
> surprising. 

I do.  Sharing is irrelevant.  If it's been cleaned up, then
the IRQ should no longer be bound to that device.



>>>I believe that we should
>>>
>>>1) not free ohci->hcca so that system has better chance surviving
>>>hcd_panic()
>>
>>Not ever????
>>
>>It's freed in exactly one place, after everything should be
>>shut down.  If it wasn't shut down, that was the problem.
>>
>>Could you instead figure out why it wasn't shut down?
> 
> 
> In case of hcd_panic(), where is interrupt deallocated?

I'll have to check that out, but I noticed that one of my
usual development machines (on which suspend/resume can
actually be made to work) is now unusable due to some PCI
initialization issue with Cardbus.


>>>and 
>>>
>>>2) inform user when hcd panics.
>>
>>The OHCI code does that already on the normal panic path
>>(controller delivers a Unrecoverable Error interrupt), but
>>you're right that this would be better as a generic KERN_CRIT
>>diagnostic.  (But one saying which HCD panicked, rather than
>>leaving folk to guess which of the N it applied to...)  And
>>I'd print that message sooner, not waiting for that task to
>>be scheduled.
> 
> 
> That would be good. I definitely had another failure path, where it
> did not tell me that hcd is no K.O...

I'll likely submit that to Greg in the next few days, cc you.

- Dave




> 								Pavel


