Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261778AbSJNAkL>; Sun, 13 Oct 2002 20:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbSJNAkL>; Sun, 13 Oct 2002 20:40:11 -0400
Received: from clix.aarnet.edu.au ([192.94.63.10]:12524 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP
	id <S261778AbSJNAkK>; Sun, 13 Oct 2002 20:40:10 -0400
Message-ID: <3DAA13CB.20500@aarnet.edu.au>
Date: Mon, 14 Oct 2002 10:16:03 +0930
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australian Academic and Research Network
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-au, en-gb, en, en-us
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 0/3 Fix serial console flow control
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A patch against 2.4.20-pre8 drivers/char/serial.c.  If it is
accepted I will port it other architectures and USB dongles.

The serial console driver contains a little documented 'r' option
which activates hardware flow control.  Eg: console=ttyS0,9600n8r

The RS-232 flow control option has a pathological condition.  When
Clear to Send is not asserted then console messages can take one
second per character to write.  Thus a machine connected to a
correctly configured idle in-dial modem or an idle terminal server may
take over 30 minutes to boot the kernel.

After considerable thought, I decided to augment the RS-232 flow
control with RS-232 status control.  This requires Data Set Ready and
Data Carrier Detect to be asserted before Clear to Send is tested.
RS-232-F states that CTS is not defined when DSR is unasserted.  There
appears to be no other way to make CTS flow control work correctly.

It was not possible to add this behaviour within the existing function
heirarchy of the serial console code of serial.c.  Although the
heirarchy has altered, the code fragments with that heirarchy remain
the same.

This code fixes all other bugs that have been reported to me as the
maintainer of the "Remote Serial Console HOWTO".  These are noted in
the code.  The most significant ones being:

  - in-dial modems hanging up on incoming calls during periods of lots
    of console messages (as during a failing disk).

  - modem configurations being subverted by non-root users.

The behaviour without the flow control option 'r' remains the same.

A set of sysctls are also added, at /proc/sys/dev/serialconsole/*.
These are required for user-space fault-finding (such as wiring issues
with RS-232 null modem cables and modem configurations).

Documentation is also enhanced, describing the flow control option,
the sysctls, and a pointer to the HOWTO.

serial.c's version is incremented from 5.05c to 5.05d.

Existing users configuring flow control will now need to present
RS-232 signals DSR and DCD in addition to CTS.  This should not
mitigate against applying the patch: all flow control users I know of
already provide the status lines and in any case are annoyed enough
the slow boot times to make any necessary cabling changes [as you
might be, if you had a supercomputing cluster that boots slower than a
486].

-- 
  Glen Turner                                 Network Engineer
  (08) 8303 3936      Australian Academic and Research Network
  glen.turner@aarnet.edu.au          http://www.aarnet.edu.au/
--
  The revolution will not be televised, it will be digitised

