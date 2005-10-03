Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVJCPT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVJCPT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVJCPTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:19:54 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:9536 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751105AbVJCPTw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:19:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YoGhy37hnQ0g4Ryh8QUBa06bia1r/X7juu4UAtG4LIj+/c3WYSL3jjUnmx89OR3fHG/hjpExHqJSlalLMk9a0xNEsg8WzzIHCNgU9vGbu7DxnsOXaw12hIFaS8X2c6hxbOZ+YnTX4303cMGod0W9oUI0kRZSE6h+wCiupLeaEks=
Message-ID: <355e5e5e0510030819od4ef8e5l93708588990081da@mail.gmail.com>
Date: Mon, 3 Oct 2005 11:19:51 -0400
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: Lukasz Kosewski <lkosewsk@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] Add disk hotswap support to libata RESEND #5
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <1127949651.26686.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <355e5e5e05092618018840fc3@mail.gmail.com>
	 <433AEAAE.2070003@pobox.com>
	 <1127949651.26686.11.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Alan,

On 9/28/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> For PATA the requirements I'm aware of are
>
> -       Interface for user to say "am about to swap"

You mean something like "echo scsi-remove-single-device a b c d" >
/proc/scsi/scsi?  I guess the sysfs equivalent?

> -       Interface for user to say "have swapped"

I suppose ditto.

> -       Must quiesce both master and slave before swap (or one per cable)

The way I've written my infrastructure, this seems as if it'll just
require another carefully placed hook function.

> -       Must reset to PIO_SLOW and then recompute modes for both devices
> becuse it is possible that changing one changes the other timings

This shouldn't be hard since I already do a similar reset by resetting
udma_flags to a pre-init state.  Probably in an if (!(ap->flags &
ATA_FLAG_SATA)).

> -       The above is true for *unplug* too. A straight unplug may speed up the
> other drive!
> -       Post hotswap need to reconfigure both drives as if from scratch

Hmm, this seems far more complicated... basically during a swap
operation, we have to shut down all I/O to the other drive on the
cable (if there is one), if I read you correctly, and then reconfigure
both drives once one is plugged in.

>From what you're saying, it seems to me that the infrastructure I put
forth will work as is, plus some if statements and extraneous
PATA-only functions (and functionality like shutting down the other
disk on the cable until the user calls the 'warm-swap complete'
function').

How about this; I want this SATA hotswapping stuff to be tested, so
I'll commit my patches for 'SATA only' for the time being.  I'll stare
at them for a while and then see what kind of PATA-specific if
statements and hooks are necessary in the code?

Luke
