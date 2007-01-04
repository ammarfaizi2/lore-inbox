Return-Path: <linux-kernel-owner+w=401wt.eu-S964927AbXADPjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbXADPjP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbXADPjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:39:15 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59069 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964927AbXADPjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:39:14 -0500
Date: Thu, 4 Jan 2007 07:34:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
cc: Grzegorz Kulewski <kangur@polcom.net>, Alan <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: RE: kernel + gcc 4.1 = several problems
In-Reply-To: <10EA09EFD8728347A513008B6B0DA77A086B84@pdsmsx411.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0701040729360.3661@woody.osdl.org>
References: <10EA09EFD8728347A513008B6B0DA77A086B84@pdsmsx411.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2007, Zou, Nanhai wrote:
> 
> cmov will stall on eflags in your test program.

And that is EXACTLY my point.

CMOV is a piece of CRAP for most things, exactly because it serializes 
three streams of data: the two inputs, and the conditional.

My test-case was actually _good_ for cmov, because there was just the one 
conditional (which was 100% ALU) thing that was serialized. In real life, 
the two data sources also come from memory, and _any_ of them being 
delayed ends up delaying the cmov, and screwing up your out-of-order 
pipeline because you now introduced a serialization point that was very 
possibly not necessary at all.

In contrast, a conditional branch-around serializes absolutely NOTHING, 
because branches get predicted.

> I think you will see benefit of cmov if you can manage to put some 
> instructions which does NOT modify eflags between testl and cmov.

A lot of the time, the conditional _is_ the critical path.

The whole point of this discussion was that cmov isn't really all that 
great. It has fundamental problems that a conditional branch that gets 
predicted simply does not have.

That's qiute apart from the fact that cmov has rather limited semantics, 
and that in 99% of all cases you have to use a conditional branch anyway.

			Linus
