Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbUCPQLZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbUCPQJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:09:58 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:51406 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263134AbUCPQF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:05:57 -0500
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       jgarzik@pobox.com
Subject: Re: [3C509] Fix sysfs leak.
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <200403152147.i2FLl09s002942@delerium.codemonkey.org.uk>
	<wrpad2hf4be.fsf@panther.wild-wind.fr.eu.org>
	<20040316134613.GA15600@redhat.com>
	<wrp3c88g9xu.fsf@panther.wild-wind.fr.eu.org>
	<20040316142951.GA17958@redhat.com>
	<wrpwu5kessd.fsf@panther.wild-wind.fr.eu.org>
	<20040316153018.GB17958@redhat.com>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Tue, 16 Mar 2004 17:05:45 +0100
Message-ID: <wrpr7vseq06.fsf@panther.wild-wind.fr.eu.org>
In-Reply-To: <20040316153018.GB17958@redhat.com> (Dave Jones's message of
 "Tue, 16 Mar 2004 15:30:19 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == Dave Jones <davej@redhat.com> writes:

Dave> no it doesn't, which is the whole purpose of the patch I sent.
Dave> try it..

Dave> modprobe 3c509
Dave> lsmod | grep 3c509     # module didnt stay around
Dave> find /sys | grep 3c509 # oh look, it left crap in sysfs

Real problem, wrong fix. You just killed 3c509 EISA support
altogether. Could you please test the following patch (against latest
bk) :

===== drivers/net/3c509.c 1.49 vs edited =====
--- 1.49/drivers/net/3c509.c	Mon Mar 15 22:24:30 2004
+++ edited/drivers/net/3c509.c	Tue Mar 16 16:44:24 2004
@@ -1655,14 +1655,14 @@
 	}
 
 #ifdef CONFIG_EISA
-	if (eisa_driver_register (&el3_eisa_driver) <= 0) {
+	if (eisa_driver_register (&el3_eisa_driver) < 0) {
 		eisa_driver_unregister (&el3_eisa_driver);
 	}
 #endif
 #ifdef CONFIG_MCA
 	mca_register_driver(&el3_mca_driver);
 #endif
-	return el3_cards ? 0 : -ENODEV;
+	return 0;
 }
 
 static void __exit el3_cleanup_module(void)

This is not pretty either, but 3c579 probing will work, and in your
case it won't leave a dangling directory in sysfs.

Dave> Why is this even an issue so late on? Bus probing should have
Dave> been done as part of bootup. By the time I get to modprobing
Dave> device drivers, it should have been determined already.

Modprobing is perfectly OK, and indeed everything has been probed at
this stage. But having built-in drivers raises a few different
problems (the driver may be initialized before all busses are probed).

Dave> Your argument seems to be "probing is hard, so we don't do it",
Dave> which is just *wrong*.

If you want to get back to the 2.4 state, where every single EISA
driver reinvents EISA probing, fair enough. I think 2.6 has it mostly
right (at least, it respects the bus hierarchy, which is necessary to
set futile things like dma_mask correctly). Drivers may be broken
(does hp100 rings a bell ?), but the framework looks sane to me.

Again, if you have something better to offer, I'm all ears.

Regards,

	M.
-- 
Places change, faces change. Life is so very strange.
