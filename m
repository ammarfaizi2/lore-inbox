Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUHSHwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUHSHwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUHSHwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:52:20 -0400
Received: from fmr06.intel.com ([134.134.136.7]:55996 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263735AbUHSHuu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:50:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.8.1-mm1 and Asus L3C : problematic change found, can be reverted. Real fix still missing
Date: Thu, 19 Aug 2004 15:50:13 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F039A1877@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.8.1-mm1 and Asus L3C : problematic change found, can be reverted. Real fix still missing
Thread-Index: AcSFvIrYEaGLpgoDSGG9okmv37HDWgAA2nnQ
From: "Li, Shaohua" <shaohua.li@intel.com>
To: <eric.valette@free.fr>
Cc: "Karol Kozimor" <sziwan@hell.org.pl>, "Brown, Len" <len.brown@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>,
       <linux@brodo.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Aug 2004 07:50:14.0621 (UTC) FILETIME=[2997C0D0:01C485C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,
The patch for bug 3049 has been in 2.6.8.1 and should fix the IO port
problem. If the Asus quirk is just because of IO port problem, I'd like
to remove it. Note PNP driver also reserves the IO port for the SMBus
and lets SMBus driver to use it. ACPI motherboard driver behaves the
same as PNP driver.

Thanks,
Shaohua
>-----Original Message-----
>From: Eric Valette [mailto:eric.valette@free.fr]
>Sent: Thursday, August 19, 2004 3:17 PM
>To: Karol Kozimor
>Cc: Brown, Len; Wang, Zhenyu Z; Andrew Morton; Greg KH; linux@brodo.de;
>linux-kernel@vger.kernel.org; Li, Shaohua
>Subject: Re: 2.6.8.1-mm1 and Asus L3C : problematic change found, can
be
>reverted. Real fix still missing
>
>Karol Kozimor wrote:
>> Okay, so I think I've finally got what's happening here.
>> Enabling the SMBus device (00:1f.3) seems to mess up the resource
>> reservation code, specifically the 0xe800 port region. Here's the
diff
>> between 2.6.8.1-mm1 acpi=off and the same kernel with no arguments:
>
>Hi Karol,
>
>This is the same problem on every asus motherboard including very old
>ones like my A7V : the ACPI pre-allocates the ioport region for the SMB
>bus because the DTSD contain indication to do so and special care
should
>be used in order to reuse the IO port range already owned by ACPI
>(motherboard).
>
>See :
><http://lkml.org/lkml/2004/8/3/160>
>
>And especially the end of /proc/oprots current one (before ACPI fix, I
>was forced to avoid/not fail ioport reservation for SMB in
i2c-viapro.c)
>
>e800-e80f : 0000:00:04.4	<===============
>    e800-e80f : motherboard
>
>But with the shaohua li proposed fix for
><http://bugme.osdl.org/show_bug.cgi?id=3049>, i2c-viapro.c becomes
owner
>of part of this ioport range:
>
>e800-e80f : 0000:00:04.4
>   e800-e80f : motherboard
>     e800-e807 : viapro-smbus    <========
>
>So in other words, it is possible either to force reallocation of an
>ioport range already owned by ACPI now (at least in some configuration)
>or to avoid this io port allocation has it is already mapped like my
>proposed kludge to make A7V work...
>
>However :
>	1) I have no clue however of the correct way to do this,
>	2) I do not know if the fix for
><http://bugme.osdl.org/show_bug.cgi?id=3049> is also valid for this
ASUS
>motherboard/laptop,
>	3) I still would like to know what you want to do with the SMB
bus...
>
>-- eric
>
>
>

