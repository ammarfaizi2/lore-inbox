Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTJCX3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbTJCX3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:29:15 -0400
Received: from users.ccur.com ([208.248.32.211]:11120 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S261486AbTJCX3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:29:02 -0400
Date: Fri, 3 Oct 2003 19:28:43 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, andrea@suse.de
Subject: Re: mlockall and mmap of IO devices don't mix
Message-ID: <20031003232843.GB26590@rudolph.ccur.com>
References: <20031003214411.GA25802@rudolph.ccur.com> <20031003152349.7194b73d.akpm@osdl.org> <20031003225509.GA26590@rudolph.ccur.com> <20031003160642.6173f13a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031003160642.6173f13a.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh crap, you're mapping /dev/mem rather than going through a device driver.
> /dev/mem isn't setting VM_IO.

You're right; I just tried your original patch with a real device driver
and it worked.


> Does this little experiment make it go?
> -	if (uncached)
> +//	if (uncached)

Yes it does....

(am about to look at and try your third patch out).

Comments of the first patch:

	vm_io = vma->vm_flags & VM_IO;

uses 'vma' before it has been established that vma is a
non-NULL pointer.  Perhaps we should go back to just using
(vma_flags &VM_IO) everywhere it is needed?

Also, conside changing
	
	while (!vm_io && !(map = follow_page(mm,start,write))) {
to
	if (!vm_io) {
	    while (!(map = ...))) {
		....
            }
            if (pages) {
		....
            }
        }

as it more clearly codes up the intended effect, rather than relying
on  side effects ('pages' happens to be NULL whenever VM_IO is set).

Joe
