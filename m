Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318614AbSHLCaI>; Sun, 11 Aug 2002 22:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318622AbSHLCaI>; Sun, 11 Aug 2002 22:30:08 -0400
Received: from h-66-134-202-53.SNVACAID.covad.net ([66.134.202.53]:11663 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318614AbSHLCaH>; Sun, 11 Aug 2002 22:30:07 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 11 Aug 2002 19:33:44 -0700
Message-Id: <200208120233.TAA16322@adam.yggdrasil.com>
To: ryan.flanigan@intel.com
Subject: Re: 2.5.31: modules don't work at all
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Flanigan writes:
>>>>>> "Andrew" == Andrew Rodland <arodland@noln.com> writes:
>
>    Andrew> On Sun, 11 Aug 2002 14:41:36 +0200 "Michel Eyckmans (MCE)"
>    Andrew> <mce@pi.be> wrote:
>
>    >> After upgrading from 2.5.30 to 2.5.31, nothing related to
>    >> modules works for me. Insmod, rmmod, you name it. They all
>    >> cause errors along the line of: "QM_SYMBOLS: Bad Address". Any
>    >> suggestions?
>
>    Andrew> Ditto here.  Ryan: Yes, CONFIG_PREEMPT is set.
>
>try "unsetting" it.  (same problem on the 2.5.31 kernels where i had it set)

	I am also experiencing modules not working with CONFIG_PREEMPT
set, and deactivating CONFIG_PREEMPT works around the problem for me too.

	Ryan, thanks for suggesting that, as it would have taken me a
long time to narrow it down that far!

	It would help avoid duplication of effort if you could indicate
how along you are with this problem.  If you or someone else has nailed
the problem and is preparing a patch, then there is no point in anyone
else trying to duplicate that debugging effort.  On the other hand,
if you just noticed CONFIG_PREEMPT was the difference between your
configuration and that of someone else who was running 2.5.31 successfully
and are not actively debugging the problem, then I'll try to poke at it
some more.

	I already know that the error that trips insmod occurs at
in modules.c, line 831, when qm_symbols gets an error from copy_to_user():

        for (; i < mod->nsyms ; ++i, ++s, vals += 2) {
                len = strlen(s->name)+1;
                if (len > bufsize)
                        goto calc_space_needed;

here------>     if (copy_to_user(strings, s->name, len)
                    || __put_user(s->value, vals+0)
                    || __put_user(space, vals+1))
                        return -EFAULT;

                strings += len;
                bufsize -= len;
                space += len;
        }

	The values of strings and s->name are similar in 2.5.30+preempt
(works) and 2.5.31+preempt (does not work).  strings is 0x08______, and
s->name is 0xc0______.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
