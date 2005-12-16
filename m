Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVLPRvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVLPRvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVLPRvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:51:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751298AbVLPRvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:51:50 -0500
Date: Fri, 16 Dec 2005 09:51:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nicholas Miell <nmiell@comcast.net>
cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 0/3] *at syscalls: Intro
In-Reply-To: <1134695632.2785.12.camel@entropy>
Message-ID: <Pine.LNX.4.64.0512160946580.3060@g5.osdl.org>
References: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com>
 <1134695632.2785.12.camel@entropy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Dec 2005, Nicholas Miell wrote:
> 
> Don't take this as an objection to implementation of the *at() syscalls
> in Linux, though; rather, look at is as a request for the addition of
> int pthread_attr_setfssharing_np(pthread_attr_t *attr, int share) and
> int pthread_attr_getfssharing_np(pthread_attr_t *attr) to glibc.

I don't think separate fs/files makes sense with pthreads.

Why? Signals.

Signals are shared in a pthread environment, so signal handlers can happen 
in any thread. If you don't share the filesystem thing, your signal 
handlers had better not do any file operations. You'd better not try to 
use the old "send a byte down a pipe" trick to wake somebody else up, 
because the thread you may take the signal in may not _have_ that pipe fd 
open.

Now, opening files in a signal handler may be unusual enough that 
having separate cwd/root (!CLONE_FS as opposed to !CLONE_FILES) might be 
more commonly usable, but it's still potentially asking for some really 
funky behaviour.

			Linus
