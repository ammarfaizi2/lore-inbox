Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288485AbSA3EyS>; Tue, 29 Jan 2002 23:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288511AbSA3Ex5>; Tue, 29 Jan 2002 23:53:57 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:43534 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S288485AbSA3Ex4>; Tue, 29 Jan 2002 23:53:56 -0500
Message-Id: <200201300453.g0U4rYI61847@aslan.scsiguy.com>
To: andersen@codepoet.org
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec 1480b SlimSCSI vs hotplug 
In-Reply-To: Your message of "Tue, 29 Jan 2002 19:52:12 MST."
             <20020130025212.GA5240@codepoet.org> 
Date: Tue, 29 Jan 2002 21:53:34 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue Jan 29, 2002 at 05:48:53PM -0700, Justin T. Gibbs wrote:
>> >Does this look agreeable?
>> 
>> The only thing you've really changed is the class_mask.  I don't
>> understand why testing against *more bits* of the class allows your
>> card to be detected.  Can you explain why the old code fail?
>
>Exactly, the class_mask is the significant bit.  The rest I just
>tidied since I hate seeing magic numbers.

It would make your patch easier to review if you didn't intermingle
style changes with content changes.

>Anyways, I started off
>with the simple observation that it didn't work.  Watching
>/sbin/hotplug (diethotplug with debugging enabled) closely during
>add events showed me the following:

[...]

>Here we can see it is looking at aic7xxx twice, once for vendor
>0x9004, where it notices that the vendor matches, but then fails
>to match due to the 0xFFFF00 class_mask filter, and once for
>vendor 9005 which of course doesn't match.  After changing the
>class_mask to ~0 I now see:

[...]

Changing the mask may have the desired effect, but it doesn't
show where the true bug is.

>So let me turn the question back to you:  What is the intended 
>purpose of masking out part of the class space?

I'm only trying to match on the base and sub class fields.  In
the kernel (see drivers/pci/pci.c), the pci device field is
three bytes wide with the programming interface stored in the
lowest byte and class information in bytes 1 and 2.  Since I only
place the expected class values in my table, not the value for
the programming interface, the low byte needs to be masked away prior
to doing the comparison.  The logic in the kernel handles the
mask correctly:

	((ids->class ^ dev->class) & ids->class_mask) == 0

My guess is that diethotplug is not handling the mask correctly
and thus doesn't work with a partial mask.

--
Justin
