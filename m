Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264151AbUESMvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbUESMvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264161AbUESMvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 08:51:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58310 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264151AbUESMvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 08:51:09 -0400
Date: Wed, 19 May 2004 08:50:36 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: sendfile -EOVERFLOW on AMD64
Message-ID: <20040519125036.GM30909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1XuW9-3G0-23@gated-at.bofh.it> <m3d650wys1.fsf@averell.firstfloor.org> <20040519103855.GF18896@fi.muni.cz> <20040519105805.GK30909@devserv.devel.redhat.com> <20040519124427.GA68902@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519124427.GA68902@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 02:44:27PM +0200, Andi Kleen wrote:
> > (note error is int, not ssize_t), but I don't see anything obvious
> > for other filesystems.
> 
> sendfile64 on 32bit hosts seems to be quite fishy too.
> 
> It works with ssize_t, which is 32bit only, but there are no checks
> that the transfered file is not >4GB.  It would just wrap in this case.
> It would be better to add such checks for 32bit hosts to sendfile64.
> 
> Or am I missing something?

The userland prototypes are:
extern ssize_t sendfile (int __out_fd, int __in_fd, off_t *__offset,
                         size_t __count) __THROW;
extern ssize_t sendfile64 (int __out_fd, int __in_fd, __off64_t *__offset,
                           size_t __count) __THROW;
Thus you really cannot transfer more than 4G-1 bytes in one call on 32-bit
arches.
Actually, already any counts >= 2GB-1 might be problematic, but we are
there on the same boat as with e.g. read(2).  For read, POSIX says:
"If the value of nbyte is greater than {SSIZE_MAX}, the result is
implementation-defined."
so portable programs really shouldn't try to transfer more than that
in one go but the kernel certainly should try to handle sizes up to
SIZE_MAX-4096 or something like that.

	Jakub
