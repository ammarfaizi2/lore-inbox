Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270667AbTGNQtB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270684AbTGNQrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:47:32 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:18869 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S270667AbTGNQqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:46:24 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Martin Schlemmer <azarah@gentoo.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.5.74-mm2 + nvidia (and others)
Date: Mon, 14 Jul 2003 18:51:54 +0200
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@osdl.org>, smiler@lanil.mine.nu,
       KML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Christian Zander <zander@mail.minion.de>
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu> <20030712012130.GB15452@holomorphy.com> <1058184576.799.341.camel@workshop.saharacpt.lan>
In-Reply-To: <1058184576.799.341.camel@workshop.saharacpt.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200307141851.55775.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

can anyone tell me WHY the NV_PMD_OFFSET() should not work the way it is with 
the new NVIDIA patch? For our memories here it is again:

#define NV_PMD_OFFSET(address, pgd, pmd) \
    { \
        pmd_t *pmd__ = pmd_offset_map(pgd, address); \
        pmd = *pmd__; \
        pmd_unmap(pmd__); \
    }

1.) For a 2 level pagetable it simply results in a:
	pmd = *((pmd_t *) pgd);

So here the correct entry from the first page directory is copied into a 
variable on the stack. No big deal, as the location of this entry is not 
interesting for the further tablewalk, only its contents.

2.) So let's see what happens for a 3 level pagetable.
We get following code after expanding (most of) the macros:

a.) pmd_t *pmd__ = ((pmd_t *)kmap_atomic(pgd_page(*(pgd)), KM_PMD0) + 
pmd_index(addr));
b.) pmd = *pmd__;
c.) kunmap_atomic(pmd__, KM_PMD0);

The most interesting part is the first line of it...
a.) Here the page number is extracted from the pgd entry and converted to a 
pointer to a page_struct (pgd_page). Now the page is mapped (from the high 
memory) into the lower memory (kmap_atomic). The index where the interesting 
pmd entry is located in this page is extracted from the virtual address via 
the pmd_index macro. With this the pointer to the pmd entry is calculated and 
assigned to pmd__.

b.) Now this entry is simply copied into a variable located at the stack. 
(Again not an issue, as the location of the variable is not of interest for 
the rest of the tablewalk anymore.)

c.) At least the page that contains the pmd entry, too, is unmapped, but our 
local copy on the stack stays...


So after both pieces of code the pmd entry is stored in a variable on the 
stack and the further processing does not need to know where it came from, it 
just needs its contents...

So please tell me where this is wrong...! I just can't see it...

Thank you all for all the work!

Best regards
   Thomas Schlichter
