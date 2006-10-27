Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752432AbWJ0Uze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbWJ0Uze (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbWJ0Uzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:55:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20935 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752432AbWJ0Uzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:55:33 -0400
Date: Fri, 27 Oct 2006 13:48:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
In-Reply-To: <Pine.LNX.4.64.0610271323020.3849@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0610271347320.3849@g5.osdl.org>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
 <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de>
 <20061027012058.GH5591@parisc-linux.org> <20061026182838.ac2c7e20.akpm@osdl.org>
 <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com>
 <20061027172219.GC30416@elf.ucw.cz> <20061027113908.4a82c28a.akpm@osdl.org>
 <20061027114144.f8a5addc.akpm@osdl.org> <20061027114237.d577c153.akpm@osdl.org>
 <20061027114729.49185fd2@freekitty> <20061027131529.980cd53e.akpm@osdl.org>
 <Pine.LNX.4.64.0610271323020.3849@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Oct 2006, Linus Torvalds wrote:

> 
> 	static int do_in_parallel(void *arg)
> 	{
> 		struct thread_exec *p = arg;
> 		int (*fn)(void *) = p->fn;
> 		void *arg = p->arg;
> 		int retval;
> 
> 		/* Tell the caller we are done with the arguments */
> 		complete(&p->completion);
> 
> 		/* Do the actual work in parallel */
> 		retval = p->fn(p->arg);

Duh. The whole reason I copied them was to _not_ do that. That last line 
should obviously be

		retval = fn(arg);

because "p" may gone after we've done the "complete()".

> (And I repeat: the above code is untested, and was written in the email 
> client. It has never seen a compiler, and not gotten a _whole_ lot of 
> thinking).

.. This hasn't changed, I just looked through the code once and found that 
obvious bug.


		Linus
