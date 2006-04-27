Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWD0PYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWD0PYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWD0PYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:24:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965152AbWD0PYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:24:14 -0400
Date: Thu, 27 Apr 2006 08:23:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
cc: linux-kernel@vger.kernel.org, bonachead@comcast.net
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
In-Reply-To: <20060427090620.GF4649@implementation.labri.fr>
Message-ID: <Pine.LNX.4.64.0604270816260.3701@g5.osdl.org>
References: <20060427090620.GF4649@implementation.labri.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Apr 2006, Samuel Thibault wrote:
> 
> I'm getting a bit late in the discussion, but this is a bug that we've
> here known for quite some time now. The easy fix for getting correct
> concurrent writes was to add a pipe: instead of calling
> 
> my_parallel_program > log
> 
> just call
> 
> my_parallel_program | tee log
> 
> the pipe guarantees atomicity.

Side note: the pipe only guarantees atomicity for writes smaller than 
PIPE_BUF (normally 4kB on linux).

For larger writes, you'll still see all the data exactly once, but 
individual write() calls may have their contents mixed up. Ie if two 
processes or threads each do a 8kB write, the reader might see 4kB from 
the first thread, 4kB from the second, and then the remaining 4kB from the 
first again (or any other pattern - you could see alternating bytes, 
although in practice that is obviously not what is going to happen).

And yes, that atomicity is actually guaranteed by standards, so this is 
portable, and how you should do things if you care.

		Linus
