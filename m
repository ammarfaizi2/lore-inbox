Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263407AbVBDRjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbVBDRjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263835AbVBDRY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:24:56 -0500
Received: from mail.joq.us ([67.65.12.105]:16009 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S265863AbVBDRUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:20:14 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <42014C10.60407@bigpond.net.au>
	<200502022303.j12N3nZa002055@localhost.localdomain>
	<20050203213645.GB27255@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Fri, 04 Feb 2005 11:21:37 -0600
Message-ID: <87wtto5jha.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> i believe RT-LSM provides a way to solve this cleanly: you can make your
> audio app setguid-audio (note: NOT setuid), and make the audio group
> have CAP_SYS_NICE-equivalent privilege via the RT-LSM, and then you
> could have a finegrained per-app way of enabling SCHED_FIFO scheduling,
> without giving _users_ the blanket permission to SCHED_FIFO. Ok?

Yes, we designed the module with this scenario specifically in mind.

> this way if jackd (or a client) gets run by _any_ user, all jackd
> processes will be part of the audio group and can do SCHED_FIFO - but
> users are not automatically trusted with SCHED_FIFO.
>
> you are currently using RT-LSM to enable a user to do SCHED_FIFO, right? 
> I think the above mechanism is more secure and more finegrained than
> that.

We *are* doing that (based on group membership).  We designed it just
as you say.  And it works fine for Qt and command line clients.

Unfortunately, GTK+ refuses to cooperate.  It has a special check at
startup (in gtkmain)...

  if (ruid != euid || ruid != suid ||
      rgid != egid || rgid != sgid)
    {
      g_warning ("This process is currently running setuid or setgid.\n"
		 "This is not a supported use of GTK+. You must create a helper\n"
		 "program instead. For further details, see:\n\n"
		 "    http://www.gtk.org/setuid.html\n\n"
		 "Refusing to initialize GTK+.");
      exit (1);
    }

Note that this calls *exit(1)*, not just returning an error code.
Following the suggested URL, <http://www.gtk.org/setuid.html>, reveals
their understandable, but basically wrong-headed, rationale...

  GTK+ supports the environment variable GTK_MODULES which specifies
  arbitrary dynamic modules to be loaded and executed when GTK+ is
  initialized. It is somewhat similar to the LD_PRELOAD environment
  variable. However, this (and similar functionality such as
  specifying theme engines) is not disabled when running setuid or
  setgid. Is this a security hole? No. Writing setuid and setgid
  programs using GTK+ is bad idea and will never be supported by the
  GTK+ team.

They are wrong (IMHO), because these kinds of security tests *cannot*
reliably be done in userspace.  They are not testing for possession of
privileges, but merely disallowing two of a half-dozen ways of
granting those privileges.  Why should it be OK to run GTK as `root',
but not as setgid `audio'?  Ironically, people don't run GTK threads
with SCHED_FIFO.  Those are precisely the threads over which the
signal processing threads need to have priority.

This "feature" has forced us to fall back on supplementary groups for
our main authorization mechanism.  That is unfortunate because, as you
say, the setgid() approach has finer granularity, which is better.
So, that GTK test has the unintended consequence of making our
security exposure larger, not smaller.

We can live with this, mainly because our users often need
supplementary membership in group `audio' anyway, to gain access to
the sound card.

If we can ever convince the GTK developers to remove this "feature",
the RT-LSM handles setgid() correctly.  So, we could immediately start
using it (at least on systems with a new enough GTK library to permit
that).
-- 
  joq
