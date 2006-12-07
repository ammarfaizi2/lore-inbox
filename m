Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163480AbWLGWZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163480AbWLGWZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163470AbWLGWZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:25:09 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:7307 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163504AbWLGWZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:25:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PW2tzrM/ynhmRasnzhRxVZ6FzuPrzJaKB+/339An1E+mahD4Jt6RLeAHn7Xl0KFknrYWHqGqCmaW3o/1SwCCdojb0hNpVUZsGMHD171zr9vnsOLO5UjBsoz9+0xBdJN5s+M8STgFZLvcH9kUp5Ss1YM6xOONroHCv90EDYOPWE4=
Message-ID: <9a8748490612071425g41eabc1fnf2683e85bde262a8@mail.gmail.com>
Date: Thu, 7 Dec 2006 23:25:07 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: additional oom-killer tuneable worth submitting?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45788E55.5070009@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45785DDD.3000503@nortel.com>
	 <9a8748490612071050q60b378c4ldf039140ffd721be@mail.gmail.com>
	 <457886B4.2030507@nortel.com>
	 <9a8748490612071337p612f7a2t5fd31968a9ff5da9@mail.gmail.com>
	 <45788E55.5070009@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/06, Chris Friesen <cfriesen@nortel.com> wrote:
> Jesper Juhl wrote:
> >> Jesper Juhl wrote:
>
> >> > What happens in the case where the OOM killer really, really needs to
> >> > kill one or more processes since there is not a single drop of memory
> >> > available, but all processes are below their configured thresholds?
>
> > I realize that if this case happens the system is misconfigured as far
> > as oomthresh goes, but if this is a knob that we put in the mainline
> > kernel then I believe there should be some sort of emergency handling
> > code that takes this situation into account.  Perhaps throw some very
> > nasty looking log messages and then fall back to the classic OOM
> > killer behaviour..?
>
> Yeah, I can see that the reboot might be a bit drastic for mainline.  I
> think the fallback to classic behaviour might work okay.
>
> Anyway, the chances of hitting that case are likely pretty slim.  The
> way we've been using this is to only set the threshold for fairly
> important long-lived daemons.  Much of the "standard" stuff (shell, cat,
> cp, mv, etc.) is left unprotected.
>
Sure, that's sensible, to only protect the important stuff.
But even if the chances of hitting this are slim, we still need a way
out. For most people anything is better than a hung box.

Some examples;

 For a desktop (where people may be experimenting with the feature) -
seeing your firefox process evaporate due to the OOM killer and then
finding a message explaining what happened in dmesg is a lot less
frustrating than a hang or sudden reboot.

 For a server - If you mis-configure the new feature you may be in for
a long drive to reboot a box whereas falling back to the classic OOM
killer (+ nasty messages in dmesg) will likely save you the trip and
clue you in as to what you mis-configured.

 For an embedded box - triggering a reboot would probably be better
than both a hang or classic OOM kill in many cases (better to have the
device reboot and come back working than to hang or start
malfunctioning due to a missing process).

So maybe what's needed is an additional knob for people to tweak - one
that selects what should happen in this rare case: 1) fallback to
classic OOM (default), 2) reboot, 3) hang.   In all cases messages
should be logged explaining what happened.
Or is that overkill?  If so I'd personally prefer just falling back to
classic OOM kill in this case.

A way out for the "OOM but all processes below threshold" case +
perhaps coupled with oomthresh applying to process groups instead of
just processes and I personally start to like this feature.

Let's see some code...

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
