Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265706AbUGHCbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265706AbUGHCbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 22:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUGHCbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 22:31:33 -0400
Received: from mail.inter-page.com ([12.5.23.93]:6155 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S265291AbUGHCbY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 22:31:24 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Sean Neakums'" <sneakums@zork.net>, <jan@talentex.demon.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: malloc overlap?
Date: Wed, 7 Jul 2004 19:31:12 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAOvmnDDtgE0WvXVi7klPGDAEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <6ufz8dmkv1.fsf@zork.zork.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Err, not to contradict... DON'T DO:

x = realloc(x,s);

You should do:

tmp = realloc(x,s);
if (tmp) {
   x = tmp;
} else {
   /* do something about being out of memory */
}

In the first (wrong) case, if there isn't enough memory to move x, and x must be
moved, then the result will be NULL and the original x is still valid at the old
address.  Without the conditional you can get quite a mess.

Also be aware that if s == 0, the block will be freed, tmp will be null and x will be
worthless.

Whatever you are doing, from what I read of your original question, you should
probably suck-it-up and manage the memory properly/separately unless there is some
rare and supreme reason to do otherwise.  These clever tricks will end up hurting you
a lot.

If you *absolutely* must get clever like this, try going the other way, allocate the
first structure with the (largest legal) extent already attached, and then, if you
are feeling frugal, "trim it down" with realloc.  "Shrinking" is always(TM) better
than growing (with all the customary warnings and caveats for the word "always" 8-).

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of Sean Neakums
Sent: Wednesday, June 30, 2004 2:55 AM
To: jan@talentex.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: malloc overlap?

jan@talentex.demon.co.uk writes:

> I am developing a program that mallocs a struct, which contains a
> pointer to another struct, which gets malloced. Then I realloc the
> first buffer to be one element larger and assign something to an
> element in the second element - and this action overwrites part of the
> second level struct. After much tracing I am now sure that the buffers
> somehow have come to overlap. Is this a known error? I imagine that if
> the kernel had this kind of problem, it wouldn't run far, but surely
> memory allocation is handled in the kernel?

malloc is implemented in userspace, typically by the C library, which
uses lower-elvel mechanisms to obtain memory from the kernel.

How are you calling realloc?  It must be called thus:

    x = realloc(x, s);

since the block will have to be moved if there is no space after it
into which to expand.  Given that you allocated the block at x,
another block, and then expanded the block at x, I think this may be
what's happening.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



