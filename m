Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030490AbWASAEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbWASAEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWASAEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:04:22 -0500
Received: from fmr17.intel.com ([134.134.136.16]:63906 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030486AbWASAEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:04:20 -0500
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4]  Hot Dock/Undock support
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
In-Reply-To: <20060118222348.GG1580@elf.ucw.cz>
References: <1137545813.19858.45.camel@whizzy>
	 <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy>
	 <20060118194554.GA1502@elf.ucw.cz> <1137618370.31839.12.camel@whizzy>
	 <20060118222348.GG1580@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 16:06:59 -0800
Message-Id: <1137629220.31839.56.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 19 Jan 2006 00:04:04.0987 (UTC) FILETIME=[DC5ECCB0:01C61C8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 23:23 +0100, Pavel Machek wrote:
<snip>
> Device GDCK looks like dock to my untrained eye. Unfortunately its
> type is IBM0079... ...
> 
> Ahha, and ibm_acpi.c agrees with me.
> 
> IBM_HANDLE(dock, root, "\\_SB.GDCK",    /* X30, X31, X40 */
> 
>         Scope (\_SB)
>         {
>             Device (GDCK)
>             {
>                 Name (_HID, EisaId ("IBM0079"))
>                 Name (_CID, 0x150CD041)
>                 Method (_STA, 0, NotSerialized)
>                 {
> ...
>                 Method (_DCK, 1, NotSerialized)
>                 {
>                     Store (0x00, Local0)
>                     If (LEqual (GGID (), 0x03))
>                     {
>                         Store (\_SB.PCI0.LPC.EC.SDCK (Arg0), Local0)
>                     }
> 
>                     If (LEqual (GGID (), 0x00))
>                     {
>                         Store (\_SB.PCI0.PCI1.DOCK.DDCK (Arg0), Local0)
>                     }
> 
>                     Return (Local0)
>                 }
> 
>                 Method (_EJ0, 1, NotSerialized)
>                 {
>                     If (LEqual (GGID (), 0x03))
>                     {
>                         \_SB.PCI0.LPC.EC.SEJ0 (Arg0)
>                     }
> 
>                     If (LEqual (GGID (), 0x00))
>                     {
>                         \_SB.PCI0.PCI1.DOCK.DEJ0 (Arg0)
>                     }
>                 }
> ....
> 
> Hope this helps.
> 						Pavel


so the problem that I see is that this dsdt defines two separate dock
devices, one outside the scope of pci, and one within it.  The one
outside the scope of pci defines the _EJ0 and _DCK methods.  So, when
acpiphp loads, it scans the pci slots for ejectable slots, finds none
(because _EJ0 is defined in the dock device that is outside the scope of
pci) and exits.  This dsdt is different from the others I've used in
that most of them define all methods related to docking under the actual
dock bridge (within the scope of pci).  perhaps some acpi people can
shed some light on the best way to handle this - otherwise I'm sure I
can hack something up that will be less than acceptable :).


