Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVLZCJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVLZCJW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 21:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVLZCJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 21:09:22 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:64653 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750974AbVLZCJV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 21:09:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bnJpvxfTe9x54iNzBVeiFGeMEze7BV5ljdAo/BTRUex1scVIdex2VuYnJMOYpbCjHqBBP5hLNBdPYIuH1P0q8sW5a4yK8qfvg00eaF7CJ+7eYx3e/XirMEmsFyub5s6RrHw+6m1GgWRkblp39QQetvBkyTa4CLpcPr/x1OhFbWI=
Message-ID: <e18c2fef0512251809s2ce834c9maf8d52b983246337@mail.gmail.com>
Date: Sun, 25 Dec 2005 18:09:19 -0800
From: Andrew Chuah <hachuah@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Need help on sending 5 consecutive USB keyboard LED on's.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just bought an IPAC-VE from www.ultimarc.com. It is basically a USB
keyboard emulator and I can hook it up to my arcade joystick to play MAME.
Now, the problem is that there is no programming utility for it in Linux, so
I am taking a look at trying to make one. There was one written in 2002 at
http://www.zumbrovalley.net/ipacutil/ but it no longer works for kernel 2.6.

The problem is that the way the PC talks to the emulator is by sending
keyboard LED signals. The first handshake is done by PC sending 5 "all LED
on" codes, and the emulator replies by sending a "z". So, I downloaded the
source for ipacutil and ran it, but it didn't work. I looked through the
kernel source (I'm running 2.6.9), and it looked like Linux doesn't send 2
"on" events consecutively.

So, I made the following changes in drivers/input/input.c:
        case EV_LED:

//            if (code > LED_MAX || !test_bit(code, dev->ledbit) ||
!!test_bit(code, dev->led) == value) {
            if (code > LED_MAX || !test_bit(code, dev->ledbit)) {
                printk(KERN_WARNING "Failed to turn on LED in input.c");
                return;
            }
            if (value == 1) {
                printk(KERN_WARNING "Setting LED now in input.c");
                set_bit(code, dev->led);
            } else if (value == 0) {
                printk(KERN_WARNING "Clearing LED now in input.c");
                clear_bit(code, dev->led);
            }
            // change_bit(code, dev->led);
            if (dev->event) dev->event(dev, type, code, value);

            break;

Instead of change_bit, I used set_bit and clear_bit. I also changed
drivers/char/keyboard.c

void setledstate(struct kbd_struct *kbd, unsigned int led)
{
    if (!(led & ~7)) {
        ledioctl = led;
        ledstate = 0xff; -- added this line
        printk(KERN_WARNING "In setledstate: flushing ledstate");
        kbd->ledmode = LED_SHOW_IOCTL;
    } else {
        printk(KERN_WARNING "In setledstate: in else");
        kbd->ledmode = LED_SHOW_FLAGS;
    }
    set_leds();
}


After all this, I modprobe evbug, and I see that ipacutil is "sending"
5 all LED ons, according to the log messages. However, I still don't
get a response. Is there something else I'm missing??? Can someone who
is more knowledgable point me to how to send all LED ons 5 times?

thx,
andrew
