Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272960AbTHFAFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272961AbTHFAFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:05:38 -0400
Received: from waste.org ([209.173.204.2]:7874 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272960AbTHFAFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:05:30 -0400
Date: Tue, 5 Aug 2003 19:05:24 -0500
From: Matt Mackall <mpm@selenic.com>
To: s0be <s0be@DrunkenCodePoets.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops in 2.6.0-test2-mm4
Message-ID: <20030806000524.GC26701@waste.org>
References: <20030805170558.3ee38204.s0be@DrunkenCodePoets.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805170558.3ee38204.s0be@DrunkenCodePoets.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 05:05:58PM -0400, s0be wrote:
> here's the oops from dmesg and the surrounding messages.  I'm guessing it was caused by smb, but I can't confirm it.  trying to recreate it.
> 
> SMB connection re-established (-5)
> smb_errno: class ERRSRV, code 91 from command 0x80
> SMB connection re-established (-5)
> smb_errno: class ERRSRV, code 91 from command 0x80
> SMB connection re-established (-5)
> smb_errno: class ERRSRV, code 91 from command 0x80
> SMB connection re-established (-5)
> smb_errno: class ERRSRV, code 91 from command 0x80
> Debug: sleeping function called from invalid context at include/asm/uaccess.h:512Call Trace:
>  [<c011fd3c>] __might_sleep+0x5c/0x5e
>  [<c010da1a>] save_v86_state+0x6a/0x200
>  [<c010e565>] handle_vm86_fault+0xa5/0x8c0
>  [<c0170a23>] dput+0x23/0x200
>  [<c010c030>] do_general_protection+0x0/0xa0
>  [<c032519f>] error_code+0x2f/0x38
>  [<c0324733>] syscall_call+0x7/0xb
> 
> SMB connection re-established (-5)
> smb_errno: class ERRSRV, code 91 from command 0x80
> XFS mounting filesystem hda1

Actually, Samba seems unconnected.

This is not an oops, just a debug trace that says something tried to
do something unsafe (namely calling copy_from_user while in_atomic()
was true). 

Looks like we've got:

 do_general_protection
  handle_vm86_fault
   return_to_32bit
    save_v86_state
     copy_to_user   

and the destination of the copy is current->thread.vm86_info->regs,
which is labelled __user. Presuming this is actually in userspace,
this could be a problem.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
