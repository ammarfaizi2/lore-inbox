Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135540AbRDSD4I>; Wed, 18 Apr 2001 23:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135539AbRDSD4A>; Wed, 18 Apr 2001 23:56:00 -0400
Received: from m20-mp1-cvx1c.col.ntl.com ([213.104.76.20]:18816 "EHLO
	[213.104.76.20]") by vger.kernel.org with ESMTP id <S135538AbRDSDzy>;
	Wed, 18 Apr 2001 23:55:54 -0400
To: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Next gen PM interface
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD91@orsmsx35.jf.intel.com>
	<m2oftvkm6f.fsf@boreas.yi.org.>
From: John Fremlin <chief@bandits.org>
Date: 19 Apr 2001 04:54:56 +0100
In-Reply-To: <m2oftvkm6f.fsf@boreas.yi.org.>
Message-ID: <m2d7a97ddb.fsf_-_@bandits.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Solid Vapor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin <chief@bandits.org> writes:

[...]

> IMHO the pm interface should be split up as following:

Nobody has disagreed: therefore this separation must be perfect ;-)

>         (1) Battery status, power status, UPS status polling. It
>         should be possible for lots of processes to do this
>         simultaneously. [That does not prohibit a single process
>         querying the kernel and all the others querying it.]

Solution. Have a bunch of procfs or dev nodes each giving info on a
particular power source, like now, but vaguely standardise the output.

>         (2) Funky events happening to the physical machine, like a
>         button being pressed, the case being closed, etc. [Should this
>         include battery low warnings, power status changes? I don't
>         know.]

Solution. Have a special procfs or dev node that any number of people
can select(2) or read(2). Protocol text. Syntax:

        <event> <WS> <subsystem> <WS> <description> <LF>

Where <event> is one of the strings
OFF,SLEEP,WAKE,EMERGENCY,POWERCHANGE, <WS> is a space character,
<subsystem> is a word signifying the kernel pm interface responsible
for generating th event, <description> is an arbitrary string. <LF> is
a newline character \n.

This is flexible and simple. It means a reasonable default behaviour
can be suggested by the kernel (OFF,SLEEP,etc.) for events that
userspace doesn't know about and yet userspace can choose fine grained
policy and provide helpful error messages based on the exact event by
checking the description.

[...]

>         (3) Sending the machine to sleep, turning it off. It should be
>         possible to do this from userspace ;-)

I would suggest that all pm capable objects should be able to be
controlled individually. E.g. you should be able to send your monitor
to sleep alone, leaving other stuff running. Fbdrivers are already
capable of this on some archs.

IOW I suggest a nice FS with a dir per PM capable device. In this
dir would be

        name - descriptive text name of device class

        wake - writing to this node wakes device

        sleep - writing a number n (text encoded) sends the device to
        sleep in such a way that it can be back in action in no less
        than n seconds after a wakeup call on a vague guess
        basis. Reading from it gets errno.

        off - writing to this node puts device in deepest possible
        sleep, possibly losing state. Reading gets errno.

Like the proc/sys/net/ipv4/neigh stuff you can have an all/ dir that'd
try to whatever to everything. Hotunplug can be handled.

Any objections? Would such a patch be accepted by the powers that be?

[...]

-- 

	http://www.penguinpowered.com/~vii
