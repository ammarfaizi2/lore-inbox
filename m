Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291346AbSBMEbE>; Tue, 12 Feb 2002 23:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291349AbSBMEap>; Tue, 12 Feb 2002 23:30:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3344 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291346AbSBMEaf>;
	Tue, 12 Feb 2002 23:30:35 -0500
Message-ID: <3C69EBB7.24EA9C05@zip.com.au>
Date: Tue, 12 Feb 2002 20:29:43 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <3C69B5D7.CFF9E8EA@zip.com.au> <Pine.LNX.3.96.1020212224341.8017C-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> Alan and/or Linus:
> 
>   Am I misreading this or is the Linux implementation of sync() based on
> making the shutdown scripts pause until disk i/o is done? Because I don't
> think commercial unices work that way, I think they work as SuS
> specifies. More reason to rethink this in 2.4 as well as 2.5 and get the
> possible live lock out of the kernel.
> 

IMO, the SuS definition sucks.  We really do want to do our best to
ensure that pending writes are committed to disk before sys_sync()
returns.  As long as that doesn't involve waiting until mid-August.

For example, ext3 users get to enjoy rebooting with `sync ; reboot -f'
to get around all those silly shutdown scripts.  This very much relies
upon the sync waiting upon the I/O.


I mean, according to SUS, our sys_sync() implementation could be

asmlinkage void sys_sync(void)
{
	return;
}

Because all I/O is already scheduled, thanks to kupdate.



But we want sync to be useful.


> 
>   If this were only a performance issue I wouldn't push for prompt
> implementation, but anything which can hang the system, particularly in
> shutdown, is bad.
> 

If shutdown hangs, it's probably due to something else.

-
