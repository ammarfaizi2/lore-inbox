Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030609AbWJJWiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbWJJWiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030612AbWJJWim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:38:42 -0400
Received: from mail.impinj.com ([206.169.229.170]:9821 "EHLO earth.impinj.com")
	by vger.kernel.org with ESMTP id S932172AbWJJWif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:38:35 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: BUG in filp_close() (was: Re: 2.6.19-rc1-mm1)
Date: Tue, 10 Oct 2006 15:38:36 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
       Andrew Morton <akpm@osdl.org>
References: <20061010000928.9d2d519a.akpm@osdl.org> <1160495269.9864.18.camel@kleikamp.austin.ibm.com> <1160518024.28923.33.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1160518024.28923.33.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101538.36358.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 15:07, Dave Kleikamp wrote:
> On Tue, 2006-10-10 at 10:47 -0500, Dave Kleikamp wrote:
> > On Tue, 2006-10-10 at 00:09 -0700, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc
> > >1/2.6.19-rc1-mm1/
> >
> > I'm seeing an exception in filp_close(), called from sys_dup2().  I have
> > only seen it when I try to start up a java application (Lotus
> > Workplace).
> >
> > I suspect that it may be related to the fdtable work, but I haven't
> > investigated it too closely.
>
> Still don't know exactly what's going on here.  In case it helps, this
> is the call to dup2() from strace output:
>
> 1419  open("/dev/null", O_RDWR)         = 7
> 1419  getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
> 1419  dup2(7, 524)                      = 524
> 1419  dup2(7, 525 <unfinished ...>
>
> > > +fdtable-delete-pointless-code-in-dup_fd.patch
> > > +fdtable-make-fdarray-and-fdsets-equal-in-size.patch
> > > +fdtable-remove-the-free_files-field.patch
> > > +fdtable-implement-new-pagesize-based-fdtable-allocator.patch
> > >
> > >  Redo the fdtable code.

D'oh!!! Everybody who hit this bug can feel free to call me a moron now! (And 
Andrew will probably take me up on that offer, for all the residual flak he 
caught. :)) The problem is in the following logic:
+        nr++;
+        nr /= (PAGE_SIZE / 4 / sizeof(struct file *));
+        nr = roundup_pow_of_two(nr);
+        nr *= (PAGE_SIZE / 4 / sizeof(struct file *));
+        if (nr > NR_OPEN)
+                nr = NR_OPEN;
The problem is that roundup_pow_of_two() will not necessarily bring the array 
up to the necessary size, and we get an array overflow. This is clearly 
visible in the example above: dup2(..., 524) with a PAGE_SIZE of 4K. (Thanks 
for sending that in, Dave.) Let me think about the best way to fix this 
computation, and I'll send out a patch for you folks to test to see if it 
fixes your problem, if you'll oblige.

-- Vadim Lobanov, idiot of the day
