Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVFTTWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVFTTWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVFTTVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:21:30 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:11426 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261523AbVFTTSR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:18:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SgwrXs9CJ0G+rB1kDTCqaKbGspiuaiJQZxJ/ncBwbSpwx4RnZrlyxqKEkigyVvHCkilm6Li54Mx0ZObxVNBkSCPwVhXXB3RA1teWkhieZkM0mTqFy9kMIaIeg5z4qjysN5s+RCNUXWxE0hv/BwM2oU0jDhqntKe1fgaqAQP4ajw=
Message-ID: <f2176eb805062012181fe9707b@mail.gmail.com>
Date: Tue, 21 Jun 2005 03:18:11 +0800
From: Paradise <paradyse@gmail.com>
Reply-To: Paradise <paradyse@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: 2.6.12-mm1 cannot build nvidia driver?
Cc: linux-kernel@vger.kernel.org,
       Debian Users List <debian-user@lists.debian.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <f2176eb80506201200bb50ef1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f2176eb805062004557fc7b9ac@mail.gmail.com>
	 <f2176eb805062005201c96510a@mail.gmail.com>
	 <200506201639.j5KGdoNO016276@turing-police.cc.vt.edu>
	 <f2176eb805062012003b068199@mail.gmail.com>
	 <f2176eb80506201200bb50ef1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, it is fixed by adding back  "!defined(HAVE_COMPAT_IOCTL)", might
something wrong with debian package

Thanks.

On 6/21/05, Paradise <paradyse@gmail.com> wrote:
> *version of 1.0.7174-3 from debian*
> 
> On 6/21/05, Paradise <paradyse@gmail.com> wrote:
> > this is the version of !defined(HAVE_COMPAT_IOCTL) from debian
> > .....there is no "!defined(HAVE_COMPAT_IOCTL)" that you said..
> >
> > void NV_API_CALL os_register_ioctl32_conversion(U032 cmd, U032 size)
> > {
> > #if defined(NVCPU_X86_64) && defined(CONFIG_IA32_EMULATION)
> >     unsigned int request = _IOWR(NV_IOCTL_MAGIC, cmd, char[size]);
> >     register_ioctl32_conversion(request, (void *)sys_ioctl);
> > #endif /* NVCPU_X86_64 */
> > }
> >
> > void NV_API_CALL os_unregister_ioctl32_conversion(U032 cmd, U032 size)
> > {
> > #if defined(NVCPU_X86_64) && defined(CONFIG_IA32_EMULATION)
> >     unsigned int request = _IOWR(NV_IOCTL_MAGIC, cmd, char[size]);
> >     unregister_ioctl32_conversion(request);
> > #endif /* NVCPU_X86_64 */
> > }
> >
> >
> > On 6/21/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> > > On Mon, 20 Jun 2005 20:20:06 +0800, Paradise said:
> > > > seems un/register_ioctl32_conversion is removed from 2.6.12-mm1..
> > > > any patch for nvidia kernel driver?
> > >
> > > No patch, but some hints - I suspect the problem is a local build config error...
> > >
> > > 1) The exact patch causing your problem in -mm1 is:
> > > remove-register_ioctl32_conversion-and-unregister_ioctl32_conversion.patch
> > >
> > > Building with this one patch -R'ed out should help, but it's the wrong thing
> > > to do, as it only papers over the real problem, which is:
> > >
> > > 2) Your failing code is in os-interface.c:
> > >
> > > void NV_API_CALL os_unregister_ioctl32_conversion(U032 cmd, U032 size)
> > > {
> > > #if defined(NVCPU_X86_64) && defined(CONFIG_IA32_EMULATION) && !defined(HAVE_COMPAT_IOCTL)
> > >     unsigned int request = _IOWR(NV_IOCTL_MAGIC, cmd, char[size]);
> > >     unregister_ioctl32_conversion(request);
> > > #endif
> > > }
> > >
> > > Might want to figure out why HAVE_COMPAT_IOCTL isn't defined - there's at least
> > > 3 other places where it matters (in nv.c).  It's #defined in the include/linux/fs.h
> > > header in 2.6.12-rc6-mm1, so you probably want to figure out why your build isn't
> > > picking up on it.  Are your #include directories screwed up?
> > >
> > > Sorry I can't provide more help, this looks like an X86-64 only issue.  If this
> > > isnt enough, take it up on the NVidia forums:
> > >
> > > http://www.nvnews.net/vbulletin/forumdisplay.php?s=&forumid=14
> > >
> > >
> > >
> > >
> > >
> >
> >
> > --
> > Regards,
> > Paradise
> >
> 
> 
> --
> Regards,
> Paradise
> 


-- 
Regards,
Paradise
