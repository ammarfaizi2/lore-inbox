Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTEQLJu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 07:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbTEQLJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 07:09:49 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:60306 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261414AbTEQLJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 07:09:47 -0400
To: linux-kernel@vger.kernel.org
Subject: Scheduling problem with 2.4?
Reply-To: dak@gnu.org
From: David.Kastrup@t-online.de (David Kastrup)
Date: 17 May 2003 13:22:23 +0200
Message-ID: <x54r3tddhs.fsf@lola.goethe.zz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a problem with Emacs which crawls when used as a shell.  If I
call M-x shell RET and then do something like
hexdump -v /dev/null|dd count=100k bs=1
then characters appear rather slowly at first, most of them in single
character packets, with an occasional 1024 packet in between.  More
of them at the end.  The rate of the packets does not exceed 100/sec.

Other operating systems do not exhibit this extreme case of
throttling.  Emacs is using select calls AFAICS for dealing with
packets arriving, and it would appear that the delivering process
causes a context switch immediately when writing its single byte to
the pipe or is taken from the run queue while the select call is
pending.  Whatever.  In the ensuing time slice, Emacs processes the
single arriving byte and then enters the select call again.

Now that the pipe is not allowed to fill up in most cases (most: in
some, increasingly more at the later time, the pipe gets filled
alternately complete and with single bytes) before a context switch
occurs is already unfortunate with regard to the efficiency of
processing.  What is quite more of a nuisance is the apparent
throttling to a single byte per clock tick: the CPU is idling most of
the time.  It would be unfortunate enough if it were going full blast
at processing 1-byte packets, but most of the time it does nothing
but wait for the next tick.

Now I would want to

a) get sufficient information about what might go wrong inside of
Linux as compared to other operating systems.

b) find a good workaround for not triggering this kind of behavior.

I don't have sufficient kernel experience to debug this one, and it
definitely impacts the speed of operations severely, and in close
cooperation with the operating system.  So any pointers would be
welcome.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
