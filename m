Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUBXUtn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUBXUtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:49:43 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:14487 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262443AbUBXUtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:49:07 -0500
Subject: cryptoapi highmem bug
From: Christophe Saout <christophe@saout.de>
To: James Morris <jmorris@intercode.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077655754.14858.0.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 21:49:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

someone noticed strange corruptions with dm-crypt and highmem. After I
found out that I could force my machine to use highmem even though it
only has 256MB, I finally found the problem after some debugging:

The problem is in cbc_process (well, partly):

>      const int need_stack = (src == dst);
>      u8 stack[need_stack ? crypto_tfm_alg_blocksize(tfm) : 0];
>      u8 *buf = need_stack ? stack : dst;

src == dst fails if the page was in highmem because crypto_kmap will
assign two different virtual addresses for the same page.

The result is data corruption.

How could this be fixed?

scapperwalk_map could check if this page was already mapped (walk_in)
and reuse the virtual address if so. So a single page is only mapped
once and the check in cbc_process will work.

I can really use the src == dst case because I would need to allocate
unnecessary buffers (at least 512 bytes at a time and per cpu).

(I just hacked dm-crypt to allocate 512 bytes on the stack and use it
temporarily and kmap around myself to copy it back and the problem is
gone. Ugly.)


