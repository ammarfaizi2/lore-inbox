Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWBFQ61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWBFQ61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWBFQ61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:58:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932223AbWBFQ60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:58:26 -0500
Date: Mon, 6 Feb 2006 08:56:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
cc: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
In-Reply-To: <43E61448.7010704@sw.ru>
Message-ID: <Pine.LNX.4.64.0602060847130.3854@g5.osdl.org>
References: <43E38BD1.4070707@openvz.org>  <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>
 <43E3915A.2080000@sw.ru>  <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>
 <1138991641.6189.37.camel@localhost.localdomain> <43E61448.7010704@sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Feb 2006, Kirill Korotaev wrote:
> 
> Please, also note, in OpenVZ we have 2 pointers on task_struct:
> One is owner of a task (owner_env), 2nd is a current context (exec_env).
> exec_env pointer is used to avoid adding of additional argument to all the
> functions where current context is required.

That naming _has_ to change.

"exec" has a very clear meaning in unix: it talks about the notion of 
switching to another process image, or perhaps the bit that says that a 
file contains an image that can be executed. It has nothing to do with 
"current".

What you seem to be talking about is the _effective_ environment. Ie the 
same way we have "uid" and "euid", you'd have a "container" and the 
"effective container".

The "owner" name also makes no sense. The security context doesn't "own" 
tasks. A task is _part_ of a context.

So if some people don't like "container", how about just calling it 
"context"? The downside of that name is that it's very commonly used in 
the kenel, because a lot of things have "contexts". That's why "container" 
would be a lot better.

I'd suggest

	current->container	- the current EFFECTIVE container
	current->master_container - the "long term" container.

(replace "master" with some other non-S&M term if you want)

(It would make sense to just have the prepend-"e" semantics of uid/gid, 
but the fact is, "euid/egid" has a long unix history and is readable only 
for that reason. The same wouldn't be true of containers. And 
"effective_container" is probably too long to use for the field that is 
actually the _common_ case. Thus the above suggestion).

		Linus
