Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268866AbTB0Afq>; Wed, 26 Feb 2003 19:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbTB0Afq>; Wed, 26 Feb 2003 19:35:46 -0500
Received: from franka.aracnet.com ([216.99.193.44]:9660 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268866AbTB0Afp>; Wed, 26 Feb 2003 19:35:45 -0500
Date: Wed, 26 Feb 2003 16:45:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Mikael Pettersson <mikpe@user.it.uu.se>
cc: Ion Badulescu <ionut@badula.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box!
Message-ID: <10510000.1046306748@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302261559170.3527-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302261559170.3527-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  
>  	connect_bsp_APIC();
>  
> -	phys_cpu_present_map = 1;
> -	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
> +	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
>  
>  	apic_pm_init2();

If I'm reading this correctly, this is called out of APIC_init_uniprocessor
from smp_init ... isn't that after people have finished using
phys_cpu_present_map (eg setup_ioapic_ids_from_mpc)? 


maybe change this bit in trap_init:

@@ -665,7 +665,6 @@
 	}
 	set_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-	boot_cpu_physical_apicid = 0;
 	if (nmi_watchdog != NMI_NONE)
 		nmi_watchdog = NMI_LOCAL_APIC;
 
to do:

boot_cpu_physical_apicid = hard_smp_processor_id();
phys_cpu_present_map = 1 << boot_cpu_physical_apicid;

or something like that? On the other hand, I can't see how this works right
now (maybe it doesn't), so the above may be utterly wrong.

M.

