Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVCNF5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVCNF5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 00:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVCNF5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 00:57:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:6803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261771AbVCNF5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 00:57:37 -0500
Date: Sun, 13 Mar 2005 21:57:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg Stark <gsstark@MIT.EDU>
Cc: gsstark@MIT.EDU, s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org,
       pmcfarland@downeast.net
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
Message-Id: <20050313215710.5fa920d4.akpm@osdl.org>
In-Reply-To: <87zmx66b2b.fsf@stark.xeocode.com>
References: <87u0ng90mo.fsf@stark.xeocode.com>
	<200503130152.52342.pmcfarland@downeast.net>
	<874qff89ob.fsf@stark.xeocode.com>
	<200503140103.55354.s0348365@sms.ed.ac.uk>
	<87sm2y7uon.fsf@stark.xeocode.com>
	<20050313200753.20411bdb.akpm@osdl.org>
	<87br9m7s8h.fsf@stark.xeocode.com>
	<87zmx66b2b.fsf@stark.xeocode.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark <gsstark@MIT.EDU> wrote:
>
>  Greg Stark <gsstark@MIT.EDU> writes:
> 
>  > Andrew Morton <akpm@osdl.org> writes:
>  > 
>  > > Are you able to narrow it down to something more fine grained than "between
>  > > 2.6.6 and 2.6.9-rc1"?
>  > 
>  > Er, I suppose I would have to build some more kernels. Ugh. Is there a good
>  > place to start or do I have to just do a binary search?
> 
>  Oof. I just skimmed the Changelogs. It looks like the i810 OSS drivers got
>  quite a rototilling in 2.6.7 and 2.6.8. It also kind of sounds like they
>  needed it though.

The 2.6.6 i810_audio.c compiles OK in current kernels with the below patch
applied.  

--- 25/sound/oss/i810_audio.c~a	2005-03-13 21:54:00.000000000 -0800
+++ 25-akpm/sound/oss/i810_audio.c	2005-03-13 21:56:29.000000000 -0800
@@ -1758,7 +1758,8 @@ static int i810_mmap(struct file *file, 
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(dmabuf->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
@@ -3349,7 +3350,7 @@ static int i810_pm_suspend(struct pci_de
 			}
 		}
 	}
-	pci_save_state(dev,card->pm_save_state); /* XXX do we need this? */
+	pci_save_state(dev); /* XXX do we need this? */
 	pci_disable_device(dev); /* disable busmastering */
 	pci_set_power_state(dev,3); /* Zzz. */
 
@@ -3362,7 +3363,7 @@ static int i810_pm_resume(struct pci_dev
 	int num_ac97,i=0;
 	struct i810_card *card=pci_get_drvdata(dev);
 	pci_enable_device(dev);
-	pci_restore_state (dev,card->pm_save_state);
+	pci_restore_state (dev);
 
 	/* observation of a toshiba portege 3440ct suggests that the 
 	   hardware has to be more or less completely reinitialized from
_

