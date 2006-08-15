Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWHOKeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWHOKeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965372AbWHOKeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:34:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20650 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965371AbWHOKeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:34:11 -0400
Subject: Shared page tables patch... some results
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: hugh@veritas.com, akpm@osdl.org, dmccr@us.ibm.com
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 15 Aug 2006 12:34:07 +0200
Message-Id: <1155638047.3011.96.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

until OLS of this year, most people thought that Dave's shared page
table patch was effectively a database-only hack, and thus not all that
interesting...

however it's also possible to use shared page tables for shared
libraries, and thus the gain is MUCH wider in scope. Dave has been so
kind as to send me his latest patch, and I've done some measurements on
my new x86-64 test machine (which runs FC6-test2)...

and the result is interesting:
Just booting into runlevel 5 and logging into gnome (without starting
any apps) gets a sharing of 1284 pte pages! This means that five
megabytes (!!) of memory is saved, and countless pagefaults are avoided.

Now, as Dave discussed in Ottawa, there is one so-far unsolved gotcha
with shared pagetables: RSS accounting.

The problem is that if application A and B both map a file C, and end up
sharing the pagetable.. page faults that A gets are accounted as the rss
for A, but not in the RSS for B, even though the page is now in the
pagetables for application B.

One possible solution would be to upper-bound estimage the RSS cost of
shareable file mappings to the mapping size; another possible angle is
to dynamically calculate the RSS for file backed mappings (by storing
the rss count in the struct page of the pagetable, and then iterate over
these).

But.. I'm really hoping someone out here has some other smart idea; it'd
be really nice to get this working really well.. after all it's a memory
saving for everyone!

Greetings,
   Arjan van de Ven


Notes about the measurement of the number 1284 
[1] This only works on x86-64, not i386. For this to work the libraries
need to be mapped at a granularity of 2Mb; i386 uses 4Kb which is too
small
[2] This only works if you use a new enough binutils (such as FC6-test
has); older versions of binutils used 1Mb not 2Mb as alignment.
[3] It really helps to use prelink (as I did), prelink makes sure that a
library is on the same virtual address in all applications, which is
basically a requirement for sharing the pagetables

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

