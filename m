Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbTFMQt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbTFMQt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:49:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:5290 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265229AbTFMQtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:49:52 -0400
Importance: Normal
Sensitivity: 
Subject: RE: e1000 performance hack for ppc64 (Power4)
To: haveblue@us.ibm.com
Cc: "Feldman, Scott" <scott.feldman@intel.com>, David Gibson <dwg@au1.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>,
       "Nancy J Milliner" <milliner@us.ibm.com>,
       "Ricardo C Gonzalez" <ricardoz@us.ibm.com>,
       "Brian Twichell" <twichell@us.ibm.com>, netdev@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFE66E5333.7D508BC2-ON85256D44.005D4736@pok.ibm.com>
From: "Herman Dierks" <hdierks@us.ibm.com>
Date: Fri, 13 Jun 2003 12:03:00 -0500
X-MIMETrack: Serialize by Router on D01ML065/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 06/13/2003 01:03:21 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I will let Anton respond to this.   I think he may have tried this some
time back in his early prototypes to fix this.
I think the problem was not where the buffer started but where the  packet
ended up within the buffer.
Due to varying sizes of TCP and IP headers the packet ended up at some
non-cache aligned address.
What we need for the DMA to work well is to have the final packet  (with
datalink headers)  starting on a cache line as its the final packet that
must be DMA'd. In fact it may need to to be aligned to a higher level than
that (not sure).


haveblue@us.ltcfwd.linux.ibm.com on 06/13/2003 11:21:03 AM

To:    Herman Dierks/Austin/IBM@IBMUS
cc:    "Feldman, Scott" <scott.feldman@intel.com>, David Gibson
       <dwg@au1.ibm.com>, Linux Kernel Mailing List
       <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>,
       Nancy J Milliner/Austin/IBM@IBMUS, Ricardo C
       Gonzalez/Austin/IBM@ibmus, Brian Twichell/Austin/IBM@IBMUS,
       netdev@oss.sgi.com
Subject:    RE: e1000 performance hack for ppc64 (Power4)



Too long to quote:
http://marc.theaimsgroup.com/?t=105538879600001&r=1&w=2

Wouldn't you get most of the benefit from copying that stuff around in
the driver if you allocated the skb->data aligned in the first place?

There's already code to align them on CPU cache boundaries:
#define SKB_DATA_ALIGN(X)       (((X) + (SMP_CACHE_BYTES - 1)) & \
                                 ~(SMP_CACHE_BYTES - 1))

So, do something like this:
#ifdef ARCH_ALIGN_SKB_BYTES
#define SKB_ALIGN_BYTES ARCH_ALIGN_SKB_BYTES
#else
#define SKB_ALIGN_BYTES SMP_CACHE_BYTES
#endif
#define SKB_DATA_ALIGN(X)       (((X) + (ARCH_ALIGN_SKB - 1)) & \
                                 ~(SKB_ALIGN_BYTES - 1))

You could easily make this adaptive to no align on th arch size when the
request is bigger than that, just like in the e1000 patch you posted.
--
Dave Hansen
haveblue@us.ibm.com





