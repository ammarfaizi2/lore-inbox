Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTLLRVU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 12:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTLLRVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 12:21:20 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:5052 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261613AbTLLRVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 12:21:18 -0500
Date: Fri, 12 Dec 2003 18:21:16 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <Pine.LNX.4.53.0312121152240.730@chaos>
Message-ID: <Pine.LNX.4.55.0312121805160.21008@jurand.ds.pg.gda.pl>
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>
 <brcoob$a02$1@gatekeeper.tmr.com> <Pine.LNX.4.55.0312121717510.21008@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.53.0312121152240.730@chaos>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, Richard B. Johnson wrote:

> >  Sometimes the NMI watchdog works in principle, but its activation leads
> > to system instability -- almost always this is a symptom of buggy SMM code
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > executed by the BIOS behind our back (NMIs are disabled by default in the
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > SMM, but careless code may enable them by accident).
> 
> The NMI vector goes to Linux code. In fact all interrupt vectors
> go to Linux code. There is no way that some BIOS code could possibly
> be accidentally executed here. Some Linux code would have to
> call some 16-bit BIOS code somewhere, and it doesn't even know
> where..........

 The problem happens when the SMM is active (i.e. the BIOS code is being
executed) after an SMI has been received during Linux operation (SMIs may
get triggered due to various reasons -- a parity/ECC error caught by the
chipset, an access to an emulated 8042 controller, a power failure in a
notebook, etc.) and an NMI arrives.  When in the SMM, no interrupt
(including the NMI) causes a switch back into the protected mode (and the
processor expects real-mode style interrupt vectors), so the Linux's NMI
handler is never reached and the SMM's NMI handler (if at all initialized)  
isn't appropriate for handling the NMI watchdog.  Since the SMM cannot
know what NMIs are used for in a particular OS, the code should best keep
NMIs disabled -- then an arriving NMI event is latched and postponed until
after the RSM instruction is executed.

 The SMM was invented to be transparent to a running OS, but care has to
be taken for this to be true and firmware bugs sometimes make the SMM
activity visible.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
