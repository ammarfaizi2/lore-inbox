Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbWADBg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWADBg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWADBg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:36:56 -0500
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:1541 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S965124AbWADBgz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:36:55 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Patch] es7000 broken without acpi
Date: Tue, 3 Jan 2006 19:36:39 -0600
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B09AE@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] es7000 broken without acpi
Thread-Index: AcYQwD4nezlL70WsQqG19cKyGG4LFQADaMag
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Eric Sesterhenn / snakebyte" <snakebyte@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Jan 2006 01:36:39.0921 (UTC) FILETIME=[4F2C3610:01C610CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Eric Sesterhenn / snakebyte <snakebyte@gmx.de> wrote:
> >
> > hi,
> > 
> > a make randconfig gave me a situation where es7000 was enabled, but 
> > acpi wasnt ( dont know if this makes sense ), gcc gave me some 
> > compiling errors, which the following patch fixes. Please 
> cc me as i am not on the list. Thanks.
> > 
> > 
> 
> I believe that es7000 requires ACPI, so a better fix would be 
> to enforce that within Kconfig.
> 
> Natalie, can you please comment?


You are correct, Andrew: ES7000 "preferred" mode is ACPI (although it
runs in MPS as well, which we use for debugging of intermittent ACPI and
platform problems).
I have done a similar patch (see
http://bugzilla.kernel.org/attachment.cgi?id=5771&action=view) against
2.6.13, but the one suggested later by Peter Hagervall  
http://www.ussg.iu.edu/hypermail/linux/kernel/0510.3/1302.html was
actually taking care of the compile problem through Kconfig better,
since "acpi=off" option is available for our debug/testing purposes
anyway.
Thanks,
--Natalie

> 
> > 
> > 
> > diff -up 
> linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000.h 
> linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000.h
> > --- 
> linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000.h	
> 2005-12-12 23:44:39.000000000 +0100
> > +++ linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000.h	
> 2005-12-12 23:43:51.000000000 +0100
> > @@ -83,6 +83,7 @@ struct es7000_oem_table {
> >  	struct psai psai;
> >  };
> >  
> > +#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI)
> >  struct acpi_table_sdt {
> >  	unsigned long pa;
> >  	unsigned long count;
> > @@ -98,6 +99,7 @@ struct oem_table {
> >  	u32 OEMTableAddr;
> >  	u32 OEMTableSize;
> >  };
> > +#endif
> >  
> >  struct mip_reg {
> >  	unsigned long long off_0;
> > diff -up 
> linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000plat.c 
> linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000plat.c
> > --- 
> linux-2.6.15-rc5-git2/arch/i386/mach-es7000.orig/es7000plat.c	
> 2005-12-12 23:44:39.000000000 +0100
> > +++ 
> linux-2.6.15-rc5-git2/arch/i386/mach-es7000/es7000plat.c	
> 2005-12-12 23:43:20.000000000 +0100
> > @@ -92,7 +92,9 @@ setup_unisys(void)
> >  		es7000_plat = ES7000_ZORRO;
> >  	else
> >  		es7000_plat = ES7000_CLASSIC;
> > +#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI)
> >  	ioapic_renumber_irq = es7000_rename_gsi;
> > +#endif
> >  }
> >  
> >  /*
> > @@ -160,6 +162,7 @@ parse_unisys_oem (char *oemptr)
> >  	return es7000_plat;
> >  }
> >  
> > +#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI)
> >  int __init
> >  find_unisys_acpi_oem_table(unsigned long *oem_addr)  { @@ -212,6 
> > +215,7 @@ find_unisys_acpi_oem_table(unsigned long
> >  	}
> >  	return -1;
> >  }
> > +#endif
> >  
> >  static void
> >  es7000_spin(int n)
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org 
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
