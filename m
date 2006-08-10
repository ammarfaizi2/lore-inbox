Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161463AbWHJQyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161463AbWHJQyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161462AbWHJQyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:54:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161459AbWHJQym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:54:42 -0400
Date: Thu, 10 Aug 2006 09:54:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "John Stoffel" <john@stoffel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Jeff Garzik <jeff@garzik.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
Message-Id: <20060810095413.3797b4a2.akpm@osdl.org>
In-Reply-To: <17627.23974.848640.278643@stoffel.org>
References: <1155172843.3161.81.camel@localhost.localdomain>
	<20060809234019.c8a730e3.akpm@osdl.org>
	<Pine.LNX.4.64.0608101302270.6762@scrub.home>
	<44DB203A.6050901@garzik.org>
	<Pine.LNX.4.64.0608101409350.6762@scrub.home>
	<44DB25C1.1020807@garzik.org>
	<Pine.LNX.4.64.0608101429510.6762@scrub.home>
	<44DB27A3.1040606@garzik.org>
	<Pine.LNX.4.64.0608101459260.6761@scrub.home>
	<44DB3151.8050904@garzik.org>
	<Pine.LNX.4.64.0608101519560.6762@scrub.home>
	<17627.23974.848640.278643@stoffel.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 12:24:06 -0400
"John Stoffel" <john@stoffel.org> wrote:

> >>>>> "Roman" == Roman Zippel <zippel@linux-m68k.org> writes:
> 
> Roman> If you force everyone to use 64bit sector numbers, I don't
> Roman> understand how you can claim "still working just fine on
> Roman> 32bit"?  At some point ext4 is probably going to be the de
> Roman> facto standard, which very many people want to use, because it
> Roman> has all the new features, which won't be ported to ext2/3. So I
> Roman> still don't understand, what's so wrong about a little tuning
> Roman> in both directions?
> 
> The problem as I see it, is that you want extents, but you don't want
> the RAM/DISK/ROM penalty of 64bit blocks, since embedded devices won't
> ever go past the existing ext3 sizes, right?

For ext3 on x86:

CONFIG_LBD=y:

box:/usr/src/25> size fs/jbd/jbd.o fs/ext3/ext3.o
   text    data     bss     dec     hex filename
  51076       8      32   51116    c7ac fs/jbd/jbd.o
  87466    1020       4   88490   159aa fs/ext3/ext3.o

CONFIG_LBD=n:

box:/usr/src/25> size fs/jbd/jbd.o fs/ext3/ext3.o
   text    data     bss     dec     hex filename
  51133       8      32   51173    c7e5 fs/jbd/jbd.o
  87679    1020       4   88703   15a7f fs/ext3/ext3.o

That's a grand total of 270 bytes of text saved.  aka 0.19%.

We'll save four bytes in the inode (unlikely to save anything due to slab
packing).

We'll save 12 bytes against open-for-writing files due to
ext3_block_alloc_info shrinkage (unlikely to save anything due to kmalloc
size roundup).

IOW, unless I've missed something major, we're looking at a total saving of
around a 16th of a page.  We can save more than that any day of the week by
going around and deleting some crap from somewhere.  We can surely save
more than this by taming ext4's inlining frenzy.

I'd expect any runtime savings to be similarly modest.
