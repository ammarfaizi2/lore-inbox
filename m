Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVI0Oxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVI0Oxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVI0Oxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:53:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964960AbVI0Oxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:53:44 -0400
Date: Tue, 27 Sep 2005 07:53:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Harald Welte <laforge@gnumonks.org>
cc: linux-usb-devel@lists.sourceforge.net, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, greg@kroah.com, security@linux.kernel.org
Subject: Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing
 async USB via usbdevio
In-Reply-To: <20050925151330.GL731@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Sep 2005, Harald Welte wrote:
> 
> async_completed() calls send_sig_info(), which in turn does a
> spin_lock(&tasklist_lock) to protect itself from task_struct->sighand
> from going away.  However, the call to
> "spin_lock_irqsave(task_struct->sighand->siglock)" causes an oops,
> because "sighand" has disappeared.

And the real bug is that you're buggering up the system in the first 
place.

You don't save "current". You save "pid", and then you send a signal using 
that and kill_proc_info(). End of story, bug gone. And it works with 
threaded programs too, which the old thing didn't work at all with.

I refuse to apply this patch - Greg, don't even _try_ to sneak this in 
through a git merge. What a horribly broken thing to do: why would USB 
_ever_ need to know about things like tasklist_lock, and internal signal 
handling functions and rules like "p->sighand"?

		Linus
