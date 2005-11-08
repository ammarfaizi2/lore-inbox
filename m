Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965384AbVKHHWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965384AbVKHHWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965386AbVKHHWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:22:41 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:49630 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965384AbVKHHWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:22:41 -0500
Date: Tue, 8 Nov 2005 08:22:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 7/21] i386 Losing fs gs to bios
Message-ID: <20051108072243.GC28201@elte.hu>
References: <200511080425.jA84PrSo009878@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511080425.jA84PrSo009878@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> I discovered an even more subtle problem; the PnP BIOS code is saving 
> the %fs and %gs segments in inline assembler, yet it also uses the 
> same hack for patching in a fake real mode selector for the BIOS data 
> area. Note that the protected mode selector 0x40 overlaps the user TLS 
> area in the GDT; this means that badly timed PnP BIOS calls could come 
> in, save %fs, come back, and restore %fs -- to point to the fake real 
> mode selector in the GDT.  This selector will remain cached despite 
> the GDT update until the next task context switch, and could very well 
> be responsible for causing random crashes and corruption in user space 
> programs which make use of it (notably, Wine).
> 
> Rather than leave a half effort, I wrote an encapsulation function 
> that saves and restores GDT state properly before attempting to call a 
> potentially buggy BIOS.  Note that saving and restoring %fs and %gs 
> must be done after restoring the fake real mode GDT entry (0x40 >> 3), 
> since they could possibly be referencing that segment.  Also note that 
> %cs, %ss, %ds, and %es need not be messed with, since in kernel mode, 
> they never can point to a user TLS segment.

as per my previous comment, wouldnt this patch mostly go away if we 
dedicated entry #8 to the 0x40 BIOS hack?

	Ingo
