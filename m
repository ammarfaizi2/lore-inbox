Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVHATUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVHATUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVHATUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:20:10 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:1261 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261157AbVHATUI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:20:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sjgeaHMT8FWVmGxZG26fWWr0Cbtv+Z03nNuz4qj6TbX+9J+ubIn9FEGFFT0b04ROFi1iaqN+kygfxAC9l5Us8uAM9hOYsQOMyzU2QdycD/kBcZQliMt3bOwFDnb39/DIBFnT0YN4mUn8NNWhds0i+V/DAGWhdzDMLMkDu4aJUn0=
Message-ID: <a36005b505080112203c7a5b58@mail.gmail.com>
Date: Mon, 1 Aug 2005 12:20:07 -0700
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Fw: sigwait() breaks when straced
Cc: Dave Airlie <airlied@gmail.com>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <9a87484905080109257abd0bde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050730170049.6df9e39f.akpm@osdl.org>
	 <20050801000120.1D00F180EC0@magilla.sf.frob.com>
	 <21d7e99705073117121241159a@mail.gmail.com>
	 <9a87484905080109257abd0bde@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> I'm not quite sure you are right Ulrich. Given this little bit from
> SUSv3 about SA_RESTART in the page describing sigaction (
> http://www.opengroup.org/onlinepubs/009695399/functions/sigaction.html
> ) :

It's not an official SA_RESTART since the syscall is defined to
support EINTR.  It's clear  that sigwait in this sense is not
interruptible.  Return EINTR from sigwait is only allowed by POSIX
since there is no contrary wording (unlike for the pthread functions).
 But if this clause would be used each and every syscall could return
EINTR and we would have to surround all syscalls with a loop.  Hence
the syscall should be restarted, not because SA_RESTART is set, but
because EINTR shouldn't be returned.

Now, Roland correctly said sigtimedwait and sigwaitinfo need to return
EINTR and we use one syscall for them all.  I overlook that part.  So,
I'll add the wrapper in the libc so that sigwait restarts on EINTR.
