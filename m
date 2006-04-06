Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWDFNUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWDFNUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 09:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWDFNUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 09:20:00 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:31193 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751260AbWDFNUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 09:20:00 -0400
Message-ID: <443515E1.1000600@plan99.net>
Date: Thu, 06 Apr 2006 14:21:37 +0100
From: Mike Hearn <mike@plan99.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
References: <5XGlt-GY-23@gated-at.bofh.it> <5XGOz-1eP-35@gated-at.bofh.it> <E1FRSqP-0000g3-9i@be1.lrz>
In-Reply-To: <E1FRSqP-0000g3-9i@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMO the program must be aware of the get-my-exedir feature, just configuring
> --prefix=/proc/... is aiming for your feet.

I disagree, though /proc/self/exedir may not be the right answer. The 
problem with the original proposal is there's no concept of a group 
leader to which files are resolved relative to so there is this problem 
with child processes.

I sent a mail outlining a scheme that used file descriptor passing to 
achieve the same effect but with the needed "inheritance" of the path, 
but, vger seems to have munched it! At least I don't see it on the gmane 
archives. But the scheme is simple enough:

  * get_prefix() reads /proc/self/exe and turns it into the correct
    directory

  * dup2(open(get_my_exedir()), 999)

  * ./configure --prefix=/proc/self/fd/999

Obviously that code leaks but you get the idea. Paths can now be 
resolved relative to the magic fd number (whatever numbe is used up to 
the userspace app). The fd is inherited on exec, so sub-programs that 
are passed a path relative to it still work.

It doesn't need kernel support which is nice.

It also restricts the problem to passing paths to other processes that 
are not subprocesses (eg via rpc). But as each process can have its own 
namespace this will always be an issue that needs careful treatment, and 
the pain of adjusting software to realpath() it is much lower than 
modifying every path in every piece of software. That approach was 
already tried and sucks.

thanks -mike
