Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVAKUsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVAKUsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAKUsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:48:45 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:31742 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262161AbVAKUsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:48:19 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: utz lehmann <lkml@s2y4n2c.de>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       Con Kolivas <kernel@kolivas.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87oefw3p7m.fsf@sulphur.joq.us>
References: <200501111305.j0BD58U2000483@localhost.localdomain>
	 <87oefw3p7m.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 21:47:26 +0100
Message-Id: <1105476446.4692.40.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 10:28 -0600, Jack O'Quin wrote:
> Paul Davis <paul@linuxaudiosystems.com> writes:
> 
> >>Rlimits are neither UID/GID or PAM-specific. They fit well within
> >>the general model of UNIX security, extending an existing mechanism
> >>rather than adding a completely new one. That PAM happens to be the
> >>way rlimits are usually administered may be unfortunate, yes, but it
> >>doesn't mean that rlimits is the wrong way.
> 
> PAM is how most GNU/Linux systems manage rlimits.  It is very UID/GID
> oriented.  So from the sysadmin perspective, claiming that rlimits is
> "better" or "easier to manage" than "GID hacks" is bogus.

Why do you have such a problem with a rlimit base approach?
IMHO it's not a hack like realtime LSM, usable for other things beside
pro audio (see "scheduling priorities with rlimit" thread), securer and
more user friendly.

With realtime LSM a user in the realtime group can change the nice
values and RT priorities of other users processes, incl. owned by root
and kernel threads. This has to be fixed. I think this means a rewrite
(not using CAP_SYS_NICE).

It can't be used with distro kernels which have common-caps complied in,
eg. fedora.

IMHO for a possible mainline inclusion the mlock part have to taken away
because RLIMIT_MLOCK is a better solution. A pro audio user have to deal
with rlimits for mlock and realtime LSM for the RT priority part.
Doing both with rlimits is more user friendly. Most of them have only to
put something like this in limits.conf:

me	hard	memlock		500000
me	soft	memlock		500000
me	hard	realtime	60
me	soft	realtime	60

And with rlimits you can drop privileges on process basis. Just set the
hard RLIMIT_RT to 0 (ulimit). You can't do this with realtime LSM.
 
With realtime rlimit you can even think about to give users realtime
prios on a multi user machine. Limit the RT prio for users to 10 and
have a rt-watchdog process with a higher priority which kills runaway
user RT processes.
With realtime LSM you can't limit the RT prio. It's all or nothing.


