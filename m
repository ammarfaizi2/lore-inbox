Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUIPEvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUIPEvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 00:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUIPEux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 00:50:53 -0400
Received: from mail.joq.us ([67.65.12.105]:20376 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S267464AbUIPEst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 00:48:49 -0400
To: Jody McIntyre <realtime-lsm@modernduck.com>
Cc: James Morris <jmorris@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <Xine.LNX.4.44.0409120956150.16684-100000@thoron.boston.redhat.com>
	<871xh7thzx.fsf@sulphur.joq.us>
	<20040916023118.GE2945@conscoop.ottawa.on.ca>
From: "Jack O'Quin" <joq@io.com>
Date: 15 Sep 2004 23:48:29 -0500
In-Reply-To: <20040916023118.GE2945@conscoop.ottawa.on.ca>
Message-ID: <87d60mrf8i.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody McIntyre <realtime-lsm@modernduck.com> writes:

> On Sun, Sep 12, 2004 at 02:16:50PM -0500, Jack O'Quin wrote:
> 
> > I have not implemented that yet because (1) the current approach has
> > proven adequate for the Linux audio user community, and (2) I haven't
> > wanted to spend time mastering the internal kernel interfaces for
> > accessing /proc from an LSM.  I know it's not difficult, but I had
> > other things I'd rather do.  :-)
> 
> Here's a patch based on the one posted in
> <1095117752.1360.5.camel@krustophenia.net> that adds a sysctl
> (/proc/sys) interface.  These sysctls don't seem to fit into any of the
> existing groups, so I added CTL_SECURITY (/proc/sys/security).
> 
> Example:
> 
> # modprobe realtime
> # echo 29 > /proc/sys/security/realtime/gid

Thanks!  That's even cleaner than I had realized.  I like it.

What are the serialization issues with variable updates via /proc?  I
presume they can change at any time, even while the LSM is running on
some other processor.  If so, I'll need to be careful to fetch each
variable only once and use that value for the entire capability
computation, right?  That should be straightforward.

The only LSM option that doesn't fit this model is `allcaps', which
only functions at initialization time (by adding CAP_SETPCAP to the
capability bounds).  My initial thought is that we probably don't want
that to change via /proc, so just leave it out of the sysctl list.

But, perhaps we should consider removing this option entirely.  It is
the only one with a potentially serious security exposure.  The others
at worst allow Denial of Service attacks.

`Allcaps' is there for compatibility with 2.4 kernels with the so-
called "capabilities patch".  Many Linux audio users run that way so
they can use the JACK Audio Connection Kit without being root.  With
`allcaps' the same methods work with either kernel.  This is not
strictly necessary, because the Realtime LSM provides the required
capabilities without `allcaps'.  But, it is convenient for people like
me who maintain programs on both kernel versions and frequently switch
back and forth for testing purposes.

Because 2.4 with the low-latency patches provides outstanding realtime
performance, many serious audio users have not yet moved to 2.6.  With
the excellent results recently reported with 2.6 patched for low
latency, that may soon change (especially when some of these patches
have been integrated into the mainline kernel).

Since the long-term need for `allcaps' is unclear, maybe it should be
enabled by a separate `experimental' Kconfig option accompanied with
appropriate security warnings.  Eventually, we might want to phase it
out entirely.
-- 
  joq
