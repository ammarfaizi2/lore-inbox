Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRCRCWV>; Sat, 17 Mar 2001 21:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRCRCWL>; Sat, 17 Mar 2001 21:22:11 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:24591 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S129242AbRCRCWA>; Sat, 17 Mar 2001 21:22:00 -0500
To: paulus@linuxcare.com.au
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: PATCH against 2.4.2: TTY hangup on PPP channel corrupts kernel memory
In-Reply-To: <vbaofv1nyza.fsf@mozart.stat.wisc.edu>
	<15027.20462.682109.679714@argo.linuxcare.com.au>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Paul Mackerras's message of "Sat, 17 Mar 2001 22:52:14 +1100 (EST)"
Date: 17 Mar 2001 20:21:10 -0600
Message-ID: <vbasnkblsvd.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@linuxcare.com.au> writes:
> 
> But the waiting process must have had an instance of /dev/ppp open and
> attached to the channel in order to be doing anything with rwait,
> within either ppp_file_read or ppp_poll.  The process of attaching to
> the channel increases its refcnt, meaning that the channel shouldn't
> be destroyed until the instance of /dev/ppp is closed and ppp_release
> is called.

Ugh...  I duplicated the hangs and verified my patch fixed them under
kernel 2.4.0 with "pppd" 2.3.11; and I also verified that kernel 2.4.2
with my patch and "pppd" 2.4.0f correctly deferred channel destruction
on modem hangup.  However, I forget to double-check that the hangs
were actually still possible with 2.4.2 and "pppd" 2.4.0f.

I didn't realize my specific hang was a peculiarity of the older
attachment style.  The channel created by pushing the PPP line
discipline onto a TTY was connected to a unit with a PPPIOCATTACH
ioctl on the TTY---this didn't really "attach" the channel; it still
had a refcnt of only one.  Through the old compatibility interface, it
was possible to call ppp_asynctty_read -> ppp_channel_read -> ppp_read
on the channel's "struct ppp_file" and wait on the channel's "rwait".
If the modem hung up, "do_tty_hangup" would call "ppp_asynctty_close"
(with a reader still in "ppp_asynctty_read") and the "struct channel"
would be freed in "ppp_unregister_channel".

I think your analysis of how things presently are with 2.4.2 and a
modern "pppd" is correct...

Since the new "pppd" uses an explicit PPPIOCATTCHAN / PPPIOCCONNECT
sequence, the refcnt gets bumped to 2 and stays there while the
channel is attached.  So, this specific hang isn't a problem anymore
for "ppp_async.c".  It's still a problem with "ppp_synctty.c", though
(when used with "pppd" 2.3.11, say).  Is the compatibility stuff in
there slated for removal, too?

> I presume that the generic file descriptor code ensures that the file
> release function doesn't get called while any task is inside the read
> or write function for that file, or while the file descriptor is in
> use in a select or poll.

It's not the file "release" function that's the problem.  It's the
line discipline's "close" call.  On a real hardware hangup, The kernel
thread "eventd" calls "do_tty_hangup" which grabs the big kernel lock
and calls ppp_asynctty_close.  I believe any line discipline or
"/dev/ppp" file function that sleeps (and so gives up its big kernel
lock) with refcnt == 1 is susceptible to having the "struct channel"
pulled out from under it.

In particular, the comment above "ppp_asynctty_close" is misleading.
It's true that the TTY layer won't call any further line discipline
entries while the "close" is executing; however, there may be
processes already sleeping in line discipline functions called before
the hangup.  For example, "ppp_asynctty_close" could be called while
we sleep in the "get_user" in "ppp_channel_ioctl" (called from
"ppp_asynctty_ioctl").  Therefore, calling "PPPIOCATTACH" on an
unattached PPP-disciplined TTY could, in unlikely circumstances
(argument swapped out), lead to a crash.

In fact, I think the only remaining PPP locking problem in
"ppp_async.c" still in 2.4.2 has to do with those PPPIOCATTACH/DETACH
ioctls for the TTY.  They seem to be the only way someone can
reference the "struct channel" of an unattached channel.

I assume PPPIOCATTACH (on the TTY) is deprecated in favor of
PPPIOCATTCHAN / PPPIOCCONNECT (on the "/dev/ppp" handle).  Can we
eliminate "ppp_channel_ioctl" from "ppp_async.c" entirely, as in the
patch below?  We're requiring people to upgrade to "pppd" 2.4.0
anyway, and it has no need for these calls.  This would give me a warm,
fuzzy feeling.

Kevin <buhr@stat.wisc.edu>

                        *       *       *

--- linux-2.4.2/drivers/net/ppp_async.c	Sun Mar  4 20:09:19 2001
+++ linux-2.4.2-local/drivers/net/ppp_async.c	Sat Mar 17 20:11:45 2001
@@ -244,11 +244,6 @@
 		err = 0;
 		break;
 
-	case PPPIOCATTACH:
-	case PPPIOCDETACH:
-		err = ppp_channel_ioctl(&ap->chan, cmd, arg);
-		break;
-
 	default:
 		err = -ENOIOCTLCMD;
 	}
