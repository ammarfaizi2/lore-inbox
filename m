Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932810AbWJINty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbWJINty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbWJINty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:49:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:36073 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932810AbWJINtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:49:52 -0400
Date: Mon, 9 Oct 2006 09:49:26 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 1/12] i386: Distinguish absolute symbols
Message-ID: <20061009134926.GA17572@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003170413.GA3164@in.ibm.com> <20061006233547.43888a48.akpm@osdl.org> <20061008164713.GA7149@in.ibm.com> <4529FBBE.9070206@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4529FBBE.9070206@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 09:35:26AM +0200, Gerd Hoffmann wrote:
> >> looks odd.  What's the point in putting a gap before __smp_alt_end?  Moving
> >> __smp_alt_end to before the ALIGN doesn't prevent the warning.
> >>
> 
> > Please find attached a patch for the same. I am also copying Gerd Hoffmann,
> > who introduced this ALIGN. Gerd, can you please confirm that above ALIGN()
> > is not required and the patch attached should be fine.
> 
> The data between __smp_alt_start and __smp_alt_end will be released at
> boot time in some cases (UP machine, kernel without CPU_HOTPLUG, ...).
> 
> Releasing memory works at page granularity only, thats why I added the
> alignment.  I think you can't simply drop it.
> 
> > o There seems to be one extra ALIGN(4096) before symbol __smp_alt_end. The
> >   only usage of __smp_alt_end is to mark the end of smp alternative
> >   sections so that this memory can be freed. As a physical page is freed
> >   one has to just make sure that there is no other data on the same page
> >   where __smp_alt_end is pointing. There is already a ALIGN(4096) after
> >   this section which should take care of the above issue. Hence it looks
> >   like the ALIGN(4096) before __smp_alt_end is redundant and not required.
> 
> Hmm, ok, it should work then.  How about adding a comment to make sure
> the align after __smp_alt_end doesn't get dropped by accident?
> 

Thanks Gerd. I have put a comment to make things more clear. Please find
attahched the attached regenerated patch.



o There seems to be one extra ALIGN(4096) before symbol __smp_alt_end. The
  only usage of __smp_alt_end is to mark the end of smp alternative
  sections so that this memory can be freed. As a physical page is freed
  one has to just make sure that there is no other data on the same page
  where __smp_alt_end is pointing. There is already a ALIGN(4096) after
  this section which should take care of the above issue. Hence it looks
  like the ALIGN(4096) before __smp_alt_end is redundant and not required.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.19-rc1-vivek/arch/i386/kernel/vmlinux.lds.S |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/vmlinux.lds.S~i386-remove-unnecessary-align-option arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.19-rc1/arch/i386/kernel/vmlinux.lds.S~i386-remove-unnecessary-align-option	2006-10-09 09:39:00.000000000 -0400
+++ linux-2.6.19-rc1-vivek/arch/i386/kernel/vmlinux.lds.S	2006-10-09 09:43:22.000000000 -0400
@@ -112,11 +112,15 @@ SECTIONS
   }
   .smp_altinstr_replacement : AT(ADDR(.smp_altinstr_replacement) - LOAD_OFFSET) {
 	*(.smp_altinstr_replacement)
-	. = ALIGN(4096);
 	__smp_alt_end = .;
   }
 
-  /* will be freed after init */
+  /* will be freed after init
+   * Following ALIGN() is required to make sure no other data falls on the
+   * same page where __smp_alt_end is pointing as that page might be freed
+   * after boot. Always make sure that ALIGN() directive is present after
+   * the section which contains __smp_alt_end.
+   */
   . = ALIGN(4096);		/* Init code and data */
   .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
   	__init_begin = .;
_
