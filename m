Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWCHNgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWCHNgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWCHNgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:36:37 -0500
Received: from web26507.mail.ukl.yahoo.com ([217.146.176.44]:43406 "HELO
	web26507.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750779AbWCHNgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:36:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DCq7gUO4wxwabyacLknUolxRzDNl2akPWvjdQOrl3DeG1jDwU2o/IfZLI6AYm4nnmM8pM7OCg+C5vxsdtM5kvPMrU48NmuC/q6m1V62qIckytOoEn3VRm0V7VWy7L/nC8voX8zpsKjkfzhDFSdA9yVwdJGUXSlyzZq5r4LHWm1U=  ;
Message-ID: <20060308133635.96547.qmail@web26507.mail.ukl.yahoo.com>
Date: Wed, 8 Mar 2006 14:36:35 +0100 (CET)
From: karsten wiese <annabellesgarden@yahoo.de>
Subject: RE: [Alsa-devel] Re: 2.6.15-rt18, alsa sequencer, rosegarden -> alsa hangs
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net, cc@ccrma.Stanford.EDU
In-Reply-To: <1141800836.6150.3.camel@cmn3.stanford.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1420263798-1141824995=:96220"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1420263798-1141824995=:96220
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

> > 
> > could you get a tasklist-dump? It's either SysRq-T, or:
> > 
> > 	echo t > /proc/sysrq-trigger
> > 
> > that should dump all tasks and their backtraces -
> including the hung 
> > rosegardensequencer task.
> 
> I'll try to do that tomorrow. 
> 
> In the meanwhile I think this might be the same problem
> that was solved
> in -rt20? (building it as I type). I have been trying to
> catch up to the
> subset of lkml that I manage to read and found some
> reports that
> apparently point to similar problems with the alsa
> sequencer (Rui, in
> particular, and then Karsten's post in this thread).

ALSA Midi sequencer uses tasklets. there are 2 kinds of
them: lo and hi.
In rt-18 PREEMPT-RT, tasklet_hi_schedule() didn't work,
'cause it woke up tasklet_lo's thread.
Thats what my patch fixed.

Before finding the solution, i reduced my testcase
to a simple "aconnect -d" call:
aconnect sends a midi-reset to the client to disconnect via
tasklet_hi then. subsequently aconnect wants to finish, and
cannot: it has to wait for tasklet_hi cleanup, which
doesn't happen, 'cause the wrong thread had been triggered.

Find the corresponding sysrq-t excerpt attached.

      Karsten


	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
--0-1420263798-1141824995=:96220
Content-Type: text/plain; name=dmlog_sysrq_t_exc
Content-Description: 3110844057-dmlog_sysrq_t_exc
Content-Disposition: inline; filename=dmlog_sysrq_t_exc

[  998.876000] aconnect      [f5867010]R C013CF4C [on rq #0]     0  2708   2272                     (NOTLB)
[  998.876000] f3ca1d1c f5867010 c0452ee0 c013cf4c f3ca1000 00000000 f5867148 c0494740 
[  998.876000]        f3ca1d08 f5867010 8ec9c300 000000e8 003d0900 00000000 f3ca1000 0002aa75 
[  998.876000]        00000000 f3ca1d44 c034a6e5 c01279b9 c0494740 f3ca1d58 0002aa73 60000000 
[  998.876000] Call Trace:
[  998.876000]  [<c034a6e5>] schedule+0xa5/0x140 (40)
[  998.876000]  [<c034b0cc>] schedule_timeout+0x4c/0xc0 (52)
[  998.876000]  [<c034b17a>] schedule_timeout_uninterruptible+0x1a/0x20 (8)
[  998.876000]  [<c0128bd8>] msleep+0x28/0x40 (12)
[  998.876000]  [<c0123ddc>] tasklet_kill+0x3c/0x70 (16)
[  998.876000]  [<f88372a3>] snd_rawmidi_drop_output+0x43/0x90 [snd_rawmidi] (32)
[  998.876000]  [<f8837372>] snd_rawmidi_drain_output+0x82/0x180 [snd_rawmidi] (68)
[  998.876000]  [<f8a4c5a7>] midisynth_unuse+0x37/0x80 [snd_seq_midi] (32)
[  998.876000]  [<f8aafb3e>] unsubscribe_port+0x4e/0x100 [snd_seq] (36)
[  998.876000]  [<f8ab0004>] snd_seq_port_disconnect+0x134/0x180 [snd_seq] (60)
[  998.876000]  [<f8aa9eb6>] snd_seq_ioctl_unsubscribe_port+0xe6/0x140 [snd_seq] (132)
[  998.876000]  [<f8aaaf9a>] snd_seq_do_ioctl+0x5a/0xd0 [snd_seq] (36)
[  998.876000]  [<f8aab039>] snd_seq_ioctl+0x29/0x60 [snd_seq] (24)
[  998.876000]  [<c01838a8>] do_ioctl+0x38/0xa0 (36)
[  998.876000]  [<c0183ad0>] vfs_ioctl+0x60/0x200 (40)
[  998.876000]  [<c0183cea>] sys_ioctl+0x7a/0x90 (40)
[  998.876000]  [<c01032db>] sysenter_past_esp+0x54/0x75 (-4020)
[  998.876000] ---------------------------
[  998.876000] | preempt count: 00000002 ]
[  998.876000] | 2-level deep critical section nesting:
[  998.876000] ----------------------------------------
[  998.876000] .. [<c013cf4c>] .... add_preempt_count+0x1c/0x20
[  998.876000] .....[<c0349f7b>] ..   ( <= __schedule+0x4b/0x710)
[  998.876000] .. [<c013cf4c>] .... add_preempt_count+0x1c/0x20
[  998.876000] .....[<c034a021>] ..   ( <= __schedule+0xf1/0x710)
[  998.876000] 
[  998.876000] ------------------------------
[  998.876000] | showing all locks held by: |  (aconnect/2708 [f5867010, 116]):
[  998.876000] ------------------------------
[  998.876000] 
[  998.876000] #001:             [f0ee1264] {(struct rw_semaphore *)(&grp->list_mutex)}
[  998.876000] ... acquired at:               snd_seq_port_disconnect+0x27/0x180 [snd_seq]
[  998.876000] 
[  998.876000] #002:             [f0ee16f8] {(struct rw_semaphore *)(&grp->list_mutex)}
[  998.876000] ... acquired at:               snd_seq_port_disconnect+0x3a/0x180 [snd_seq]
[  998.876000] 
[  998.876000] 

--0-1420263798-1141824995=:96220--
