Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUF2T2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUF2T2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUF2T2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:28:12 -0400
Received: from magic.adaptec.com ([216.52.22.17]:10960 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S265932AbUF2T14 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:27:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PATCH: Further aacraid work
Date: Tue, 29 Jun 2004 15:27:54 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189FF1D6D0@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH: Further aacraid work
Thread-Index: AcReC8UrR13XM/bjTJWqBKNI2C8CaQAASJvA
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Byron Stanoszek" <gandalf@winds.org>
Cc: "Mark Haverkamp" <markh@osdl.org>, "Alan Cox" <alan@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-scsi" <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although I am gratified that 1.1.5-2345 works, and works well (*many*
performance improvements have occurred in this driver, but some of those
have reached Alan's patch), I am at a loss because I was sure that the
lockup was associated with commands taking longer than 60 seconds to
complete (a 'can happen' with a complicated RAID card with multiple
targets, that unfortunately gives the SCSI layer and especially ext3
some headaches). The workaround in the reset handler is to let the
commands quiesce to give the Firmware some breathing space to respond to
the test unit ready command that is issued to the target immediately
following return from the reset handler.

This not solving the problem has the implication, as Alan had noted,
that this could be an issue with the adapter itself locking up or going
unresponsive under load. Both reports, this one and "PERC 3/Di broken
2.6.6-mm5 -> 2.6.7-rc1-mm" now smell of some subtle problems creeping
in.

Can we get some additional tests on this?

1) Does this problem occur on a single CPU (Hyperthreading disabled
too)? I am assuming some locking issues appeared, mainly because of some
restructuring in that code.
2) If you turn off Cache (Read & Write), does the problem persist? This
is the usual condition with older Firmware where the duration could be
extended as a result of the priority at which a Cache Flush occurs
blocking commands.
3) The `Adaptec' driver has a beefed up health checker
(aac_rx_check_health) in rx.c that may be useful for catching what is
called a `blinkLED' report from the adapter. If this piece of code is
moved into the 2.6.7 driver with a single printk reporting the return
value from the health check in linit.c we may get a clue to the
conditions of failure if it is in the adapter.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Byron Stanoszek [mailto:gandalf@winds.org] 
Sent: Tuesday, June 29, 2004 3:03 PM
To: Salyzyn, Mark
Cc: Mark Haverkamp; Alan Cox; linux-kernel; linux-scsi
Subject: RE: PATCH: Further aacraid work

On Tue, 29 Jun 2004, Salyzyn, Mark wrote:

> I believe this nails the problem too.
>
> However, there is a corner case condition lurking on this (See my
> currently unanswered email "error recovery and command completion" on
> linux-scsi) where I try to deal with completing a command while error
> recovery is triggered. Scsi_done will return doing *nothing*
effectively
> loosing the command completion.
>
> MarkH, I had talked to you about he addition of the scsi_add_timer
> before calling scsi_done to address this condition. I do not believe
> this to be the (Reliable and/or performance oriented) solution.
>
> Sincerely -- Mark Salyzyn

I've tested out both patches sent to me.

Test 1: aacraid-1.1.5-2245.tgz

Works flawlessly and speedily! The rsync completes, and doing a sync()
(as
called during a normal lilo update) takes roughly 1 second as opposed to
20
with the original aacraid patch from Alan Cox. Also, no SCSI hang
message ever
appears.

Test 2: Mark Haverkamp's linit.c patch

The "SCSI hang" console message appears just as before during the
'rsync',
however (unlike before) the device is still usable for roughly 30
seconds after
the problem. During these 30 seconds, the 'rsync' process is hung, but I
can
still do a 'df', 'ls', and so on. After 30 seconds, the entire /dev/sda
locks
up and I have no choice but to reboot the system.

  -Byron

