Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWDMGVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWDMGVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 02:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWDMGVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 02:21:52 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:42104 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964790AbWDMGVw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 02:21:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uk8rp/gEf67K7toRh5gm5Z6lIrpOmF03rYiGLq5e91cgBqgoc/mVvbByxEhWvkZeJXRf0tiZ4pPorjzNthkLMPxtNtXdKycvTt4h2sO+DuifopoqCqwcd/PaM6f34Iuh6AQQEtoZvPAmSb+LZ+4FsgkyKPAoJKZ/e99nEmJ6LYk=
Message-ID: <aec7e5c30604122321p2bedb370l945009ccdb725bac@mail.gmail.com>
Date: Thu, 13 Apr 2006 15:21:51 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] Re: [PATCH] Kexec: Remove order
Cc: "Magnus Damm" <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m164le6rcg.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060413030040.20516.9231.sendpatchset@cherry.local>
	 <m164le6rcg.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Magnus Damm <magnus@valinux.co.jp> writes:
>
> > Kexec: Remove order
> >
> > This patch replaces kexec n-order allocation code with 0-order only.
> >
> > Almost all kexec allocations are 0-order pages already, with the exception of
> > some x86_64 specific code that requests two physically contiguous pages.
> >
> > These two physically contiguous pages are easily replaced with two separate
> > pages. The second page is kept in an architecture specific pointer that is
> > added to struct kimage.
> >
> > Using 0-order allocations only greatly simplifies kexec porting work to
> > the Xen hypervisor.
>
> NACK.
>
> It is a big intrusive patch that makes it impossible to
> port to some architectures, and it obscures what you
> are really trying to do which is fix x86_64.

When I had a working x86_64 that didn't use 2 contiguous pages there
were no other users left of non-0 order allocations, so I thought it
would be better to remove the unused code than to keep it.

But you probably have some unmerged code that depends on that functionality.

> Feel free to fix x86_64, to use only page sized allocates.

I will. But first - questions:

Should KEXEC_CONTROL_CODE_SIZE be left in even if it's always 4096?

Do you like how I added image->arch_private?

> Until I see a reasonable argument that none of the architectures
> currently supported by the linux kernel would need a multi order
> allocation for a kexec port am I interested in removing support.

I argue that it is quite pointless to have code to support N-order
allocations that no one is using. Especially since the code is more
complex and it may be harder for the buddy allocator to fulfill
N-order allocations compared to 0-order allocations.

And on top of the reasons above I'd like to stay away from N-order
allocations because Xen doesn't guarantee that (pseudo-)physical pages
handled out by the buddy allocator are contiguous.

> As I recall the alpha had an architectural need for a 32KB
> allocation or something like that.

Oh. So if someone is working on kexec for alpha I guess we need
N-order allocations, right?

Thanks for your comments!

/ magnus
