Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTKBKbM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 05:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbTKBKbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 05:31:12 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:2834 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261614AbTKBKbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 05:31:10 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: DervishD <raul@pleyades.net>
Subject: Re: /dev/input/mice doesn't work in test9?
Date: Sun, 2 Nov 2003 13:12:15 +0300
User-Agent: KMail/1.5.3
Cc: Shawn Willden <shawn-lkml@willden.org>, linux-kernel@vger.kernel.org
References: <E1AFUFz-0008jt-00.arvidjaar-mail-ru@f20.mail.ru> <20031101205646.GB9129@DervishD>
In-Reply-To: <20031101205646.GB9129@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311021312.15902.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 November 2003 23:56, DervishD wrote:
[...]
>
>     My problem is a bit different. I'm using 2.4.21, with an USB
> mouse. I have 'input' built-in, and hid and mousedev as modules.
> Well, if I do a cat /dev/mouse (c 13 32) or /dev/mice (c 13 63), I
> always get ENODEV, unless I manually load hid and mousedev. The logs
> doesn't say anything like 'cannot find driver for char-major-13' or
> whatever. It just seems that 'mousedev' is never autoloaded :?
>

Well, major 13 is for all input devices not for mousedev alone. You have input 
built-in which means there is no reason for kernel to try autoload driver for 
char-13 as it is already available.

You may add explicit per-minor autoloading to input.c, see 
drivers/input/input.c:input_open_file()

> > The whole input subsystem has changed between 2.4 and 2.6.
> > Unfortunately, input sysbsystem hotplugging is not currently
> > implemented. Your best bet is to forcibly load mousedev during
> > boot.
>
>     But hotplugging is for connecting and disconnecting devices, not
> for autoloading modules. I mean, if I access any char-major-13, and
> the corresponding modules is not loaded, it should autoload :?
>
>     The rest of devices in my system are properly autoloaded on
> demand, but hid and mousedev are not :( Am I doing something wrong?
>

no. Loading on demand simply is not supported.

If you are using hotplug, both should be loaded by hotplug. IMHO it is also 
the right way to go.

> > Alternatively look into hotplug for usermap, it allows provide fake
> > mapping for modules - you could add mapping from UDB IDs of oyur
> > mouse to mousedev. Loading it statically is likely to be more
> > simple.
>

which is of course already available in hotplug, sorry for confusion. 

>     Exactly... Anyway, if I build 'mousedev' into my kernel instead
> of making it a module, should I do the same with 'hid' or
> char-major-13 *is* autoloaded?
>

char-major-13 is 'input'. Period. It is not mousedev or whatever. For this 
reason it must implement its own autoloading if desired. Cf. misc driver.

Hid will never be autoloaded (without manual configuration) on access to 
mousedev because they are independent. Mousedev provides use interface to any 
mouse, not just USB mouse handled by HID. Mousedev has no way to know what 
hardware is connected until driver for it has registered with input layer. So 
hid should be loaded when mouse is detected (i.e. by hotplug) or manually if 
you always know you have USB mouse. Building it in kernel is the easiest way 
to ensure it is always available.

-andrey

