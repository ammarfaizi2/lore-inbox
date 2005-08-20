Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932771AbVHTAC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbVHTAC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbVHTAC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:02:57 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54750 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932768AbVHTAC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:02:56 -0400
Message-ID: <43067328.3020200@pobox.com>
Date: Fri, 19 Aug 2005 20:02:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Simon Oosthoek <s.oosthoek@home.nl>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SATA status report updated
References: <4AA7B-4jm-5@gated-at.bofh.it> <4DagM-7c8-43@gated-at.bofh.it> <871x4ql24a.fsf@ABG3595C.abg.fsc.net> <43062623.607@pobox.com> <430664C8.1090000@home.nl>
In-Reply-To: <430664C8.1090000@home.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Oosthoek wrote:
> I know Mandriva is on the ball and a bug with some information and an 
> updated patch is on the kernel bugme...
> 
> http://qa.mandriva.com/show_bug.cgi?id=17654
> http://bugme.osdl.org/show_bug.cgi?id=4192
> 
> I'd say it's important to get some proper fix in a distribution soon (so 
> I can use my new PC ;-)


That's not an updated patch.  That's the patch that duplicates kernel 
infrastructure, implementing things in the driver that should instead be 
implemented in libata core.

That's how Windows drivers are written: work around the OS, rather than 
fix it.

Here is a list of problems with the patch.  I'll paste this into the bug 
as well:

1) duplicates SATA phy reset

2) abuses infrastructure to support PATA, rather than doing it properly. 
  doing it properly involves an approach similar to that found in the 
'promise-sata-pata' branch of libata-dev.git.  Same problem as Promise 
SATA+PATA, with the same solution.

3) duplicates ATA bus reset, except, does it poorly

4) duplicates ata_busy_sleep()

5) appears to do strange things with PATA devices, when one uses the 
->scr_write() and ->scr_read() hooks -- hooks used to talk to SATA PHYs 
(never PATA devices).

6) [maybe] sets DMA/PIO timings even for SATA devices.  This -may- be 
needed, depending on PATA<->SATA bridge presence in the host controller

7) Pads DMA to 32-bit boundary.  Should be done in libata core, this is 
needed for all host controllers.

8) The DMA pad code is very buggy.  It uses the dma_map_single() to map 
a buffer, but never synchronizes nor flushes the buffer.  This can and 
will lead to data corruption, particularly on x86-64 platform.

Regards,

	Jeff


