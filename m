Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWINMTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWINMTS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 08:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWINMTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 08:19:18 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:15295 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S1751153AbWINMTS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 08:19:18 -0400
Message-ID: <450948D0.3010100@sh.cvut.cz>
Date: Thu, 14 Sep 2006 14:19:28 +0200
From: Rudolf Marek <r.marek@sh.cvut.cz>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Watchdog device class
References: <4443EED9.30603@sh.cvut.cz> <20060418195751.GA6968@infomag.infomag.iguana.be> <4445533D.9010000@sh.cvut.cz> <20060419210204.GA4205@infomag.infomag.iguana.be> <4446AAA8.70907@sh.cvut.cz> <20060815171328.GC2415@infomag.infomag.iguana.be>
In-Reply-To: <20060815171328.GC2415@infomag.infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wim,

Sorry for the delay I have been quite busy ...

> It's a first draft of the generic code. (it's split into tree main parts: the core code, the 
> /dev/watchdog code and the sysfs code). (Note: I used Greg's new "class" device setup).
> And it basically uses the following operations and watchdog_device structure:
> 
> struct watchdog_ops {
> 	/* mandatory routines */
> 	int	(*start)(struct watchdog_device *);			/* operation = start watchdog */
> 	int	(*stop)(struct watchdog_device *);			/* operation = stop watchdog */
> 	int	(*keepalive)(struct watchdog_device *);			/* operation = send keepalive ping */
> 	/* optional routines */
> 	int	(*set_heartbeat)(struct watchdog_device *,int);		/* operation = set watchdog's heartbeat */
> 	int	(*get_status)(struct watchdog_device *,int *);		/* operation = get the watchdog's status */
> 	int	(*get_timeleft)(struct watchdog_device *, int *);	/* operation = get the time left before reboot */
> 	int	(*sys_restart)(struct watchdog_device *);		/* operation = force a system_restart for rebooting */
> };
> 
> struct watchdog_device {
> 	unsigned char name[32];				/* The watchdog's 'identity' */
> 	unsigned long options;				/* The supported capabilities/options */
> 	unsigned long firmware;				/* The Watchdog's Firmware version */
> 	int heartbeat;					/* The watchdog's heartbeat */
> 	int nowayout;					/* The nowayout setting for this watchdog */
> 	int bootstatus;					/* The watchdog's bootstatus */
> 	int temppanic;					/* wether or not to panic on temperature trip's */
> 	struct watchdog_ops *watchdog_ops;		/* link to watchdog_ops */
> 
> 	/* watchdog status (register/unregister) state machine */
> 	enum { WATCHDOG_UNINITIALIZED=0,
>                WATCHDOG_REGISTERED,			/* completed register_watchdogdevice */
>                WATCHDOG_STARTED,			/* watchdog device started */
>                WATCHDOG_STOPPED,			/* watchdog device stopped */
>                WATCHDOG_UNREGISTERED,			/* completed unregister_watchdogdevice */
> 	} watchdog_state;
> 
> 	struct semaphore sem;				/* locks this structure */
> 
> 	struct device *cdev;				/* Sysfs watchdog class device */
> 
> 	/* From here on everything is device dependent */
> 	void	*private;
> };

Looks good to me. I would second Alan's idea about the standard time structure, 
because for embedded stuff even [s] might be too long.

> There are still a number of things to be added:
> * have a list under register_watchdogdevice so that we can register multiple watchdog devices
> (Note: only one watchdog device will be linked to /dev/watchdog)
> * add pre-timeout stuff
> * clean-up sysfs code
> * do proper locking
> * add documentation
> * make docbook ready

I would add:
   * infrastructure for too fast or too slow hardware watchdogs.

The idea is following: If the watchdog is too fast (1s timeout like some 
winbonds) there could be in watchdog class a common code that would ping this 
watchdog often as needed and the real ping from userspace would go to the soft 
one... So same as it is now, but part of the class core instead of part of each 
driver.

If the design is done correctly, just a time constants could be switched, so the 
soft dog is required to be "ping"ed more often then hardware. This would solve 
the other problem with 1m hw watchdogs, which are way too "slow".

> * decide how we will handle the old temperature ioctl

Drop? Or there is one easy way. Let the watchdog core call the "private" ioctl 
for unknown/temp IOCTL commands - routine ptr would be defined in the structure 
above or NULL. We can mark this interface obsolete, and later remove that 
private ioctl routine and the field in the watchdog_device structure...

Have you any clue if this IOCTL is used actually by some util? I googled a bit 
but without any luck.

As for the temps... Enough should be the registration to hwmon class and 
creation of few sysfs callbacks. The interface is stable and well defined. Just 
check the Documentation/hwmon/sysfs-interface. I cannot recall if the userspace 
app will be able to find out the currect hwmon directory in sysfs from a 
watchdog one, but I guess there is somehow assured this class hiearchy...

As for the sysfs attributes: I would suggest to use [ms] for time stuff. Rest 
looks quite straightforward.

I'm willing to help with the implementation, just tell me what you have done 
already from that list ;)

Sorry for the delay, I hope I will be able to schedule this stuff more often now ;)

Regards
Rudolf
