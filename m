Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWCNXXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWCNXXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWCNXXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:23:05 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:24796 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750876AbWCNXXE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:23:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PylkoqJXnHrCQNAPzyUuzNrPhSJt8UwwvvKsr1wCAT6Pzrc1tVuSmlenOk0dn5Lv4wPAFiOfzURxlp9NQ6PTD2B5woDnfsqMJ2NZKRr8njAMH+3xnioXZo2KfRfyI/xcmqoZMSKBqzb9lPp0c3+BNj5EkLBBgU2Wp6Z72MDzZUM=
Message-ID: <305c16960603141523u5b6e96bbxd46d9ec39aeda56f@mail.gmail.com>
Date: Tue, 14 Mar 2006 20:23:00 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: usbkbd not reporting unknown keys
Cc: dtor_core@ameritech.net, vojtech@suse.cz
In-Reply-To: <305c16960603141510g72def22bmd0043d5f71d9ef6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <305c16960603081130g5367ddb3m4cbcf39a9253a087@mail.gmail.com>
	 <305c16960603081225m68c26ff7wd3b73621cfb81d9a@mail.gmail.com>
	 <d120d5000603081247i69f9e7dbm6ef614f50140227f@mail.gmail.com>
	 <305c16960603081334k25ce9a89g132876d4c9246fc6@mail.gmail.com>
	 <d120d5000603090543p3446b4a0sddaaa031ad2513ca@mail.gmail.com>
	 <305c16960603091230r32038a86mbefc6d80bedb24ab@mail.gmail.com>
	 <305c16960603141510g72def22bmd0043d5f71d9ef6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i worked on this problem a little bit more today, the following
patch makes jstest usable for me:

--- jstest.c.old    2006-03-14 19:48:36.000000000 -0300
+++ jstest.c    2006-03-14 19:34:53.000000000 -0300
 @@ -113,7 +113,8 @@

     printf("and %d buttons (", buttons);
     for (i = 0; i < buttons; i++)
-        printf("%s%s", i > 0 ? ", " : "", button_names[btnmap[i] - BTN_MISC]);
+        if ((btnmap[i] >= BTN_MISC) && (btnmap[i] < sizeof(btnmap)))
+            printf("%s%s", i > 0 ? ", " : "", button_names[btnmap[i]
- BTN_MISC]);
     puts(").");

     printf("Testing ... (interrupt to exit)\n");

Now i can see it reports a joystick device of 37 axes and 12 buttons.
Ive played with it for a while and the only events i can trigger are
button 7 8 and 9, for left right and middle mouse button respectively.
All the others dont seem to change.

Btw this is the result of cat /proc/bus/input/devices:

I: Bus=0003 Vendor=045e Product=00e3 Version=0053
N: Name="Microsft Microsoft Wireless Optical Desktop# 2.20"
P: Phys=usb-0000:00:02.0-1 /input0
S: Sysfs=/class/input/input0
H: Handlers=kbd event0
B: EV=120003
B: KEY=10000 7 ff800000 7ff febeffdf f3cfffff ffffffff fffffffe
B: LED=7

I: Bus=0003 Vendor=045e Product=00e3 Version=0053
 N: Name="Microsft Microsoft Wireless Optical Desktop# 2.20"
P: Phys=usb-0000:00:02.0-1/input1
S: Sysfs=/class/input/input1
H: Handlers=kbd mouse0 js0 event1
B: EV=10000f
B: KEY=c0002 400 0 c000000 1f0001 10f80 78007 ffe739fa d941d7ff
febeffdf ffefffff ffffffff fffffffe
B: REL=fc3
B: ABS=ffffff01 701ff

The joystick in question is ofcourse js0, which is registered together
with the mouse.

So, is this hid-input's fault for registering my mouse as a joystick,
my mouse for reporting its a joystick device, or something else?
If its my mouse's fault, is it possible to blacklist it, and use some
kind of quirk to fix this?

Sorry to send this twice, gmail screwed up the no html subpart rule.
