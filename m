Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbUKJBBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbUKJBBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUKJBB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:01:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:24771 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261816AbUKJBBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:01:14 -0500
Date: Tue, 9 Nov 2004 17:01:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Kujau <evil@g-house.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matt Domsch <Matt_Domsch@dell.com>, Pekka Enberg <penberg@gmail.com>,
       Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
In-Reply-To: <41915EF9.6060604@g-house.de>
Message-ID: <Pine.LNX.4.58.0411091646290.2301@ppc970.osdl.org>
References: <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>
 <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de>
 <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com>
 <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de>
 <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <4191530D.8020406@g-house.de>
 <20041109234053.GA4546@lists.us.dell.com> <41915EF9.6060604@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Nov 2004, Christian Kujau wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Matt Domsch schrieb:
> > 
> > -BIOS EDD facility v0.16 2004-Jun-25, 16 devices found
> > +BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
> > 
> > So with the latest EDD patch noted above, it's finding more disks than
> > before.  How many disks do you actually have in the system?
> 
> i have one scsi disk (sda) and two atapi cdrom drives:

Interestingly, "16" is also EDD_MBR_SIG_MAX, so my suspicion is that it 
overflowed some EDD data area. edd_num_devices() (which is what reports 
the above number) does

	min_t(unsigned char,
		max_t(unsigned char, edd.edd_info_nr, edd.mbr_signature_nr),
		max_t(unsigned char, EDD_MBR_SIG_MAX, EDDMAXNR));

where EDDMAXNR is 6, and EDD_MBR_SIG_MAX is the afore-mentioned 16, so we 
know that either edd.edd_info_nr or edd.mbr_signature_nr is actually 
_bigger_ than 16.

Which is clearly totally bogus. In fact, even your old "6 devices found" 
thing looks suspiciously bogus.

> PS: do you have *any* idea how this could be related to the snd-es1371
> driver (which is producing the oops then)?

I bet it's overwriting some array, and just corrupting memory after it. 
For example, the edd_info[] array only has 6 entries, and for example, the 
EDD_MBR_SIG_BUFFER is quite close to where we save the E820MAP memory map 
at bootup, so if something stomps on that, the kernel might be confused 
about where PCI memory can be allocated or similar. Or it might have 
overwritten some ACPI memory data, who knows.

			Linus
