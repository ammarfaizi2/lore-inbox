Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263037AbUKSBKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUKSBKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbUKSBGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:06:09 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:42113 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S262993AbUKSBEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:04:49 -0500
Date: Fri, 19 Nov 2004 02:05:08 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable
 braindamage
In-Reply-To: <20041118181540.U28844@almesberger.net>
Message-ID: <Pine.LNX.4.58.0411182256340.3639@be1.lrz>
References: <fa.ev73q5c.ejcnom@ifi.uio.no> <fa.es1mdq5.76ib8j@ifi.uio.no>
 <E1CUtCE-0000us-00@be1.7eggert.dyndns.org> <20041118181540.U28844@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Werner Almesberger wrote:
> Bodo Eggert wrote:

> > You'll have some precompiled binaries causing trouble, while other
> > precompiled binaries will be killed while you want them to stay alife.
> 
> That's why you could use a wrapper.

That's why I thought about a nice-like value.

> > The best solution I can think of is attaching a kill priority (similar to
> > the nice value). Before killing, this value would be added to lg_2(memsize),
> > and the least desirable process would "win", even if it's sshd running wild.
> 
> I'm extremely sceptical about solutions that require the user to
> quantify things. In the world of QoS, if you give users a knob
> to play with, the'll stare at in confusion, and ask for the
> "faster" button. I don't think the OOM case is much different.

> A "victim" (or a "precious") flag has the advantage that the user
> doesn't need to estimate peak demands, but still doesn't depend
> solely on the verdict of some arcane algorithm working behind
> the scenes.

There would usurally be no need to tune. The OOB would select the biggest 
process by default, and it would allmost certainly be the the best 
decision.

If it isn't you'll einther need to flag all suspicious tasks before they 
run and prevent your users from avoiding your wrappers, or you'll need to 
flag the few important "notme"s. But what happens if your "notme" is dhcpd 
running wild (as it just happened to me because it didn't handle 
"permission denied" correctly)? Bye bye userland?

With the "notme"-level, your default system will kill the biggest process.
This will usurally be the best process, but on some systems, it would 
kill the DB engine with the login table instead. You'll need to tune here,
sicne no OS will know when your DB is just big and when it's eating 
memory. In this case, you would adjust only the database process, and 
you'd choose a small value. For a 2-GB-Process to "lose" against a 500 MB 
mozilla, you'll need a "notme"-value ("OOM-Adjustment"?) of -2; -4 would 
be allmost overkill to the system and -sizeof(void*)*8 will create a 
privileged class of processes that will only be killed if all other 
processes are killed (I repeat: you don't want that).

OTOH, there is nothing hindering you from creating goat processes by
running your web-browser on +127, if you like it being killed as soon as
your vi starts eating memory. (Even here I'd limit the value to +2.)


Summary:

The "notme"-value will autotune, while the "victim"-flag needs to be 
adjusted on every system. In rare cases, "notme" will need to be adjusted 
for large daemons, and even in those cases, it won't need much adjustment.
The "notme"-value _is_ more complicated, but you only need to count to 5.

The "victim"-flag can be circumvented by users, while the "notme"-value 
will be as safe as "nice".

The "precious"-flag does not protect against mad processes, while the 
"notme"-value can be adjusted to match your specific need.


Further considerations:

Both systems will need an additional per-process-value, but they can share 
their space with existing flags.
(Even the 8 bit per value I asumed above may be overkill, and they aren't 
supposed to be touched often (set, fork and OOM only).)

You'll usurally want to kill forked processes before the parent (e.g.
inetd), and legacy applications won't adjust the setting for you.
Therefore you'll need a second value for the childs.

The adjustment to OOM-Killer for "victim" is a flag telling you the flag
status of the last found candidate, and it could skip calculating the
memory size if there is a flagged-to-be-better victim.

"notme" will require a level (lg_2()+"notme") instead of the flag, and it
would usurally have to calculate the memory size, especially if the
adjustment is limited to <=5 bit.
-or-
You'd use a larger data type for the calculated memory size and bit-shift 
the result by (adjustment+minval). I guess it's cheaper, but it only 
works for small adjustments (5 or 6 bit, depending on arch).

Both should be easy to implement if somebody else is doing the work.-)



[0] This can be difficult: Shall we kill process A even if most memory is 
shared and we don't gain much? What if it's a large forkbomb?
:(){:|:};:
-- 
'.... now touch these wires to your tongue!' 
