Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVFOUdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVFOUdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVFOUdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:33:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261542AbVFOUc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:32:56 -0400
Date: Wed, 15 Jun 2005 13:33:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org, vojtech@ucw.cz
Subject: Re: [patch 1/2] pcspeaker driver update
Message-Id: <20050615133338.398febbc.akpm@osdl.org>
In-Reply-To: <42B056A3.4040202@aknet.ru>
References: <42AF2454.8090806@aknet.ru>
	<20050614134518.68df565d.akpm@osdl.org>
	<42B056A3.4040202@aknet.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> Andrew Morton wrote:
> >> Attached one is just a clean-up:
> >>  it removes the extern definitions
> >>  for the i8253_lock and i8259A_lock,
> >>  making the use of the appropriate
> >>  headers instead.
> > A nice cleanup to make, however we cannot include asm/timer.h from generic
> > code, because only a few architectures have such a file.
> OK, what a bugger...
> Does the attached one look any better?

Well not really - for example you now have drivers/input/joystick/analog.c
including asm/8253pit.h, which not all architectures implement.

The basic problem is that we have generic code referring to an x86-specific
lock inside `#ifdef __i386__'.

Perhaps what you could do is to declare those locks in
include/asm-i386/hardirq.h and then make sure that all the relevant files
include <linux/hardirq.h>.  That's a bit of an abuse of hardirq.h, but we
don't have a generic "platform.h" place to put things like this.

If abusing hardirq.h offends you then you could make sure that all
architectures implement asm/rtc.h (most already do) (just copy
include/asm-alpha/rtc.h) and put the declarations in
include/asm-i386/rtc.h, which is more appropriate.

Whichever way you go, please check that x86_64 works OK too.
