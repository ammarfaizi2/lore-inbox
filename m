Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWCGAnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWCGAnQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWCGAnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:43:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932531AbWCGAnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:43:15 -0500
Date: Mon, 6 Mar 2006 16:41:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: fix usbmixer double kfree.
Message-Id: <20060306164111.5510fc09.akpm@osdl.org>
In-Reply-To: <20060306084951.GA15905@redhat.com>
References: <20060306084951.GA15905@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> snd_ctl_add() kfree's the kcontrol already if we fail there,
> so this driver is currently doing a double kfree.

Well sometimes it does.  If we hit one of those snd_assert() abominations,
snd_ctl_add() will return error without freeing the kcontrol.

Still, a leak is better than a double-free.

> --- linux-2.6/sound/usb/usbmixer.c~	2006-03-06 03:40:20.000000000 -0500
> +++ linux-2.6/sound/usb/usbmixer.c	2006-03-06 03:45:03.000000000 -0500
> @@ -434,7 +434,6 @@ static int add_control_to_empty(struct m
>  		kctl->id.index++;
>  	if ((err = snd_ctl_add(state->chip->card, kctl)) < 0) {
>  		snd_printd(KERN_ERR "cannot add control (err = %d)\n", err);
> -		snd_ctl_free_one(kctl);
>  		return err;
>  	}
>  	cval->elem_id = &kctl->id;

