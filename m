Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280211AbRJaNkq>; Wed, 31 Oct 2001 08:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280210AbRJaNkh>; Wed, 31 Oct 2001 08:40:37 -0500
Received: from [195.66.192.167] ([195.66.192.167]:46344 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280206AbRJaNkZ>; Wed, 31 Oct 2001 08:40:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [Patch] Re: Nasty suprise with uptime
Date: Wed, 31 Oct 2001 15:39:00 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.30.0110311218470.28509-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.30.0110311218470.28509-100000@gans.physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01103115390007.00794@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 October 2001 11:35, Tim Schmielau wrote:
> The appended patch enables 32 bit linux boxes to display more than
> 497.1 days of uptime. No user land application changes are needed.
>
> Credit is due to George Anzinger and the High-res-timers project
> at https://sourceforge.net/projects/high-res-timers/, where I ripped
> out the 64 bit jiffies patch. However, I do claim ownership on
> all misdesign and bugs since this is my first kernel patch.
>
> My Intel box just now displays a (faked, of course) uptime of 497 days,
> 2:38 hours, so the 32 jiffies value has wrapped without problems about 10
> minutes ago.
>
> Next step would be to decide what to do with the start_time field of
> struct task_struct, which is still 32 bit, so ps on my box believes some
> processes to have started 497 days ago. Probably there are tons of other
> uses for the upper 32 bit of jiffies as well.

Hmm.... 64bit jiffies are attractive.

I'd like to see less #defines in kernel
Some parts of your patch fight with the fact that jiffies
is converted to macro -> it is illegal now to have local vars
called "jiffies". This is ugly. I know that there are tons of similarly
(ab)used macros in the kernel now but let's stop adding more!

This test prog shows how to make overlapping 32bit and 64bit vars.
It works for me.
 
#include <stdio.h>
typedef unsigned long long u64;

extern u64 jiffies_64;
extern unsigned long jiffies;
extern unsigned long jiffies_hi;

asm(
"	.bss\n"
"	.align 8\n"
".globl jiffies_64\n"
".globl jiffies\n"
".globl jiffies_hi\n"
"jiffies_64:\n"
// <- a bunch of ifdefs needed here to sort out endianness stuff...
"jiffies:\n"
"	.zero	4\n"
"jiffies_hi:\n"
"	.zero	4\n"

//not working!? how to return to prev .data/.text/whatever?
//I don't know gas...
//"	.previous\n"
);

int main() {
    jiffies_64 = 0xFEDCBA9876543210UL;
    printf("lo: 0x%08x\n",jiffies);
    printf("hi: 0x%08x\n",jiffies_hi);
    return 0;
}

Is this better or not? If not, why?
--
vda
