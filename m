Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbRCWEcO>; Thu, 22 Mar 2001 23:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRCWEcF>; Thu, 22 Mar 2001 23:32:05 -0500
Received: from ns1.samba.org ([203.17.0.92]:33368 "HELO au2.samba.org")
	by vger.kernel.org with SMTP id <S129466AbRCWEbz>;
	Thu, 22 Mar 2001 23:31:55 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15034.53871.560040.366149@argo.linuxcare.com.au>
Date: Fri, 23 Mar 2001 15:34:55 +1100 (EST)
To: buhr@stat.wisc.edu (Kevin Buhr)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: PATCH against 2.4.2: TTY hangup on PPP channel corrupts kernel memory
In-Reply-To: <vbasnkblsvd.fsf@mozart.stat.wisc.edu>
In-Reply-To: <vbaofv1nyza.fsf@mozart.stat.wisc.edu>
	<15027.20462.682109.679714@argo.linuxcare.com.au>
	<vbasnkblsvd.fsf@mozart.stat.wisc.edu>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Buhr writes:

> I didn't realize my specific hang was a peculiarity of the older
> attachment style.  The channel created by pushing the PPP line

I didn't realize you were talking about linux 2.4.0 and pppd 2.3.11.

> discipline onto a TTY was connected to a unit with a PPPIOCATTACH
> ioctl on the TTY---this didn't really "attach" the channel; it still
> had a refcnt of only one.  Through the old compatibility interface, it
> was possible to call ppp_asynctty_read -> ppp_channel_read -> ppp_read
> on the channel's "struct ppp_file" and wait on the channel's "rwait".
> If the modem hung up, "do_tty_hangup" would call "ppp_asynctty_close"
> (with a reader still in "ppp_asynctty_read") and the "struct channel"
> would be freed in "ppp_unregister_channel".

That's one of the main reasons why I removed the compatibility
stuff. :)

> I think your analysis of how things presently are with 2.4.2 and a
> modern "pppd" is correct...
> 
> Since the new "pppd" uses an explicit PPPIOCATTCHAN / PPPIOCCONNECT
> sequence, the refcnt gets bumped to 2 and stays there while the
> channel is attached.  So, this specific hang isn't a problem anymore
> for "ppp_async.c".  It's still a problem with "ppp_synctty.c", though
> (when used with "pppd" 2.3.11, say).  Is the compatibility stuff in
> there slated for removal, too?

Yep, and we should take out the stuff in ppp_generic.c that was called
by the compatibility stuff in the channels, too.

> In particular, the comment above "ppp_asynctty_close" is misleading.
> It's true that the TTY layer won't call any further line discipline
> entries while the "close" is executing; however, there may be
> processes already sleeping in line discipline functions called before
> the hangup.  For example, "ppp_asynctty_close" could be called while
> we sleep in the "get_user" in "ppp_channel_ioctl" (called from
> "ppp_asynctty_ioctl").  Therefore, calling "PPPIOCATTACH" on an
> unattached PPP-disciplined TTY could, in unlikely circumstances
> (argument swapped out), lead to a crash.

Yuck.  I don't see that we can protect against this without having
some sort of lock in the tty structure, though.  We can't protect the
existence of the channel structure with a lock inside that structure.
Ideally the necessary protection would be provided at the tty level.

> I assume PPPIOCATTACH (on the TTY) is deprecated in favor of
> PPPIOCATTCHAN / PPPIOCCONNECT (on the "/dev/ppp" handle).  Can we
> eliminate "ppp_channel_ioctl" from "ppp_async.c" entirely, as in the
> patch below?  We're requiring people to upgrade to "pppd" 2.4.0
> anyway, and it has no need for these calls.  This would give me a warm,
> fuzzy feeling.

Sure, that would be fine.  I'll make up a patch and send it to Linus.

Paul.
