Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUGGBZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUGGBZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 21:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUGGBZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 21:25:41 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:44729 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S264795AbUGGBZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 21:25:37 -0400
Message-ID: <40EB510F.2040801@metaparadigm.com>
Date: Wed, 07 Jul 2004 09:25:35 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040704 Debian/1.7-4
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       David Gibson <hermes@gibson.dropbear.id.au>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current
 CVS
References: <20040702222655.GA10333@bougret.hpl.hp.com> <20040703010709.A22334@electric-eye.fr.zoreil.com> <20040704021304.GD25992@zax> <20040704191732.A20676@electric-eye.fr.zoreil.com> <20040706011401.A390@electric-eye.fr.zoreil.com> <40E9E6BC.8020608@pobox.com> <20040707005402.A15251@electric-eye.fr.zoreil.com>
In-Reply-To: <20040707005402.A15251@electric-eye.fr.zoreil.com>
Content-Type: multipart/mixed;
 boundary="------------030909060204080007060706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030909060204080007060706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Just like to chime in as a tester. I've been running the orinoco CVS
for around 6 weeks now. Has been very stable although I needed the
attached patch to make suspend/resume work (thinkpad with APM).

I posted a bug on orinoco savannah but haven't seen any changes in CVS.

BTW - what is the *correct* ordering of pci_(save|restore)_state,
pci_set_power_state?

The new scanning functionality is great. Thanks guys for the good work.

~mc

On 07/07/04 06:54, Francois Romieu wrote:
> Jeff Garzik <jgarzik@pobox.com> :
> 
>>Francois Romieu wrote:
>>
>>>The news:
>>>- I got the adequate patch from the cvs repository
>>>- 35 patches are available at the usual location. The series-mm file
>>>  describes the ordering of the patches. I'll redo the numbering as
>>>  it starts to be scary
>>>- the remaining diff weights ~210k so far
>>>
>>>At least it makes reviewing easier.
>>
>>
>>If you are willing to do some re-diffing, feel free to send out the 
>>boring, and easy-to-review parts such as netdev_priv() or obvious 
>>cleanups.  That would help, at least, to cut things to more meat, and 
>>less noise.
> 
> 
> Actually it does not induce a noticeable noise. The remaining patch is
> down to 162 ko. 50 ko have disappeared while partially moving code on
> the target sources (I'll keep this part separated from the "normal"
> patches).
> 
> The renumbered patches + one or two new ones are available at
> http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm6

--------------030909060204080007060706
Content-Type: text/x-patch;
 name="orinoco-fix-powerstate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="orinoco-fix-powerstate.patch"

--- orinoco_pci.c.orig	2004-06-21 20:35:22.000000000 +0800
+++ orinoco_pci.c	2004-06-22 12:32:24.000000000 +0800
@@ -327,8 +327,8 @@
 	
 	orinoco_unlock(priv, &flags);
 
-	pci_set_power_state(pdev, 3);
 	pci_save_state(pdev, card->pci_state);
+	pci_set_power_state(pdev, 3);
 
 	return 0;
 }
@@ -343,8 +343,8 @@
 
 	printk(KERN_DEBUG "%s: Orinoco-PCI waking up\n", dev->name);
 
-	pci_restore_state(pdev, card->pci_state);
 	pci_set_power_state(pdev, 0);
+	pci_restore_state(pdev, card->pci_state);
 
 	err = orinoco_reinit_firmware(dev);
 	if (err) {

--------------030909060204080007060706--
