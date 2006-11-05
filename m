Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWKEVeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWKEVeA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 16:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbWKEVeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 16:34:00 -0500
Received: from nz-out-0102.google.com ([64.233.162.196]:41865 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1422683AbWKEVd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 16:33:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mdtTsp1n1z7H2hN9UyZLjTiYK02WAQr+JX7gwEAySxwiXBeTY0TNeiLIoXWEvTasU9uER77nTwwSSY6P50iLXqspYMtHfWeNtN97tPKhf4SOoQaU8WkLUM46Kc4mFgtEnHEZfFERIi3PzBP7VdywXIFlAeakKl7iy7I/sMrtdPM=
Message-ID: <b9481e140611051333p7250179ax6ba3629fcf0ad9e3@mail.gmail.com>
Date: Sun, 5 Nov 2006 22:33:58 +0100
From: "Nicolas FR" <nicolasfr@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: sc3200 cpu + apm module kernel crash
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1162750917.31873.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b9481e140611031506u42e326dbs5c0e97d14c5fb5b3@mail.gmail.com>
	 <1162750917.31873.38.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have finally traced down the bug (Tatung webpad TWN-5213CU with SC3200 CPU):

- in apm_mainloop there is an for(;;) loop, which set a
scheduler_timeout (1second) and then calls apm_event_handler().

- apm_event_handler does some checks and calls check_events();

- check_events has a loop:
	while ((event = get_event()) != 0) { switch (event) {...} }

The module was "crashing" on my box because it keeps on receiving
events=APM_UPDATE_TIME meaning that it would never get out of the
while() loop in check_events. I need to do some tests but I might
simply fix this by ignoring APM_UPDATE_TIME events. I first thought
replacing the "while ((event = get_event()) != 0)" by an "if ((event =
get_event()) != 0)" but maybe I would miss other events doing this?


Best regards,
Nicolas.

PS: btw, thanks for your email that's really nice to answer every
message on this mailing list.

On 11/5/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Sad, 2006-11-04 am 00:06 +0100, ysgrifennodd Nicolas FR:
> > I have thrown a bunch of  "printk(KERN_INFO "apm: I am here\n");" and
> > noticed the crash is happening just when calling apm_event_handler();
> > and does not even execute any instruction in this function... This is
> > the point I don't understand, how can it crash just on calling a
> > function and not executing the first statement in this function?
>
> APM is BIOS code so the assembler inlines trap into the firmware and the
> firmware sometimes isn't very good, particularly the 32bit entry points
> which are not used by a certain other vendors products.
>
> In those cases you need to trace the asm code in the firmware and see if
> the firmware is buggy.
>
>
