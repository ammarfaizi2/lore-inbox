Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbTIPOci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTIPOcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:32:14 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:23312 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261898AbTIPOcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:32:05 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Ramon Casellas <casellas@infres.enst.fr>, Patrick Mochel <mochel@osdl.org>
Subject: Re: Bug/Oops Power Management with linux-2.6.0-test5-mm2
Date: Tue, 16 Sep 2003 22:29:17 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0309151006060.950-100000@localhost.localdomain> <Pine.LNX.4.56.0309161431230.11872@gandalf.localdomain>
In-Reply-To: <Pine.LNX.4.56.0309161431230.11872@gandalf.localdomain>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309162229.17737.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 September 2003 20:34, Ramon Casellas wrote:
> 
> The only problem now is that if I suspend, when resuming, neither the
> mouse nor the NIC works, but it's getting much better.
> 
> 
> with 
> echo -n disk > /sys/power/state
> 
> Stopping tasks: ===================================================================
>  stopping tasks failed (1 tasks remaining)
>  Restarting tasks...<6> Strange, artsd not stopped
>   done
> 
> IIRC, I only have to kill artsd before hibernating...
> 
> 

As to the mouse, i8042 wont survice suspend. Its a bit tricky
but reloading the module works. 

However I was unable to convince modprobe to load i8042 so it 
won't work before rc.sysinit runs.

1) You can use the little patch below

--- linux-2.6.0-test4-Vanilla/drivers/input/serio/Kconfig       2003-09-05 18:07:10.000000000 +0800
+++ linux-2.6.0-test5-mhf63/drivers/input/serio/Kconfig 2003-09-16 21:16:38.000000000 +0800
@@ -19,7 +19,7 @@
          as a module, say M here and read <file:Documentation/modules.txt>.

 config SERIO_I8042
-       tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
+       tristate "i8042 PC Keyboard controller"
        default y
        depends on SERIO
        ---help---

2) Config i8042 as a module in input device support
  CONFIG_SERIO_I8042=m

3) Add near top of rc.sysinit
  modprobe i8042

4) In your script Note you must use a script because once you
remove the module so goes the keyboard ;)

rmmod i8042
echo -n mem > /sys/power/state
modprobe i8042

As to the NIC, I suspect PCI interrupt links die.
  Note the output of /proc/interrupts _before_ and _after_
  suspend. 

  I expect the interrupts not to increase after suspend.

If other devices connected to PCI such as PCMCIA or USB (sound ?)
have trouble after suspend _and_ reloading the module does not 
work, this is the likely cause.

Regards
Michael


