Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRJJGAs>; Wed, 10 Oct 2001 02:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274851AbRJJGAk>; Wed, 10 Oct 2001 02:00:40 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:10998 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S274368AbRJJGAX>; Wed, 10 Oct 2001 02:00:23 -0400
Message-ID: <3BC3E424.1070901@wipro.com>
Date: Wed, 10 Oct 2001 11:31:08 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
In-Reply-To: <Pine.LNX.4.33.0110092236210.1305-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:

>On Wed, 10 Oct 2001, BALBIR SINGH wrote:
>
>>>And THAT is the hard part. Doing lookup without locks ends up being
>>>pretty much worthless, because you need the locks for the removal
>>>anyway, at which point the whole thing looks pretty moot.
>>>
>>What about cases like the pci device list or any other such list. Sometimes
>>you do not care if somebody added something, while you were looking through
>>the list as long as you do not get illegal addresses or data.
>>Wouldn't this be very useful there? Most of these lists come up
>>at system startup and change rearly, but we look through them often.
>>
>
>It's not about "change rarely". You cannot use a non-locking lookup if
>they _ever_ remove anything.
>
>I can't think of many lists like that. The PCI lists certainly are both
>add/remove: cardbus bridges and hotplug-PCI means that they are not just
>purely "enumerate at bootup".
>

I agree, I just thought of one case quickly. Assume that somebody did a cat /proc/pci.
Meanwhile somebody is adding a new pci device (hotplug PCI) simultaneously (which is very rare).
I would not care if the new device showed up in the output of /proc/pci this time. It would
definitely show up next time. Meanwhile locking the list (just in case it changes) is an
overhead in the case above. I was referring to these cases in my earlier mail.
   

>
>Sure, maybe there are _some_ things that don't need to ever be removed,
>but I can't think of any interesting data structure off-hand. Truly static
>stuff tends to be allocated in an array that is sized once - array lookups
>are much faster than traversing a linked list anyway.
>
>So the linked list approach tends to make sense for things that _aren't_
>just static, but I don't know of anything that only grows and grows. In
>fact, that would sound like a horrible memory leak to me if we had
>something like that. Even slow growth is bad if you want up-times measured
>in years.
>
>Now, in all fairness I can imagine hacky lock-less removals too. To get
>them to work, you have to (a) change the "next" pointer to point to the
>next->next (and have some serialization between removals, but removals
>only, to make sure you don't have next->next also going away from you) and
>(b) leave the old "next" pointer (and thus the data structure) around
>until you can _prove_ that nobody is looking anything up any more, and
>that the now-defunct data structure can truly be removed.
>
The problem with removals is that somebody could be adding an element simulataneously
to the "next" element. Which might cause problems. I hope I correctly understood
the scenario here.

>
>However, apart from locking, there aren't all that many ways to "prove"
>that non-use. You could probably do it with interesting atomic sequence
>numbers etc, although by the time you generate atomic sequence numbers
>your lookup is already getting heavier - to the point where locking
>probably isn't so bad an idea any more.
>
>		Linus
>
>
Balbir



--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
