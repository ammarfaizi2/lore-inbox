Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWJ3FJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWJ3FJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 00:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWJ3FJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 00:09:24 -0500
Received: from smtpout.mac.com ([17.250.248.182]:46575 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161023AbWJ3FJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 00:09:23 -0500
In-Reply-To: <20061030033834.GJ27968@stusta.de>
References: <Pine.LNX.4.64.0610290610020.6502@localhost.localdomain> <Pine.LNX.4.61.0610291244310.15986@yvahk01.tjqt.qr> <Pine.LNX.4.64.0610290742310.7457@localhost.localdomain> <20061029120534.GA4906@martell.zuzino.mipt.ru> <Pine.LNX.4.64.0610291044230.9726@localhost.localdomain> <slrnek9le5.2vm.olecom@flower.upol.cz> <20061029171855.GF27968@stusta.de> <Pine.LNX.4.64.0610291223520.31583@localhost.localdomain> <20061030033834.GJ27968@stusta.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FFAA1E76-B60F-46AD-B1A0-593517D8EDB1@mac.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Oleg Verych <olecom@flower.upol.cz>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: why test for "__GNUC__"?
Date: Mon, 30 Oct 2006 00:08:42 -0500
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 29, 2006, at 22:38:34, Adrian Bunk wrote:
>> for better or worse, i generally assume that whatever i'm looking  
>> at is there for a *reason* and i might spend some time puzzling  
>> over a bit of code until it finally dawns on me that it's just  
>> historical cruft that has no value.  it's not a bug, it just  
>> doesn't *do* anything anymore.
>>
>> in my case, it's sometimes easier to spot things like this since  
>> i'm following along in some book, like r. love's "linux kernel  
>> development."  so when he writes that the linux kernel is wedded  
>> to gcc, and yet i see tests for "__GNUC__" throughout the code, my  
>> little antenna stalks perk up a bit.
>
> Looking at it, it seems I might look through them - some of them  
> seem to be really pointless.

One other thing of note is that certain linux kernel headers _are_  
used by userspace (albeit in a number of cases legacy userspace), and  
as a result we need to ensure that they continue to build on the  
variety of compilers currently used in userspace.  Naturally this  
doesn't apply to everything, but see the recent threads involving  
(IIRC) some part of KDE and indirectly <linux/types.h>.  From what  
Linus has stated in the past it sounds like his goal is to make the  
user<=>libc interface completely 100% separated from the  
libc<=>kernel interface such that neither includes the other, but a  
lot of older userspace violates those assumptions.  As a result, if  
we want older versions of libc's to continue to work in various  
compilers with newer kernel headers we need to maintain some of that  
"compatibility cruft".

That said, if __GNUC__ is mentioned inside __KERNEL__ in anything  
other than a version test then it should probably be removed.  To  
that end these little macros in <linux/compiler.h> might make it a  
bit more obvious what's being tested and make it easier to grep for:

#ifdef __KERNEL__
# define GCC_VERSION ((__GNUC__ << 24) | \
	(__GNUC_MINOR__ << 16) | \
	(__GNUC_PATCHLEVEL__))
# define GCC_AT_LEAST(x,y,z) (GCC_VERSION >= (((x)<<24)|((y)<<16)|(z)))
# define GCC_OLDER_THAN(x,y,z) (!GCC_AT_LEAST(x,y,z))
#endif

> There's also the kernelnewbies list.
>
> But your emails are not as bad as you think - the email starting  
> this thread as well as your earlier emails regarding menu structure  
> etc. have some value (and they are better than many other questions  
> that hit this list...).

I personally tend to agree; seems like some of this cruft is just  
accepted status-quo because it would be so tedious and git-queue- 
blocking to go through and clean it all up.

Cheers,
Kyle Moffett

