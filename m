Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVGXAa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVGXAa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 20:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVGXAa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 20:30:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262107AbVGXAa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 20:30:56 -0400
Date: Sat, 23 Jul 2005 17:30:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
In-Reply-To: <20050711143427.GC14529@thunk.org>
Message-ID: <Pine.LNX.4.58.0507231723270.6074@g5.osdl.org>
References: <20050711123237.787dfcde@localhost> <20050711143427.GC14529@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Jul 2005, Theodore Ts'o wrote:
> 
> According to the Single Unix Specification V3, all functions that
> return EINTR are supposed to restart if a process receives a signal
> where signal handler has been installed with the SA_RESTART flag.  

That can't be right.

Some operations, like "select()" and "pause()" always return EINTR, and 
indeed, real applications will break if you always restart. Restarting a 
pause() would be nonsensical.

This is why the kernel has ERESTARTSYS (restart always) and ERESTARTNOHAND
(restart if the signal had no handler) which will be turned into EINTR if
SA_RESTART isn't set. And even then, there are some ops that just always
use EINTR and don't even try to restart.

> There may be a few places in the kernel where this isn't happenning,
> that's what the specification states. 

The specs are broken, and apparently don't take real life (or sanity -
pause() in particular just doesn't make sense if restarted) into account.  

Afaik, the historical BSD behaviour (which is what SA_RESTART is all
about) always was to just restart some system calls, not all of them.

		Linus
