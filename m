Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTI3QOy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbTI3QOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:14:54 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:36065 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261735AbTI3QOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:14:50 -0400
Date: Tue, 30 Sep 2003 18:13:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ivo van Doorn <ivd@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] setkeycodes with 2.6.0-test5 / -test6
Message-ID: <20030930161347.GA27198@ucw.cz>
References: <20030930095308.19043.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930095308.19043.qmail@linuxmail.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 10:53:08AM +0100, Ivo van Doorn wrote:
> Hi!
> 

> I'va been working on a kernelpatch for the 2.6 test kernel named the
> Funkey patch. This patch has been created by Rick van Rein for 2.2 and
> 2.4 kernels: website is here: http://rck.vanrein.org/linux/funkey.

> When i ported this patch to 2.6 I run into small problem., which also
> occurs when no patch is applied.  First I will give a small
> explanation on how the Funkey patch works:

> Modern keyboards have extra multimedia keys (think of the "www" "mail"
> "search" sound volume etc.) By using setkeycodes to give these buttons
> a keycode and in the keymap giving that keycode a highbyte the key
> gets picked up by the funkey patch and instead of sending the signal
> through /dev/console, it gets send through /dev/funkey. Using the
> matching daemon the /dev/funkey can be read and programs can be
> launched when the buton is pressed. "www" button can for example start
> lynx, or mozilla or whatever.

You shouldn't need any patch for 2.6 to implement this functionality.
Basically you need to modify the funkey daemon to do this:

1) Open /proc/bus/input/devices and read it to find out which device
   is the system keyboard.
2) Open the correct /dev/input/event? device
3) Program the scancode/keycode mappings using the EVIOCSKEYCODE
   ioctl()
4) Use the EVIOCGRAB ioctl() to prevent any other program to get
   keycodes from the keyboard.
5) Open /dev/uinput and create a new virtual keyboard
6) Read events from /dev/input/event? and process them. Either forward
   them to /dev/uinput (normal keys) or do whatever action is needed
   (fun keys)

Does that sound reasonable?

Another option is to omit steps 4 and 5, and just let the extra keys
reach the applications. If they're not mapped in kernel/xfree keymaps,
they'll be simply ignored.

One more thing: Microsoft standardized some of the WWW/Multimedia keys.
I'll be changing the default scancode/keycode/rawmode tables to support
them soon.

> The problem in ran into was exactly at the beginning of the entire proces: Mapping the keys.
> I tried several keys to test the patch on a 2.6.0-test5 and a 2.6.0-test6 kernel.
> First key I tried was my "www" key.
> showkey -s output was:
> 0xe0 0x32 0xe0 0xb2

I'm sorry, but showkey -s lies on 2.6. To get the real data, use either
'dmesg' if the key doesn't work (and you'll see a "Unknown scancode"
message) or evtest /dev/input/event?, where you'll see input events with
predefined keycodes.

> showkey -k output was:
> keycode 0 press
> keycode 1 release
> keycode 22 release
> keycode 0 release
> keycode 1 release
> keycode 22 release

This is extended medium raw mode. The 0 is a 'magic' prefix informing
the next two bytes will contain a 14-bit keycode.

> The showkey -k output was unchanged after I ran the command
> setkeycodes e032 89

Yes, because the scancode of that key is not e032 in 2.6.

> When testing if the setkeycodes command was correct I used it on a 2.4.20 kernel as well. This time it worked.
> 
> I repeated the same test with the window buttons between the "alt" and "Control"
> showkey -k output was always:
> keycode 125 pressed
> keycode 125 released
> 
> setkeycodes e05b 89
> did not help. keycode for this key remained 125.
> 
> Before everybody starts shouting my patch is mostl likely the problem:
> These results were with an unpatched version of the kernel...
> Off course nothing changed when I applied my patch.
> 

> Personally I guess this means a small bug in the setkeycodes of the
> kernel, unless I am doing everything wrong?

Andries considers it a bug. I don't. It just works differently than in 2.4.

> 
> Ivo
> -- 
> ______________________________________________
> http://www.linuxmail.org/
> Now with e-mail forwarding for only US$5.95/yr
> 
> Powered by Outblaze
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
