Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWDRU74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWDRU74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWDRU74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:59:56 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:63132 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S932230AbWDRU7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:59:55 -0400
Message-ID: <4445533D.9010000@sh.cvut.cz>
Date: Tue, 18 Apr 2006 22:59:41 +0200
From: Rudolf Marek <r.marek@sh.cvut.cz>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Watchdog device class
References: <4443EED9.30603@sh.cvut.cz> <20060418195751.GA6968@infomag.infomag.iguana.be>
In-Reply-To: <20060418195751.GA6968@infomag.infomag.iguana.be>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wim,

> I was doing some stuff for the ICH6 & ICH7 I/O chipsets first and was then 
> planning to resume working on my generic watchdog code again. (It used to be
> stored in a bitkeeper tree, but I didn't convert it to a git tree yet).
> I'll make sure that the code get's stored in the linux-2.6-watchdog-experimental
> git tree in the coming days.

Aha good. I will check it later.

> 	int	(*get_timervalue)(struct watchdog_device *, int *);
Good one.

> 	int	(*sys_restart)(struct watchdog_device *);		/* operation = force a
system_restart for rebooting */

Aha as for the cobalt stuff?

> 	int	(*get_status)(struct watchdog_device *,int *);		/* operation = get the watchdog's status */
> 	int	(*get_temperature)(struct watchdog_device *, int *);	/* operation = get the temperature in °F */

I had those there too but I eliminated them. I used following methods:
For the status stuff I did a variable boot_status and status. I have
a handler for this in the common IOCTL handling code.

I have no such thing for the temp IOCTL but the new "ioctl" operation
could be created to catch it.
(and get called when no standard ioctl in watchdog-dev is used)

As for sysfs, I would like to have the temps handled with the hwmon class
and have some sort of "symlink" from the watchdog directory to corresponding
hwmon directory. The status stuff might be handled via standard format sysfs file.

> struct watchdog_device {
> 	unsigned char name[32];				/* The watchdog's 'identity' */
> 	unsigned long options;				/* The supported capabilities/options */
> 	unsigned long firmware;				/* The watchdog's Firmware version */
> 	int heartbeat;					/* The watchdog's heartbeat */
> 	int nowayout;					/* The nowayout setting for this watchdog */
> 	int bootstatus;					/* The watchdog's bootstatus */
got the unsigned long to have more space...
> 	int temppanic;					/* wether or not to panic on temperature trip's */
> 	struct watchdog_ops *watchdog_ops;		/* link to watchdog_ops */
> 
> 	/* watchdog status state machine */
> 	enum { WATCHDOG_UNINITIALIZED=0,
>                WATCHDOG_INITIALIZED,
>                WATCHDOG_STARTED,
>                WATCHDOG_STOPPED,
>                WATCHDOG_UNREGISTERED,
> 	} watchdog_state;

I dont have the state machine but something like this is implemented in the dev
device handling.

Additionaly I have the self ping stuff in the class too.

> 	/* From here on everything is device dependent */
> 	void	*private;

In the w83792d I used different approach, because the device is not only a
watchog, the struct watchdog_device was a part of the common device structure,
and for single purpose devices this *private makes sense. But I think there
some per device private data pointer somewhere.

> you don't need an operation for the notify_reboot. This is only necessary to
> make sure that you either stop the watchdog or force it to reboot (because
> the hardware isn't capable of rebooting itself. See the cobalt server)).

Alan already did a hint about the device driver callback that may handle this.

Now it seems we have two different approaches and a code, so which one will wim
? ;) If you want to talk to me you may find me on #linux-sensors on freenode.net.

Also I would like to know your ideas about the sysfs file structure for
watchdogs and also If you like to have more watchdogs active in the system or
just one.

Thanks,
Regards
Rudolf

PS: CC me please.
