Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933052AbWGAAJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933052AbWGAAJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933068AbWGAAJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:09:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19637 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933052AbWGAAJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:09:10 -0400
Date: Fri, 30 Jun 2006 17:12:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.17-mm4
Message-Id: <20060630171212.50630182.akpm@osdl.org>
In-Reply-To: <4807377b0606301653n68bee302t33c2cc28b8c5040@mail.gmail.com>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<4807377b0606291053g602f3413gb3a60d1432a62242@mail.gmail.com>
	<20060629120518.e47e73a9.akpm@osdl.org>
	<4807377b0606301653n68bee302t33c2cc28b8c5040@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesse Brandeburg" <jesse.brandeburg@gmail.com> wrote:
>
> On 6/29/06, Andrew Morton <akpm@osdl.org> wrote:
> > On Thu, 29 Jun 2006 10:53:03 -0700
> > "Jesse Brandeburg" <jesse.brandeburg@gmail.com> wrote:
> >
> > > can't boot 2.6.17-mm4 on x86_64 Intel 7520 platform.
> > > instant reboot after printing:
> > >   Booting 'Red Hat Enterprise Linux AS (2.6.17-mm4-jesse)'
> > >
> > > root (hd0,0)
> > >  Filesystem type is ext2fs, partition type 0x83
> > > kernel /vmlinuz-2.6.17-mm4-jesse ro root=LABEL=/1 rhgb hdc=none video=atyfb:102
> > > 4x768M-32@70 console=ttyS0,115200n8 console=tty1 panic=30
> > >    [Linux-bzImage, setup=0x1e00, size=0x199883]
> > > initrd /initrd-2.6.17-mm4-jesse.img
> > >    [Linux-initrd @ 0x37efd000, 0xf2da8 bytes]
> > >
> > > ie no kernel output
> >
> > Your .config works OK on my x86_64 box.  Wanna swap? ;)
> >
> > > where should i start to debug?  I can do a bisect pretty easily too
> > > using git if necessary.
> >
> > That would be great, thanks.  Your options are to do a git bisect using
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git#v2.6.17-mm4
> >
> > (Beware that the mm-to-git trees have had a few problem reports and I'm not
> > aware of anyone previously using them for a bisect).
> >
> > or to install quilt and use
> > http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> 
> had to pull in linus' tree in order to get the latest 2.6.17 label,
> bisect complete, this patch appeared to make the problem
> ad596171ed635c51a9eef829187af100cbf8dcf7 is first bad commit
> diff-tree ad596171ed635c51a9eef829187af100cbf8dcf7 (from
> 734efb467b31e56c2f9430590a9aa867ecf3eea1)
> Author: john stultz <johnstul@us.ibm.com>
> Date:   Mon Jun 26 00:25:06 2006 -0700
> 
>     [PATCH] Time: Use clocksource infrastructure for update_wall_time
> 
>     Modify the update_wall_time function so it increments time using the
>     clocksource abstraction instead of jiffies.  Since the only
> clocksource driver
>     currently provided is the jiffies clocksource, this should result in no
>     functional change.  Additionally, a timekeeping_init and timekeeping_resume
>     function has been added to initialize and maintain some of the new
> timekeping
>     state.
> 
>     [hirofumi@mail.parknet.co.jp: fixlet]
>     Signed-off-by: John Stultz <johnstul@us.ibm.com>
>     Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> :040000 040000 3ea3b4140ffa318c20513d596eb063430760822a
> 30d3669ec72a2a9edc69a72fadfb4158bd17d6fe M      include
> :040000 040000 5c222365dd5b1fdbfebabd40106732b9bfcc3f0d
> adbb7244617875fe7e0f3014e90808ddf6115976 M      init
> :040000 040000 24c5fcb7f26396cf231c7ab06ddc8fb187ebe5d4
> 8157df180abe5f6f058c050f1d017b46334f5c8f M      kernel
> 
> however i cannot revert this patch from -mm4 because of conflicts ( i
> might be able to revert a specific set of patches from mm)

Thanks.  I assume mainline is doing this now.

I guess it has to be dying in timekeeping_init().  Have you tried
earlyprintk=vga or, better, earlyprintk=serial,ttyS0,9600?

