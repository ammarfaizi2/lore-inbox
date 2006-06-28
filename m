Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWF1KIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWF1KIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 06:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWF1KIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 06:08:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31174 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030499AbWF1KID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 06:08:03 -0400
Subject: Re: tty_mutex and tty_old_pgrp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Paul Fulghum <paulkf@microgate.com>, lkml <linux-kernel@vger.kernel.org>,
       "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <9e4733910606272029r32255d27we6e8b34a4c2e569@mail.gmail.com>
References: <9e4733910606261538i584e2203o9555d77094de6fe7@mail.gmail.com>
	 <44A1B79F.9020204@microgate.com>
	 <9e4733910606272029r32255d27we6e8b34a4c2e569@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jun 2006 11:24:00 +0100
Message-Id: <1151490240.15166.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-27 am 23:29 -0400, ysgrifennodd Jon Smirl:
> Why does this need to be protected? exit.c
> 	mutex_lock(&tty_mutex);
> 	current->signal->tty = NULL;
> 	mutex_unlock(&tty_mutex);

It races against things like a third party haungup of the controlling
tty session if the lock is not held.

> After looking at all of this for a couple of hours it looks to me like
> tty_mutex could be removed if ref counts were used to control when the
> tty_struct gets destroyed. 

You would still want memory barriers and to audit the time things took
effect as there is a fairly defined ordering involved here. Fully
refcounting ttys would not be a bad thing but would require some driver
work because the driver level objects hung off a tty are often not
dynamically allocated and are not themselves refcounted so would get
corrupted if the tty object was freed and a new one allocated and opened
in the meantime.

Alan

