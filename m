Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWGEHGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWGEHGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 03:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWGEHGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 03:06:55 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:24921 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751053AbWGEHGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 03:06:54 -0400
Message-ID: <44AB650A.7070807@tls.msk.ru>
Date: Wed, 05 Jul 2006 11:06:50 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] MODALIAS support for SCSI devices (try 1)
References: <20060704203410.5B70391F1@gandalf.tls.msk.ru> <20060704214427.5CB9248B8F4@tzec.mtu.ru>
In-Reply-To: <20060704214427.5CB9248B8F4@tzec.mtu.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
[]
>> The modalias format is like this:
>>
>>  scsi:type-0x04

That's actually scsi:t-0x04 in the patch.  But it makes no real
difference and is trivial to adjust.

>> (for TYPE_WORM, handled by sr.c now).
>>
>> Several comments.
>>
>> o This hexadecimal type value is because all TYPE_XXX constants
>>   in include/scsi/scsi.h are given in hex, but __stringify() will
>>   not convert them to decimal (so it will NOT be scsi:type-4).
>>   Since it does not really matter in which format it is, while
>>   both modalias in module and modalias attribute match each other,
>>   I descided to go for that 0x%02x format (and added a comment in
>>   include/scsi/scsi.h to keep them that way), instead of changing
>>   them all to decimal.
> 
> well, I started with the same but then changed my mind.
> 
> - is it possible that in future some more information may be added? Like
> vendor ID, product ID or whatever? At least in one case SCSI type is not
> enough to distinguish between drivers (st vs. osst Onstream tapes).

Yeah, as mentioned in my second comment - it's the same as 8139cp vs
8139too drivers.

But sure it's possible to change the things in the future, since it's
all internal to kernel - the only requirement is that modalias device
attribute should match module alias attributes.

> - it makes sense to redo bus matching then; which requires some sort of
> explicit ID table anyway.

Oh well.  I don't think it's worth the effort really.  Only 4 drivers so
far (sd, sr, st and osst).  The only reason to try harder is to avoid
loading of osst for non-osst tapes.  But I don't think it's a big deal
to load osst module -- it's harmless, and after all, it's always possible
to "blacklist" it on a particular machine, just like some people do with
8139cp module.

> Unfortunately I do not have the patch ready as yet; may be end of week.
> 
>> o There was no .uevent routine for SCSI bus.  It might be a good
>>   idea to add some more ueven environment variables in there.
>>
>> o osst.c driver handles tapes too, like st.c, but only SOME tapes.
>>   With this setup, hotplug scripts (or whatever is used by the
>>   user) will try to load both st and osst modules for all SCSI
>>   tapes found, because both modules have scsi:type-0x01 alias).
>>   It is not harmful, but one extra module is no good either.
>>   It is possible to solve this, by exporting more info in
>>   modalias attribute, including vendor and device identification
>>   strings, so that modalias becomes something like
>>     scsi:type-0x12:vendor-Adaptec LTD:device-OnStream Tape Drive
>>   and having that, match for all 3 attributes, not only device
>>   type.  But oh well, vendor and device strings may be large,
>>   and they do contain spaces and whatnot.
>>   So I left them for now, awaiting for comments first.
> 
> We can go the PCMCIA way that stores string hashes; like in
> 
>         Identification: manf_id: 0x0156 card_id: 0x0002
>                         function: 6 (network)
>                         prod_id(1): "TOSHIBA" (0xb4585a1a)
>                         prod_id(2): "Wireless LAN Card" (0x0b537c13)
>                         prod_id(3): "Version 01.01" (0xd27deb1a)
>                         prod_id(4): --- (---)

BTW, a question for osst folks (Willem Riede?) -- why osst checks for
both vendor and device strings, isn't it sufficient to just check vendor
for "OnStream" ?  Just curious maybe...

> strictly speaking, modalias real value is not relevant, we are going to
> do "modprobe $modalias" anyway without even looking at it.

Sure thing - that's why I said it makes no difference whenever to use
hex or dec values.

/mjt
