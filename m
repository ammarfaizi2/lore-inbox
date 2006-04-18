Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWDRT6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWDRT6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 15:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWDRT6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 15:58:07 -0400
Received: from outmx007.isp.belgacom.be ([195.238.5.234]:41680 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932301AbWDRT6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 15:58:06 -0400
Date: Tue, 18 Apr 2006 21:57:51 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Rudolf Marek <r.marek@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Watchdog device class
Message-ID: <20060418195751.GA6968@infomag.infomag.iguana.be>
References: <4443EED9.30603@sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4443EED9.30603@sh.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rudolf,

> I wanted to create a watchdog driver for I2C W83792D chip and I realized
> that there is no clean way how to connect the existing I2C device driver
> with the watchdog ops. As the consequence of this I created new watchdog
> device class.
> 
> This class supports all common infrastructure such as char device handling,
> sysfs exports and even the infrastructure for too fast watchdogs
> (the self ping feature). The class is based on the RTC class which
> is fairly similar in some aspects.
> 
> The char device of watchdog class is compatible with existing watchdog API,
> so no need to change the user applications. There is just one exception
> and this is temperature handling. I belive it should be implemented not
> via IOCTL but using the HWMON class. (100% compatibility can be restored
> with the ioctl class op)
> 
> I have defined this class ops so far:
> 
> struct watchdog_class_ops {
> 	int (*enable)(struct device *);
> 	int (*disable)(struct device *);
> 	int (*ping)(struct device *);
> 	int (*set_timeout)(struct device *, int sec);
> 	int (*notify_reboot)(struct notifier_block *this, unsigned long code,
> 	        void *unused);

I was doing some stuff for the ICH6 & ICH7 I/O chipsets first and was then 
planning to resume working on my generic watchdog code again. (It used to be
stored in a bitkeeper tree, but I didn't convert it to a git tree yet).
I'll make sure that the code get's stored in the linux-2.6-watchdog-experimental
git tree in the coming days.

But basically this is what we need for watchdog devices:
---------------------------------------------------------------------------
struct watchdog_ops;
struct watchdog_device;

struct watchdog_ops {
	/* mandatory routines */
	int	(*start)(struct watchdog_device *);			/* operation = start watchdog */
	int	(*stop)(struct watchdog_device *);			/* operation = stop watchdog */
	int	(*keepalive)(struct watchdog_device *);			/* operation = send keepalive ping */
	/* optional routines */
	int	(*set_heartbeat)(struct watchdog_device *,int);		/* operation = set watchdog's heartbeat */
	int	(*get_status)(struct watchdog_device *,int *);		/* operation = get the watchdog's status */
	int	(*get_temperature)(struct watchdog_device *, int *);	/* operation = get the temperature in °F */
	int	(*get_timervalue)(struct watchdog_device *, int *);	/* operation = get the current timer value */
	int	(*sys_restart)(struct watchdog_device *);		/* operation = force a system_restart for rebooting */
};

struct watchdog_device {
	unsigned char name[32];				/* The watchdog's 'identity' */
	unsigned long options;				/* The supported capabilities/options */
	unsigned long firmware;				/* The watchdog's Firmware version */
	int heartbeat;					/* The watchdog's heartbeat */
	int nowayout;					/* The nowayout setting for this watchdog */
	int bootstatus;					/* The watchdog's bootstatus */
	int temppanic;					/* wether or not to panic on temperature trip's */
	struct watchdog_ops *watchdog_ops;		/* link to watchdog_ops */

	/* watchdog status state machine */
	enum { WATCHDOG_UNINITIALIZED=0,
               WATCHDOG_INITIALIZED,
               WATCHDOG_STARTED,
               WATCHDOG_STOPPED,
               WATCHDOG_UNREGISTERED,
	} watchdog_state;

	struct semaphore sem;				/* locks this structure */

	/* From here on everything is device dependent */
	void	*private;
};

/* drivers/watchdog/watchdog.c */
extern struct watchdog_device *alloc_watchdogdev(void);
extern int free_watchdogdev(struct watchdog_device *dev);
extern int register_watchdogdevice(struct watchdog_device *dev);
extern int unregister_watchdogdevice(struct watchdog_device *dev);
---------------------------------------------------------------------------

you don't need an operation for the notify_reboot. This is only necessary to
make sure that you either stop the watchdog or force it to reboot (because
the hardware isn't capable of rebooting itself. See the cobalt server)).
The notify reboot is not a watchdog operation, it's for making sure that when
you shutdown/reboot everything runs smoothly.

Greetings,
Wim.

