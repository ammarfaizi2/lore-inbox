Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbUKIFyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbUKIFyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUKIFyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:54:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:53899 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261370AbUKIF2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:28:02 -0500
Date: Mon, 8 Nov 2004 21:27:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: mingo@elte.hu, diffie@gmail.com, linux-kernel@vger.kernel.org,
       diffie@blazebox.homeip.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: 2.6.10-rc1-mm3
Message-Id: <20041108212747.33b6e14a.akpm@osdl.org>
In-Reply-To: <20041108224259.GA14506@kroah.com>
References: <9dda349204110611043e093bca@mail.gmail.com>
	<20041107024841.402c16ed.akpm@osdl.org>
	<20041108075934.GA4602@elte.hu>
	<20041107234225.02c2f9b6.akpm@osdl.org>
	<20041108224259.GA14506@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> So I don't see how that could be failing here.  And why I don't see this
>  on my boxes...

OK, progress.  The oops is due to CONFIG_LEGACY_PTY_COUNT=512.  I assume
anything greater than 256 will trigger it.

- tty_register_driver() calls tty_register_device() for 512 devices.

- tty_register_device() calls pty_line_name() for the 512 devices, but
  pty_line_name() only understands 256 devices.  After that, it starts
  returning duplicated names.

- class_simple_device_add() gets an -EEXIST return from
  class_device_register() and then tries to kfree local variable s_dev, but
  it's already free.  Presumably all that icky refcounting under
  class_device_register() did this for us already.  Can you fix this one
  Greg?  Just enable slab debugging, set CONFIG_LEGACY_PTY_COUNT=512 and
  watch the fun.

As for the limitation of 256 legacy ptys: we should either raise it by
cooking up new device names or limit it to 256 in config.  The latter, I
guess.  Is there a requirement to support more than 256 legacy ptys?





Limit the number of legacy ptys to 256.  pty_line_name() isn't capable of
generating more than 256 unique names.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/char/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/char/Kconfig~limit-CONFIG_LEGACY_PTY_COUNT drivers/char/Kconfig
--- 25/drivers/char/Kconfig~limit-CONFIG_LEGACY_PTY_COUNT	2004-11-08 21:22:46.843719848 -0800
+++ 25-akpm/drivers/char/Kconfig	2004-11-08 21:23:23.496147832 -0800
@@ -478,6 +478,7 @@ config LEGACY_PTYS
 config LEGACY_PTY_COUNT
 	int "Maximum number of legacy PTY in use"
 	depends on LEGACY_PTYS
+	range 1 256
 	default "256"
 	---help---
 	  The maximum number of legacy PTYs that can be used at any one time.
_

