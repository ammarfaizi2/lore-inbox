Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWCGWDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWCGWDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWCGWDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:03:35 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:29906 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S1751481AbWCGWDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:03:35 -0500
Subject: 2.6.15-rt18, alsa sequencer, rosegarden -> alsa hangs
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Cc: cc@ccrma.Stanford.EDU, nando@ccrma.Stanford.EDU
Content-Type: text/plain
Date: Tue, 07 Mar 2006 14:03:20 -0800
Message-Id: <1141769000.5565.21.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I don't know where to go from here...

I'm trying to get a 2.6.15-rt18 kernel going and I'm finding a big
showstopper in the alsa sequencer, presumably at the kernel module
level. This is -rt18 with PREEMPT_RT and high resolution timers enabled,
plus either alsa kernel drivers from 1.0.10 (latest stable release) or
1.0.11rc3. Same problem for both. I initially thought that the
snd-rtctimer kernel module was a problem so the latest tests were done
with that module disabled so that the alsa sequencer is using the system
timer for timing (HZ == 1000 for this kernel). 

The symptoms are as follows:
  - start jack using qjackctl
  - start qsynth (gui front end for fluidsynth, a synth)
  - start rosegarden (midi sequencer and audio recorder)
  - load a midi file into rosegarden
  - midi file plays successfully
  - close rosegarden
at this point one of the threads of rosegarden fails to exit and stays
forever in the process list, in a ps axuw it shows as:

nando 5484 0.0 0.0 0 0 pts/1    D    13:32   0:00 [rosegardenseque]

Anything else that I try to stop that touches the alsa sequencer never
dies (qjackctl, vkeybd, qsynth, etc). Anything I try to start that tries
to use it does not start. This happened with two widely different
versions of rosegarden (1.0 and 1.2.3) - I have not yet tried with other
alsa sequencer clients - I tried different kernel builds and alsa builds
before giving up, the cycle is long when I include the frequent reboots.
I can browse around in /proc/asound/seq but a:
  cat /proc/asound/clients
hangs forever (unkillable). Obviously I can't unload the alsa subsystem
to try again. At this point my only recourse to recover is a reboot
(which hangs when trying to stop the alsa subsystem - so the reset key
is the only option). 

There are no kernel oops or messages either in dmesg
or /var/log/messages that I can see. 

Booting into 2.6.14 with the latest -rt patch for that branch does not
show the problem (using alsa kernel modules from 1.0.10 stable). 

The problem happens with at least three completely different soundcards
and two different kernel builds (one kind of vanilla, the other derived
from the latest fc4 kernel configuration and patches).

So it would look like an interaction between the newest -rt patches and
the alsa sequencer timing. Weird because while rosegarden is up and
running it plays midi sequences with no apparent problems, it is only
when it exits that things get completely messed up. 

Suggestions appreciated...
-- Fernando

# cat /proc/asound/seq/timer
Timer for queue 0 : system timer
  Period time : 0.001000000
  Skew : 65536 / 65536

[rosegarden is still there.....]
# cat /proc/asound/seq/queues
queue 0: [Rosegarden queue]
owned by client    : 130
lock status        : Locked
queued time events : 0
queued tick events : 0
timer state        : Running
timer PPQ          : 96
current tempo      : 500000
current BPM        : 120
current time       : 1617.680000000 s
current tick       : 318130

# cat /proc/asound/seq/drivers
snd-seq-oss,loaded,0
snd-seq-midi,loaded,1


