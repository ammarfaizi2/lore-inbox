Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbUCMD61 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 22:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUCMD61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 22:58:27 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:41369 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263042AbUCMD6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 22:58:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH - take 3] atkbd shaddup
Date: Fri, 12 Mar 2004 22:58:14 -0500
User-Agent: KMail/1.6.1
Cc: Matthew Galgoci <mgalgoci@redhat.com>, akpm@osdl.org, <tytso@mit.edu>
References: <Pine.LNX.4.44.0403122015400.2910-100000@lacrosse.corp.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0403122015400.2910-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403122258.15551.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 12 March 2004 08:17 pm, Matthew Galgoci wrote:
> > > Andrew,
> > > 
> > > I can't be the only person to be annoyed by the "too many keys
> > > pressed" error message that often gets spewed across the console
> > > when I am typing fast. This patch turns that error message (and
> > > others) into info message. Also, one debug message was turned into
> > > info, and a couple of warnings were turned into info where I thought
> > > it made sense.
> > 
> > I'd go even further.  Do we need to print the "too many keys pressed"
> > message at *all*?  Why would anyone care?
> 
> atkbd shaddup - Take 3 - I suck again.
>

Hi, 

I agree that "too many keys pressed" message is annoying; I have some
objections to the rest of the changes:

>  	if (atkbd->id == 0xaca1 && atkbd->translated) {
> -		printk(KERN_ERR "atkbd.c: NCD terminal keyboards are only supported on non-translating\n");
> -		printk(KERN_ERR "atkbd.c: controllers. Use i8042.direct=1 to disable translation.\n");
> +		printk(KERN_INFO "atkbd.c: NCD terminal keyboards are only supported on non-translating\n");
> +		printk(KERN_INFO "atkbd.c: controllers. Use i8042.direct=1 to disable translation.\n");
>  		return -1;

This message has severity "error" since at this point because keyboard
initialization fails and you are left without a keyboard.

>  	if (atkbd_command(atkbd, NULL, ATKBD_CMD_ENABLE)) {
> -		printk(KERN_ERR "atkbd.c: Failed to enable keyboard on %s\n",
> +		printk(KERN_WARNING "atkbd.c: Failed to enable keyboard on %s\n",
>  			atkbd->serio->phys);
>  		return -1;
>  	}

Ditto. This is a hard error, not a warning, because keyboard will not be
available if atkbd fails to enable it.  

>  		case ATKBD_KEY_UNKNOWN:
> -			printk(KERN_WARNING "atkbd.c: Unknown key %s (%s set %d, code %#x on %s).\n",
> +			printk(KERN_INFO "atkbd.c: Unknown key %s (%s set %d, code %#x on %s).\n",
>  				atkbd->release ? "released" : "pressed",
>  				atkbd->translated ? "translated" : "raw", 
>  				atkbd->set, code, serio->phys);
>  			if (atkbd->translated && atkbd->set == 2 && code == 0x7a)
> -				printk(KERN_WARNING "atkbd.c: This is an XFree86 bug. It shouldn't access"
> +				printk(KERN_INFO "atkbd.c: This is an XFree86 bug. It shouldn't access"
>  					" hardware directly.\n");
>  			else
> -				printk(KERN_WARNING "atkbd.c: Use 'setkeycodes %s%02x <keycode>' to make it known.\n",						code & 0x80 ? "e0" : "", code & 0x7f);
> +				printk(KERN_INFO "atkbd.c: Use 'setkeycodes %s%02x <keycode>' to make it known.\n",						code & 0x80 ? "e0" : "", code & 0x7f);
>  			break;

Somebody either pokes directly in the keyboard controller guts or keymap is
incomplete - both deserve a warning, although wording could be better.

>  
>          if (!dev) {
> -                printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
> +                 printk(KERN_INFO "atkbd.c: reconnect request, but serio is disconnected, ignoring...\n");
>                  return -1;
>          }

Might be useful while debugging reconnect code but otherwise normal situation
and is not worth mentioning.

-- 
Dmitry
