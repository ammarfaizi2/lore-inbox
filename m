Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbTFMQJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265419AbTFMQJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:09:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8581 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265403AbTFMQJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:09:09 -0400
Subject: RE: e1000 performance hack for ppc64 (Power4)
From: Dave Hansen <haveblue@us.ibm.com>
To: Herman Dierks <hdierks@us.ibm.com>
Cc: "Feldman, Scott" <scott.feldman@intel.com>, David Gibson <dwg@au1.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>,
       Nancy J Milliner <milliner@us.ibm.com>,
       Ricardo C Gonzalez <ricardoz@us.ibm.com>,
       Brian Twichell <twichell@us.ibm.com>, netdev@oss.sgi.com
In-Reply-To: <OF0078342A.E131D4B1-ON85256D44.0051F7C0@pok.ibm.com>
References: <OF0078342A.E131D4B1-ON85256D44.0051F7C0@pok.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055521263.3531.2055.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Jun 2003 09:21:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

