Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWHORNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWHORNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWHORNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:13:39 -0400
Received: from outmx023.isp.belgacom.be ([195.238.4.204]:21203 "EHLO
	outmx023.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030390AbWHORNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:13:38 -0400
Date: Tue, 15 Aug 2006 19:13:28 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Rudolf Marek <r.marek@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Watchdog device class
Message-ID: <20060815171328.GC2415@infomag.infomag.iguana.be>
References: <4443EED9.30603@sh.cvut.cz> <20060418195751.GA6968@infomag.infomag.iguana.be> <4445533D.9010000@sh.cvut.cz> <20060419210204.GA4205@infomag.infomag.iguana.be> <4446AAA8.70907@sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4446AAA8.70907@sh.cvut.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rudolf,

> > It's not about different approaches: we have to find the best thing for watchdog
> > devicesi, so the best thing is to talk about pro's and con's and see what we should 
> > do best. (I for instance didn't come to the sysfs part yet of my code (which would
> > be in watchdog_sysfs.c)
> 
> Ok I will look into your code.

Please have a look at the experimental code in the linux-2.6-watchdog-experimental git tree
(http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog-experimental.git;a=summary).

It's a first draft of the generic code. (it's split into tree main parts: the core code, the 
/dev/watchdog code and the sysfs code). (Note: I used Greg's new "class" device setup).
And it basically uses the following operations and watchdog_device structure:

struct watchdog_ops {
	/* mandatory routines */
	int	(*start)(struct watchdog_device *);			/* operation = start watchdog */
	int	(*stop)(struct watchdog_device *);			/* operation = stop watchdog */
	int	(*keepalive)(struct watchdog_device *);			/* operation = send keepalive ping */
	/* optional routines */
	int	(*set_heartbeat)(struct watchdog_device *,int);		/* operation = set watchdog's heartbeat */
	int	(*get_status)(struct watchdog_device *,int *);		/* operation = get the watchdog's status */
	int	(*get_timeleft)(struct watchdog_device *, int *);	/* operation = get the time left before reboot */
	int	(*sys_restart)(struct watchdog_device *);		/* operation = force a system_restart for rebooting */
};

struct watchdog_device {
	unsigned char name[32];				/* The watchdog's 'identity' */
	unsigned long options;				/* The supported capabilities/options */
	unsigned long firmware;				/* The Watchdog's Firmware version */
	int heartbeat;					/* The watchdog's heartbeat */
	int nowayout;					/* The nowayout setting for this watchdog */
	int bootstatus;					/* The watchdog's bootstatus */
	int temppanic;					/* wether or not to panic on temperature trip's */
	struct watchdog_ops *watchdog_ops;		/* link to watchdog_ops */

	/* watchdog status (register/unregister) state machine */
	enum { WATCHDOG_UNINITIALIZED=0,
               WATCHDOG_REGISTERED,			/* completed register_watchdogdevice */
               WATCHDOG_STARTED,			/* watchdog device started */
               WATCHDOG_STOPPED,			/* watchdog device stopped */
               WATCHDOG_UNREGISTERED,			/* completed unregister_watchdogdevice */
	} watchdog_state;

	struct semaphore sem;				/* locks this structure */

	struct device *cdev;				/* Sysfs watchdog class device */

	/* From here on everything is device dependent */
	void	*private;
};

There are still a number of things to be added:
* have a list under register_watchdogdevice so that we can register multiple watchdog devices
(Note: only one watchdog device will be linked to /dev/watchdog)
* add pre-timeout stuff
* clean-up sysfs code
* do proper locking
* add documentation
* make docbook ready
* decide how we will handle the old temperature ioctl
...

All comments/suggestions are welcome. Let's see/discuss what's missing, what we should do different, ...

Greetings,
Wim.

