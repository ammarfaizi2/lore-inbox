Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVDLAQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVDLAQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVDLAQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:16:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:36750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261743AbVDLAQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:16:48 -0400
Date: Mon, 11 Apr 2005 17:13:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: hozer@hozed.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050411171347.7e05859f.akpm@osdl.org>
In-Reply-To: <52oeclyyw3.fsf@topspin.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
	<52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org>
	<5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org>
	<52oeclyyw3.fsf@topspin.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
>     Troy> Do we even need the mlock in userspace then?
> 
> Yes, because the kernel may go through and unmap pages from userspace
> while trying to swap.  Since we have the page locked in the kernel,
> the physical page won't go anywhere, but userspace might end up with a
> different page mapped at the same virtual address.

That shouldn't happen.  If get_user_pages() has elevated the refcount on a
page then the following can happen:

- The VM may decide to add the page to swapcache (if it's not mmapped
  from a file).

- Once the page is backed by either swapcache of a (mmapped) file, the VM
  may decide the unmap the application's pte's.  A later minor fault by the
  app will cause the same physical page to be remapped.

- The VM may decide to try to write the page to its backing file or swap.
   If it does, the page is still in core, but is now clean.

- Once all pte's are unmapped and the page is clean, the VM may decide to
  try to reclaim the page.  The VM will then see the elevated refcount and
  will bale out, leaving the page in core.

- If your code was doing a read-from-disk (modifying memory), then your
  code should run set_page_dirty() or set_page_dirty_lock() against the
  page before dropping the refcount which get_user_pages() added.  Once the
  page is dirty, the VM can't reclaim it until it has been been written to
  swap or mmapped backing file.

IOW: while the page has an elevated refcount from get_user_pages(), that
physical page is 100% pinned.  Once you've done the
set_page_dirty+put_page(), the page is again under control of the VM.

There should be no need to run mlock() from userspace.

