Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312280AbSCUOwh>; Thu, 21 Mar 2002 09:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312351AbSCUOw2>; Thu, 21 Mar 2002 09:52:28 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:61614 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312280AbSCUOwU>; Thu, 21 Mar 2002 09:52:20 -0500
Importance: Normal
Sensitivity: 
Subject: Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell box
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OFD90E745F.C0FAFDC5-ON88256B83.0050EB0E@boulder.ibm.com>
From: "James Washer" <washer@us.ibm.com>
Date: Thu, 21 Mar 2002 06:52:47 -0800
X-MIMETrack: Serialize by Router on D03NM038/03/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/21/2002 07:52:16 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, I agree that page 104 ( Section  3.11 ) is inconsistent with itself
wrt
      "Write to control register CR3 to invalidate all TLB entries."

For the particular problem Tom is seeing however. I've recoded do_trap() to
do an invlpg to the particular page that is causing the problem.. Just in
case the G bit was set and the pte was stale.  I suspect he'll be able to
test this code this morning.

 - jim

Zwane Mwaikambo <zwane@linux.realnet.co.sz>@vger.kernel.org on 03/20/2002
11:19:41 PM

Sent by:    linux-kernel-owner@vger.kernel.org


To:    James Washer/Beaverton/IBM@IBMUS
cc:    Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject:    Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell
       box



On Wed, 20 Mar 2002, James Washer wrote:

>
> The iTLB would be flushed when he did the reload of cr3 ( per your
> suggestion ) UNLESS the G bit was set.
> I suppose theres some small chance, that at the time this instruction was
> first cached and its corresponding iTLB entry was loaded, the G bit may
> have been set.. Seems unlikely. but I'll hack up something to
> unconditionally flush the iTLB.

I find vol3 somewhat confusing in this regard...

P104 - The only ways to deterministically invalidate global page entries
are as follows:
o Clear the PGE flag and then invalidate the TLBs.
o Execute the INVLPG instruction to invalidate individual page-directory
  or page-table entries in the TLBs.
o Write to control register CR3 to invalidate all TLB entries.

Then on page 381.

The following operations invalidate all TLB entries except global entries.
(A global entry is one for which the G (global) flag is set in its
corresponding page-directory or page-table entry. The global flag was
introduced into the IA-32 architecture in the P6 family processors, see
Section 10.5.,  Cache Control .)

o Writing to control register CR3.
o A task switch that changes control register CR3.

I would reckon reference 1 (p104) is incorrect, can someone shed some
light?

Thanks,
 Zwane


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



