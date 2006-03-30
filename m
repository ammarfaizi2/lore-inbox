Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWC3UsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWC3UsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWC3UsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:48:20 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:50850 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750844AbWC3UsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:48:20 -0500
Message-ID: <442C440B.2090700@garzik.org>
Date: Thu, 30 Mar 2006 15:48:11 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] splice support #2
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.5 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Let me pull back from the details a bit, to note a code pattern I'm 
beginning to see:

	if (src_fd is a file &&
	    dest_fd is a socket)
		sendfile()
	else
		hand code fd->fd data move

with splice this becomes

	if (special case fd combination #1)
		sendfile()
	else (special case fd combination #2)
		splice()
	else
		hand code fd->fd data move

Creating a syscall for each fd->fd data move case seems wasteful.  I 
would rather that the kernel Does The Right Thing so the app doesn't 
have to support all these special cases.  Handling the implicit buffer 
case in the kernel, when needed, means that the app is future-proofed: 
when another fd->fd optimization is implemented, the app automatically 
takes advantage of it.

	Jeff


