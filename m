Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUFWJXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUFWJXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 05:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUFWJXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 05:23:52 -0400
Received: from audiogram.mail.pas.earthlink.net ([207.217.120.253]:26831 "EHLO
	audiogram.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265224AbUFWJXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 05:23:50 -0400
Message-ID: <40D94C0F.6050400@exmsft.com>
Date: Wed, 23 Jun 2004 11:23:27 +0200
From: Keith Moore <keithmo@exmsft.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.7-mm1 PCNet Problems under VMWare 4.5.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: bd47eb33e10cdf15d780f4a490ca69564776905774d2ac4be8f15d04692ebf8afbdc3fc4f4e5cb55350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 81.190.213.75
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing problems running a 2.6.7-mm1 kernel with Fedora Core 2 
running in a VMWare Workstation 4.5.2 VM. The kernel hangs trying to 
bring up the (dhcp-enabled) eth0 interface.

I dug through the -mm1 patch, and the problem seems to be the changes at 
the end of the pcnet32_interrupt() function (in drivers/net/pcnet32.c). 
The relevant patch fragment is:

-    /* Clear any other interrupt, and set interrupt enable. */
-    lp->a.write_csr (ioaddr, 0, 0x7940);
+    /* Set interrupt enable. */
+    lp->a.write_csr (ioaddr, 0, 0x0040);

Reverting this one section of the patch makes eth0 happy again.

I poked around with the values written to the csr register, and it 
appears the virtual PCNet-II adapter needs bit 0x0100 (initialzation 
done) set. So, writing 0x0140 instead of 0x0040 seems to work well.

I have no idea how accurate VMWare's emulation of this adapter is, or if 
this change may cause problems with other (physical) adapters.


KM


