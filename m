Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTJ0DQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 22:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263753AbTJ0DQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 22:16:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:19170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263752AbTJ0DQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 22:16:15 -0500
Date: Sun, 26 Oct 2003 19:16:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: "P. Christeas" <p_christ@hol.gr>
Cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: Linux 2.6.0-test9
Message-Id: <20031026191641.497132ec.akpm@osdl.org>
In-Reply-To: <200310262051.32801.p_christ@hol.gr>
References: <200310262051.32801.p_christ@hol.gr>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"P. Christeas" <p_christ@hol.gr> wrote:
>
> One more, (as reported a few weeks ago):
> rmmod aic7xxx 
> will fail, as this module uses some wrong locks. This will also block sleeping 
> (tested w. ACPI) if the module is there.
> IMHO this module is crucial to many systems.

The rmmod works OK for me, in the sense that the module is removed, the
kernel doesn't crash and the module can be reloaded.

But yes, there are several locking problems in there:

- ahc_free() now sleeps, deep down in the kobject layer somewhere (it
  calls /sbin/hotplug).

  This is a likely fix for that:

--- 25/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c~aic7xxx-sleep-in-spinlock-fix	2003-10-26 18:51:45.000000000 -0800
+++ 25-akpm/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2003-10-26 18:52:11.000000000 -0800
@@ -100,9 +100,10 @@ ahc_linux_pci_dev_remove(struct pci_dev 
 		ahc_lock(ahc, &s);
 		ahc_intr_enable(ahc, FALSE);
 		ahc_unlock(ahc, &s);
-		ahc_free(ahc);
 	}
 	ahc_list_unlock(&l);
+	if (ahc)
+		ahc_free(ahc);
 }
 #endif /* !LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0) */
 


- ahc_linux_kill_dv_thread() is called under ahc_list_lock(), but it sleeps.



> I'm just repeating this issue, as I cannot see any patch for that. Justin has 
> not replied (I will need to be CC'ed). Andrew, who's the maintainer?

Justin is.

> I wish I 
> could help myself solve that, but fixing SMP-safe locks seems the hardest 
> thing I could do here. Somebody has to help here.


Well we can live with the CONFIG_DEBUG_SPINLOCK_SLEEP warnings I guess. 
But you don't actually say what goes wrong when you run rmmod.  Does the
kernel oops?  Lock up?  What?

