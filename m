Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbUCXQVC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 11:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbUCXQVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 11:21:02 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32751 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263763AbUCXQU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 11:20:57 -0500
Message-ID: <4061B562.4060601@mvista.com>
Date: Wed, 24 Mar 2004 08:20:50 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org, Daniel Jacobowitz <djacobowitz@mvista.com>
Subject: Re: [PATCH]Call frame debug info for 2.6 kernel
References: <1AR5s-75I-27@gated-at.bofh.it> <1CHY0-1Uw-9@gated-at.bofh.it> <m3n0685nfp.fsf@averell.firstfloor.org> <4060B005.4020804@mvista.com> <20040324062548.GA96115@colin2.muc.de>
In-Reply-To: <20040324062548.GA96115@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>The long and short of it is, to do it at all, you need to have a fair 
>>knowledge of dwarf2.  Once you get to that, I suspect one way is as good as 
>>another.
> 
> 
> Did you contact the gdb and binutils maintainers about the problems?
> Maybe it can be easily fixed.
> 
I mentioned it to Daniel Jacobowitz.

The problem is what is needed is access to the full dwarf2 expression code. 
Actually only a small sub set is needed here, but I suspect they would only do 
the whole thing, and it is rather rich.  I only implemented about 20% of the 
opcodes.

For example, the way gdb knows that "this is the bottom of the stack" is for the 
CFI address to come back as zero.  Normally this is a stack address.  An 
expression is needed to get zero, and, at least in interrupt / trap handling, 
the expression needs to be conditional.  So, either a new language is invented 
or access is provided to the dwarf2 language, or an abstracted version of it.

The ladder is what I did.  I provided the dwarf2 opcodes with macros that 
wrapped the required boiler plate around them.  I set it up the way C does, i.e. 
as a separate block of asm code, rather than intermixed with the assembly thing 
(which would require relocs to the debug space and back as well as additional 
boiler plate).  This is artifact of how I figured out how to translate the 
dwarf2 spec to real code, i.e. I looked at what C was doing.

The thing is, we are talking assembly code here.  That means that just about 
anything is possible WRT the call frame.

If I had any sway over what the binutils folks do, I would argue for allowing 
dwarf2 code intermixed with inline asm in the C asm() code.  At the moment this 
is very hard (impossible) to do.

An example of what I would like to be able to do is to build a call frame for 
the out of line part of the spin lock.  It would be a very simple frame that 
would just say it was called from the inline part of the spin lock.

As second example is to properly describe the "switch frame" used for context 
switching.  Currently x86 requires frame pointers to cover this, i.e. with frame 
pointers off, gdb can not unwind tasks that are not active, even with dwarf2 
frame stuff.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

