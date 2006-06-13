Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWFMXfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWFMXfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWFMXfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:35:24 -0400
Received: from asteria.debian.or.at ([86.59.21.34]:13987 "EHLO
	asteria.debian.or.at") by vger.kernel.org with ESMTP
	id S964803AbWFMXfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:35:22 -0400
Date: Wed, 14 Jun 2006 01:35:21 +0200
From: Peter Palfrader <peter@palfrader.org>
To: linux-kernel@vger.kernel.org
Cc: openipmi-developer@lists.sourceforge.net
Subject: BUG: soft lockup detected on CPU#1, ipmi_si
Message-ID: <20060613233521.GO22999@asteria.noreply.org>
Mail-Followup-To: Peter Palfrader <peter@palfrader.org>,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-PGP: 1024D/94C09C7F 5B00 C96D 5D54 AEE1 206B  AF84 DE7A AF6E 94C0 9C7F
X-Request-PGP: http://www.palfrader.org/keys/94C09C7F.asc
X-Accept-Language: de, en
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2.6.17-rc6 I get these soft lockup warnings quite regularly on one of
my DL145-G2 systems (dual dual-core (opteron 275), x86_64).

Here's an example of one:

Jun 14 00:57:55 laura kernel: [97133.246571] BUG: soft lockup detected on CPU#1!
Jun 14 00:57:55 laura kernel: [97133.247456] 
Jun 14 00:57:55 laura kernel: [97133.247457] Call Trace: <IRQ> <ffffffff802a6eba>{softlockup_tick+250}
Jun 14 00:57:55 laura kernel: [97133.247496]        <ffffffff80293bb7>{update_process_times+87} <ffffffff80279923>{smp_local_timer_interrupt+35}
Jun 14 00:57:55 laura kernel: [97133.247546]        <ffffffff80279e61>{smp_apic_timer_interrupt+65} <ffffffff8026712e>{apic_timer_interrupt+98} <EOI>
Jun 14 00:57:55 laura kernel: [97133.247599]        <ffffffff802526c3>{try_to_del_timer_sync+83} <ffffffff8026be38>{_spin_unlock_irqrestore+8}
Jun 14 00:57:55 laura kernel: [97133.247652]        <ffffffff880eab78>{:ipmi_si:ipmi_thread+72} <ffffffff880eab30>{:ipmi_si:ipmi_thread+0}
Jun 14 00:57:55 laura kernel: [97133.247707]        <ffffffff80237099>{kthread+217} <ffffffff8026743a>{child_rip+8}
Jun 14 00:57:55 laura kernel: [97133.247757]        <ffffffff8029d280>{keventd_create_kthread+0} <ffffffff80236fc0>{kthread+0}
Jun 14 00:57:55 laura kernel: [97133.247807]        <ffffffff80267432>{child_rip+0}

I have several more, all of which include ipmi_si in one way or
another.  Usually these lockups happened on CPUs 2 and 3, tho today I
got one of CPU 1.

It's interesting to note that these logs are happening every 30 minutes
(munin queries 'openipmi -I open sensors' about once every 5 minutes).

Jun 12 18:45:40 laura kernel: [ 2876.040688] BUG: soft lockup detected on CPU#2!
Jun 12 19:15:54 laura kernel: [ 4688.141966] BUG: soft lockup detected on CPU#2!
Jun 12 19:46:06 laura kernel: [ 6499.159958] BUG: soft lockup detected on CPU#3!
Jun 12 20:16:17 laura kernel: [ 8309.394462] BUG: soft lockup detected on CPU#2!
Jun 12 20:46:29 laura kernel: [10120.468415] BUG: soft lockup detected on CPU#3!
Jun 12 21:16:42 laura kernel: [11931.614321] BUG: soft lockup detected on CPU#2!
Jun 12 21:46:54 laura kernel: [13742.672285] BUG: soft lockup detected on CPU#2!
[rebooted in between]
Jun 14 00:57:55 laura kernel: [97133.246571] BUG: soft lockup detected on CPU#1!
Jun 14 01:28:07 laura kernel: [98944.316467] BUG: soft lockup detected on CPU#3!

Not having the ipmi_si module loaded means these warnings don't happen.

I suspect this started happening when I upgraded the firmware of the
iLo 100i BMC from 1.00 to version 1.23 (the other system's firmware
wasn't upgraded yet).  I'm still reporting it here on the chance that it
actually is a kernel/ipmi_si module bug.

Cheers,
Peter
-- 
                           |  .''`.  ** Debian GNU/Linux **
      Peter Palfrader      | : :' :      The  universal
 http://www.palfrader.org/ | `. `'      Operating System
                           |   `-    http://www.debian.org/
