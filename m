Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVIWXX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVIWXX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVIWXX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:23:57 -0400
Received: from fmr22.intel.com ([143.183.121.14]:33667 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751345AbVIWXX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:23:56 -0400
Date: Fri, 23 Sep 2005 16:22:45 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Horms <horms@debian.org>, Nikos Ntarmos <ntarmos@ceid.upatras.gr>,
       329354@bugs.debian.org, Frederik Schueler <fs@lowpingbastards.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       ak@suse.de
Subject: Re: [patch] x86_64: fix tss limit (was Re: CAN-2005-0204 and 2.4)
Message-ID: <20050923162245.C12631@unix-os.sc.intel.com>
References: <E1EI1tH-0006Yy-00@master.debian.org> <20050922023025.GA20981@verge.net.au> <20050922200446.GB9472@dmt.cnet> <20050923151738.B12631@unix-os.sc.intel.com> <9a87484905092315556e9fc0bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9a87484905092315556e9fc0bd@mail.gmail.com>; from jesper.juhl@gmail.com on Sat, Sep 24, 2005 at 12:55:41AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 12:55:41AM +0200, Jesper Juhl wrote:
> On 9/24/05, Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> >         set_tssldt_descriptor(&cpu_gdt_table[cpu][GDT_ENTRY_TSS], (unsigned long)addr,
> >                               DESC_TSS,
> > -                             sizeof(struct tss_struct) - 1);
> > +                             IO_BITMAP_OFFSET + IO_BITMAP_BYTES + 7);
> >  }
> >
> [snip]
> 
> Is it just me, or would it be nice with a symbolic name for this "7" ?
> For someone reading the code for the first time it seems to me that
> it's non-obvious why the 7 is there, and why it's 7 exactely - a
> define would make it clearer as I see it.

Andrew please apply this updated patch. Thanks.

--
Fix the x86_64 TSS limit in TSS descriptor.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.14-rc1/include/asm-x86_64/desc.h.orig	2005-09-12 20:12:09.000000000 -0700
+++ linux-2.6.14-rc1/include/asm-x86_64/desc.h	2005-09-23 15:41:28.103954880 -0700
@@ -127,9 +127,16 @@ static inline void set_tssldt_descriptor
 
 static inline void set_tss_desc(unsigned cpu, void *addr)
 { 
+	/*
+	 * sizeof(unsigned long) coming from an extra "long" at the end
+	 * of the iobitmap. See tss_struct definition in processor.h
+	 * 
+	 * -1? seg base+limit should be pointing to the address of the
+	 * last valid byte
+	 */
 	set_tssldt_descriptor(&cpu_gdt_table[cpu][GDT_ENTRY_TSS], (unsigned long)addr, 
 			      DESC_TSS,
-			      sizeof(struct tss_struct) - 1);
+			      IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1);
 } 
 
 static inline void set_ldt_desc(unsigned cpu, void *addr, int size)
