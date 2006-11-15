Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030949AbWKOTaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030949AbWKOTaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030948AbWKOTaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:30:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030937AbWKOTaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:30:03 -0500
Date: Wed, 15 Nov 2006 11:29:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, ext4 <linux-ext4@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: pagefault in generic_file_buffered_write() causing deadlock
Message-Id: <20061115112957.e38539e9.akpm@osdl.org>
In-Reply-To: <455B5A7B.6010807@us.ibm.com>
References: <1163606265.7662.8.camel@dyn9047017100.beaverton.ibm.com>
	<20061115090005.c9ec6db5.akpm@osdl.org>
	<455B5A7B.6010807@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 10:20:43 -0800
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> Andrew Morton wrote:
> > On Wed, 15 Nov 2006 07:57:45 -0800
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> >   
> >> We are looking at a customer situation (on 2.6.16-based distro) - where
> >> system becomes almost useless while running some java & stress tests.
> >>
> >> Root cause seems to be taking a pagefault in generic_file_buffered_write
> >> () after calling prepare_write. I am wondering 
> >>
> >> 1) Why & How this can happen - since we made sure to fault the user
> >> buffer before prepare write.
> >>     
> >
> > When using writev() we only fault in the first segment of the iovec.  If
> > the second or succesive segment isn't mapped into pagetables we're
> > vulnerable to the deadlock.
> >
> >   
> Hmm.. Not it :(
> Its coming from write() not writev().
> 
> [C00000002ABBF290] [C00000000039D58C] .do_page_fault+0x2e4/0x75c
> [C00000002ABBF460] [C000000000004860] .handle_page_fault+0x20/0x54
> --- Exception: 301 at .__copy_tofrom_user+0x11c/0x580
>     LR = .generic_file_buffered_write+0x39c/0x7c8
> [C00000002ABBF750] [C000000000095A94]
> .generic_file_buffered_write+0x2c0/0x7c8 (
> unreliable)
> [C00000002ABBF8F0] [C0000000000962EC]
> .__generic_file_aio_write_nolock+0x350/0x3
> e0
> [C00000002ABBFA20] [C000000000096908] .generic_file_aio_write+0x78/0x104
> [C00000002ABBFAE0] [C0000000001649F0] .ext3_file_write+0x2c/0xd4
> [C00000002ABBFB70] [C0000000000C5168] .do_sync_write+0xd4/0x130
> [C00000002ABBFCF0] [C0000000000C5ED4] .vfs_write+0x128/0x20c
> [C00000002ABBFD90] [C0000000000C664C] .sys_write+0x4c/0x8c
> [C00000002ABBFE30] [C00000000000871C] syscall_exit+0x0/0x40
> 

Oh well.  If it's a deadlock (this is not clear from your description) then
please gather backtraces of all affected tasks.

There is an ab/ba deadlock with journal_start() and lock_page(), iirc. 
Chris and I had a look at that a while back and collapsed in exhaustion -
it isn't pretty.  
