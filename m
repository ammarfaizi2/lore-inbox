Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269592AbUJFWuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269592AbUJFWuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269586AbUJFWqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:46:31 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:14052 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S269591AbUJFWnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:43:15 -0400
To: kilian@bobodyne.com (Alan Kilian)
Cc: linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <200410062020.i96KKPN13520@raceme.attbi.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 06 Oct 2004 15:43:13 -0700
In-Reply-To: <200410062020.i96KKPN13520@raceme.attbi.com> (Alan Kilian's
 message of "Wed, 6 Oct 2004 15:20:25 -0500 (CDT)")
Message-ID: <52llejpiwu.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: Driver access ito PCI card memory space question.
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 06 Oct 2004 22:43:14.0297 (UTC) FILETIME=[DD657E90:01C4ABF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Alan>      Then I do request_mem_area(0xfeaff000,4095, "SSE");

    Alan>      Then I do a readl(0xfeaff100); and get this:

    Alan>         Unable to handle kernel paging request at virtual address feaff100

You can't blindly access an address from your device's BARs; on many
architectures PCI access needs setting up and/or addresses need
munging before use.  The API you need is ioremap().

You need to do something like:

	void __iomem *mybase = ioremap(pci_resource_start(my_pdev, 0), 4095);
	u32 value = readl(mybase + 0x100);

(Delete the __iomem annotation for kernels before 2.6.9).

The "Linux Device Drivers" online book, available at
<http://www.xml.com/ldd/chapter/book/> will probably be pretty
helpful.  In fact if you're serious about writing drivers, you should
buy a dead-tree copy.

 - Roland
