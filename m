Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVCMUzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVCMUzw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 15:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVCMUzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 15:55:52 -0500
Received: from mail.aknet.ru ([217.67.122.194]:40457 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261455AbVCMUzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 15:55:44 -0500
Message-ID: <4234A8DD.9080305@aknet.ru>
Date: Sun, 13 Mar 2005 23:55:57 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@redhat.com>, Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz>
In-Reply-To: <20050313201020.GB8231@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Pavel Machek wrote:
>> +	andl $(VM_MASK | (4 << 8) | 3), %eax
>> +	cmpl $((4 << 8) | 3), %eax
>> +	je ldt_ss			# returning to user-space with LDT SS
> All common linux apps use same %ss, no? Perhaps it would be more
> efficient to just check if %ss == 0x7b, and proceed directly to
> restore_nocheck if not?
Such an optimization will cost three more
instructions, one of which is a "taken"
jump. It seems like the "taken" jump on
a fast path is not good, while now it is
only 5 instructions with a not-taken jump.
I am not sure here, but I think the current
solution is better (depends on how bad the
"taken" jump is, and how bad it is to have
the three extra insns for that optimization
purpose).

> Or perhaps we could only enable this code
> after application loads custom ldt?
The good thing here is that the code
actually does what you say, i.e. it jumps
to ldt_ss only when the app has loaded
the custom ldt and loaded that selector
to %ss. The way it is implemented, is
probably different from what you mean,
I assume you mean the new per-thread flag?
But I don't see how it can be more optimal,
i.e. you propose to check whether or not
the app altered the ldt (which can just be
the old glibc I think), while the current
solution is to also check whether it was
loaded to %ss (so the glibc case is avoided,
IIRC glibc used to load %gs with LDT selector).
I.e. since right now we jump to ldt_ss only
when the %ss is loaded with an LDT selector,
I think the extra checks are not needed.

