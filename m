Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVBAPZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVBAPZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVBAPZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:25:28 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:11980 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262039AbVBAPYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 10:24:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Altva82CScn0472ptCwdRjivse8dm4azDfzcD0uabAyekiG6LEegZ2Lho/X/HKm9XDt45n8H5NWI+yF3K2DyLOycDd5xy5QOjxxSG8Zw/1H/ouC4HxZh+RTJUc8xh9D+MiDoisVjDI3UmkTgN5V5buoeuAcPui/0isf7bN1D/94=
Message-ID: <d120d500050201072413193c62@mail.gmail.com>
Date: Tue, 1 Feb 2005 10:24:39 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: David Fries <dfries@mail.win.org>
Subject: Re: [PATCH] Linux joydev joystick disconnect patch 2.6.11-rc2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20050201145215.GA29942@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041123212813.GA3196@spacedout.fries.net>
	 <20050201145215.GA29942@spacedout.fries.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005 08:52:15 -0600, David Fries <dfries@mail.win.org> wrote:
> Currently a blocking read, select, or poll call will not return if a
> joystick device is unplugged.  This patch allows them to return.
> 
...
> static unsigned int joydev_poll(struct file *file, poll_table *wait)
> {
> +       int mask = 0;
>        struct joydev_list *list = file->private_data;
>        poll_wait(file, &list->joydev->wait, wait);
> -       if (list->head != list->tail || list->startup < list->joydev->nabs + list->joydev->nkey)
> -               return POLLIN | POLLRDNORM;
> -       return 0;
> +       if(!list->joydev->exist)
> +               mask |= POLLERR;

Probably need POLLHUP in addition (or instead of POLLERR).

>        if (joydev->open)
> +       {
>                input_close_device(handle);
> +               wake_up_interruptible(&joydev->wait);
> +       }
>        else
> +       {
>                joydev_free(joydev);
> +       }

Opening braces should go on the same line as the statement (if (...) {).
-- 
Dmitry
