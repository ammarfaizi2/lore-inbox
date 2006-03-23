Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965378AbWCWEqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965378AbWCWEqf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 23:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965372AbWCWEqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 23:46:34 -0500
Received: from mga03.intel.com ([143.182.124.21]:9909 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965365AbWCWEqd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 23:46:33 -0500
X-IronPort-AV: i="4.03,121,1141632000"; 
   d="scan'208"; a="14468837:sNHT348176640"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Thu, 23 Mar 2006 12:46:20 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B468F5D@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZNu01CKt/eqaMfSZydY2e6Uoi6NQAc7jBA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 23 Mar 2006 04:46:25.0111 (UTC) FILETIME=[BD7ED670:01C64E34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  How about this. The side effect of this change is that _BIF, 
>_BST could
>  NOT work. But I think it's just ok.
>
>
>		      Method (I2RB, 3, NotSerialized)
>		      {
>			  Store (Arg0, HCSL)
>			  Store (ShiftLeft (Arg1, 0x01), HMAD)
>			  Store (Arg2, HMCM)
>			  Store (0x0B, HMPR)
>	    /*              Return (CHKS ())*/
>		      }
>
>It hangs in the usual way (2nd sleep).  The boot messages had two Fatal
>opcodes, but that must be the _BIF and _BST that you mentioned:

Good, then the hang should be caused by:

			  Store (Arg0, HCSL)
			  Store (ShiftLeft (Arg1, 0x01), HMAD)
			  Store (Arg2, HMCM)
			  Store (0x0B, HMPR)

Could you add this at the beginning of this block:
	Store (Arg0,  Debug)
And add this at the end of this block:
	Store( HMPR, Debug)

Also change boot option: acpi_debug_layer=0x00100010,
acpi_debug_level=0x10
Let me verify if ec access is just ok.

>
>  Execute Method: [\_TZ_.THM0._TMP] (Node e3f8bf88)
>  ACPI: Fatal opcode executed
>  Execute Method: [\_TZ_.THM0._PSV] (Node e3f8be48)
>  Execute Method: [\_TZ_.THM0._TC1] (Node e3f8bdc8)
>  Execute Method: [\_TZ_.THM0._TC2] (Node e3f8bd88)
>  Execute Method: [\_TZ_.THM0._TSP] (Node e3f8bd48)
>  Execute Method: [\_TZ_.THM0._AC0] (Node e3f8bf48)
>  Execute Method: [\_TZ_.THM0._SCP] (Node e3f8bec8)
>  Execute Method: [\_TZ_.THM0._TMP] (Node e3f8bf88)
>  ACPI: Fatal opcode executed
>  ACPI: Thermal Zone [THM0] (47 C)
>
>With later modifications (e.g. commenting out one of the Store 
>lines), I
>could Return(0x00) instead of commenting out the line.  Let me know
>which ones to try.  

Probably yes.

>
>One more thought.  We know that commenting out the UPDT call in _TMP
>fixes the hang.  By bisecting the UPDT method, however, we change every
>call to UPDT, including the one in THM0._TMP.  So we're making extra
>changes beyond what is needed to fix the hang (and maybe producing
>another hang?).
>
>But let's continue this bisection since it's almost done.  If we
>eventually find the offending statement, we can use the information in
>order to find the smallest change that fixes the hang.  We make a copy
>of the original UPDT method, call it UPDTCOPY, say; same for 
>I2RB.  Then
>THM0._TMP can call EC0.UPDTCOPY(), which calls I2RBCOPY.  And we modify
>I2RBCOPY, but we leave I2RB and UPDT alone.
>
Yes, that's good idea to have separate i2rb copy for THM0 which we are
hacking.
