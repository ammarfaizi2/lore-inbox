Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWCCEtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWCCEtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 23:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWCCEtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 23:49:16 -0500
Received: from fmr17.intel.com ([134.134.136.16]:30080 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751169AbWCCEtP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 23:49:15 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions 
Date: Fri, 3 Mar 2006 12:46:06 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B172CC2@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions 
Thread-Index: AcY+bqU7wd4t1hjuQhyeBzoNklGQiQADQt2A
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       <v4l-dvb-maintainer@linuxtv.org>, <video4linux-list@redhat.com>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       <linux-usb-devel@lists.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       "Duncan" <1i5t5.duncan@cox.net>, "Pavlik Vojtech" <vojtech@suse.cz>,
       <linux-input@atrey.karlin.mff.cuni.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 03 Mar 2006 04:46:07.0804 (UTC) FILETIME=[62EAFFC0:01C63E7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>>> Subject    : S3 sleep hangs the second time - 600X
>>> References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
>
>From: "Yu, Luming" <luming.yu@intel.com>
>> According to bug report, the BIOS DSDT is modified.  I don't know
>> how these changes affect the results of suspend/resume. But, it is
>> clear this is NOT right approach to fix problem. Hence, I need the
>> testing report with un-modified DSDT on TP 600X, bios 1.11.
>
>I'll try it, although I don't think I'll get any data on the problem.
>The unmodified DSDT (bios 1.11) lacks an S3 sleep object, so I had to
>modify the DSDT even to get S3 to sleep at all.  See
><http://bugzilla.kernel.org/show_bug.cgi?id=3534> for that discussion.
>In additional comment #4 there (2004-10-14), you said:
>
>  The root cause of [the missing S3 object] failure is that linux is
>  using element in
>
>  const char      *acpi_gbl_sleep_state_names[ACPI_S_STATE_COUNT] =
>  {
>	  "\_S0_",
>	  "\_S1_",
>	  "\_S2_",
>	  "\_S3_",
>	  "\_S4_",
>	  "\_S5_"
>  };
>
>  to call acpi_get_sleep_type_data, but your box define _S3 under the
>  device PNP0A03. So, the evaluating \_S3 will fail.
>
>  The workaround in DSDT is to change _S3 to \_S3_ .
>  We can fix it in acpi driver soon.

Hmm, this conclusion seems to be wrong. at that time, I said it too
early.  The real problem is this, if your box support S3, the _S3 method
should return from ELSE-statement which return package
{0x01,0x01,0x00,0x00}.

If you still use this
http://bugzilla.kernel.org/show_bug.cgi?id=3534#c10 to
override your DSDT, which bypass the testing and blindly assume BIOS or
platform
do support S3, then I suggest you to retest, and post dmesg with
UN-modified BIOS.

Thanks,
Luming


    Method (_S3, 0, NotSerialized)
    {
        If (BXPT)
        {
            Return (Package (0x04)
            {
                0x06,
                0x06,
                0x00,
                0x00
            })
        }
        Else
        {
            Return (Package (0x04)
            {
                0x01,
                0x01,
                0x00,
                0x00
            })
        }
    }
