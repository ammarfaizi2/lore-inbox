Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVABPlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVABPlA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 10:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVABPlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 10:41:00 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:46765 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261260AbVABPkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 10:40:52 -0500
Subject: Re: Flaw in ide_unregister()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <007e01c4ef30$f23ba3c0$0f01a8c0@max>
References: <007e01c4ef30$f23ba3c0$0f01a8c0@max>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104674725.14712.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 02 Jan 2005 14:36:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-31 at 12:04, Richard Purdie wrote:
> I've been having some problems with calls to ide_unregister() (in ide.c).
> 
> This function is declared void which should mean it always succeeds and yet 
> it can fail *silently* under the following condition:

Actually in 2.4.x and 2.6.x (except 2.6.9-ac and 2.6.10-ac) its
essentially unusable and full of races and should always be avoided.

> 3. Add a return value. What does ide-cs.c do with it though? The hardware is 
> gone. (doesn't help)

In 2.6.9-ac and 2.6.10-ac the ide_unregister_hwif calls return an error
if the drive is in use. At this point the ide-cs code still throws it
away. The -ac code IDE also adds "removed_hwif_iops" so the bits are
there for the correct result which is something like

	if(ide_unregister_hwif(hwif) < 0 {
		printk("Whine whine...");
		removed_hwif_ops(hwif);
		while(ide_unregister_hwif(hwif) < 0)
			msleep(1000);
	}

I've just not had time yet to propogate this into the drivers and into
the new PCI helper for hotplugging IDE controllers.

Alan

