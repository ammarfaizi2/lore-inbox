Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWHBTS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWHBTS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWHBTS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:18:26 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:11187 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932169AbWHBTSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:18:25 -0400
Date: Wed, 2 Aug 2006 15:14:08 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
To: Stas Sergeev <stsp@aknet.ru>
Cc: Zachary Amsden <zach@vmware.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608021515_MC3-1-C6D7-2B90@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44D0DCF5.8050906@aknet.ru>

On Wed, 02 Aug 2006 21:12:21 +0400, Stas Sergeev wrote:
> 
> > iret faults, but doesn't pop the user return frame.
> But does it push the kernel frame after it or not?
> If not - I don't understand how we go to a fixup.
> If yes - I don't understand how the user's frame gets
> accessed later, as it is above the kernel's frame.

Just before trying to return to userspace, we have a stack:

        user_regs [ebx ... es]
        orig_eax
        user_iret_frame [eip ... oldss]

After RESTORE_ALL and discarding orig_eax, we have this just
before doing iret (user's regs are in the CPU regs now):

        user_iret_frame [eip ... oldss]

iret faults and we get:

        kernel_iret_frame [eip(of iret) ... flags]
        user_iret_frame [eip ... oldss]

error_code then saves regs and we have:

        user_regs [ebx ... es]
        orig_eax [== -1]
        kernel_iret_frame [eip(iret) ... flags]
        user_iret_frame [eip ... oldss]

error_code then calls e.g. do_segment_not_present, which finds a fixup
and does:

        regs->eip = fixup_address;

now we have:

        user_regs [ebx ... es]
        orig_eax [== -1]
        kernel_iret_frame [eip(fixup) ... flags]
        user_iret_frame [eip ... oldss]

standard return sequence gives us (again user's regs are back in CPU):

        kernel_iret_frame [eip(fixup) ... flags]
        user_iret_frame [eip ... oldss]

iret returns to the fixup code which jumps to error_code and then we have:

        user_regs [ebx ... es]
        orig_eax [== -1]
        user_iret_frame [eip ... oldss]

So now there is a stack frame that looks like it came from userspace
and we call the iret fault handler with that.

Only problem I have with this is we lose the original fault info from
the iret.  So we have no real way of knowing whether it was #GP, #NP, #SF
or whatever, and no record of the offending iret's address.

-- 
Chuck

