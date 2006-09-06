Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWIFHeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWIFHeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWIFHeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:34:50 -0400
Received: from fep01.xtra.co.nz ([210.54.141.245]:18613 "EHLO fep01.xtra.co.nz")
	by vger.kernel.org with ESMTP id S1751571AbWIFHes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:34:48 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
cc: "Jan Beulich" <jbeulich@novell.com>,
       "Badari Pulavarty" <pbadari@gmail.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, petkov@math.uni-muenster.de,
       akpm@osdl.org, "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199" 
In-reply-to: Your message of "Thu, 31 Aug 2006 09:41:40 +0200."
             <200608310941.40076.ak@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Sep 2006 18:31:12 +1200
Message-ID: <13380.1157524272@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (on Thu, 31 Aug 2006 09:41:40 +0200) wrote:
>P.S.: Badari, we worked out your kernel_math_context trace too:
>that one is actually a gcc bug related to dubious unwind tables generated
>for noreturn calls (in your case do_exit). We were still discussing the best 
>workaround for that one.

Lots of luck.  I logged a bug several years ago against gcc for ia64
with noreturn calls.  When gcc sees a call to a function marked
noreturn (like do_exit or panic), gcc has been known to discard all
code past that point.  The unwind code has to assume that the return
address is pointing into the previous function.  Where does the return
address point after a noreturn call compiled with the gcc bug?  - at
the start of the next function.  Goodbye unwind.

I asked that gcc always insert at least one instruction after a call to
a noreturn function.  That would keep the return address inside the
right function and the unwind code would work.  Ideally that
instruction would cause an error if it was ever executed (break 0 on
ia64, ud2 on i386/x86_64) but even a no-op would be good enough.  Most
of the ia64 list thought it was a good idea, the gcc team disagreed.
AFAIK the bug is still outstanding.

