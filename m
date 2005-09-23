Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbVIWWS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVIWWS7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 18:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVIWWS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 18:18:59 -0400
Received: from fmr24.intel.com ([143.183.121.16]:42913 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751322AbVIWWS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 18:18:58 -0400
Date: Fri, 23 Sep 2005 15:17:39 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Horms <horms@debian.org>, suresh.b.siddha@intel.com,
       Nikos Ntarmos <ntarmos@ceid.upatras.gr>, 329354@bugs.debian.org,
       Frederik Schueler <fs@lowpingbastards.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       ak@suse.de
Subject: [patch] x86_64: fix tss limit (was Re: CAN-2005-0204 and 2.4)
Message-ID: <20050923151738.B12631@unix-os.sc.intel.com>
References: <E1EI1tH-0006Yy-00@master.debian.org> <20050922023025.GA20981@verge.net.au> <20050922200446.GB9472@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050922200446.GB9472@dmt.cnet>; from marcelo.tosatti@cyclades.com on Thu, Sep 22, 2005 at 05:04:46PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 05:04:46PM -0300, Marcelo Tosatti wrote:
> 
> On Thu, Sep 22, 2005 at 11:30:25AM +0900, Horms wrote:
> > On Wed, Sep 21, 2005 at 01:31:37PM +0300, Nikos Ntarmos wrote:
> > > Package: kernel-source-2.4.27
> > > Version: 2.4.27-11.hls.2005082200
> > > Severity: important
> > > Justification: fails to build from source
> > > 
> > > Patch 143_outs.diff.bz2 breaks the kernel compilation on x86_64. The
> > > problem is that it uses the IO_BITMAP_BYTES macro which is defined for
> > > i386 (in linux/include/asm-i386/processor.h) but not for x86_64.
> > > Reverting the patch lets the kernel build again, although I guess the
> > > correct solution would be to add an appropriate IO_BITMAP_BYTES to
> > > linux/include/asm-x86_64/processor.h as well.
> > 
> > Hi Nikos,
> > 
> > First up, thanks for testing out my prebuild kernels.  For the
> > uninitiated they are snapshots of what is in the deabian kernel-team's
> > SVN and live in http://packages.vergenet.net/testing/
> > 
> > The problem that you see is a patch that was included in
> > 2.4.27-11 (the current version in sid), though it isn't built
> > for amd64.
> > 
> > Could you see if the following patch works for you.  I've CCed lkml and
> > Marcelo for their consideration.  It seems to me that 2.4 is indeed
> > vulnerable to CAN-2005-0204, perhaps someone can shed some light on
> > this.
> > 
> > -- 
> > Horms
> > 
> > Description: [CAN-2005-0204]: AMD64, allows local users to write to privileged IO ports via OUTS instruction
> > Patch author: Suresh Siddha (suresh.b.siddha@intel.com)
> > Upstream status: not applied
> > URL: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=146244
> > Patch source: Micah Anderson <micah@riseup.net> (debian-kernel)
> > 
> > Added definition of IO_BITMAP_BYTES for Debian's 2.4.27 and
> > submitted upstream for consideration for inclusion in 2.4 -- Horms
> 
> And v2.6 does not seem to have been updated either, or a different form of 
> the fix has been deployed? 
> 
> 130 static inline void set_tss_desc(unsigned cpu, void *addr)
> 131 {
> 132 	set_tssldt_descriptor(&cpu_gdt_table[cpu][GDT_ENTRY_TSS], (unsigned long)addr,
> 133 	DESC_TSS,
> 134 	sizeof(struct tss_struct) - 1);
> 135 } 

Marcelo, This particular vulnerability is not present in 2.6 base. As I
mentioned in that bugzilla, 2.6 base increased IO_BITMAP_BITS  to 65536
and the kernel initializes this bitmap pointer during boot appropriately.

But in general the specified limit is wrong and needs to be fixed.

Appended patch will fix the tss limit. Andrew, please apply. Thanks.
--

Fix the x86_64 TSS limit in TSS descriptor.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.14-rc1/include/asm-x86_64/desc.h.orig	2005-09-12 20:12:09.000000000 -0700
+++ linux-2.6.14-rc1/include/asm-x86_64/desc.h	2005-09-23 12:50:58.210135128 -0700
@@ -129,7 +129,7 @@ static inline void set_tss_desc(unsigned
 { 
 	set_tssldt_descriptor(&cpu_gdt_table[cpu][GDT_ENTRY_TSS], (unsigned long)addr, 
 			      DESC_TSS,
-			      sizeof(struct tss_struct) - 1);
+			      IO_BITMAP_OFFSET + IO_BITMAP_BYTES + 7);
 } 
 
 static inline void set_ldt_desc(unsigned cpu, void *addr, int size)
