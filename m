Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265136AbUGCO63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUGCO63 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 10:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUGCO63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 10:58:29 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6066 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265136AbUGCO6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 10:58:19 -0400
Date: Sat, 3 Jul 2004 16:58:10 +0200 (MEST)
Message-Id: <200407031458.i63EwAGO023123@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ahu@ds9a.nl
Subject: Re: small perfctr bug or misunderstanding
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jul 2004 16:08:29 +0200, bert hubert wrote:
>Mikael, thanks for the low-level-api.txt documentation. Will vperfctr_* see
>some documentation? Want me to whip up manpages?

Docs for the syscalls will appear shortly.

>So far perfctr has been very useful to me already - I now know parts of
>PowerDNS that are completely memory bound, which I so far only suspected.
>Are the global counters available? There is a note in the perfctl
>distribution that says they aren't?

Currently no; I removed them while we've been debating the
API to the (IMO more important) per-process counters.
I intend to add them back once the current stuff has been
Linus-approved.

>One thing - on my Pentium M I'm unable to get more than one counter going
>simultaneously, I get 'Operation not permitted'. Perfex reports that
>supposedly two are possible.

Classic beginner's mistake :-)

>  void addCounter(unsigned int v, unsigned int unit=0) 
>  {
>    int count=d_control.cpu_control.nractrs;
>
>    d_control.cpu_control.evntsel[count] = v | (1 << 16) | (1 << 22) | (unit << 8); 
>    d_control.cpu_control.pmc_map[count] = count;
>    d_control.cpu_control.nractrs++; // no support for .nrictrs
>  }

Quoting from Documentation/perfctr/low-level-x86.txt:

>Intel P6
>--------
>The evntsel values are mapped directly onto the counters'
>EVNTSEL control registers.
>
>The global enable bit (22) in EVNTSEL0 must be set. That bit is
>reserved in EVNTSEL1.
>...
>AMD K7/K8
>---------
>Similar to Intel P6. The main difference is that each evntsel has
>its own enable bit, which must be set.

The driver sees ENABLE set in EVNTSEL1 on your P-M,
and properly returns an error.

The proper way is for user-space to consider a set of
events (not yet added to the control struct), and to
use the current CPU type to format the control and
handle any quirks. For P6 vs K7 the differences are
minor, but to program the P4 you _really_ need helper
procedures.

/Mikael
