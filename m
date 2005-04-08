Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbVDHNKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVDHNKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 09:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVDHNDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 09:03:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19473 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262805AbVDHNAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 09:00:10 -0400
Date: Fri, 8 Apr 2005 15:00:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
Message-ID: <20050408130008.GA6653@stusta.de>
References: <4252BC37.8030306@grupopie.com> <20050407214747.GD4325@stusta.de> <42567B3E.8010403@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42567B3E.8010403@grupopie.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 01:38:22PM +0100, Paulo Marques wrote:
> Adrian Bunk wrote:
> >On Tue, Apr 05, 2005 at 05:26:31PM +0100, Paulo Marques wrote:
> 
> Hi Adrian,

Hi Paolo,

> >>[...]
> >>pros:
> >> - smaller kernel image size
> >> - smaller (and more readable) source code
> >
> >Which is better readable depends on what you are used to.
> 
> That's true to some degree, but look at code like this (in 
> drivers/usb/input/hid-core.c):
> 
> >	if (!(field = kmalloc(sizeof(struct hid_field) + usages * 
> >	sizeof(struct hid_usage)
> >		+ values * sizeof(unsigned), GFP_KERNEL))) return NULL;
> >
> >	memset(field, 0, sizeof(struct hid_field) + usages * sizeof(struct 
> >	hid_usage)
> >		+ values * sizeof(unsigned));
> 
> and compare to this:
> 
> >	field = kzalloc(sizeof(struct hid_field) + usages * sizeof(struct 
> >	hid_usage)
> >			+ values * sizeof(unsigned), GFP_KERNEL);
> >	if (!field) 
> >		return NULL;
> 
> In the first case you have to read carefully to make sure that the size 
> argument in both the kmalloc and the memset are the same. Even more, if 
> the size needs to be updated to include something more, a mistake can be 
> made by inserting the extra size just in the kmalloc call. Also, you are 
> assuming that the compiler is smart enough to notice that the two 
> expressions are the same and cache the result, but this is probably true 
> for gcc, anyway.
> 
> I think most will agree that the second piece of code is more "readable".

In this case yes (but it could still use the normal kcalloc).

>...
> >There are tasks of higher value that can be done.
> 
> I couldn't agree more :)
> 
> >E.g. read my "Stack usage tasks" email. The benefits would only be 
> >present for people using GNU gcc 3.4 or SuSE gcc 3.3 on i386, but this 
> >is a reasonable subset of the kernel users - and it brings them a
> >2% kernel size improvement.
> 
> I've read that thread, but it seems that it is at a dead end right now, 
> since we don't have a good tool to find out which functions are abusing 
> the stack with unit-at-a-time.
> 
> Is there some way to even limit the search, like using a stack usage log 
> from a compilation without unit-at-a-time, and going over the hotspots 
> to check for problems?
> 
> If we can get a list, even if it contains a lot of false positives, I 
> would more than happy to help out...

Joerg's list of recursions should be valid independent of the kernel 
version. Fixing any real stack problems [1] that might be in this list 
is a valuable task.

And "make checkstack" in a kernel compiled with unit-at-a-time lists 
several possible problems at the top.

> Paulo Marques

cu
Adrian

[1] there are cases in this list that aren't a problem e.g. because of
    an obviously limited recursion

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

