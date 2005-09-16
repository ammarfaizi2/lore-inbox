Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVIPWwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVIPWwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 18:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVIPWwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 18:52:40 -0400
Received: from iris-63.mc.com ([63.96.239.141]:57289 "EHLO mc.com")
	by vger.kernel.org with ESMTP id S1750745AbVIPWwk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 18:52:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: inconsistent mmap and get_user_pages with hugetlbfs on ppc64
Date: Fri, 16 Sep 2005 18:52:35 -0400
Message-ID: <92CB67C83EE773499A7F2F6EA7E3FC940F0E99@ad-email1.ad.mc.com>
Thread-Topic: inconsistent mmap and get_user_pages with hugetlbfs on ppc64
Thread-Index: AcW7EVQISNtAnHF6Sru2TN5ezHcsjQ==
From: "Sexton, Matt" <sexton@mc.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Sexton, Matt" <sexton@mc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a ppc64 platform running 2.6.13-1, the virtual to physical mapping
established by mmap'ing a hugetlbfs file does not seem to match the
mapping described by get_user_pages().

Specifically, I have written a driver for a PCI device that writes data
into a user-allocated memory buffer.  The user passes the virtual
address of the buffer to the driver, which calls get_user_pages() to
lock the pages and to get the page information in order to be able to
build a scatter list of contiguous physical blocks to pass to the DMA
engine on the device. The device then writes a known pattern to the
buffer, which the user space program can verify.

This process works fine on ia32 and ppc64 using malloc'ed memory.  This
process also works fine on ia32 when obtaining the memory by mmap'ing a
file on a hugetlbfs filesystem.  The 2MB pages are used to reduce the
number of entries in the scatter list.

The process doesn't work so well on ppc64 with hugetlbfs (and 16MB
pages).  Often, the data is written to the wrong 16MB pages, from the
perspective of the user space program.  The data is correct within a
16MB page, it's just written to the wrong page. It seems that the
information returned by  get_user_pages() doesn't match the virtual to
physical mapping used by the user process.

Any suggestions on what I could be doing wrong in this specific case?
Any known problems with the kernel in this case?

Please CC me on any replies.

Thanks,
Matt

