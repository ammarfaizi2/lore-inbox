Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVCaGUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVCaGUF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 01:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVCaGUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 01:20:04 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:20237 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262493AbVCaGTZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 01:19:25 -0500
Date: Wed, 30 Mar 2005 22:19:24 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Ulrich Lauther <ulrich.lauther@siemens.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: problem with suspending linux-2.6.12-rc1
Message-ID: <20050331061924.GA32548@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328222049.GE1389@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 12:20:49AM +0200, Pavel Machek wrote:
> On Po 28-03-05 10:03:06, Ulrich Lauther wrote:
> > > > since upgrading from 2.6.11 to 2.6.12-rc1 software suspend doesn't work 
> > > > anymore for me:
> > > > The last I see when suspending (echo 4 > /proc/acpi/sleep) is a
> > > > message refering to eth0, then when "writing to swap space"
> > > > should appear, the system stops.

This sounds similar to the swsusp hang I started seeing when I upgraded
from 2.6.11 to 2.6.12-rc1; my touchpad was failing to reinitialize, so
input was calling hotplug which tried to exec /sbin/hotplug, and the
exec() blocked because userland was stopped.  If you do Sysrq-T and see
a process with a stack trace like
	wait_for_completion
	call_usermodehelper
	kobject_hotplug
	kobject_del
	class_device_del
	class_device_unregister
	mousedev_disconnect
	input_unregister_device
then you're seeing the same kind of bug.

Try the patch below from Dmitry.

-andy

===================================================================

Input: serio - do not attempt to immediately disconnect port if
       resume failed, let kseriod take care of it. Otherwise we
       may attempt to unregister associated input devices which
       will generate hotplug events which are not handled well
       during swsusp.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |    1 -
 1 files changed, 1 deletion(-)

Index: dtor/drivers/input/serio/serio.c
===================================================================
--- dtor.orig/drivers/input/serio/serio.c
+++ dtor/drivers/input/serio/serio.c
@@ -779,7 +779,6 @@ static int serio_resume(struct device *d
 	struct serio *serio = to_serio_port(dev);
 
 	if (!serio->drv || !serio->drv->reconnect || serio->drv->reconnect(serio)) {
-		serio_disconnect_port(serio);
 		/*
 		 * Driver re-probing can take a while, so better let kseriod
 		 * deal with it.

