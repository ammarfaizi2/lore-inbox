Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVIDDPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVIDDPq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 23:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVIDDPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 23:15:45 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:60904 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750794AbVIDDPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 23:15:45 -0400
Date: Sat, 3 Sep 2005 23:14:19 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: looking for help tracing oops
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509032315_MC3-1-A912-1FF8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <431925C4.60509@nortel.com>

On Fri, 02 Sep 2005 at 22:25:40 -0600, Christopher Friesen wrote:

> One thing I 
> don't understand--the function makes calls to other functions including 
> printk(), but I don't see those calls listed in the disassembly.

Calls to external functions whose address is not known at compile time
look like this (using 'objdump -d' on my 2.6.10 kernel:)

    19fd:       e8 fc ff ff ff          call   19fe <filp_close+0x4e>

e8 is call relative with 32-bit displacement from start of next instruction.
The displacement points right back at itself (fffffffc == -4)

> EIP is at filp_close+0x64/0xa0

Here:

> 0x00001ac4 <filp_close+100>:    mov    0x2c(%eax),%edx  <============
> 0x00001ac7 <filp_close+103>:    test   %edx,%edx
> 0x00001ac9 <filp_close+105>:    je     0x1a93 <filp_close+51>

eax is f88ad500 and your illegal access was at f88ad52c

Looks like filp->fops points to unallocated memory and it dies while
trying to access filp->fops->flush here:

        if (filp->f_op && filp->f_op->flush) {
 
__
Chuck
