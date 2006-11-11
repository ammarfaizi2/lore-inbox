Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424484AbWKKBdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424484AbWKKBdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 20:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424487AbWKKBdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 20:33:36 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:28555 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1424484AbWKKBdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 20:33:36 -0500
X-Sasl-enc: 2wApOymrVvvhsA4tDId0QlvzGV0VMJUKCM17Vhdq0KCs 1163208815
Subject: Re: [2.4.19-rc4 and 2.4.19-rc4-mm2] super block list corruption
	following fill_super returns fail
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <20061110165544.a63aea51.akpm@osdl.org>
References: <1163162022.10725.13.camel@localhost>
	 <20061110165544.a63aea51.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 09:33:28 +0800
Message-Id: <1163208808.3113.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 16:55 -0800, Andrew Morton wrote:
> On Fri, 10 Nov 2006 20:33:42 +0800
> Ian Kent <raven@themaw.net> wrote:
> 
> > I'm seeing an oops after returning a fail status from the autofs and
> > autofs4 fill_super methods. The scenario is a little contrived but does
> > demonstrate the mount fail case.
> > 
> > get_super+0x78 corresponds to:
> > 
> >                         down_read(&sb->s_umount);
> > ---->                   if (sb->s_root)
> >                                 return sb;
> >                         up_read(&sb->s_umount);
> > 
> > So I believe that, following the fill_super call in get_sb_nodev the
> > super block is freed during the call to deactivate_super but not removed
> > from the supers list.
> > 
> > As far as I can tell I've done the appropriate housekeeping in the
> > autofs[4] fill_super function. In particular, sb->s_root is not set upon
> > mount fail.
> > 
> 
> Yup, sget() adds the superblock to super_blocks and deactivate_super()
> doesn't take it off.
> 
> > Does anyone have any suggestions as to what I might not be doing that I
> > should be doing that is preventing this removal? 
> 
> Well afacit the only piece of code which knows how to remove a superblock
> from the global list is generic_shutdown_super().  So perhaps your
> ->fill_super() implementation is supposed to run generic_shutdown_super()
> if it's about to return an error.

I came to the same conclusion.

There are a couple of ways I could do it but I was hoping to get a
recommendation from someone that is familiar with the way it's supposed
to be done.

I'll have a look at some of the other file systems.

Ian


