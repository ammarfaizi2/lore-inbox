Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265003AbUFAMEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265003AbUFAMEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 08:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbUFAMEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 08:04:46 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:62405 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S265003AbUFAMEe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 08:04:34 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Ben LaHaise <bcrl@kvack.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Architectures Group <linux-arch@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Matthew Wilcox <willy@debian.org>
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF283CD009.20B7561C-ONC1256EA6.003BBE8A-C1256EA6.00424F81@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 1 Jun 2004 14:04:17 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 01/06/2004 14:04:05
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> The last issue is ptep_establish, we're flushing the pte in do_wp_page
> inside ptep_establish again for no good reason. Those suprious tlb
> flushes may even trigger IPIs (this time in x86 smp too even with
> processes), so I'd really like to remove the explicit flush in
> do_wp_page, however this will likely break s390 but I don't understand
> s390 so I'll leave it broken for now (at least to show you this
> alternative and to hear comments if it's as broken as the previous one).

No, this shouldn't break s390 in any way, removing superfluous tlb flushes
will benefit s390 just like any other architecture.

> The really scary thing about this patch is the s390 ptep_establish.

The s390 version of ptep_establish isn't scary at all, it's just an
optimization. s390 can use the generic set_pte & flush_tlb_page sequence
for ptep_establish without a problem but there is a better way to do it.
We use the ipte instruction because it only flushes the tlb entries for
a single page and not all of them. Don't worry too much about breaking
s390, if you do I will complain.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com

