Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753458AbWKCSs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbWKCSs2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbWKCSs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:48:28 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:22926 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1753458AbWKCSs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:48:27 -0500
Date: Fri, 3 Nov 2006 19:48:26 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.61.0611031349490.9606@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0611031945220.30722@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <454A71EB.4000201@googlemail.com> <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
 <454AA4C5.3070106@googlemail.com> <Pine.LNX.4.61.0611030911540.13091@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0611031248030.17174@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.64.0611031257400.17174@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.61.0611031349490.9606@yvahk01.tjqt.qr>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> So anyway, why do you need _llseek? Can't you just use lseek() like
>>>> everyone else?
>>>
>>> Because I want it to work with glibc 2.0 that I still use on one machine.
>>
>> BTW. is it some interaction with symbols defined elsewhere or were _syscall
>> macros dropped altogether? Which glibc symbol should I use in #ifdef to tell if
>> glibc has 64-bit support?
>
> -D_LARGEFILE_SOURCE=1 -D_LARGE_FILES -D_FILE_OFFSET_BITS=64
>
> I think the second is not needed.

I see, but the question is how do I test in C preprocessor that glibc is 
sufficiently new to react on them?

Now I changed it to:
#ifdef __linux__
#if !defined(__GLIBC__) || __GLIBC__ < 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ < 1)
#include <asm/unistd.h>
#ifdef __NR__llseek
#define use_llseek
static _syscall5(int, _llseek, uint, fd, ulong, hi, ulong, lo, loff_t *, 
res, uint, wh);
#endif
#endif

So we see if someone else runs into problem.

Mikulas
