Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWHVISd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWHVISd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWHVISd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:18:33 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:1208 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S932108AbWHVISc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:18:32 -0400
Message-Id: <44EADA09.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 22 Aug 2006 10:18:49 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
References: <20060820013121.GA18401@fieldses.org>
 <20060821094718.79c9a31a.rdunlap@xenotime.net>
 <20060821212043.332fdd0f.akpm@osdl.org> <200608221001.36124.ak@suse.de>
In-Reply-To: <200608221001.36124.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Has anyone even tried to reproduce Bruce's crash?
>
>I looked at it a bit, but it puzzles me. The chaining for the interrupt stacks
>on i386 -- which is what seems to be corrupted here -- shouldn't have changed at all 
>by the unwinder changes.

Not necessarily:

	if (UNW_SP(&info))
		stack = (void *)UNW_SP(&info);

is rather fragile - the minimum extra protection here should be to only use
UNW_SP() for the continuation stack pointer if it actually points into kernel
space (as is being done in one of the 2.6.19 patches), ...

>I suspect it would crash without unwinder too. Bruce, do you get the 
>same crash when you boot with "call_trace=old" ? 

... but of course I continue to agree that doing things like

	addr = *stack++;

in the legacy stack trace code cannot be good, given that this code
generally is expected to run when things are already bad in some way.

Jan
