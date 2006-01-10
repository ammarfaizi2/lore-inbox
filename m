Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWAJR3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWAJR3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWAJR3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:29:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28124 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932572AbWAJR3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:29:03 -0500
Date: Tue, 10 Jan 2006 09:28:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Lord <lkml@rtr.ca>
cc: Jens Axboe <axboe@suse.de>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
In-Reply-To: <43C3E9C2.1000309@rtr.ca>
Message-ID: <Pine.LNX.4.64.0601100923150.4939@g5.osdl.org>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>
 <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org>
 <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
 <43C3E9C2.1000309@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Jan 2006, Mark Lord wrote:
>
> So, the patch would now look like this:

Yes, except I think we need to make the "depends on" include !X86_PAE:

> +choice
> +	depends on EXPERIMENTAL

	depends on EXPERIMENTAL && !X86_PAE

since PAE depends on the 3G/1G split (we could make it work for a pure 
2G/2G split, but that's a separate issue, and then we'd need to change the 
CONFIG_PAGE_OFFSET defaults to be something like

	default 0x80000000 if VMSPLIT_2G && X86_PAE

(but that's definitely not appropriate for now - that's a separate issue, 
after somebody has verified that PAE and 2G:2G works)

Also, I think the arch/i386/mm/init.c snippet should just be removed. If 
we make the split configurable, I don't see that we should warn about a 
configuration where you have less memory than the point where the split 
makes sense. A distribution (either something like Fedora _or_ just a 
internal company "standard image") migth decide to use 2G:2G, but not all 
machines might have lots of memory. Warning about it would be silly.

Anyway, this should go into -mm, and I'd rather have it stay there for a 
while. I've got tons of stuff for 2.6.16 already, I'd prefer to not see 
this kind of thing too..

		Linus
