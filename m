Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVCVA4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVCVA4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVCVAyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:54:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33956 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262254AbVCVAx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:53:26 -0500
Date: Tue, 22 Mar 2005 01:53:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-ID: <20050322005313.GA1408@elf.ucw.cz>
References: <20050321025159.1cabd62e.akpm@osdl.org> <200503212343.31665.rjw@sisk.pl> <20050321160306.2f7221ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321160306.2f7221ec.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/
> > 
> > I get the following BUG every time I try to suspend my box to disk.
> 
> Pavel, that's the BUG() in pci_choose_state().  I did have some
> reject-fixing to do on that wrt a change in Greg's tree, so maybe there was
> some incompatible intent in there.
> 
> I dunno why pci_choose_state() is saying that it received PCI_D1, when
> prepare_devices() is passing down PMSG_FREEZE?

This works it around:

--- clean-mm/drivers/pci/pci.c	2005-03-21 11:39:32.000000000 +0100
+++ linux-mm/drivers/pci/pci.c	2005-03-22 01:41:48.000000000 +0100
@@ -376,11 +376,13 @@
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
+#if 0
 	if (platform_pci_choose_state) {
 		ret = platform_pci_choose_state(dev, state);
 		if (ret >= 0)
 			state = ret;
 	}
+#endif
 	switch (state) {
 	case 0: return PCI_D0;
 	case 3: return PCI_D3hot;

platform_pci_choose_state is very wrong, and it would be nice to just
revert the patch that introduced it. pm_message_t is going to became a
structure, and I don't want to have another place to fixup.

Hmm, it looks like I should do switch to the structure *now* so that
pm_message_t becomes incompatible with int and people can't get it
wrong...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
