Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161234AbWASPXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbWASPXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161235AbWASPXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:23:04 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:23303 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161233AbWASPXB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:23:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j0hb8LtD4yn/YPgGNDgXVuIGx/4XRt9USDbmg4TTtSakf/F3vkmQ8n6Tgn+ONZ+SBWCcKd/4vB8Yaj2W4Tnbwipyc1BZZAy8SFmT2qhxbs4Irfdy43VtlX5Aqz0JMlWCVRfvLT7BJGxhxMcFrdOWIb4mCkcZACs546Pab8IlnQ0=
Message-ID: <d120d5000601190723k3339f92eufc3bc1d0832f6058@mail.gmail.com>
Date: Thu, 19 Jan 2006 10:23:00 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4] Hot Dock/Undock support
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
In-Reply-To: <1137629220.31839.56.camel@whizzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1137545813.19858.45.camel@whizzy>
	 <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy>
	 <20060118194554.GA1502@elf.ucw.cz> <1137618370.31839.12.camel@whizzy>
	 <20060118222348.GG1580@elf.ucw.cz> <1137629220.31839.56.camel@whizzy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/06, Kristen Accardi <kristen.c.accardi@intel.com> wrote:
> On Wed, 2006-01-18 at 23:23 +0100, Pavel Machek wrote:
> <snip>
> > Device GDCK looks like dock to my untrained eye. Unfortunately its
> > type is IBM0079... ...
> >
> > Ahha, and ibm_acpi.c agrees with me.
> >
> > IBM_HANDLE(dock, root, "\\_SB.GDCK",    /* X30, X31, X40 */
> >
> >         Scope (\_SB)
> >         {
> >             Device (GDCK)
> >             {
> >                 Name (_HID, EisaId ("IBM0079"))
> >                 Name (_CID, 0x150CD041)
> >                 Method (_STA, 0, NotSerialized)
> >                 {
> > ...
> >                 Method (_DCK, 1, NotSerialized)
> >                 {
> >                     Store (0x00, Local0)
> >                     If (LEqual (GGID (), 0x03))
> >                     {
> >                         Store (\_SB.PCI0.LPC.EC.SDCK (Arg0), Local0)
> >                     }
> >
> >                     If (LEqual (GGID (), 0x00))
> >                     {
> >                         Store (\_SB.PCI0.PCI1.DOCK.DDCK (Arg0), Local0)
> >                     }
> >
> >                     Return (Local0)
> >                 }
> >
> >                 Method (_EJ0, 1, NotSerialized)
> >                 {
> >                     If (LEqual (GGID (), 0x03))
> >                     {
> >                         \_SB.PCI0.LPC.EC.SEJ0 (Arg0)
> >                     }
> >
> >                     If (LEqual (GGID (), 0x00))
> >                     {
> >                         \_SB.PCI0.PCI1.DOCK.DEJ0 (Arg0)
> >                     }
> >                 }
> > ....
> >
> > Hope this helps.
> >                                               Pavel
>
>
> so the problem that I see is that this dsdt defines two separate dock
> devices, one outside the scope of pci, and one within it.  The one
> outside the scope of pci defines the _EJ0 and _DCK methods.  So, when
> acpiphp loads, it scans the pci slots for ejectable slots, finds none
> (because _EJ0 is defined in the dock device that is outside the scope of
> pci) and exits.  This dsdt is different from the others I've used in
> that most of them define all methods related to docking under the actual
> dock bridge (within the scope of pci).  perhaps some acpi people can
> shed some light on the best way to handle this - otherwise I'm sure I
> can hack something up that will be less than acceptable :).
>

ACPI has (had?) a braindamage - it drops devices that do not present
when initially scanning ACPI namespace. So if you boot undocked - too
bad. Driver won't ever see your docking station.

--
Dmitry
