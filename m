Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVGGNoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVGGNoa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVGGNnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:43:08 -0400
Received: from styx.suse.cz ([82.119.242.94]:63935 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261495AbVGGNkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:40:52 -0400
Date: Thu, 7 Jul 2005 15:40:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Anssi Hannula <anssi.hannula@mbnet.fi>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Force Feedback interface to joydev
Message-ID: <20050707134049.GA28382@ucw.cz>
References: <4256BF90.7040408@mbnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4256BF90.7040408@mbnet.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 08:29:52PM +0300, Anssi Hannula wrote:
> This patch adds Force Feedback interface to joydev. I felt this 
> necessary because games usually don't run as root while evdev usually 
> can't be read or written by anyone else. Patch is against 2.6.12-rc2. If 
> there is a reason this can't be applied or needs modifications, please 
> say it :)

Modern distros usually chown() the event devices to the user logged on
the console, so this shouldn't be a problem. Anyway, I'm not opposed to
adding the ioctl()s, but you should also add 64-bit compatible versions
of them.

> 
> If I have enough time and skills, I will start developing userspace 
> Force Feedback library, which would do (among other things) all 
> necessary force convertings between joystick, gamepad and wheel controllers.
> 
> Does anyone have any thoughts about this?
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@mbnet.fi>
> 

> diff -Nurp linux-2.6.11/Documentation/input/ff.txt linux-2.6.11-ffjoy/Documentation/input/ff.txt
> --- linux-2.6.11/Documentation/input/ff.txt	2005-03-02 09:38:12.000000000 +0200
> +++ linux-2.6.11-ffjoy/Documentation/input/ff.txt	2005-04-08 00:07:50.000000000 +0300
> @@ -1,5 +1,6 @@
>  Force feedback for Linux.
>  By Johann Deneux <deneux@ifrance.com> on 2001/04/22.
> +Updated & cleaned on 2005/04/04 by Anssi Hannula <anssi.hannula@gmail.com>
>  You may redistribute this file. Please remember to include shape.fig and
>  interactive.fig as well.
>  ----------------------------------------------------------------------------
> @@ -10,18 +11,11 @@ This document describes how to use force
>  goal is not to support these devices as if they were simple input-only devices
>  (as it is already the case), but to really enable the rendering of force
>  effects.
> -At the moment, only I-Force devices are supported, and not officially. That
> -means I had to find out how the protocol works on my own. Of course, the
> -information I managed to grasp is far from being complete, and I can not
> -guarranty that this driver will work for you.
> -This document only describes the force feedback part of the driver for I-Force
> -devices. Please read joystick.txt before reading further this document.
> +Please read joystick.txt before reading further this document.
>  
>  2. Instructions to the user
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -Here are instructions on how to compile and use the driver. In fact, this
> -driver is the normal iforce, input and evdev drivers written by Vojtech
> -Pavlik, plus additions to support force feedback.
> +Here are instructions on how to compile and use the driver.
>  
>  Before you start, let me WARN you that some devices shake violently during the
>  initialisation phase. This happens for example with my "AVB Top Shot Pegasus".
> @@ -29,19 +23,18 @@ To stop this annoying behaviour, move yo
>  should keep a hand on your device, in order to avoid it to brake down if
>  something goes wrong.
>  
> -At the kernel's compilation:
> -	- Enable IForce/Serial
> -	- Enable Event interface
> +At the kernel's compilation enable the Force Feedback support for devices you
> +have.
>  
>  Compile the modules, install them.
>  
> -You also need inputattach.
> +For serial devices you also need inputattach.
>  
>  You then need to insert the modules into the following order:
>  % modprobe joydev
>  % modprobe serport		# Only for serial
> -% modprobe iforce
> -% modprobe evdev
> +% modprobe iforce		# Example of FF driver
> +% modprobe evdev		# For evdev-interface
>  % ./inputattach -ifor $2 &	# Only for serial
>  If you are using USB, you don't need the inputattach step.
>  
> @@ -66,23 +59,37 @@ mknod input/event3 c 13 67
>  2.1 Does it work ?
>  ~~~~~~~~~~~~~~~~~~
>  There is an utility called fftest that will allow you to test the driver.
> +% fftest /dev/input/jsXX
> +
> +You can test the evdev interface with:
>  % fftest /dev/input/eventXX
>  
> +Please note that joydev (jsXX) interface is recommended over evdev due to
> +security issues involved in allowing users to access evdev devices.
> +
>  3. Instructions to the developper
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -  All interactions are done using the event API. That is, you can use ioctl()
> -and write() on /dev/input/eventXX.
> -  This information is subject to change.
> +All interactions are done using the joydev API. That is, you can use ioctl()
> +and write() on /dev/input/jsXX. There is also an evdev interface on
> +/dev/input/eventXX.
> +
> +Joydev FF API is present in JS_VERSION >= 0x020200.
> +Evdev FF API is present in all 2.6 series kernels.
> +Use the joydev API instead of evdev whenever possible.
> +
> +This information is subject to change.
>  
>  3.1 Querying device capabilities
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  #include <linux/input.h>
> +#include <linux/joystick.h>
>  #include <sys/ioctl.h>
>  
>  unsigned long features[1 + FF_MAX/sizeof(unsigned long)];
>  int ioctl(int file_descriptor, int request, unsigned long *features);
>  
> -"request" must be EVIOCGBIT(EV_FF, size of features array in bytes )
> +"request" must be JSIOCGFFBIT(size of features array in bytes).
> +The evdev version is EVIOCGBIT(EV_FF, size of features array in bytes ).
>  
>  Returns the features supported by the device. features is a bitfield with the
>  following bits:
> @@ -100,6 +107,7 @@ following bits:
>  - FF_INERTIA    can simulate inertia
>  
>  
> +int ioctl(int fd, JSIOCGEFFECTS, int *n);
>  int ioctl(int fd, EVIOCGEFFECTS, int *n);
>  
>  Returns the number of effects the device can keep in its memory.
> @@ -107,11 +115,12 @@ Returns the number of effects the device
>  3.2 Uploading effects to the device
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  #include <linux/input.h>
> +#include <linux/joystick.h>
>  #include <sys/ioctl.h>
>   
>  int ioctl(int file_descriptor, int request, struct ff_effect *effect);
>  
> -"request" must be EVIOCSFF.
> +"request" must be JSIOCSFF (EVIOCSFF for evdev).
>  
>  "effect" points to a structure describing the effect to upload. The effect is
>  uploaded, but not played.
> @@ -126,6 +135,7 @@ You need xfig to visualize these files.
>  
>  3.3 Removing an effect from the device
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +int ioctl(int fd, JSIOCRMFF, effect.id);
>  int ioctl(int fd, EVIOCRMFF, effect.id);
>  
>  This makes room for new effects in the device's memory. Please note this won't
> @@ -136,6 +146,7 @@ stop the effect if it was playing.
>  Control of playing is done with write(). Below is an example:
>  
>  #include <linux/input.h>
> +#include <linux/joystick.h>
>  #include <unistd.h>
>  
>  	struct input_event play;
> @@ -143,7 +154,7 @@ Control of playing is done with write().
>  	struct ff_effect effect;
>  	int fd;
>  ...
> -	fd = open("/dev/input/eventXX", O_RDWR);
> +	fd = open("/dev/input/jsXX", O_RDWR);
>  ...
>  	/* Play three times */
>  	play.type = EV_FF;
> @@ -207,8 +218,11 @@ case, the driver stops the effect, up-lo
>  
>  3.8 Information about the status of effects
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -Every time the status of an effect is changed, an event is sent. The values
> -and meanings of the fields of the event are as follows:
> +Every time the status of an effect is changed, an event is sent.
> +
> +NOTE: This appears to not be implemented in all drivers at the moment.
> +
> +The values and meanings of the fields of the event are as follows:
>  struct input_event {
>  /* When the status of the effect changed */
>  	struct timeval time;
> diff -Nurp linux-2.6.11/drivers/input/joydev.c linux-2.6.11-ffjoy/drivers/input/joydev.c
> --- linux-2.6.11/drivers/input/joydev.c	2005-04-07 23:57:21.000000000 +0300
> +++ linux-2.6.11-ffjoy/drivers/input/joydev.c	2005-04-08 00:04:40.000000000 +0300
> @@ -141,6 +141,13 @@ static int joydev_fasync(int fd, struct 
>  	return retval < 0 ? retval : 0;
>  }
>  
> +static int joydev_flush(struct file * file)
> +{
> +	struct joydev_list *list = file->private_data;
> +	if (!list->joydev->exist) return -ENODEV;
> +	return input_flush_device(&list->joydev->handle, file);
> +}
> +
>  static void joydev_free(struct joydev *joydev)
>  {
>  	joydev_table[joydev->minor] = NULL;
> @@ -191,7 +198,21 @@ static int joydev_open(struct inode *ino
>  
>  static ssize_t joydev_write(struct file * file, const char __user * buffer, size_t count, loff_t *ppos)
>  {
> -	return -EINVAL;
> +	struct joydev_list *list = file->private_data;
> +	struct input_event event;
> +	int retval = 0;
> +
> +	if (!list->joydev->exist) return -ENODEV;
> +
> +	while (retval < count) {
> +
> +		if (copy_from_user(&event, buffer + retval, sizeof(struct input_event)))
> +			return -EFAULT;
> +		input_event(list->joydev->handle.dev, event.type, event.code, event.value);
> +		retval += sizeof(struct input_event);
> +	}
> +
> +	return retval;
>  }
>  
>  static ssize_t joydev_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> @@ -358,6 +379,26 @@ static int joydev_ioctl(struct inode *in
>  		case JSIOCGBTNMAP:
>  			return copy_to_user(argp, joydev->keypam,
>  						sizeof(__u16) * (KEY_MAX - BTN_MISC + 1)) ? -EFAULT : 0;
> +		case JSIOCSFF:
> +			if (dev->upload_effect) {
> +				struct ff_effect effect;
> +				int err;
> +				if (copy_from_user(&effect, argp, sizeof(effect)))
> +					return -EFAULT;
> +				err = dev->upload_effect(dev, &effect);
> +				if (put_user(effect.id, &(((struct ff_effect __user *)arg)->id)))
> +					return -EFAULT;
> +				return err;
> +			}
> +			else return -ENOSYS;
> +		case JSIOCRMFF:
> +			if (dev->erase_effect)
> +				return dev->erase_effect(dev, (int)arg);
> +			return -ENOSYS;
> +		case JSIOCGEFFECTS:
> +			if (put_user(dev->ff_effects_max, (int __user *)arg))
> +				return -EFAULT;
> +			return 0;
>  		default:
>  			if ((cmd & ~(_IOC_SIZEMASK << _IOC_SIZESHIFT)) == JSIOCGNAME(0)) {
>  				int len;
> @@ -367,6 +408,15 @@ static int joydev_ioctl(struct inode *in
>  				if (copy_to_user(argp, dev->name, len)) return -EFAULT;
>  				return len;
>  			}
> +			if (_IOC_NR(cmd) == _IOC_NR(JSIOCGFFBIT(0))) {
> +				int len;
> +				len = NBITS(FF_MAX) * sizeof(long);
> +				if (len > _IOC_SIZE(cmd))
> +					len = _IOC_SIZE(cmd);
> +				if (copy_to_user(argp, dev->ffbit, len))
> +					return -EFAULT;
> +				return len;
> +			}
>  	}
>  	return -EINVAL;
>  }
> @@ -380,6 +430,7 @@ static struct file_operations joydev_fop
>  	.release =	joydev_release,
>  	.ioctl =	joydev_ioctl,
>  	.fasync =	joydev_fasync,
> +	.flush =	joydev_flush,
>  };
>  
>  static struct input_handle *joydev_connect(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id)
> diff -Nurp linux-2.6.11/include/linux/joystick.h linux-2.6.11-ffjoy/include/linux/joystick.h
> --- linux-2.6.11/include/linux/joystick.h	2005-04-07 23:57:42.000000000 +0300
> +++ linux-2.6.11-ffjoy/include/linux/joystick.h	2005-04-07 23:59:59.000000000 +0300
> @@ -36,7 +36,7 @@
>   * Version
>   */
>  
> -#define JS_VERSION		0x020100
> +#define JS_VERSION		0x020200
>  
>  /*
>   * Types and constants for reading from /dev/js
> @@ -71,6 +71,13 @@ struct js_event {
>  #define JSIOCSBTNMAP		_IOW('j', 0x33, __u16[KEY_MAX - BTN_MISC + 1])	/* set button mapping */
>  #define JSIOCGBTNMAP		_IOR('j', 0x34, __u16[KEY_MAX - BTN_MISC + 1])	/* get button mapping */
>  
> +#define JSIOCGFFBIT(len)	_IOC(_IOC_READ, 'j', 0x41, len)			/* get force effect bits */
> +#define JSIOCSFF		_IOW('j', 0x42, struct ff_effect)
> +			/* upload a force effect to a force feedback device */
> +#define JSIOCRMFF		_IOW('j', 0x43, int)				/* erase a force effect */
> +#define JSIOCGEFFECTS		_IOR('j', 0x44, int)
> +			/* get number of effects playable at the same time */
> +
>  /*
>   * Types and constants for get/set correction
>   */
> 


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
