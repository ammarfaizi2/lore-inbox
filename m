Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbSLWQ7k>; Mon, 23 Dec 2002 11:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbSLWQ7k>; Mon, 23 Dec 2002 11:59:40 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:15064 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S266886AbSLWQ7j>; Mon, 23 Dec 2002 11:59:39 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C1AEC7F@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Pallipadi, Venkatesh'" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: RE: [PATCH][2.4]  generic support for systems with more than 8 CP
	Us (2/2)
Date: Mon, 23 Dec 2002 11:07:34 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+	/*
+	 * Switch to Physical destination mode in case of generic
+	 * more than 8 CPU system, which has xAPIC support
+	 */
+#define FLAT_APIC_CPU_MAX	8
+	if ((clustered_apic_mode == CLUSTERED_APIC_NONE) &&
+	    (xapic_support) &&
+	    (num_processors > FLAT_APIC_CPU_MAX)) {
+		clustered_apic_mode = CLUSTERED_APIC_XAPIC;
+		apic_broadcast_id = APIC_BROADCAST_ID_XAPIC;
+		int_dest_addr_mode = APIC_DEST_PHYSICAL;
+		int_delivery_mode = dest_Fixed;
+		esr_disable = 1;
+	}
+#endif
+

Venkatesh,
I could not find the definition for CLUSTERED_APIC_NONE. Is this an attempt
to set up the clustered mode right in case if it was not compiled with
CLUSTERED_..._XAPIC on the system with > 8 cpu?

>There is already some code in base that does this. For NUMAQ specifically
>this check happens and clustered mode is selected for APIC. My patch has
this 
>additinal check (after the initial IBM OEM check), for non-NUMAQ systems
with 
>more than 8 CPUs and xAPIC support. These systems can not work with the 
>default flat addressing mode. So, this patch sets up such systems in
physical 
>mode.

In the systems like ES7000, all CPU (up to 32) and IO-APICs have 8-bit
hard-wired ID's according to their topological position. Therefore, the
apic_broadcast_id be has to be 0xFF (like summit's, I guess), and modes
should be clustered logical for Cascades, clustered physical for xAPIC. The
IO-APIC lines are programmed with the broadcast ID/lowest priority for
Cascades, and boot CPU ID/XTPR flag/Lowest priority for Fosters/Gallatins.
This is pretty much the only choices we have. If this is not what the patch
allows to do, we need a last chance architectural hook to be able to
accommodate our stuff.

Thanks,
--Natalie

>Thanks,
>-Venkatesh
