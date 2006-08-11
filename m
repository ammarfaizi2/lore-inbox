Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161168AbWHKHJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWHKHJS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 03:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWHKHJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 03:09:18 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:9865 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1161168AbWHKHJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 03:09:17 -0400
Message-Id: <44DC496D.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Fri, 11 Aug 2006 09:10:05 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
References: <200608101343_MC3-1-C7B1-9E81@compuserve.com>
In-Reply-To: <200608101343_MC3-1-C7B1-9E81@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> The point is that the push-es in FIX_STACK() aren't annotated, so
>> >> things won't be correct at those points anyway.
>> >
>> >I have a patch here that adds that, but it won't compile
>> >because that part of the NMI handler is un-annotated:
>> 
>> But you didn't clarify why you need this piece of code annotated...
>
>Uh, which one didn't I clarify?
>
>FIX_STACK() is already invoked from debug(), which is annotated, but
>FIX_STACK() isn't.  And that messes with the stack, so for a few
>instructions the annotations are all wrong.
>
>When I annotated FIX_STACK(), I found entry.S wouldn't compile
because
>nmi() included FIX_STACK() but was completely missing annotations
>in that piece. So I added them so FIX_STACK()'s annotations would
>compile...

Ah, okay, this means the original sequence of additions was the reverse
of
how I got to see these patches. I understand now, but am still
uncertain
about the need to annotate FIX_STACK() - especially since you use
.cfi_undefined, meaning the return point cannot be established anyway.
If at all I'd annotate the initial pushes with either just the normal
CFI_ADJUST_CFA_OFFSET, and the final one with one setting back the
CFA base to the now adjusted frame. That way, until the pushes are
complete the old frame will be used for determining the call origin,
and
once complete the (full) new state will be used.
Or annotate them so that the new values take effect immediately with
each push, but clearly without any CFI_UNDEFINED. That way, the
frame will be slightly inconsistent in between, which could be of
concern
once we also properly annotate the segment register spills/restores.

>Should I send a combined patch, leave the two patches separate, or
just
>drop it?

Either way, but if you leave them separate you should always send them
as pair, to make the intentions clear.

Jan
