Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUBJJs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 04:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUBJJsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 04:48:55 -0500
Received: from aun.it.uu.se ([130.238.12.36]:36038 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265800AbUBJJsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 04:48:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16424.43181.502341.118903@alkaid.it.uu.se>
Date: Tue, 10 Feb 2004 10:47:25 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Moore, Eric Dean" <Emoore@lsil.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: RE: 2.4.25-rc1: Inconsistent ioctl symbol usage in drivers/messag
	e/fusion/mptctl.c
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5703D1A827@exa-atlanta.se.lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E5703D1A827@exa-atlanta.se.lsil.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moore, Eric Dean writes:
 > On Monday, February 09, 2004 5:27 AM, Marcelo Tosatti wrote
 > > Hi Eric,
 > > 
 > > Can you please fix this up?
 > > 
 > > On Mon, 9 Feb 2004, Keith Owens wrote:
 > > 
 > > > 2.4.25-rc1 drivers/message/fusion/mptctl.c expects sys_ioctl,
 > > > register_ioctl32_conversion and unregister_ioctl32_conversion to be
 > > > exported symbols when MPT_CONFIG_COMPAT is defined.  That symbol is
 > > > defined for __sparc_v9__, __x86_64__ and __ia64__.
 > > >
 > > > The symbols are not exported in ia64, mptctl.o gets 
 > > unresolved symbols
 > > > when it is a module on ia64.
 > > >
 > > > x64_64 exports register_ioctl32_conversion and 
 > > unregister_ioctl32_conversion,
 > > > but not sys_ioctl.
 > >
 > 
 > 
 > Marcelo - Here is a fix for the x86_64 issue.
 > In Redhat/Suse kernels this "sys_ioctl" symbol is exported, but
 > not in generic kernel.  The ia64 problem is going to require
 > a fix in the mptctl driver.
 > 
 > 
 > --- linux-2.4.25-pre8-ref/arch/x86_64/ia32/ia32_ioctl.c	2004-02-09
 > 12:49:05.000000000 -0700
 > +++ linux-2.4.25-pre8/arch/x86_64/ia32/ia32_ioctl.c	2004-02-09
 > 12:00:52.000000000 -0700
 > @@ -129,6 +129,8 @@
 >  #define EXT2_IOC32_GETVERSION             _IOR('v', 1, int)
 >  #define EXT2_IOC32_SETVERSION             _IOW('v', 2, int)
 >  
 > +EXPORT_SYMBOL(sys_ioctl);
 > +

Can't you just use register_ioctl32_conversion()'s convention that
a NULL handler defaults to sys_ioctl? Alternatively you could just
write the one-liner 

filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg)

in your handler.
