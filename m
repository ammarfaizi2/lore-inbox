Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318358AbSGRWNg>; Thu, 18 Jul 2002 18:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318360AbSGRWNg>; Thu, 18 Jul 2002 18:13:36 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:6785 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S318358AbSGRWNf>;
	Thu, 18 Jul 2002 18:13:35 -0400
Date: Fri, 19 Jul 2002 00:16:19 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: willy@debian.org
Cc: jsimmons@transvirtual.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 broken on headless boxes
Message-ID: <20020718221619.GA16292@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 02 at 22:45, Matthew Wilcox wrote:
> On Thu, Jul 18, 2002 at 11:42:18PM +0200, Petr Vandrovec wrote:
> > CONFIG_VGA_CONSOLE/CONFIG_DUMMY_CONSOLE determines whether your VT can
> > be created at all - maybe _CONSOLE suffix is misleading - without
> > having at least one displaying device virtual terminals cannot be build.
> > I always thought that CONFIG_DUMMY_CONSOLE cannot be unset, but
> > apparently it can...
> > 
> > And BTW, when such configuration worked for you last time? It does not
> > look to me like that it should ever work.
> 
> erm, 2.5.25 worked, and i didn't change the .config between 2.5.25 and
> 2.5.26 (just ran make oldconfig).

Got it. It was introduced in console.c:1.13 change from jsimmons. Before
this change we did not registered tty driver:

con_init says:
  const char* display_desc = NULL;
  if (conswitchp) display_desc = conswitchp->con_startup();
  if (!display_desc) {
     fg_console = 0;
     return;
  }
  ...
  if (tty_register_driver(&console_driver)) ...

so we did not registered VT subsystem and panic did not happened:
instead of that you got 'cannot open initial console' or something
like that...

But after change tty_register_driver is invoked (through vty_init)
unconditionally from tty_io.c, where it depends only on CONFIG_VT.

So quick untested fix is 

--- a/drivers/char/console.c	Tue Jul 16 01:22:31 2002
+++ b/drivers/char/console.c	Fri Jul 19 00:12:01 2002
@@ -2487,6 +2487,9 @@
 
 int __init vty_init(void)
 {
+	if (!conswitchp) {
+		return 0;
+	}
 	memset(&console_driver, 0, sizeof(struct tty_driver));
 	console_driver.magic = TTY_DRIVER_MAGIC;
 	console_driver.name = "vc/%d";

But I'll leave final decision at James, maybe he want to support 
VT without underlying console, and testing almost same condition
on two places looks suspicious to me. Either we need blank timer
and console, or do not. But registering one half in vty_init,
and second half in con_init?
                                            Best regards,
                                                Petr Vandrovec
                                                  
