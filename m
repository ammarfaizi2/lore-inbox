Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVKGUoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVKGUoh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVKGUog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:44:36 -0500
Received: from fmr17.intel.com ([134.134.136.16]:51123 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932365AbVKGUof convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:44:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] ACPI and PRREMPT bug
Date: Mon, 7 Nov 2005 12:44:12 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E0356B628@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] ACPI and PRREMPT bug
thread-index: AcXjg0GaU/Dpay1hTuqB9AuCdXtwLgAWG4sAAAAQxrA=
From: "Moore, Robert" <robert.moore@intel.com>
To: "Moore, Robert" <robert.moore@intel.com>, <tzachar@cs.bgu.ac.il>,
       <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 07 Nov 2005 20:44:14.0371 (UTC) FILETIME=[03A9FF30:01C5E3DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might try setting this flag (in acglobal.h) to TRUE:

/*
 * Automatically serialize ALL control methods? Default is FALSE,
meaning
 * to use the Serialized/NotSerialized method flags on a per method
basis.
 * Only change this if the ASL code is poorly written and cannot handle
 * reentrancy even though methods are marked "NotSerialized".
 */
ACPI_EXTERN UINT8       ACPI_INIT_GLOBAL (AcpiGbl_AllMethodsSerialized,
FALSE);



> -----Original Message-----
> From: Moore, Robert
> Sent: Monday, November 07, 2005 12:42 PM
> To: 'tzachar@cs.bgu.ac.il'; linux-kernel@vger.kernel.org; acpi-
> devel@lists.sourceforge.net
> Subject: RE: [ACPI] ACPI and PRREMPT bug
> 
> I'm aware of this issue and it is under investigation.
> Bob
> 
> 
> > -----Original Message-----
> > From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
> > admin@lists.sourceforge.net] On Behalf Of Nir Tzachar
> > Sent: Monday, November 07, 2005 1:36 AM
> > To: linux-kernel@vger.kernel.org; acpi-devel@lists.sourceforge.net
> > Subject: [ACPI] ACPI and PRREMPT bug
> >
> > hello.
> >
> > I'm encountering a problem with acpi on kernels where preempt is
> > enabled.
> > The problem is 100% reproducible on all kernels starting from
2.6.12.1
> > to 2.6.14
> > ( i didn't try 2.6.11 and below ).
> >
> > the problem is manifested via the battery proc interface. to produce
it,
> > run in two terminals simultaneously:
> > while true; do cat /proc/acpi/battery/BAT0/info; done
> >
> > if i turn on kernel preemption (either voluntary or not), i get the
> > following error messages in dmesg:
> > Nov  7 08:31:00 lapnir ACPI-0292: *** Error: Looking up [SERN] in
> > namespace, AE_ALREADY_EXISTS
> > Nov  7 08:31:00 lapnir ACPI-0508: *** Error: Method execution failed
> > [\_SB_.PCI0.LPC_.EC__.GBIF] (Node c18f5d60), AE_ALREADY_EXISTS
> > Nov  7 08:31:02 lapnir ACPI-0213: *** Error: Method reached maximum
> > reentrancy limit (255)
> > Nov  7 08:31:02 lapnir ACPI-0508: *** Error: Method execution failed
> > [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f5c20),
AE_AML_METHOD_LIMIT
> >
> > and with acpi debugging info turned on:
> > Nov  7 08:46:08 lapnir dswload-0292: *** Error: Looking up [SERN] in
> > namespace, AE_ALREADY_EXISTS
> > Nov  7 08:46:08 lapnir psloop-0287 [4399] ps_parse_loop         :
During
> > name lookup/catalog, AE_ALREADY_EXISTS
> > Nov  7 08:46:08 lapnir psparse-0508: *** Error: Method execution
failed
> > [\_SB_.PCI0.LPC_.EC__.GBIF] (Node c18f94e8), AE_ALREADY_EXISTS
> > Nov  7 08:46:08 lapnir osl-0856 [4403] os_wait_semaphore     :
Failed to
> > acquire semaphore[c18de5e0|1|0], AE_TIME
> > Nov  7 08:46:08 lapnir dsmethod-0213: *** Error: Method reached
maximum
> > reentrancy limit (255)
> > Nov  7 08:46:08 lapnir psparse-0508: *** Error: Method execution
failed
> > [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f9268),
AE_AML_METHOD_LIMIT
> > Nov  7 08:46:08 lapnir acpi_battery-0144 [4449] battery_get_info
:
> > Error evaluating _BIF
> > Nov  7 08:46:08 lapnir dsmethod-0213: *** Error: Method reached
maximum
> > reentrancy limit (255)
> > Nov  7 08:46:08 lapnir psparse-0508: *** Error: Method execution
failed
> > [\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c18f9268),
AE_AML_METHOD_LIMIT
> >
> >
> > this is repeated until a reboot. loading and unloading the battery
> > module does not help.
> >
> > My computer is a thinkpad t43p, and i didn't try to reproduce it on
> > another laptop
> > (have no access to another model..).
> > If you need more info, let me know.
> >
> > p.s. please cc me, im not in the list.
> >
> > --
> > =========================================================
> > Nir Tzachar.
