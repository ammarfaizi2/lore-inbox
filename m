Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUFAShU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUFAShU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 14:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265122AbUFAShU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 14:37:20 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:3671 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265119AbUFAShN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 14:37:13 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: SERIO_USERDEV patch for 2.6
Date: Tue, 1 Jun 2004 13:18:36 -0500
User-Agent: KMail/1.6.2
Cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>, Vojtech Pavlik <vojtech@suse.cz>
References: <Pine.GSO.4.58.0406011105330.6922@stekt37> <20040530134246.GA1828@ucw.cz> <xb7n03n5iji.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7n03n5iji.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Message-Id: <200406011318.36992.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 June 2004 11:50 am, Sau Dan Lee wrote:
> 
>     Tuukka> Dmitry suggested adding a kernel parameter to specify
>     Tuukka> which ports would allow to be read in raw mode and which
>     Tuukka> would be handled by kernel drivers.
> 
> That means changes have to be made to ALL drivers.  That looks "ugly".

That is only an interim solution that will be used until we have proper
sysfs support and are able to re-bind a specific driver to a specific
port. And it seems that only i8042 needs to be changed. As I said before
serial ports still accessible via /dev/ttySx, and other architectures that
provide access to SERIO_8042 type ports have much less diverse set of
peripherials... The changes can be made on as-needed basis.

So the cons of my proposal:
- Drivers need to be modified but changes are very limited.

Pros of my proposal:
- Completely non-intrusive as far as serio subsystem goes.
- The rawdev serio driver can still be used later when we have sysfs.

> 
> 
>     Tuukka> In my opinion, almost the same is achieved more
>     Tuukka> conveniently by handling in raw mode simply exactly those
>     Tuukka> ports that are opened from userspace (ie. "cat serio1"
>     Tuukka> would disconnect kernel driver), and everything else by
>     Tuukka> kernel drivers.  No additional parameters would be then
>     Tuukka> necessary, nor module reloads to change anything.
>
> I have a suggestion using sysfs or procfs:
> 
> In some directory (e.g. /proc/input/serio):
> 
>         unbound_ports/  (contains a pseudo file for each serio port
>                          that is not attached to any device yet)
>         keyboards/      (contains a pseudo file for each serio port
>                          that is attached to the keyboard device)
>         mice/           (contains a pseudo file for each serio port
>                          attached to mousedev.ko)
>         touchscreens/   (contains a pseudo file for each serio port
>                          attached to tsdev.ko)
>         direct/         (contains a pseudo file for each serio port
>                          that is exposed to userland (currently via "misc")
>                          directly, RAW)
> etc.  The contents of the pseudo files are unimportant.  (We could use
> it to show useful info, though.)
> 
> Initially,  all  serio  ports  have  their  corresponding  pseudofiles
> created   under   "unbound_ports".   When   a   serio  device   module
> (e.g. mousedev) is loaded,  the module, in the current implementation,
> will attach all mouse device  to it.  So, the corresponding entries in
> "unbound_ports/" will be moved to "mice/".
> 
> If we now  want the PS AUX port  to be accessed directly, we  do a "mv
> unbound_ports/isa0060.serio1 direct/".   The serio port isa0060/serio1

Using mv would be implementation trouble, i would rahter do:

echo "rawdev" > /sys/bus/serio/devices/serio0/driver

or something alont these lines. At least that's my grand plan ;)

-- 
Dmitry
