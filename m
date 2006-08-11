Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWHKXSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWHKXSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 19:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWHKXSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 19:18:12 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:671 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751272AbWHKXSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 19:18:11 -0400
Date: Fri, 11 Aug 2006 19:13:33 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
To: "Jan Beulich" <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org, "Andi Kleen" <ak@suse.de>
Message-ID: <200608111916_MC3-1-C7D7-ACA4@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44DC496D.76E4.0078.0@novell.com>

On Fri, 11 Aug 2006 09:10:05 +0200, Jan Beulich wrote:

> I understand now, but am still uncertain
> about the need to annotate FIX_STACK() - especially since you use
> .cfi_undefined, meaning the return point cannot be established anyway.
> If at all I'd annotate the initial pushes with either just the normal
> CFI_ADJUST_CFA_OFFSET, and the final one with one setting back the
> CFA base to the now adjusted frame. That way, until the pushes are
> complete the old frame will be used for determining the call origin,
> and once complete the (full) new state will be used.

But that's the whole point of the new annotations -- we have just
overwritten %esp with a new value and the old assumptions are
completely broken:

        movl TSS_sysenter_esp0+offset(%esp),%esp;       \

After this the old frame cannot be located by using %esp as a base
and the new frame is incomplete.  So the only choice is to make eip
undefined until the new value is available -- if not then the
unwinder will try to use whatever random values are on the new frame.
Either that or I'm still unclear on how unwind works...

-- 
Chuck

