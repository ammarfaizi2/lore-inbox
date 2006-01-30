Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWA3MAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWA3MAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 07:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWA3MAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 07:00:22 -0500
Received: from science.horizon.com ([192.35.100.1]:55358 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932234AbWA3MAW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 07:00:22 -0500
Date: 30 Jan 2006 07:00:11 -0500
Message-ID: <20060130120011.24515.qmail@science.horizon.com>
From: linux@horizon.com
To: pierre-olivier.gaillard@fr.thalesgroup.com
Subject: Re: Can on-demand loading of user-space executables be disabled ?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as I understand what happens when I start a Linux program, the
> executable file is mmaped into memory and the execution of the code
> itself prompts Linux to load the required pages of the program.
> 
> I expect that this could cause unwanted delays during program execution
> when a function that has never been used (nor loaded into memory) is
> called. This delay could be bigger than 10ms while the 2.6 kernel is
> usually quite predictable thanks to Ingo Molnar and others' work.
> 
> Is Linux really using on-demand loading ?

Yes.

> Is it very different from what I described in the first paragraph ?

No, not really (it's not different).  The pages are mapped, and brought
in via page faults.  There is read-ahead code, so if you start hitting
sequential pages, it'll read more than is immediately necessary in the
hope of keeping up.

> Can on-demand loading be disabled ? (This would seem convenient for my 
> applications since I generally start a program that is meant to run as 
> predictably as possible for months.)

Well, the easy way to disable on-demand loading is munmap().
Then the data won't be loaded and you'll get SIGSEGV.

However, I don't think that's what you mean.
If you want to keep code in memory, so it can't suffer a page
fault, either on initial load or by being swapped out to make
room for something else, use mlock() or mlockall().

If you just want to encourage (but not *insist*) code to be in memory,
I think Linux implements madvise(MADV_WILLNEED) sensibly.
