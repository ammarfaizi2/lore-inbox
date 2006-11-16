Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162113AbWKPAaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162113AbWKPAaJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162115AbWKPAaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:30:08 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:22409 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1162113AbWKPAaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:30:06 -0500
Date: Wed, 15 Nov 2006 19:28:36 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, rjw@sisk.pl, pavel@suse.cz, ebiederm@xmission.com,
       hpa@zytor.com, Reloc Kernel List <fastboot@lists.osdl.org>,
       magnus.damm@gmail.com, ak@suse.de, Don Zickus <dzickus@redhat.com>,
       Linda Wang <lwang@redhat.com>
Subject: Re: [Fastboot] [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061116002836.GG9039@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <20061115212411.GF9039@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115212411.GF9039@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 04:24:11PM -0500, Vivek Goyal wrote:
> On Mon, Nov 13, 2006 at 11:43:14AM -0500, Vivek Goyal wrote:
> > 
> > 
> > - Killed lots of dead code
> > - Improve the cpu sanity checks to verify long mode
> >   is enabled when we wake up.
> > - Removed the need for modifying any existing kernel page table.
> > - Moved wakeup_level4_pgt into the wakeup routine so we can
> >   run the kernel above 4G.
> > - Increased the size of the wakeup routine to 8K.
> > - Renamed the variables to use the 64bit register names.
> > - Lots of misc cleanups to match trampoline.S
> > 
> > I don't have a configuration I can test this but it compiles cleanly
> > and it should work, the code is very similar to the SMP trampoline,
> > which I have tested.  At least now the comments about still running in
> > low memory are actually correct.
> > 
> > Vivek has tested this patch for suspend to memory and it works fine.
> > 
> 
> More update. Got hold of another machine and suspend/resume seems to be
> facing problems.
> 
> With 2.6.19-rc5-git2
> --------------------
> - echo 3 > /proc/acpi/sleep (Suspend to memory takes place)
> - Press power button (System tries to come back but fails in MPT adapter
> 			initialization)
> 
> With 2.6.19-rc5-git2 + Reloc patches
> ------------------------------------
> - echo 3 > /proc/acpi/sleep (Suspend to memory takes place)
> - Press power button (Fan powers on but nothing additional is displayed on
> 			serial console.)
> 
> Will do a bisect and try to isolate the problem.
> 

Ok. In the new code NX bit protection feature is not being enabled and that
seems to be causing the problem. I checked and enabled the NX bit feature
in EFER in wakeup.S and it starts working.

I think my new machine supports NX bit protection feature and if while
resuming if I don't enable that feature back probably it must have caused
a GPF while loading the page tables which have got NX bit set. (A guess).

I know that previous machine I was testing on does not support NX bit
feature and that could be the reason that previous machine did not run into
the problems.

Thanks
Vivek
