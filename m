Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSKTQnk>; Wed, 20 Nov 2002 11:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSKTQnk>; Wed, 20 Nov 2002 11:43:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28503 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261446AbSKTQnj>; Wed, 20 Nov 2002 11:43:39 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: suparna@in.ibm.com, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@provisioning.fibertel.com.ar>,
       Dave Hansen <haveblue@provisioning.fibertel.com.ar>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7 -- Success Story!
References: <m1vg349dn5.fsf@frodo.biederman.org>
	<1037055149.13304.47.camel@andyp> <m1isz39rrw.fsf@frodo.biederman.org>
	<1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
	<m1el9j2zwb.fsf@frodo.biederman.org>
	<m11y5j2r9t.fsf_-_@frodo.biederman.org>
	<1037668241.10400.48.camel@andyp> <20021120141925.A2524@in.ibm.com>
	<m1smxwzjlb.fsf@frodo.biederman.org>
	<20021120120551.O17062@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Nov 2002 09:48:29 -0700
In-Reply-To: <20021120120551.O17062@almesberger.net>
Message-ID: <m1k7j8yyoy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Eric W. Biederman wrote:
> > The needed hooks are there.  You can make certain an appropriate
> > ->shutdown()/reboot_notifier method is present, or you can fix the driver
> > so it can initialize the device from any random state.  
> 
> In the case of a crash, you may not be able to use the normal
> shutdown, but there may still be pending bus master accesses, e.g.
> from an on-going transfer, or free buffers that will eventually
> (i.e. there's no use in "waiting for the operation to finish") get
> used.
> 
> Initializing the device from any state is certainly a good feature,
> and it will cure the most visible symptoms, but problems may still
> occur if the device decides to scribble over memory after leaving
> the original kernel, and before the reset has occurred under the
> new kernel. (Or did you mean to initialize before invoking kexec ?


In this case I suspect the best route is to locate the kexec_on_panic
buffers for kexec where we want to use them.  Then even in most
cases a devices is scribbling on memory, unless the device was
improperly setup, it isn't scribbling on memory necessary to get
the new kernel going.  

> I see several possible approaches for this:
> 
>  0) do as bootimg did, and ignore the problem :-)
>  1) try to call the regular device shutdown. In the case of a
>     crash, this may hang, or corrupt the system further.
>  2) add a new callback that just silences the device, without
>     trying to clean things up. This is probably the best
>     long-term solution.

Roughly that is ->shutdown() it was separated from the ->remove()
case so that it could be stripped down to a minimal implementation.

Eric
