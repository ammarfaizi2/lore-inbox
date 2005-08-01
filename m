Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVHAQ2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVHAQ2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVHAQZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:25:48 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:34525 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262238AbVHAQZF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:25:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P3y8MMr8kcnhD1lRPMzKcnOSZPeGRp073T+6MdIzLFzXcOP+3FXiQhEX8LXmT6csHRJuML9bYSsvgRe/mELCMzRHLytjS3imIWzHEGaX2cyCWQQ3KOkwi7Q8QwAaxWhN2LUk1rztSrrLI+Pp1WYtYHJ+OP0lGyM2EpmGe87UfSQ=
Message-ID: <9a87484905080109257abd0bde@mail.gmail.com>
Date: Mon, 1 Aug 2005 18:25:00 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: Fw: sigwait() breaks when straced
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@gmail.com>
In-Reply-To: <21d7e99705073117121241159a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050730170049.6df9e39f.akpm@osdl.org>
	 <20050801000120.1D00F180EC0@magilla.sf.frob.com>
	 <21d7e99705073117121241159a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/05, Dave Airlie <airlied@gmail.com> wrote:
> >
> > However, there is in fact no bug here.  The test program is just wrong.
> > sigwait returns zero or an error number, as POSIX specifies.  Conversely,
> > sigtimedwait and sigwaitinfo either return 0 or set errno and return -1.
> > It is odd that the interfaces of related functions differ in this way,
> > but they do.
> 
> The someone should fix the manpage, it explicitly says
> "The sigwait function never returns an error."
> 
> Which is clearly wrong if it can return EINTR...
> 

As I read SUSv3 , sigwait /can/ return error, but EINTR is not one
that it's supposed to ever return.

>From http://www.opengroup.org/onlinepubs/009695399/functions/sigwait.html :
...
ERRORS

    The sigwait() function may fail if:

    [EINVAL]
        The set argument contains an invalid or unsupported signal number.
...

EINVAL is the only defined error for sigwait.


Also, at the start of the thread Ulrich Drepper said  "The kernel
simply doesn't restart the function in case of a signal. It should do
this, though." .

I'm not quite sure you are right Ulrich. Given this little bit from
SUSv3 about SA_RESTART in the page describing sigaction (
http://www.opengroup.org/onlinepubs/009695399/functions/sigaction.html
) :

...
SA_RESTART
    This flag affects the behavior of interruptible functions; that
is, those specified to fail with errno set to [EINTR]. If set, and a
function specified as interruptible is interrupted by this signal, the
function shall restart and shall not fail with [EINTR] unless
otherwise specified. If the flag is not set, interruptible functions
interrupted by this signal shall fail with errno set to [EINTR].
...

by that definition, that interruptible functions are those "specified
to fail with errno set to [EINTR]", I don't see how sigwait can be
considered an interruptible function since it
a) doesn't set errno
b) doesn't even list EINTR as a defined error return
And if sigwait is not an interruptible function, then how would it be
correct for the kernel to restart it ?
Also, the sigwait page (linked above) also says that "The sigwait()
function shall select a pending signal from set, atomically clear it
from the system's set of pending signals, and return that signal
number in the location referenced by sig." - the word that stands out
to me here is "atomically" - how can it be atomic if it is allowed to
be interrupted by signals?

What am I missing?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
