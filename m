Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbUDSLyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 07:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbUDSLyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 07:54:38 -0400
Received: from elma.elma.fi ([192.89.233.77]:51937 "EHLO elma.elma.fi")
	by vger.kernel.org with ESMTP id S264368AbUDSLyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 07:54:32 -0400
Date: Mon, 19 Apr 2004 14:54:30 +0300 (EETDST)
From: Antti Lankila <alankila@elma.net>
To: linux-kernel@vger.kernel.org
Subject: re: elevator=as related to my performance issues
Message-ID: <Pine.A41.4.58.0404191355100.42820@tokka.elma.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm sorry that I can't post this mail in reply to the thread, this is
because I'm not subscribed, so I can't reply.

Here's the news.

Firstly, Nick's proposed change of setting antic_expiry to zero does not appear
to change anything for me. My subjective experience of the behaviour is that
it's just as bad as before, no qualitative changes that I can see.

I'm testing like this: I boot the Linux into X, and run gkrellm to show me
cpu use and system cpu use, and a chart of the IDE disks involved (right now
just 1 disk on the nforce2 system). Then I just shake the mouse and watch
the pointer. Pretty scientific, eh?

First I admit an egg on my face: I noticed that I can get mouse stalls can
occur with the deadline scheduler as well :-( they simply aren't so
pronounced, so I guess that proves that the AS is not at fault.  The
scheduler simply puts through different kind of IO load, and the deadline
profile just seems to hide the issue better, but not solve it, right?

In case of the deadline scheduler, the mouse may stall during the "putc()"
write test and with the "3 thread seek" test. I also once observed it to
stop during the "Writing intelligently" part of the test after the putc()
write. All in all it's a smoother experience, and updatedb doesn't seem to
cause any issues at all.

What I see in gkrellm during the putc() write test is interesting. The mouse
stall is always preceded by disk write activity. First there's just high cpu
load as some buffers get filled, then flushing to disk kicks into action and
usually it goes on for about 2 seconds, and then the mouse stops, usually
only to resume when the disk activity surge stops. The deadline
scheduler produces longer write periods than anticipatory in my case, which
seems to flush more often. Thus anticipatory shows itself off better in this
case. In the other parts, such as rewriting or writing intelligently, it's
bad though, while the deadline seems to take that load with much fewer issues.

Aniticipatory scheduler shows the worst of itself during the "3 thread seek"
test part of bonnie, in my opinion. The mouse is stalled only for brief
periods but it stops moving (and resumes about every second), and even when
moving it tends to be jerky. It's weird, too, the disk shows only small
throughput, and CPU usage would appear to be near zero, at few percent. So
by my accounts the system isn't doing much, just seeking furiously. Yet, it
appears as if this IDE work caused an absolutely huge drain on system
resources. (I do believe that system _throughput_ may be unimpaired, just
that what I do as an user with my mouse is ignored by the OS.)

Here's the system details:

- 512 MB (dual-channel) DDR 400 MHz
- XP 2400+
- Barracuda 7200.7 drive
- 2.6.5 kernel
- geforce4 and nvidia drivers

Hdparm says multcount=16, io-support=1 (32-bit), unmaskirq=1, using_dma=1,
readahead=256. Acoustic management is set to 128 (which should impact seek
performance quite a bit).

There should be no custom tuning on vm parameters. That readahead appears to
be set by the kernel.

Antti
