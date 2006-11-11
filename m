Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422847AbWKKA4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422847AbWKKA4E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 19:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422880AbWKKA4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 19:56:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39872 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422847AbWKKA4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 19:56:02 -0500
Date: Fri, 10 Nov 2006 16:55:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [2.4.19-rc4 and 2.4.19-rc4-mm2] super block list corruption
 following fill_super returns fail
Message-Id: <20061110165544.a63aea51.akpm@osdl.org>
In-Reply-To: <1163162022.10725.13.camel@localhost>
References: <1163162022.10725.13.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006 20:33:42 +0800
Ian Kent <raven@themaw.net> wrote:

> I'm seeing an oops after returning a fail status from the autofs and
> autofs4 fill_super methods. The scenario is a little contrived but does
> demonstrate the mount fail case.
> 
> get_super+0x78 corresponds to:
> 
>                         down_read(&sb->s_umount);
> ---->                   if (sb->s_root)
>                                 return sb;
>                         up_read(&sb->s_umount);
> 
> So I believe that, following the fill_super call in get_sb_nodev the
> super block is freed during the call to deactivate_super but not removed
> from the supers list.
> 
> As far as I can tell I've done the appropriate housekeeping in the
> autofs[4] fill_super function. In particular, sb->s_root is not set upon
> mount fail.
> 

Yup, sget() adds the superblock to super_blocks and deactivate_super()
doesn't take it off.

> Does anyone have any suggestions as to what I might not be doing that I
> should be doing that is preventing this removal? 

Well afacit the only piece of code which knows how to remove a superblock
from the global list is generic_shutdown_super().  So perhaps your
->fill_super() implementation is supposed to run generic_shutdown_super()
if it's about to return an error.

Seems like an odd API though.

