Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVFDAvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVFDAvY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVFDAvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:51:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:51847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261197AbVFDAvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:51:19 -0400
Date: Fri, 3 Jun 2005 17:51:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
Message-Id: <20050603175147.6cdbf81e.akpm@osdl.org>
In-Reply-To: <20050604000156.GA18065@animx.eu.org>
References: <42A0D88E.7070406@pobox.com>
	<20050603163843.1cf5045d.akpm@osdl.org>
	<20050604000156.GA18065@animx.eu.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner <wakko@animx.eu.org> wrote:
>
> Andrew Morton wrote:
> > Subject: Double free of initramfs
> 
> Is there a patch to fix this?  I've noticed a solid lockup when trying to
> umount initramfs after a pivot_root.

Nope, but there's a design:




Begin forwarded message:

Date: Wed, 16 Mar 2005 18:49:32 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-arch@vger
Subject: Double free of initramfs


In all linker scripts we currently have something like this:

  __init_begin = .;
 ...
   . = ALIGN(4096);
  __initramfs_start = .;
  .init.ramfs : { *(.init.ramfs) }
  __initramfs_end = .;
  ...
  __init_end = .;

It seems all 25 linker scripts in the current bk tree are suffering from
this.  Which mean with CONFIG_BLK_DEV_INITRD enabled first free_initrd_mem
may be called to free the initram disk and just a little later
free_initmem will try to free the entire range again, so either the
linker scripts would need fixing or free_initrd_mem has become obsolete.

  Ralf
