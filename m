Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTKKPDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTKKPDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:03:04 -0500
Received: from users.linvision.com ([62.58.92.114]:22915 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263537AbTKKPC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:02:58 -0500
Date: Tue, 11 Nov 2003 16:02:56 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031111150256.GA13283@bitwizard.nl>
References: <Qvw7.5Qf.9@gated-at.bofh.it> <QH4e.eV.3@gated-at.bofh.it> <3FB0EE0E.6090103@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB0EE0E.6090103@softhome.net>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 03:11:26PM +0100, Ihar 'Philips' Filipau wrote:
> Rogier Wolff wrote:
> >But alas, last time Linus didn't agree with me and decided we should
> >do something like "sendfile", which is IMHO just a special case of
> >this one.
> >
> 
>   I will reply on behalf of Linus: "Send patch!"
> 
>   I beleive you are not developer - so you even cannot estimate what 
> you are proposing.

Wrong.

>   This kind of patch will never be accepted.

Yes. As I said: Linus doesn't agree with me. I don't sleep less from
knowing that. Feel free to disagree with me as well. 

>   Just try to imagine: 20 file systems, so 20*20 == 400 ifs?

Right! And: Wrong!

The idea is that the default will make sure that the kernel handles
the call. It's just as efficient as the userspace implementation.

But currently we have decided that the extra efficiency of 

	"local file -> socket" 

matters enough to us that we want to optimize that case. Fine. So now
we have "sendfile". This is currently implemented as a special
systemcall. I.e. one of those 400 cases you mentioned. 

But I expect that only a few cases will be important enough
that we care to optimize their implementation. 

If we end up with 400 ifs, because we CAN optimize each and every case
by itself, and we find that important enough to actually implement,
then of course the "string of ifs" is a nice candidate to optimize
again.

>   So I beleive you will get more more positive responses, If you will 
> start improveing vfs, e.g. adding generic routines for optimized move of 
> file from one file system to another, with API which allow it to 
> extrapolate nicely to networked file systems.

Once my proposed "copy_fd_to_fd" is in place, the road is open towards
just leaving the current special case that detects: "src uses pagecache
dst is a socket" and then calls the current sendfile implementation.


>    Silly. cp is least frequent application I use.

Yeah. So? You reject a general idea just because you don't use the
application that I used as an example in my proposal.

>    And cvs I beleive already uses sendfile().

Fine. For compatibilty we'll leave "sendfile" in place. But if somehow
someone builds a filesystem which cannot use the pagecache, then
"sendfile" will fail. Or if somehow we manage to get the socket hooked
up to something else (*). Either CVS needs to handle that case
internally, or it will fail. In the first case, that causes extra code
in lots of applications that want to continue to work, in the latter
case, it's bad.

			Roger. 

(*) Suppose I manage to stop and restart an application. The "restart"
program might need to "sit between" the original application and its
filedescriptors. So now, what used to be a socket suddenly becomes a
pipe. It'd be nice if things would continue to work. Everything is a
file remember?

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
