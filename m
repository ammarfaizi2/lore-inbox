Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbTAJIfK>; Fri, 10 Jan 2003 03:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbTAJIfK>; Fri, 10 Jan 2003 03:35:10 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:46505 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264630AbTAJIfJ>;
	Fri, 10 Jan 2003 03:35:09 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15902.34759.187965.633490@harpo.it.uu.se>
Date: Fri, 10 Jan 2003 09:43:51 +0100
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Mikael Pettersson" <mikpe@csd.uu.se>, <jamesclv@us.ibm.com>,
       "Jason Lunz" <lunz@falooley.org>, <linux-kernel@vger.kernel.org>
Subject: RE: detecting hyperthreading in linux 2.4.19
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E20B@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E20B@fmsmsx405.fm.intel.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh writes:
 > 
 > > -----Original Message-----
 > > From: Mikael Pettersson [mailto:mikpe@csd.uu.se]
 > > 
 > > My performance monitoring counters driver uses this approach 
 > > in kernel-space
 > > using smp_call_function(). I don't use the siblings tables 
 > > because they suck :-)
 > > [I don't think they distinguish between logical CPUs #0 and 
 > > #1, and they aren't
 > > exported to modules. The CPUID check is simple and portable 
 > > across kernel versions.]
 > 
 > I believe it is better to use a OS interface to find out HT, rather than 
 > using CPUID. The reason being, it is possible to have HT disabled, in OS,
 > even after processor and the BIOS supports it. 
 > 1) Consider the case when processor and BIOS supports HT, but linux
 > was booted with "noht" boot option (now I am not sure whether that option is 
 > there in 2.4.19. But is is certainly there in some other kernels).
 > 2) What about some other kernel which is totally ignorant about HT, and 
 > doesn't initialize logical processor (kernel which looks at MPS in place
 > of ACPI)
 > I think, in both these cases cpuid can still say HT is present.

With smp_call_function() I execute code on exactly those CPUs the kernel
knows about. If the physical processors support HT but the kernel can't
run on the non-#0 logical CPUs (UP kernel or "noht"), then smp_call_function()
won't reach those logical CPUs #1 and everything's fine: my test will say
"not HT" which is exactly what I want in this case.

The point about checking the "local APIC physical ID" in CPUID 1, EBX,
instead of the field in the local APIC is _exactly_ because the CPUID
data is assigned by HW and read-only, while the local APIC field can be
changed. I don't want to depend on possibly-broken MP or ACPI tables or
have to know about the kernel's physical <--> virtual CPU # mapping de jour.

 > I know that sibling table is not exported. But I couldn't get your other
 > comment about sibling table "they distinguish between logical CPUs #0 and #1:"
 > Can you elaborate..

The sibling table tells you whether two linux-numbered CPUs are siblings,
but it doesn't tell which one is logical CPU #0 and which one is #1.
That distinction is important in some cases.
