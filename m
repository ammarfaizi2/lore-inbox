Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWE2Sn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWE2Sn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 14:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWE2Sn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 14:43:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63441 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751173AbWE2Sn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 14:43:59 -0400
Date: Mon, 29 May 2006 11:47:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: mingo@elte.hu, perex@suse.cz, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: 2.6.17-rc4-mm3-lockdep BUG: possible deadlock detected!
Message-Id: <20060529114749.ba020660.akpm@osdl.org>
In-Reply-To: <6bffcb0e0605291132u701cd69tb855cf60fa317994@mail.gmail.com>
References: <6bffcb0e0605291132u701cd69tb855cf60fa317994@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 20:32:47 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> I get this with Ingo's lockdep patch from
> http://people.redhat.com/mingo/generic-irq-subsystem/
> 
> ====================================
> [ BUG: possible deadlock detected! ]
> ------------------------------------
> modprobe/592 is trying to acquire lock:
>  (&grp->list_mutex){----}, at: [<fd9ee555>]
> snd_seq_port_connect+0xc0/0x337 [snd_seq]
> 
> but task is already holding lock:
>  (&grp->list_mutex){----}, at: [<fd9ee4fb>]
> snd_seq_port_connect+0x66/0x337 [snd_seq]
> 
> which could potentially lead to deadlocks!
> 
> other info that might help us debug this:
> 1 locks held by modprobe/592:
>  #0:  (&grp->list_mutex){----}, at: [<fd9ee4fb>]
> snd_seq_port_connect+0x66/0x337 [snd_seq]

yes,

        down_write(&src->list_mutex);
        down_write(&dest->list_mutex);

I wonder if there's anything which prevents another task from concurrently
coming in and trying to perform the opposite connection and causing a
deadlock.

The way we normally handle this is

	if (src < dest) {
		down_write(&src->list_mutex);
		down_write(&dest->list_mutex);
	} else {
		down_write(&dest->list_mutex);
		down_write(&src->list_mutex);
	}
