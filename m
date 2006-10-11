Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbWJKQyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWJKQyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbWJKQyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:54:53 -0400
Received: from hu-out-0506.google.com ([72.14.214.239]:4392 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161143AbWJKQyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:54:53 -0400
Message-ID: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
Date: Wed, 11 Oct 2006 12:54:51 -0400
From: "=?UTF-8?Q?G=C3=BCnther_Starnberger?=" <gst@sysfrog.org>
To: linux-kernel@vger.kernel.org
Subject: Userspace process may be able to DoS kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm not subscribed on this list - please CC answers to me.]

Hello,

It seems that the latest version of Skype may exhibit a problem in the
kernel where a non-root userspace process is able to block the whole
system for durations of up to several minutes. If someone is able to
reproduce the steps which cause the problem he may be able to DoS a
system by consecutively causing soft lockups.

There were some reports of this problem on other lists before, but
mostly on tainted systems. I was able to reproduce this problem on a
non-tainted mostly vanilla 2.6.17.6 kernel (it includes the suspend2
patches). As most users who reported this problem are using Ubuntu,
the problem may be related to one of the settings in Ubuntu's kernel
config. The configuration of my kernel is also based on the Ubuntu
kernel config. As I am not using the patched kernel by Ubuntu I hope
that the LKML is the right place to report this issue.

The lockup usually occurs when Skype 1.3.x for Linux (I'm using
1.3.0.53) sits around idle for some time and then (presumably) uses
the sound device (i.e. for me it happens when I call a contact -
others reported this problem occurs for incoming messages [there may
be an audio notification of the messages enabled]). The lockup can
take from several seconds (where it is not detected by the kernel) up
to some minutes. The whole system seems to be blocked - i.e. there is
not even disk IO.

dmesg reports the following:
BUG: soft lockup detected on CPU#0!
 <c01562cd> softlockup_tick+0xad/0xf0  <c012e609> update_process_times+0x39/0x90
 <c011600b> smp_apic_timer_interrupt+0x5b/0x70  <c0110037>
get_offset_pmtmr+0x97/0x1060
 <c0103d20> apic_timer_interrupt+0x1c/0x24  <c013d390> hrtimer_get_res+0x0/0x60
 <c0110037> get_offset_pmtmr+0x97/0x1060  <c0106b9f> do_gettimeofday+0x1f/0xd0
  <c0129654> getnstimeofday+0x14/0x40  <c01398d1> sys_clock_gettime+0x31/0xb0
 <c01031e7> sysenter_past_esp+0x54/0x75

A copy of my kernel config is available at:
http://virtual.sysfrog.org/~gst/config.txt

The hardware where this problem occurs here is a X41 Thinkpad (Pentium
M Dothan). There are also reports on other non-Intel CPUs e.g. AMD
Turion 64.

Please see the more extensive documentation of this problem on
https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/53216
(although some of the people there use tainted kernels).

I will upgrade my 2.6.17.6 kernel to 2.6.18 and try to reproduce the
problem there in the following days (but I fear that I won't have much
time before the weekend).

bye,
/gst
