Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133029AbRA0QUW>; Sat, 27 Jan 2001 11:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135181AbRA0QUM>; Sat, 27 Jan 2001 11:20:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47629 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S133029AbRA0QTy>; Sat, 27 Jan 2001 11:19:54 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: ps hang in 241-pre10
Date: 27 Jan 2001 08:19:42 -0800
Organization: Transmeta Corporation
Message-ID: <94useu$etc$1@penguin.transmeta.com>
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <20010126204324.B10046@vitelus.com> <3A72817E.CFCF0D52@pobox.com> <3A7285D4.9409E63A@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A7285D4.9409E63A@linux.com>, David Ford  <david@linux.com> wrote:
>I can quickly and easily duplicate it on my notebook by playing music or
>mpegs in xmms.  It may take a few minutes but it's guaranteed.
>
>xmms stalls flat on it's face and anything accessing /proc stalls.  If I get
>the time to do it, I'll take a gander at it with kdb.

Please, if you see something like this, just do a simple
<Alt+ScrollLock> followed by <Ctrl+ScrollLock> while in text-mode. The
magic keystrokes will give a stack trace of the currently running
process and all processes respectively.

Then, just look in your /var/log/messages, and if you have everything
set up correctly the system should have done the conversion to symbolic
kernel addresses for you - so you can see directly where the different
processes are sleeping.

Sanity-check that your System.map information (and thus the symbolic
conversion) ooks to be ok: the processes that hang should show up in the
trace as being in __down_failed() or something like that. Tha only
reason for a hang with /proc/<pid>/ tends to be that some process would
have deadlocked on it's MM semaphore or is somehow stuck inside it's
critical region on something else.

Finally, try to pinpoint _which_ process it is. Usully most easily done
by simply seeing where it is that the /proc accesses get stuck, with
something simple like

	cd /proc
	for i in [0-9]*; do
	  echo $i
	  cat $i/stat > /dev/null
	done

and see what the last pid it printed out was (not that the above
guarantees that you found the thing, because there might be several
things. But it's one more piece to the puzzle).

And send the information to the kernel mailing list, along with anything
else you might think of.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
