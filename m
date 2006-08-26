Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWHZXRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWHZXRF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 19:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWHZXRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 19:17:05 -0400
Received: from mother.openwall.net ([195.42.179.200]:13738 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750705AbWHZXRC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 19:17:02 -0400
Date: Sun, 27 Aug 2006 03:13:14 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Ernie Petrides <petrides@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: printk()s of user-supplied strings (Re: [PATCH] binfmt_elf.c : the BAD_ADDR macro again)
Message-ID: <20060826231314.GA24109@openwall.com>
References: <20060822030755.GB830@openwall.com> <200608222023.k7MKNHpH018036@pasta.boston.redhat.com> <20060824164425.GA17692@openwall.com> <20060824164633.GA21807@1wt.eu> <20060826022955.GB21620@openwall.com> <20060826082236.GA29736@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826082236.GA29736@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 10:22:36AM +0200, Willy Tarreau wrote:
> I think that we are trying to protect against :
>   1) local users faking kernel messages. (eg: disk errors, oopses, ...)
>   2) local users changing console settings (eg: black on black)
>   3) local users corrupting the log reader's terminal
> 
> 1) is relatively easy to do, basically if we escape \b, \r and \n, it will
> become hard to produce fake logs.

I think it's just '\n'; other characters that you've mentioned achieve
(1) by exploiting (2).

> 2) should be as easy. I'm not aware of any way to change a local console
> setting with non-control chars (>= 0x20)

...except that there are control chars above 0x20:

	http://archives.neohapsis.com/archives/linux/lsap/2000-q2/0151.html

(scroll down to the end).  One thing that I did not mention in that older
posting is that, IIRC, according to my vt420 manual, macro recording and
playback may be invoked via the 8-bit controls (in some terminal modes).

This is not limited to real (hardware) terminals; of the 8-bit controls,
at least CSI (0x9b) is typically supported by terminal emulators.  Even
our linux/drivers/char/console.c supports it.

Although most terminal emulators don't appear to allow for macro
recording/playback to be requested with control chars, they do support
status requests - to which they respond with certain easy-to-guess
strings (an attack would be to create a script in PATH under that name -
yes, this has multiple prerequisites).

So I think that we should escape chars in the 0x7f to 0x9f range as well.

> 3) is a problem of interpretation between the program storing the logs on
> disk and the one retrieving them and showing them to the user. It's by no
> way a kernel problem.

I'd agree, but what about dmesg?  It reads directly from the kernel and
it is commonly run with output to a tty.  OK, maybe dmesg (the userspace
program) should be fixed.

> Thus, 1 and 2 could be merged by escaping ...

Yes.

In fact, if you do the escaping right when substituting values for "%s",
then you'll cover (3) as well.

You probably don't want to modify the behavior of vsnprintf() for all of
the kernel; you only want to affect its behavior when called from
printk().  So you might need to be calling a private function instead,
which would accept an additional argument, and make vsnprintf() a
wrapper around that function.  Yes, that would be a hack.

Alternatively, you can do the escaping right after the vsnprintf() call,
but then it will affect more than just "%s".  I am not sure whether this
is acceptable.

> I don't think we will have to escape the escape char itself. I know that
> this is dirty and will not make it reliable to reverse the string, but
> we need to keep in mind that what we are trying to do is not preventing
> users from hiding their programs' exact names, but preventing them from
> faking logs. Moreover, sysklogd does not escape the escape char either,
> so we are not introducing a new weakness by doing this.

I agree.

Thanks,

Alexander
