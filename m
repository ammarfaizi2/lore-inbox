Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUBITof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 14:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbUBITof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 14:44:35 -0500
Received: from mail0.lsil.com ([147.145.40.20]:17850 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S265339AbUBIToc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 14:44:32 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703D1A827@exa-atlanta.se.lsil.com>
From: "Moore, Eric Dean" <Emoore@lsil.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.25-rc1: Inconsistent ioctl symbol usage in drivers/messag
	e/fusion/mptctl.c
Date: Mon, 9 Feb 2004 14:43:05 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3EF44.EF7A4C50"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3EF44.EF7A4C50
Content-Type: text/plain;
	charset="iso-8859-1"

On Monday, February 09, 2004 5:27 AM, Marcelo Tosatti wrote
> Hi Eric,
> 
> Can you please fix this up?
> 
> On Mon, 9 Feb 2004, Keith Owens wrote:
> 
> > 2.4.25-rc1 drivers/message/fusion/mptctl.c expects sys_ioctl,
> > register_ioctl32_conversion and unregister_ioctl32_conversion to be
> > exported symbols when MPT_CONFIG_COMPAT is defined.  That symbol is
> > defined for __sparc_v9__, __x86_64__ and __ia64__.
> >
> > The symbols are not exported in ia64, mptctl.o gets 
> unresolved symbols
> > when it is a module on ia64.
> >
> > x64_64 exports register_ioctl32_conversion and 
> unregister_ioctl32_conversion,
> > but not sys_ioctl.
>


Marcelo - Here is a fix for the x86_64 issue.
In Redhat/Suse kernels this "sys_ioctl" symbol is exported, but
not in generic kernel.  The ia64 problem is going to require
a fix in the mptctl driver.


--- linux-2.4.25-pre8-ref/arch/x86_64/ia32/ia32_ioctl.c	2004-02-09
12:49:05.000000000 -0700
+++ linux-2.4.25-pre8/arch/x86_64/ia32/ia32_ioctl.c	2004-02-09
12:00:52.000000000 -0700
@@ -129,6 +129,8 @@
 #define EXT2_IOC32_GETVERSION             _IOR('v', 1, int)
 #define EXT2_IOC32_SETVERSION             _IOW('v', 2, int)
 
+EXPORT_SYMBOL(sys_ioctl);
+
 extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned
long arg);
 
 static int w_long(unsigned int fd, unsigned int cmd, unsigned long arg) 


------_=_NextPart_000_01C3EF44.EF7A4C50
Content-Type: application/octet-stream;
	name="mpt-x86_64-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mpt-x86_64-fix.patch"

--- linux-2.4.25-pre8-ref/arch/x86_64/ia32/ia32_ioctl.c	2004-02-09 =
12:49:05.000000000 -0700=0A=
+++ linux-2.4.25-pre8/arch/x86_64/ia32/ia32_ioctl.c	2004-02-09 =
12:00:52.000000000 -0700=0A=
@@ -129,6 +129,8 @@=0A=
 #define EXT2_IOC32_GETVERSION             _IOR('v', 1, int)=0A=
 #define EXT2_IOC32_SETVERSION             _IOW('v', 2, int)=0A=
 =0A=
+EXPORT_SYMBOL(sys_ioctl);=0A=
+=0A=
 extern asmlinkage int sys_ioctl(unsigned int fd, unsigned int cmd, =
unsigned long arg);=0A=
 =0A=
 static int w_long(unsigned int fd, unsigned int cmd, unsigned long =
arg)=0A=

------_=_NextPart_000_01C3EF44.EF7A4C50--
