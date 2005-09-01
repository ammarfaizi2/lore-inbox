Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVIAPkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVIAPkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVIAPkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:40:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:54990 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030209AbVIAPkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:40:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH,RFC] Move Cell platform code to arch/powerpc
Date: Thu, 1 Sep 2005 17:40:50 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, "Paul Mackerras" <paulus@samba.org>,
       "Stephen Rothwell" <sfr@canb.auug.org.au>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <200509010247.07399.arnd@arndb.de> <8E11258A-70AD-4285-962E-797F7A3D55E3@freescale.com>
In-Reply-To: <8E11258A-70AD-4285-962E-797F7A3D55E3@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509011740.51484.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dunnersdag 01 September 2005 16:11, Kumar Gala wrote:

> I'm not 100% sure if this is the right time for introducing a  
> platform into arch/powerpc.  My concern is around that fact that we  
> have not tried to move any "code" from arch/ppc or arch/ppc64 into  
> arch/powerpc and so havent figured out how we are going to do that  
> will not breaking arch/ppc & arch/ppc64.  By introducing cell this
> way we create a dependency between ppc64 and powerpc that might
> constrain decisions we want to make.

I understand that there are good reasons for merging all the headers
first and only then start with the architecture code, that also
was my idea at first.

At least from the Kbuild side, it should not cause trouble
to refer to different architecture directories from
arch/ppc64/kernel/Makefile, that does not introduce any strong
dependency.

For the code itself, we probably need to make substantial changes
at some point, e.g. when we merge arch/powerpc/kernel/setup.c.
However, I don't think it makes much difference wether that
is done while the code resides in arch/ppc64 or arch/powerpc.

> > Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>
> >
> > --
> >  arch/powerpc/platforms/cell/Makefile     |    1
> >  arch/ppc64/kernel/Makefile               |    5
> >  arch/powerpc/platforms/cell/pic.c        |  269 ++++++++++++++++++++++
> >  arch/ppc64/kernel/bpa_iic.c              |  270 ----------------------
> >  include/asm-powerpc/cell-pic.h           |   62 +++++
> >  arch/ppc64/kernel/bpa_iic.h              |   62 -----
> >  arch/powerpc/platforms/cell/iommu.c      |  377 +++++++++++++++++++++++++++++++
> >  arch/ppc64/kernel/bpa_iommu.c            |  377 -------------------------------
> >  arch/powerpc/platforms/cell/iommu.h      |   65 +++++
> >  arch/ppc64/kernel/bpa_iommu.h            |   65 -----
> >  arch/powerpc/platforms/cell/nvram.c      |  118 +++++++++
> >  arch/ppc64/kernel/bpa_nvram.c            |  118 ---------
> 
> Should pic, iommu, and nvram really be in arch/powerpc/sysdev/

The pic and iommu are defined in the CBE Architecture documents
and different from all others, so I would prefer to keep them
here. Both the internal interrupt controller (IIC) and the
IO page tables are part of the CPU itself, so you will always
see them together with Cell based hardware.

For nvram, you are probably right that it belongs to a more
generic place, as I just wrote in my reply to Murali.

With regard to the arch/powerpc/sysdev/ location for putting
the drivers, I'm not sure if we should first find a better
definition of what goes in there. I remember that some people
did not like the current split between arch/ppc/kernel and
arch/ppc/syslib.
Do you think of arch/powerpc/sysdev/ as a different thing from
the current syslib (e.g. stuff using include/linux/sysdev.h),
or just a different name for the same thing?
 
> Also, since your renaming things any chance there is a better name  
> for iic? (just wondering since its way to similar to what some people  
> use for I2C).

Yes, Ben has expressed the same concern to me, therefore I have renamed
the file to 'pic' instead of 'iic'. However, the architecture is very
specifically calling it IIC, so my idea was to keep the identifiers
with that name, hoping that this does not cause trouble when the files
are clearly marked as belonging to one specific platform.
If you have a better idea for naming it, I can change it of course.

	Arnd <><
