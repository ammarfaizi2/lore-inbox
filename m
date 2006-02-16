Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWBPLBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWBPLBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 06:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWBPLBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 06:01:22 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:49322 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751344AbWBPLBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 06:01:21 -0500
Date: Thu, 16 Feb 2006 05:58:15 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: i386 singlestep is borken
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602160601_MC3-1-B882-BFB6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Playing around with singlestep on i386, I found this:

1. User sets TF and starts to singlestep through code,
   handling SIGTRAPS as they occur.

2. Makes vsyscall; debug trap occurs in kernel mode and TF
   is cleared.  TIF_SINGLESTEP gets set so kernel will remember
   to re-enable TF on return to user.  But when user eflags
   is saved on the stack, TF has already been cleared.

3. When user gets control back, TF is not re-enabled.

4. Even after user clears TF, TIF_SINGLESTEP remains set
   for that thread.

None of this happens when using int80 because the flag
is cleared and re-enabled by the interrupt handler.
TIF_SINGLESTEP never gets set and doesn't need to be.

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

