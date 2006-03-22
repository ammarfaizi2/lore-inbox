Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWCVOQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWCVOQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 09:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWCVOQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 09:16:42 -0500
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:53941 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751265AbWCVOQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 09:16:41 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Wed, 22 Mar 2006 15:28:44 +0800."
             <3ACA40606221794F80A5670F0AF15F840B418018@pdsmsx403> 
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Wed, 22 Mar 2006 09:16:11 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FM48B-00011o-Cs@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478a122c03f3aaf2a20c802fa83d02de0de3e9904060ab24592350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  How about this. The side effect of this change is that _BIF, _BST could
  NOT work. But I think it's just ok.


		      Method (I2RB, 3, NotSerialized)
		      {
			  Store (Arg0, HCSL)
			  Store (ShiftLeft (Arg1, 0x01), HMAD)
			  Store (Arg2, HMCM)
			  Store (0x0B, HMPR)
	    /*              Return (CHKS ())*/
		      }

It hangs in the usual way (2nd sleep).  The boot messages had two Fatal
opcodes, but that must be the _BIF and _BST that you mentioned:

  Execute Method: [\_TZ_.THM0._TMP] (Node e3f8bf88)
  ACPI: Fatal opcode executed
  Execute Method: [\_TZ_.THM0._PSV] (Node e3f8be48)
  Execute Method: [\_TZ_.THM0._TC1] (Node e3f8bdc8)
  Execute Method: [\_TZ_.THM0._TC2] (Node e3f8bd88)
  Execute Method: [\_TZ_.THM0._TSP] (Node e3f8bd48)
  Execute Method: [\_TZ_.THM0._AC0] (Node e3f8bf48)
  Execute Method: [\_TZ_.THM0._SCP] (Node e3f8bec8)
  Execute Method: [\_TZ_.THM0._TMP] (Node e3f8bf88)
  ACPI: Fatal opcode executed
  ACPI: Thermal Zone [THM0] (47 C)

With later modifications (e.g. commenting out one of the Store lines), I
could Return(0x00) instead of commenting out the line.  Let me know
which ones to try.  

One more thought.  We know that commenting out the UPDT call in _TMP
fixes the hang.  By bisecting the UPDT method, however, we change every
call to UPDT, including the one in THM0._TMP.  So we're making extra
changes beyond what is needed to fix the hang (and maybe producing
another hang?).

But let's continue this bisection since it's almost done.  If we
eventually find the offending statement, we can use the information in
order to find the smallest change that fixes the hang.  We make a copy
of the original UPDT method, call it UPDTCOPY, say; same for I2RB.  Then
THM0._TMP can call EC0.UPDTCOPY(), which calls I2RBCOPY.  And we modify
I2RBCOPY, but we leave I2RB and UPDT alone.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
