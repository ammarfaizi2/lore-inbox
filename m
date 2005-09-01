Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVIAG43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVIAG43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 02:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVIAG43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 02:56:29 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:33187 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932544AbVIAG43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 02:56:29 -0400
Date: Thu, 1 Sep 2005 08:57:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: MAX_ARG_PAGES has no effect?
Message-ID: <20050901065710.GB5179@elte.hu>
References: <4314F761.2050908@kundor.org> <20050831121144.GA13578@elte.hu> <p73psrtr8ho.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73psrtr8ho.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> > 
> > MAX_ARG_PAGES should work just fine. I think the 'getconf ARG_MAX' 
> > output is hardcoded. (because the kernel does not provide the 
> > information dynamically)
> 
> Perhaps it would be a good idea to make it a sysctl. Is there any 
> reason it should be hardcoded?  I cannot think of any.
> 
> Ok if someone lowers the sysctl then execve has to handle the case of 
> the args/environment possibly not fitting anymore, but that should be 
> easy.

the whole thing should be reworked, so that there is no artificial limit 
like MAX_ARG_PAGES. (it is after all just another piece of memory, in 
theory)

I have tried this a couple of times but failed - it's a hard problem. 
Linus had the idea years ago to page-flip the argument data into the new 
process's address space, but that doesnt work out in practice due to the 
way glibc has to extend the environment space. (glibc extends it by 
modifying the environment array, or relocating it if it has to be grown.  
execve() currently automatically 'linearizes' the environment by copying 
both the array and the old and new environment strings to a linear piece 
of memory.)

If we do unconditional page-flipping then we fragment the argument 
space, if we do both page-flipping if things are unfragmented and 
well-aligned, and 'compact' the layout otherwise, we havent solved the 
problem and have introduced a significant extra layer of complexity to 
an already security-sensitive and fragile piece of code.

The best method i found was to get rid of bprm->pages[] and to directly 
copy strings into the new mm via kmap (and to follow whatever RAM 
allocation policies/limits there are for the new mm), but that's quite 
ugly.

	Ingo
