Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbTHXXAi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 19:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTHXXAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 19:00:38 -0400
Received: from main.gmane.org ([80.91.224.249]:2446 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261331AbTHXXAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 19:00:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Charles Lepple <clepple@ghz.cc>
Subject: [2.6] i8042 module prevents APM suspend on ThinkPad 770
Date: Sun, 24 Aug 2003 19:00:36 -0400
Message-ID: <3F494394.3020700@ghz.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Vojtech Pavlik <vojtech@suse.cz>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I isolated my ThinkPad 770's APM suspend problem[1] to the i8042 
driver. Basically, every time I try and suspend the laptop (apm -s, the 
lid switch, or the power/hibernate button), the laptop goes out to lunch 
for a little while (display is still on), and then prints "apm: suspend: 
Unable to enter requested state" after about 30 seconds.

Around 2.5.31 (continuing through 2.6.0-test3), I could get by with the 
old keyboard driver. However, in later kernels, unless I make the i8042 
driver a module, and (warning: kludge ahead) have the APM scripts remove 
and reinsert it before and after suspend, the APM BIOS rejects the 
suspend request.

Other subsystems, such as the UHCI USB HC driver, are properly shut down 
and restarted through the driver framework. Maybe the i8042 driver needs 
to do something similar?

Here are the relevant .config bits that make things work:

# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y # <-- probably not necessary
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=m
CONFIG_SERIO_I8042=m
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=m
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

CONFIG_SERIO and CONFIG_KEYBOARD_ATKBD could probably both be =y, as I 
had both modules loaded when suspend started to work again (although 
i8042 still had to be unloaded).

I will try some other configurations later (as well as 2.6.0-test4, 
although I didn't see any i8042 code changes in the -test4 announcement).

My only guess is that the i8042_timer routine is reading the data 
register after the APM BIOS expects the system to quiesce. I can't back 
that up quite yet, but I'll try and test that later.

Thanks to Stephen Rothwell and Alan Cox for convincing me that this 
regression wasn't due to any of the APM changes between 2.5.31 and 
2.5.32 :-)

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=105949030715144&w=4

-- 
Charles Lepple <ghz.cc!clepple>
http://www.ghz.cc/charles/


