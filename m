Return-Path: <linux-kernel-owner+w=401wt.eu-S936678AbWLKPpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936678AbWLKPpL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 10:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936577AbWLKPpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 10:45:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36901 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936678AbWLKPpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 10:45:10 -0500
Date: Mon, 11 Dec 2006 07:44:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
In-Reply-To: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
Message-ID: <Pine.LNX.4.64.0612110741010.12500@woody.osdl.org>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Chuck Ebbert wrote:
>
> Prevent oops when an app tries to create a pipe while pipefs
> is not mounted.

Have you actually seen this, or is this just from looking at code?

Quite frankly, if "pipe_mnt" is ever NULL, we're dead for lots of other 
reasons. 

In fact, pipe_mnt can't be NULL. The way it is initialized is:

	pipe_mnt = kern_mount(&pipe_fs_type);

and pipe_mnt doesn't even return NULL - it returns an error pointer, so if 
"kern_mount()" were to have failed, pipe_mnt will be some random invalid 
pointer that could only be tested with IS_ERR(), not by comparing against 
NULL.

But more fundamentally - we might as well oops. We need to panic or oops 
or do _something_ bad at some point anyway, because it's MUCH better to 
fail spectacularly than it would be to just silently fail without a pipe.

Hmm?

		Linus
