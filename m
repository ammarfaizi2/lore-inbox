Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbUKVKRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbUKVKRO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUKVKRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:17:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12957 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262011AbUKVKRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:17:08 -0500
Date: Mon, 22 Nov 2004 05:16:46 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: var args in kernel?
Message-ID: <20041122101646.GP10340@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20041109074909.3f287966.akpm@osdl.org> <1100018489.7011.4.camel@lb.loomes.de> <20041109211107.GB5892@stusta.de> <1100037358.1519.6.camel@lb.loomes.de> <20041110082407.GA23090@bytesex> <1100085569.1591.6.camel@lb.loomes.de> <20041118165853.GA22216@bytesex> <419E689A.5000704@backtobasicsmgmt.com> <20041122094312.GC29305@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122094312.GC29305@bytesex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 10:43:12AM +0100, Gerd Knorr wrote:
> On Fri, Nov 19, 2004 at 02:41:46PM -0700, Kevin P. Fleming wrote:
> > Gerd Knorr wrote:
> > >Yet another kobject bug.  It uses the varargs list twice in a illegal
> > >way.  That doesn't harm on i386 by pure luck, but blows things up on
> > >amd64 machines.  The patch below fixes it.
> > 
> > Is this safe? The normal glibc varargs implementation says you can't 
> > even call va_start on the same args list twice, you have to use va_copy 
> > to make a clone and then call va_start on that, _before_ you ever call 
> > va_start the first time.
> 
> Hmm, maybe.  I'm not sure who actually implements the varargs (gcc?
> Or glibc/kernel?) and whenever the above applies to the kernel as well
> or not ...

varargs is implemented entirely by GCC (GCC owns the stdarg.h header
and implements the builtin functions that are used in the va_* macros).

You can call va_start on the same args list twice, both:
void foo (int x, ...)
{
  va_list ap, ap2;
  va_start (ap, x);
  va_start (ap2, x);
...
  va_end (ap);
  va_end (ap2);
}
and
void foo (int x, ...)
{
  va_list ap;
  va_start (ap, x);
...
  va_end (ap);
  va_start (ap, x);
...
  va_end (ap);
}
are ok.  What you can't do is e.g.
  va_list ap;
  va_start (ap, x);
  bar (x, ap);
  bar (x, ap);
  va_end (ap);
(i.e. once you pass the ap to some other function, the only thing that you
have to do with it in the caller is va_end).

	Jakub
