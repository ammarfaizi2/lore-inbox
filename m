Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311920AbSCTIdO>; Wed, 20 Mar 2002 03:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311921AbSCTIdE>; Wed, 20 Mar 2002 03:33:04 -0500
Received: from mail.medav.de ([213.95.12.190]:7437 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S311920AbSCTIco> convert rfc822-to-8bit;
	Wed, 20 Mar 2002 03:32:44 -0500
From: "Daniela Engert" <dani@ngrt.de>
To: "Pavel Machek" <pavel@suse.cz>, "Vojtech Pavlik" <vojtech@suse.cz>
Cc: "Jeff Garzik" <jgarzik@mandrakesoft.com>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Olivier Galibert" <galibert@pobox.com>,
        "Vojtech Pavlik" <vojtech@suse.cz>
Date: Wed, 20 Mar 2002 09:00:45 +0100 (CET)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <20020319225609.A12655@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-Id: <20020320065425.D27F3DD1C@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002 22:56:09 +0100, Vojtech Pavlik wrote:

>> > Not all of them safely, though. Many a drive will corrupt data if it
>> > receives a command when not spinned up. You need to issue a wake command
>> > first, which hdparm doesn't, it just leaves it to the kernel to issue a
>> > read command or whatever to wake the drive ...
>> 
>> Is this common disk bug, or are they permitted to behave like that?
>
>This behavior is permitted by the specification, as far as I know -

Actually not. Have a look at page 36 of the current ATA6 specification.


>results of commands other than wakeup (and other pm commands) in sleep
>or suspend mode are undefined ...

If a disk is in power state PM1:idle or PM2:standby, each ATA command
which requires media access will result in a transition to power state
PM0:active as well. The driver should be prepared of a long command
execution time in this case (due to the spin up delay). This is why a
well implemented ATA driver should track the individual power states of
each attached unit to modulate its internal command timeout
accordingly.

The driver may issue a SET_FEATURES(spin up) command in anticipation of
a media access. A "forgiving" implementation might issue this command
at proper system state transitions as well .

If a disk has entered power state PM3:sleep, its interface is turned
off! You no longer can issue any command except for a DEVICE RESET to
this unit. A reset is required to initiate a state transition from
PM3:sleep to PM2:standby (there are no other state transitions).

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


