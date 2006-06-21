Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWFUKBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWFUKBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWFUKBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:01:47 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:58258 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1751466AbWFUKBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:01:47 -0400
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: dtor_core@ameritech.net, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>
Date: Wed, 21 Jun 2006 11:01:43 +0100
Message-Id: <E1FszWp-0004zt-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [Ubuntu PATCH] input: allow root to inject unknown scan codes
In-Reply-To: <4498D9F6.6020700@oracle.com>
References: <4498D9F6.6020700@oracle.com>

Randy Dunlap <randy.dunlap@oracle.com> wrote:
> Allow root to inject unknown scan codes for input device.

I should probably describe what this does. The current code refuses to 
synthesise any keyboard events that don't appear in the mask of 
supported keycodes for the associated device. We've found that it's 
sometimes helpful to be able to inject "fake" keyboard events through 
the keyboard device. Consider the following scenario:

1) User presses ACPI hotkey that corresponds to volume up
2) Userspace turns ACPI event into volume up key, either via uinput or 
injecting into an existing /dev/input node
3) HAL fires off a dbus event based on the volume up key (removes the 
need for media players to do unpleasent things with xgrabkey)

Using the existing /dev/input/whatever node, this is all 
straightforward. Using uinput, we either need a daemon that provides a 
uinput device or a new uinput device every time an ACPI hotkey is 
pressed. The former solution requires building some sort of IPC 
mechanism, and the latter means that every key will generate a line in 
dmesg (input: foo as /class/input/input3, and so on) and HAL will have 
to notice a new event device, bind to it, launch the keyboard listener 
daemon, fire off the dbus message, notice that the device has vanished 
and then shut stuff down again. So injection through the keyboard device 
is much simpler.

At the moment this fails if the keycode doesn't correspond to one 
present in the keyboard mask - the input layer drops it on the floor 
instead. I'm not sure that there's an especially good reason for that, 
so we removed the check in order to make it easier to put as many input 
events through the input layer as possible.

(In the future where we have food pills and flying cars and Linux has 
become Atomic Fresh Linux, all these things generating acpi events 
should probably be converted into proper input drivers instead)
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
