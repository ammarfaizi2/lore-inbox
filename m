Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317547AbSGORDz>; Mon, 15 Jul 2002 13:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317549AbSGORDy>; Mon, 15 Jul 2002 13:03:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15622 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317547AbSGORDx>; Mon, 15 Jul 2002 13:03:53 -0400
Date: Mon, 15 Jul 2002 18:06:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
Message-ID: <20020715180646.B15136@flint.arm.linux.org.uk>
References: <20020715092411.A12082@flint.arm.linux.org.uk> <200207151607.g6FG7In203512@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207151607.g6FG7In203512@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Mon, Jul 15, 2002 at 12:07:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 12:07:18PM -0400, Albert D. Cahalan wrote:
> You have 64, 128, and 1000. See for yourself.
> 
> arch-cl7500/param.h     #define HZ 100
> arch-epxa10db/param.h   #define HZ 100
> arch-integrator/param.h #define HZ 100
> arch-l7200/param.h      #define HZ 128
> arch-shark/param.h      #define HZ 64
> arch-tbox/param.h       #define HZ 1000
> 
> I need to support all of that with one binary.
> So I'm stuck with:

Lets look more closely:

#ifndef HZ
#define HZ 100
#endif
#if defined(__KERNEL__) && (HZ == 100)
#define hz_to_std(a) (a)
#endif

And:

$ grep hz_to_std arch-*/param.h
arch-l7200/param.h:#define hz_to_std(a) ((a * HZ)/100)
arch-shark/param.h:#define hz_to_std(a) ((a * HZ)/100)

As I said, tbox is broken, so ignore that.

And hz_to_std gets used (fs/proc/array.c):

                hz_to_std(task->times.tms_utime),
                hz_to_std(task->times.tms_stime),
                hz_to_std(task->times.tms_cutime),
                hz_to_std(task->times.tms_cstime),

So merely grepping for HZ doesn't actually tell you anything.

All /proc values are in 100Hz units on ARM.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

