Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935341AbWK1Oqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935341AbWK1Oqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 09:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935370AbWK1Oqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 09:46:45 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:37945
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S935341AbWK1Oqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 09:46:44 -0500
Message-Id: <456C5A3F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 28 Nov 2006 14:48:15 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Jakub Jelinek" <jakub@redhat.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] work around gcc4 issue with -Os in Dwarf2 stack
	unwind code
References: <456C51D8.76E4.0078.0@novell.com>
 <20061128143214.GD6570@devserv.devel.redhat.com>
In-Reply-To: <20061128143214.GD6570@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"mis-compiling" and "work around" are wrong words, the code had undefined
>behavior (there is no sequence point between evaluation of ptr and
>get_uleb128(&ptr, end) and ptr is modified twice, so the compiler can
>evaluate it e.g. as:
>temp = ptr;
>temp = temp + get_uleb128(&ptr, end);
>ptr = temp;
>or
>temp = get_uleb128(&ptr, end);
>ptr += temp;
>While gcc has some warnings for sequence point semantics violations
>(-Wsequence-point), this can't be one of the cases at least until IPA moves
>much further, because get_uleb128 might very well not modify the variable
>and at that point the code would be ok).

I disagree - the standard says there's a sequence point at a function
call after evaluating all function arguments. To me this means that any
(parts of an) expression the function call is contained in must be
evaluated after the function call. Otherwise it would be illegal to e.g.
modify a variable in both operands of && or ||.
I consider my opinion supported by the fact that the problem doesn't
happen with any non-Os optimization, where it is obvious that it would
in all cases be beneficial to load the variable's value into a register early.
(And, btw., after the change the code generated is significantly smaller -
hinting at questionable effects of -Os.)

Jan
