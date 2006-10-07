Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWJGNOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWJGNOe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 09:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWJGNOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 09:14:34 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:39087 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750910AbWJGNOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 09:14:34 -0400
Subject: Re: get_user_pages() cache issues on ARM
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: rmk+lkml@arm.linux.org.uk, dhylands@gmail.com, guinan@bluebutton.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1GTiTy-0002kU-00@dorka.pomaz.szeredi.hu>
References: <E1GTiBq-0002i3-00@dorka.pomaz.szeredi.hu>
	 <20060930170548.GA24949@flint.arm.linux.org.uk>
	 <E1GTiTy-0002kU-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 08:13:38 -0500
Message-Id: <1160226818.3459.6.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-30 at 19:18 +0200, Miklos Szeredi wrote:
> Added James Bottomley to the CC.  He designed this interface, and he
> explained to me how it's supposed to work, but I since forgot.
> 
> James, do you have some memory of these issues?

I can try, but the problems were very parisc specific.

> > The questions I have are:
> > 
> > - where do these pages that get_user_pages() finds and calls flush_anon_page()
> >   on come from?

Anonymous pages are non-file backed pages.  Fuse has them because it
uses non file backed buffers to operate the user level filesystem
(basically any memory you malloc at user level can end up as an
anonymous page).

> > - why is the current ARM flush_dcache_page() (which is also called after
> >   flush_anon_page()) not sufficient?

I think you do the same as we do on parisc: traverse the
page_mapping(page) list and flush.  Unfortunately, anonymous pages don't
have entries in the page_mapping(page) list (because they're not file
backed), so our flush_dcache_page() wasn't flushing them, hence the need
for an additional API for fuse.

if you have an archive of linux-arch, the original discussion is under
the subject

Potential problem with the page_mapping macro and flush_dcache_page()

and begins on 19 March 2006

> > - if we implement flush_anon_page() does that mean that we end up flushing
> >   multiple times in some circumstances?  If so, how do we avoid this?

In theory no, because the way I coded the parisc version, it ignores
non-anon pages, which are flushed by flush_dcache_page(); but it would
depend on how you implement this.

James


