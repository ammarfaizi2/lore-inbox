Return-Path: <linux-kernel-owner+w=401wt.eu-S1762443AbWLJUAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762443AbWLJUAm (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 15:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762448AbWLJUAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 15:00:42 -0500
Received: from web52905.mail.yahoo.com ([206.190.49.15]:31705 "HELO
	web52905.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1762457AbWLJUAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 15:00:41 -0500
Message-ID: <20061210200040.99790.qmail@web52905.mail.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=zNXBlhSxCckNSQjLAL/VindOrYiQlWN0/PTHIMKQLpxW3T27YSU26ZdjHqbSCkN17DxpjbPeZcHBp8ZqRIytRKWrMJoh9ezaCBQZgKq7A1/PP6pfg0u51U4GZqUEbZgFpNwgx46daOiOoTfO6eX0G97w45Sa8k7T3ra1Y/c++jI=;
X-YMail-OSG: U1krcXYVM1nEDq1U0EoQIR5YCe2DWhCfxA5aJW02d.8u4FyswZzo3ZcTdcqFhFQZvKGUpVMch187uh9DAk0OPfCKkupoPOjRQjDj37jAthBeuohzyhHh6KQtsC.m5LNjAB73wneDVc.JStY-
Date: Sun, 10 Dec 2006 20:00:40 +0000 (GMT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: [OOPS] [PATCH] Avoid race when deregistering the IR control for dvb-usb
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does anyone plan on fixing this oops any time soon? I first reported it back with 2.6.16.2!

http://lkml.org/lkml/2006/4/14/58

Basically, the work item function is dvb_usb_read_remote_control():

        INIT_WORK(&d->rc_query_work, dvb_usb_read_remote_control, d);

and the last piece of work it does is:

        schedule_delayed_work(&d->rc_query_work,msecs_to_jiffies(d->props.rc_interval));

Hence you need to call "cancel_rearming_delayed_work()" and not "cancel_delayed_work()", correct?
I certainly haven't seen this oops reoccur since I applied this patch.

Cheers,
Chris

--- linux-2.6.16/drivers/media/dvb/dvb-usb/dvb-usb-remote.c.orig        2006-01-03
20:04:51.000000000 +0000
+++ linux-2.6.16/drivers/media/dvb/dvb-usb/dvb-usb-remote.c     2006-05-08 20:44:44.000000000
+0100
@@ -138,7 +138,7 @@
 int dvb_usb_remote_exit(struct dvb_usb_device *d)
 {
        if (d->state & DVB_USB_STATE_REMOTE) {
-               cancel_delayed_work(&d->rc_query_work);
+               cancel_rearming_delayed_work(&d->rc_query_work);
                flush_scheduled_work();
                input_unregister_device(d->rc_input_dev);
        }


Send instant messages to your online friends http://uk.messenger.yahoo.com 
