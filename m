Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUCFJSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 04:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUCFJSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 04:18:08 -0500
Received: from palrel13.hp.com ([156.153.255.238]:40324 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261501AbUCFJSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 04:18:01 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16457.38721.119739.816533@napali.hpl.hp.com>
Date: Sat, 6 Mar 2004 01:17:53 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <404959A5.6040809@pacbell.net>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
	<16457.12968.365287.561596@napali.hpl.hp.com>
	<404959A5.6040809@pacbell.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 05 Mar 2004 20:55:01 -0800, David Brownell <david-b@pacbell.net> said:

  >> Does this sound plausible?

  David.B> Parts of it.  There's definite recent nastiness.  Of the
  David.B> type that other eyes sometimes see better.

Here is patch #3.  It also Works For Me.  I was wondering whether it
it is really safe to mess with the OHCI control registers the way
ed_deschedule() does at a time the OHCI is running.  To test this
theory, I delayed the ed_deschedule() handling to finish_unlinks(), as
shown in the patch below.  I don't know whether this is really safe as
far as the host's lists are concerned, but it does avoid the crashes.

What's the argument as to why it's safe to update the OHCI control
registers in ed_deschedule() at the time start_ed_unlink() is running?

	--david

===== drivers/usb/host/ohci-q.c 1.48 vs edited =====
--- 1.48/drivers/usb/host/ohci-q.c	Tue Mar  2 05:52:46 2004
+++ edited/drivers/usb/host/ohci-q.c	Sat Mar  6 01:09:16 2004
@@ -274,7 +274,10 @@
  */
 static void ed_deschedule (struct ohci_hcd *ohci, struct ed *ed) 
 {
+#if 0
 	ed->hwINFO |= ED_SKIP;
+	wmb();
+#endif
 
 	switch (ed->type) {
 	case PIPE_CONTROL:
@@ -431,7 +434,12 @@
 {    
 	ed->hwINFO |= ED_DEQUEUE;
 	ed->state = ED_UNLINK;
+#if 0
 	ed_deschedule (ohci, ed);
+#else
+	ed->hwINFO |= ED_SKIP;
+	wmb();
+#endif
 
 	/* SF interrupt might get delayed; record the frame counter value that
 	 * indicates when the HC isn't looking at it, so concurrent unlinks
@@ -896,6 +904,11 @@
 				last = &ed->ed_next;
 				continue;
 			}
+
+#if 0
+#else
+			ed_deschedule (ohci, ed);
+#endif
 
 			if (!list_empty (&ed->td_list)) {
 				struct td	*td;

