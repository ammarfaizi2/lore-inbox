Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWF1D33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWF1D33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 23:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWF1D33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 23:29:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:49472 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751041AbWF1D33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 23:29:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GfLV53on4d6N+U+DslF6udrV/wp2aslfx5dxs49PHRSgLi4eqm6to+NHFOP6AknTL31QFG5ot4u/NovqeBq2f71ux5M3U4zYgGxJHbU13lr/yWkWuGSswp+1etzWOmJXehvCMXR0pyGDibCEXinQn/pGRXA+82H1MG0ToaXtN3I=
Message-ID: <9e4733910606272029r32255d27we6e8b34a4c2e569@mail.gmail.com>
Date: Tue, 27 Jun 2006 23:29:28 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Paul Fulghum" <paulkf@microgate.com>
Subject: Re: tty_mutex and tty_old_pgrp
Cc: lkml <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <44A1B79F.9020204@microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910606261538i584e2203o9555d77094de6fe7@mail.gmail.com>
	 <44A1B79F.9020204@microgate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/06, Paul Fulghum <paulkf@microgate.com> wrote:
> No one has leaped in here with any wisdom, but the people
> who wrote that code may be dead or otherwise employed.
>
> If you have knowledge of how those bits work,
> I encourage to you dig through the code and determine
> what needs to be done. It is certainly an area that can
> use more review.
>
> I did see a comment that tty_mutex protects the creation
> and destruction of tty structures, so I assume the coverage
> of tty_old_pgrp has some relation to that. Unfortunately,
> I have seen other locks get borrowed for multiple purposes.

I'm having trouble divining the use of tty_mutex. In most cases it is
protecting pgrp, tty_old_pgrp and tty fields in signal_struct.
sys_setsid(), disassociate_ctty(), daemonize(), tty::release_dev(),
tty_open() use it this way. But it is also used to protect
tty::init_dev() which makes no use of the signal_struct fields. Then
there is the use in vt::con_close() which also does not involved the
signal_struct fields.

Why does this need to be protected? exit.c
	mutex_lock(&tty_mutex);
	current->signal->tty = NULL;
	mutex_unlock(&tty_mutex);

After looking at all of this for a couple of hours it looks to me like
tty_mutex could be removed if ref counts were used to control when the
tty_struct gets destroyed. I think the problem being addressed is
dangling pointers in signal_struct::tty when a tty is being closed.
Ref counts would delay the freeing of tty_struct until all the
references were released.

-- 
Jon Smirl
jonsmirl@gmail.com
