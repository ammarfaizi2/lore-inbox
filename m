Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291838AbSBHVMp>; Fri, 8 Feb 2002 16:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291818AbSBHVMg>; Fri, 8 Feb 2002 16:12:36 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:39941 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S291813AbSBHVMR>;
	Fri, 8 Feb 2002 16:12:17 -0500
Date: Thu, 7 Feb 2002 22:33:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Driver support needed for suspend/resume
Message-ID: <20020207213350.GA290@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Hi!

SUSPEND_NOTIFY/SUSPEND_SAVE_STATE/SUSPEND_POWER_DOWN are not adequate
for suspend-to-disk.

When doing suspend to disk, I need to stop all devices, do atomic copy
of state, and restart them to be able to write memory image to disk.

What do you think about this? [I do not think SAVE_STATE is what
typical driver will do. IMO typical driver will just do nothing on
suspend and reinit device on resume. This reflects it. For drivers
that need to save/resume, I propose they do it in STOP/START.]

Take long look at suspend-to-disk. It is pretty tricky.

								Pavel

Following operations are needed for suspend/resume:

STOP_DEVICE
	brings device into silent state. (Called from process context,
	interrupts enabled.)

Silent state:
	* device may not do any DMA
	* when someone asks for operation, device may BUG()

START_DEVICE
	brings device back from silent state. Driver state (everything 
	in memory; local variables, kernel state, everything) might be
	lost between STOP_DEVICE and START_DEVICE. (Called from process
	context, interrupts enabled.)

DEINIT_DEVICE
	bring device into such state that BIOS and/or operating system
	is able to initialize the device.

INIT_DEVICE
	initialize device from state after poweron to silent state or
	working state. If you bring it to the working state, make sure
	your START_DEVICE handler can survive that.

What is this all good for?

Normal boot:

* kernel initializes devices as it allways did and boots
* user presses Ctrl-Alt-Del
* DEINIT_DEVICE is called

Suspend to RAM:

* kernel initializes devices as it allways did and boots
* user asks for suspend-to-ram
*   STOP_DEVICE is called
*     DEINIT_DEVICE is called
*     everything but RAM is powered down
*     INIT_DEVICE is called
*   START_DEVICE is called

Suspend to disk:

* kernel initializes devices as it allways did and boots
* user asks for suspend-to-disk
* kernel stops all userland tasks
* kernel frees enough memory
*   STOP_DEVICE is called
*   interrupts are disabled and atomic copy of memory is done
*   START_DEVICE is called
* kernel writes copy of memory into swapspace
*   DEINIT_DEVICE is called
*   machine goes powerdown
* another (!) kernel initializes devices as it allways did and boots
* machine realizes it is resume, not normal boot at late stage of boot
*   new kernel reads copy of old memory
*   STOP_DEVICE is called in new kernel
*   interrupts are disabled and memory is atomically copied back
*   START_DEVICE is called in old kernel
* old kernel is up and running

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
