Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVCVThT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVCVThT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVCVTge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:36:34 -0500
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:9745 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261733AbVCVTdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:33:08 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.91,111,1110150000"; 
   d="scan'208"; a="6598011:sNHT36491064"
Message-ID: <424072E8.7080006@fujitsu-siemens.com>
Date: Tue, 22 Mar 2005 20:32:56 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: S390: bug in signal frame set up when using SA_ONSTACK
Content-Type: multipart/mixed;
 boundary="------------040600070405030009000609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040600070405030009000609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi

IMHO, there is a bug in s390's signal frame handling:

If a signal handler is set to use the signal stack (SA_ONSTACK), but
the signal stack is disabled, the signal frame should be written to
the current stack without stack switching.
S390 doesn't note, that the signal stack is disabled, so it does
stack switching to a stack at 0, size 0. Then it writes the signal frame
to "0x00000000 - sizeof(sigframe)".
If a further signal comes in, while the handler is running, the next
signal frame even will overwrite the previous one.

The reason for the bug is get_sigframe() using on_sig_stack() instead
of sas_ss_flags(), which would be ok. (Oneliner patch attached)

AFAICS, the problem is in 2.4 and 2.6 kernels.

If the error occurs, bit 0 of stack pointer gpr15 is set. In
arch/s390/kernel/signal.c, there is no masking of gpr15 before passing
it to do_sigaltstack() or on_sig_stack()/sas_ss_flags(). Wouldn't it
be better to reset bit 0, to avoid possible problems?

Please CC me, I'm not on the list.

		Bodo


--------------040600070405030009000609
Content-Type: text/x-diff;
 name="s390-fix-signalstack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="s390-fix-signalstack.patch"

--- a/arch/s390/kernel/signal.c	2005-03-22 11:07:39.000000000 +0100
+++ b/arch/s390/kernel/signal.c	2005-03-22 11:08:44.000000000 +0100
@@ -285,7 +285,7 @@
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (! on_sig_stack(sp))
+		if (! sas_ss_flags(sp))
 			sp = current->sas_ss_sp + current->sas_ss_size;
 	}
 

--------------040600070405030009000609--
