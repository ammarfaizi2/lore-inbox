Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVLPVGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVLPVGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVLPVGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:06:44 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:59549 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932163AbVLPVGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:06:43 -0500
Date: Fri, 16 Dec 2005 22:06:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
       rhim@cc.gatech.edu
Subject: [rfc] guest page hinting patches, take #2.
Message-ID: <20051216210644.GA11062@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
the first set of patches for the guest page hinting project went
by more or less unnoticed. So I updated the patches against latest
and greatest which is 2.6.15-rc5-mm3. A few bugs have been fixed and
I keep the fingers crossed that I got the update to the -mm tree
right without introducing too many new bugs. Runs ok on my z/VM
system but the real test has been done with linux 2.6.13 + patches,
latest version of the millicode and latest z/VM nucleus. In that
combination it now runs rock solid under heavy stress, and it works
as expected. We have a lot of volatile pages, the hypervisor removes
them on demand and delivers the discard faults. The test with
2.6.15-rc5-mm3 is pending but I'd say the state of affairs is good
enough for another try to get some review. The first sniff test
with the -mm tree showed no unpleasant surprises.

There are again 6 patches, to reduce the complexity a bit:
1) Base patch. Introduces most of the common code. It adds two new page
   flags for serializing page state changes and to identify discarded
   pages. I would like to avoid adding page flags but failed to see a
   different solution in both cases. Another point of discussion would
   be the page->mapping/__remove_from_page_cache hack.
2) Mlock and friends. Adds special handling for mlocked pages. I use a
   field in the struct address_space to identify mlocked pages. Any
   betters ideas?
3) Support writable ptes. Adds another page flag (this makes 3 new page
   flags in total ..)
4) Minor fault vs. page state changes. 
5) Discarded page list. Ugly problem of virtual vs. absolute addresses
   on the discard fault. We tried talking the s390 architecture folks
   into providing virtual guest addresses but it seems that this is not
   possible with the current hardware.
6) s390 guest support for guest page hinting.

The patches do not include support for the host side of the equation.
For s390 this is implemented in the z/VM hypervisor. 

blue skies,
  Martin.

