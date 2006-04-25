Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWDYRKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWDYRKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWDYRKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:10:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:25869 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932272AbWDYRKU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:10:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Go3TU9p0mORCAjzidqrGA2Z0IenYUzpz/XsZxeAufiO6ehaEZDi8CybwYf7GIPITtGB99XNBqR0JklKUq43ZQa/SeGngBeAkTLG0DYRhSfs7T1jGRZurvqlX1vF/ILPjXinYQpccMdBX4Gboqqfg1P1vA9E3gwj+MUdgTqrE+TA=
Message-ID: <d120d5000604251010kd56580fl37a0d244da1eaf45@mail.gmail.com>
Date: Tue, 25 Apr 2006 13:10:09 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Avi Kivity" <avi@argo.co.il>
Subject: Re: Compiling C++ modules
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <444E524A.10906@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	 <1145911546.1635.54.camel@localhost.localdomain>
	 <444D3D32.1010104@argo.co.il>
	 <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>
	 <444DCAD2.4050906@argo.co.il>
	 <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>
	 <444E524A.10906@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/06, Avi Kivity <avi@argo.co.il> wrote:
> Kyle Moffett wrote:
> > On Apr 25, 2006, at 03:08:02, Avi Kivity wrote:
> >> Kyle Moffett wrote:
> >>> The "advantages" of the former over the latter:
> >>>
> >>> (1)  Without exceptions (which are fragile in a kernel), the former
> >>> can't return an error instead of initializing the Foo.
> >> Don't discount exceptions so fast. They're exactly what makes the
> >> code clearer and more robust.
> >
> > Except making exceptions work in the kernel is exceptionally
> > nontrivial (sorry about the pun).
> My experience with exceptions in kernel-like code (a distributed
> filesystem) was excellent.
> >
> >> A very large proportion of error handling consists of:
> >> - detect the error
> >> - undo local changes (freeing memory and unlocking spinlocks)
> >> - propagate the error/
> >>
> >> Exceptions make that fully automatic. The kernel uses a mix of gotos
> >> and alternate returns which bloat the code and are incredibly error
> >> prone. See the recent 2.6.16.x for examples.
> >
> > You talk about code bloat here.  Which of the following fits better
> > into a 4k stack?
> The C++ code. See below.
> > Which of the following shows the flow of code better?
> Once you accept the idea that an exception can occur (almost) anywhere,
> the C++ code shows you what the code does in the normal case without
> obfuscating it with error handling. Pretend that after every semicolon
> there is a comment of the form:
>
>    /* possible exceptional return */
>
> once you think like that, you can see what the code actually does rather
> than how it handles errors. A 15-line function can do something
> meaningful, not just call two functions.
> >
> > C version:
> >     int result;
> >     spin_lock(&lock);
> >
> >     result = do_something();
> >     if (result)
> >         goto out;
> >
> >     result = do_something_else();
> >     if (result)
> >         goto out;
> >
> >     out:
> >     spin_unlock(&lock);
> >     return result;
> >
> > C++ version:
> >     int result;
> not needed unless you actually return something.
> >     TakeLock l(&lock);
> >
> >     do_something();
> >     do_something_else();
> >
> > First of all, that extra TakeLock object chews up stack, at least 4 or
> > 8 bytes of it, depending on your word size.
> No, it's optimized out. gcc notices that &lock doesn't change and that
> 'l' never escapes the function.

"l" that propects critical section gets thrown away??? What is the
name of the filesystem you ported? I mean, I need to know so I don't
use it by accident.

--
Dmitry
