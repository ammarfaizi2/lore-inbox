Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTLJUtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 15:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTLJUtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 15:49:21 -0500
Received: from lists.us.dell.com ([143.166.224.162]:48514 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263971AbTLJUsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 15:48:51 -0500
Date: Wed, 10 Dec 2003 14:48:42 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
Message-ID: <20031210144842.A24414@lists.us.dell.com>
References: <Pine.SOL.4.58.0312042225300.26114@yellow.csi.cam.ac.uk> <Pine.LNX.4.44.0312051109580.1782-100000@logos.cnet> <20031205113619.A20371@lists.us.dell.com> <1070901250.4508.1.camel@imp> <20031208222322.A21354@lists.us.dell.com> <1070987393.3447.64.camel@imp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1070987393.3447.64.camel@imp>; from aia21@cam.ac.uk on Tue, Dec 09, 2003 at 04:29:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The ds segment is not pointing to the correct segment AND/OR the offsets
> into the segment used for the writes are bogus.  You write straight into
> ds and ds:si referenced memory but you never setup ds in the first
> place.  So the writes done by the EDD code corrupt the loaded compressed
> kernel and the decompression fails.

ds is set up already to point at the empty_zero_page, else none of
what I'm doing is correct.  But, it is very likely that something else
is using 0x228 in empty_zero_page but isn't marked as using it in
Documentation/i386/zero-page.txt.

You've been patient, and thorough.  As another test, could you change
include/asm-i386/edd.h: DISK80_SIG_BUFFER from 0x228 to 0x2cc (the
four bytes immediately before the e820 memory buffer), and see if that
helps?  If so, I'll submit a patch to use that instead, and another
that markes 0x228 as in use by something else.

> I haven't really spent time thinking about ds and offsets and what they
> should be set to but I hope I have given you enough information to fix
> this yourself.  (-:

I'm quite certain that ds is correct, but that 0x228 may be in use by
something else.
 
> Please also note that you may want to consider adding this around your
> first int 0x13 call (the one to read the MBR):
> 
> movb	$READ_SECTORS, %ah
> [snip]
> pushw	%dx		# work around buggy BIOSes
> stc			# work around buggy BIOSes
> int	$0x13
> sti			# work around buggy BIOSes
> popw	%dx
> 
> This is what Microsoft uses apparently to work around various buggy BIOS
> implementations - ref: Ralf Brown's Interrupt list 61, which I consider
> the ultimate and definite guide to interrupts. (-:

OK, I'll look into that too.
 
> Further, at the Getdeviceparameters int 0x13 call, you may want to zero
> the two bytes following the EDDPARMSIZE in %ds:(%si) before doing the
> interrupt as your own company's PhoneixBIOS 4.0 Release 6.0 machines
> didn't work unless this was the case (ref: Ralf Brown's Interrupt list
> 61).

Ahh, yes.  I read that now.  OK, no harm in doing so, I'll add that.
 
> Finally, would it not be prudent to check the result of
> checkextensionspresent int 0x13 call before doing the
> getdeviceparameters int 0x13 call?  For example this would do just that:
> 
> [snip]
> movw	%cx, %ds:-2(%si)		# store extensions
> [snip]                                                                                        testw	$7, %cx				# Is Function 48 supported?
> jz	edd_skip_getdevparms		# If not, skip the call...
> 
> movb	$GETDEVICEPARAMETERS, %ah	# Function 48
> int	$0x13				# make the call
> 					# Don't check for fail return
> 					# it doesn't matter.
> edd_skip_getdevparms:

So, I thought about this for a while when I first wrote the code.  I
haven't run across *any* BIOSses yet which didn't implement function
48 for at least some version of EDD; it may not be version 0x30, but we've got
space reserved for it up to the size 0x30 could return, so it doesn't
matter.  If it returns anything in function 41, then it will return
something in function 48 too.  I could be wrong I suppose, but none of
the BIOS reports I've seen suggest otherwise.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
