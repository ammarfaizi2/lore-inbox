Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbULVRnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbULVRnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 12:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbULVRnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 12:43:07 -0500
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:112 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261416AbULVRnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 12:43:03 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.88,81,1102287600"; 
   d="scan'208"; a="1183742:sNHT21968024"
Message-ID: <41C9B21F.90802@fujitsu-siemens.com>
Date: Wed, 22 Dec 2004 18:42:55 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc3, i386: fpu handling on sigreturn
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe, there is a problem in i386 fpu/signal handling:

On i386, if a signal handler is started, the kernel saves the fpu-state
of the interrupted routine in the sigcontext on the stack. Calling
unlazy_fpu() and setting current->used_math=0, the kernel supplies the
signal-handler with a cleared virtual fpu.
On sigreturn(), the old fpu-state of the interrupted routine is
restored.

If a process never used the fpu, it virtually has a cleared fpu.
If such a process is interrupted by a signal handler, no fpu-context is
saved and sigcontext->fpstate is set to NULL.

Assume, that the signal handler uses the fpu. Then, AFAICS, on sigreturn
current->used_math will be 1. Since sigcontext->fpstate still is NULL,
restore_sigcontext() doesn't call restore_i387(). Thus, no
clear_fpu() is done, current->used_math is not reset.

Now, the interrupted processes fpu no longer is cleared!

I don't know, if this could cause trouble, since I'm not an expert for
i386-fpu. But it seems to be not clean.

Best regards
Bodo


