Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264243AbTDJW5h (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbTDJW5h (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:57:37 -0400
Received: from hera.cwi.nl ([192.16.191.8]:34014 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264240AbTDJW5e (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 18:57:34 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 11 Apr 2003 01:09:14 +0200 (MEST)
Message-Id: <UTC200304102309.h3AN9EV07692.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > A different way out, especially when we use 32+32, is to kill this
    > sd_index_bits[] array, and give each disk a new number: replace
    > 	index = find_first_zero_bit(sd_index_bits, SD_DISKS);
    > by
    > 	index = next_index++;

    I wish it is that simple. We use sd_index_bits[] since we could
    sd_detach() and then sd_attach()  few disks. We will end up with
    holes, name slippage without this. We need to know what disks are
    currently being in use.

It is that simple. (At least with 64-bit dev_t.)
Look at the use of sd_index_bits[]. It is static in sd.c.
There is the definition, the first free bit is found (and set)
in sd_attach() to provide our disk with a number, this bit is
cleared again in sd_detach().

That is all. In other words, a mechanism to give an unused number
to each disk for which sd_attach() is called.

Now suppose we do nothing in sd_detach().
Then we don't know which disks have disappeared. Pity.
If the number space is infinite then
	index = next_index++;
gives a new number each time we need one.

Now that it is finite, some estimates are needed. How often
will sd_attach() be called during the uptime of this kernel /
the lifetime of this computer? And how much space is available?

Among 2^64 device numbers, 2^48 reserved for scsi disks
is a very small fraction. With at most 2^12 partitions
on each disk that would leave room for 2^36 disks.
Do you think during the lifetime of this computer a new
scsi disk will be added more than 68 . 10^9 times?
That would be adding 400 disks each second for five years.

You see, 2^64 is not infinite, but it is close.

Andries
