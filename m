Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTFLTbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTFLTbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:31:41 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:48270 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264956AbTFLTbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:31:40 -0400
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
From: john stultz <johnstul@us.ibm.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Andi Kleen <ak@suse.de>, vojtech@suse.cz, discuss@x86-64.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1055440030.1043.7.camel@serpentine.internal.keyresearch.com>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
	 <20030611191815.GA30411@wotan.suse.de>
	 <1055361411.17154.83.camel@serpentine.internal.keyresearch.com>
	 <1055362249.17154.86.camel@serpentine.internal.keyresearch.com>
	 <1055366609.18643.63.camel@w-jstultz2.beaverton.ibm.com>
	 <1055367412.17154.100.camel@serpentine.internal.keyresearch.com>
	 <1055378035.18643.95.camel@w-jstultz2.beaverton.ibm.com>
	 <1055440030.1043.7.camel@serpentine.internal.keyresearch.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055446795.18644.148.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jun 2003 12:39:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 10:47, Bryan O'Sullivan wrote:
> On Wed, 2003-06-11 at 17:33, john stultz wrote:
> 
> > Let me know if you have any issues with this patch. 
> 
> Thanks, John.  Your updated patch has survived some beating on my test
> systems.  I've also applied Vojtech's fix to hpet_tick.

One little tweak, you're still subtracting tick_usec when calculating
offset. Doesn't cause any major problems since you're catching error
with the offset<0 switch. However we won't catch lost interrupts
properly if we're always negative. 

thanks
-john


Patch for that should be:

--- 1.22/arch/x86_64/kernel/time.c	Thu Jun 12 11:40:33 2003
+++ edited/arch/x86_64/kernel/time.c	Thu Jun 12 11:42:43 2003
@@ -254,7 +254,7 @@
 		vxtime.last = offset;
 	} else {
 		offset = (((tsc - vxtime.last_tsc) *
-			   vxtime.tsc_quot) >> 32) - tick_usec;
+			   vxtime.tsc_quot) >> 32) - (USEC_PER_SEC / HZ);
 
 		if (offset < 0)
 			offset = 0;



