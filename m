Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSLVUyD>; Sun, 22 Dec 2002 15:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbSLVUyD>; Sun, 22 Dec 2002 15:54:03 -0500
Received: from franka.aracnet.com ([216.99.193.44]:8102 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265373AbSLVUyA>; Sun, 22 Dec 2002 15:54:00 -0500
Date: Sun, 22 Dec 2002 13:01:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][2.4]  generic support for systems with more than 8
 CP	Us (2/2)
Message-ID: <8870000.1040590913@titus>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C1AEC74@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C1AEC74@usslc-exch-4.slc.unisys.
 com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> IIRC NUMA-Q can be dynamically detected at boot by means of an MP OEM
>> table's presence, in particular if there's a matching string in the 8B
>> OEM record in the OEM table, with a value of "IBM NUMA" IIRC. This is
>> probably a line or two's worth of change to mpparse.c and declaring a
>> variable for clustered_apic_mode. If it were difficult to detect, I
>> wouldn't have suggested implementing it (though do so at your leisure).
>> =)

I don't think you need the OEM table to detect this, current patches do:

+static inline void mps_oem_check(struct mp_config_table *mpc, char *oem,
+               char *productid)
+{
+       if (strncmp(oem, "IBM NUMA", 8))
+               printk("Warning!  May not be a NUMA-Q system!\n");
+       if (mpc->mpc_oemptr)
+               smp_read_mpc_oem((struct mp_config_oemtable *) 
mpc->mpc_oemptr,
+                               mpc->mpc_oemsize);
+}


 @@ -376,7 +368,7 @@ static int __init smp_read_mpc(struct mp
        str[12]=0;
        printk("Product ID: %s ",str);

-       summit_check(oem, str);
+       mps_oem_check(mpc, oem, str);

        printk("APIC at: 0x%lX\n",mpc->mpc_lapic);

> The format for the OEM table is pretty much freelance. ES7000 uses it in
> the most informal way. However, we need information from this table to
> switch to APIC mode, start CPUs, etc. To have the hook for OEM tables in
> MP parsing (and in ACPI, for that matter) seems pretty natural. Or if
> reading of the OEM table could also be done in more generic way so other
> platforms had chance to read their tables seamlessly...

Support for parsing the mps oem tables is already there - I use it for
NUMA-Q ... see if smp_read_mpc_oem will do what you want ... if not,
maybe we can generalise it out.

> Also, could the clustered_logical and clustered_physical modes be
> implemented as a primary item, with NUMA being a secondary with the set of
> its unique features on top of the certain APIC mode? This way, a clustered
> mode for the APIC could be selectable without NUMA. CLUSTERED_APIC_NUMAQ
> could be still an option with an appropriate clustered mode defined.

Yup - it was only set up that way because we had a 1-1 correlation between
NUMA and clustered_apic_mode at the time. Switching the ordering as you
suggest seems sensible now.

In the last patch from Venkatesh there was a > 8CPUs option ... that
seems like a direct correlation to clustered apic support to me ...
maybe we could just switch on CONFIG_X86_CLUSTERED_APIC directly and
bypass CONFIG_X86_MANY_CPU? The menu text could stay the same (less
confusing for users than asking them about apic modes) ...

M.

