Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUA1Cze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 21:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUA1Cze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 21:55:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:56010 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265815AbUA1CzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 21:55:23 -0500
Date: Tue, 27 Jan 2004 18:55:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
In-Reply-To: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jan 2004, Hironobu Ishii wrote:
>
> This is a readX_check() prototype patch to evaluate
> the performance disadvantage.

Quite frankly, I'd much rather have something more like this:

	clear_pcix_errors(dev);
	..
	x = readX_check(dev, offset);	/* Maybe several ones, maybe in a loop */
	..
	error = read_pcix_errors(dev);
	if (error)
		take_pcix_offline(dev);

in other words, I'd rather _not_ see the "readX_check()" code itself have 
the retry logic and error value handling.

Why? Because on a number of architectures it is entirely possible that the 
error comes as a _asynchronous_ machine exception or similar. So I'd much 
rather have the interfaces be designed for that. Also, it's likely to 
perform a lot better, and result in much clearer code this way (ie you can 
try to set up the whole command before reading the error just once).

It is _also_ going to be a hell of a lot easier to disable the code if you 
want to, with just a

	#ifndef CONFIG_PCI_RECOVERY
	  #define clear_pcix_errors(dev) do { } while (0)
	  #define read_pcix_errors(dev)  (0)
	  #define take_pcix_offline(dev) do { } while (0)
	#endif

in a header file for architectures that don't support it.

Does anybody see any downsides to something like this?

			Linus
