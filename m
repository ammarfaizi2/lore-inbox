Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWAaIiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWAaIiY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 03:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWAaIiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 03:38:24 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:46754 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S965055AbWAaIiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 03:38:24 -0500
Message-ID: <43DF2332.3070705@aitel.hist.no>
Date: Tue, 31 Jan 2006 09:43:30 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pierre-olivier.gaillard@fr.thalesgroup.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Can on-demand loading of user-space executables be disabled ?
References: <43DDE697.5000007@fr.thalesgroup.com>
In-Reply-To: <43DDE697.5000007@fr.thalesgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P.O. Gaillard wrote:

> Hello,
>
> As far as I understand what happens when I start a Linux program, the 
> executable file is mmaped into memory and the execution of the code 
> itself prompts Linux to load the required pages of the program.
>
> I expect that this could cause unwanted delays during program 
> execution when a function that has never been used (nor loaded into 
> memory) is called. This delay could be bigger than 10ms while the 2.6 
> kernel is usually quite predictable thanks to Ingo Molnar and others' 
> work.

Delays may indeed happen due to something that isn't yet loaded.  They 
may also
happen because of something being swapped out due to memory pressure.
Note that "turning off swap" by not having any swap-device won't help you.
Linux knows that program code can be reloaded from the executable file,
and may decide to drop little-used functions from memory.  They will then
be demand-loaded if they ever are needed again.

>
> Is Linux really using on-demand loading ?
> Is it very different from what I described in the first paragraph ?

Not very.  Just note that linux doesn't load whole functions, it loads
4kB chunks called pages.

> Can on-demand loading be disabled ? (This would seem convenient for my 
> applications since I generally start a program that is meant to run as 
> predictably as possible for months.) 

Probably possible. It would have to be a special use for this to make 
sense though,
don't consider this just to have a "snappier desktop". Loading whole 
executables
and keeping them loaded wastes lots of memory.  Usual programs have 
startup code
that is only used once - it is normally nice that it gets dropped from 
memory
after a while.  This frees up memory for everything else.  Similiarly, 
it is nice that
the cleanup code used to end the program isn't loaded until needed, that
way it doesn't waste space so the program have more memory available for 
work.

Still, if the very occational and short page-in delay is too much for your
specialized use - use mlock.  If demand loading or swapping merely is slow
due to heavy disk usage, put the executables and swap on a spindle
of its own so these disk accesses won't compete with data accesses.

Helge Hafting
