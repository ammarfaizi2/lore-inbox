Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTEMUdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263465AbTEMUds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:33:48 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:22635 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263449AbTEMUcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:32:03 -0400
Date: Tue, 13 May 2003 15:44:45 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Race between vmtruncate and mapped areas?
Message-ID: <154080000.1052858685@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As part of chasing the BUG() we've been seeing in objrmap I took a good
look at vmtruncate().  I believe I've identified a race condition that no
only  triggers that BUG(), but also could cause some strange behavior
without the objrmap patch.

Basically vmtruncate() does the following steps:  first, it unmaps the
truncated pages from all page tables using zap_page_range().  Then it
removes those pages from the page cache using truncate_inode_pages().
These steps are done without any lock that I can find, so it's possible for
another task to get in between the unmap and the remove, and remap one or
more pages back into its page tables.

The result of this is a page that has been disconnected from the file but
is mapped in a task's address space as if it were still part of that file.
Any further modifications to this page will be lost.

I can easily detect this condition by adding a bugcheck for page_mapped()
in truncate_complete_page(), then running Andrew's bash-shared-mapping test
case.

Please feel free to poke holes in my analysis.  I'm not at all sure I
haven't missed some subtlety here.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

