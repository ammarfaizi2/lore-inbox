Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbWJNJZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWJNJZh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 05:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWJNJZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 05:25:37 -0400
Received: from twin.jikos.cz ([213.151.79.26]:695 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1161046AbWJNJZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 05:25:36 -0400
Date: Sat, 14 Oct 2006 11:23:34 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
       v4l-dvb-maintainer@linuxtv.org, linux-dvb@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] I2C && DVB: fix recursive locking lockped warning in
 i2c_transfer()
Message-ID: <Pine.LNX.4.64.0610141117440.29022@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting the following lockdep warning (with 2.6.19-rc1-mm1, but that 
probably doesn't matter too much) during initialization of my AVerMedia 
AverTV DVB-T USB 2.0 (A800) DVB tuner:

=============================================
[ INFO: possible recursive locking detected ]
2.6.19-rc1-mm1 #4
---------------------------------------------
khubd/451 is trying to acquire lock:
(&adap->bus_lock){--..}, at: [<f8902177>] i2c_transfer+0x23/0x40
[i2c_core]

but task is already holding lock:
(&adap->bus_lock){--..}, at: [<f8902177>] i2c_transfer+0x23/0x40
[i2c_core]

other info that might help us debug this:
1 lock held by khubd/451:
#0: (&adap->bus_lock){--..}, at: [<f8902177>] i2c_transfer+0x23/0x40
[i2c_core]

stack backtrace:
[<c0103b69>] dump_trace+0x65/0x1a2
[<c0103cb6>] show_trace_log_lvl+0x10/0x20
[<c0103f84>] show_trace+0xa/0xc
[<c0103f99>] dump_stack+0x13/0x15
[<c0132ea4>] __lock_acquire+0x7bd/0xa05
[<c01333c1>] lock_acquire+0x5c/0x7b
[<c034b683>] __mutex_lock_slowpath+0xab/0x1de
[<f8902177>] i2c_transfer+0x23/0x40 [i2c_core]
[<f88fa1bf>] dibx000_i2c_gated_tuner_xfer+0x166/0x185 [dibx000_common]
[<f8902183>] i2c_transfer+0x2f/0x40 [i2c_core]
[<f891f04b>] mt2060_readreg+0x4b/0x69 [mt2060]
[<f891f45e>] mt2060_attach+0x40/0x1ea [mt2060]
[<f895f468>] dibusb_dib3000mc_tuner_attach+0x126/0x16c
[ ... ]

etc (the USB subsystem stacktrace stripped). 

The obvious reason is that dibusb_dib3000mc is calling i2c_transfer() 
recursively - first call is issued for the DVB frontend and second call is 
issued for the actual adapter (or whatever the correct DVB terminology 
is).

RFC: I have fixed this by adding the 'depth' field to the struct i2c_adapter, and
setting this field to represent 'logical' nesting of i2c adapters (i.e. to represent
the ordering in which they have to lock when recursing). In this case, depth == 0 for
the DVB frontend and depth == 1 for the adapter). This could probably be useful for 
other devices using I2C, but I have not yet checked. Would this be acceptable by the
I2C people?

Note: when the lockdep_set_subclass() patch makes it into mainline 
(currently only in input tree, but Dmitry told me that it's on its way 
up), we could get rid of mutex_lock_nested() in the i2c_transfer(), and 
set the lock class during initialization of the lock in i2c_add_adapter(), 
if desired.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

--- 

[PATCH] I2C && DVB: fix recursive locking lockped warning in i2c_transfer()

The following callchain can happen and is OK: dibusb_dib3000mc_tuner_attach ->
mt2060_attach -> mt2060_readreg -> i2c_transfer -> dibx000_i2c_gated_tuner_xfer 
-> i2c_transfer. Teach lockdep that recursive locking of adap->bus_lock inside 
i2c_transfer() is OK in such case.


 drivers/i2c/i2c-core.c                       |    2 +-
 drivers/media/dvb/dvb-usb/dvb-usb-i2c.c      |    2 ++
 drivers/media/dvb/frontends/dibx000_common.c |    2 ++
 include/linux/i2c.h                          |    1 +
 4 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 7ca81f4..1f9262d 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -603,7 +603,7 @@ #ifdef DEBUG
 		}
 #endif
 
-		mutex_lock(&adap->bus_lock);
+		mutex_lock_nested(&adap->bus_lock, adap->depth);
 		ret = adap->algo->master_xfer(adap,msgs,num);
 		mutex_unlock(&adap->bus_lock);
 
diff --git a/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c b/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c
index 55ba020..0d380f8 100644
--- a/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c
+++ b/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c
@@ -27,6 +27,8 @@ #else
 #endif
 	d->i2c_adap.algo      = d->props.i2c_algo;
 	d->i2c_adap.algo_data = NULL;
+	/* DVB adapter locks after DVB frontend */
+	d->i2c_adap.depth = 1;
 
 	i2c_set_adapdata(&d->i2c_adap, d);
 
diff --git a/drivers/media/dvb/frontends/dibx000_common.c b/drivers/media/dvb/frontends/dibx000_common.c
index a18c8f4..5397946 100644
--- a/drivers/media/dvb/frontends/dibx000_common.c
+++ b/drivers/media/dvb/frontends/dibx000_common.c
@@ -111,6 +111,8 @@ static int i2c_adapter_init(struct i2c_a
 	i2c_adap->class     = I2C_CLASS_TV_DIGITAL,
 	i2c_adap->algo      = algo;
 	i2c_adap->algo_data = NULL;
+	/* DVB frontend locks before DVB adapter */
+	i2c_adap->depth = 0;
 	i2c_set_adapdata(i2c_adap, mst);
 	if (i2c_add_adapter(i2c_adap) < 0)
 		return -ENODEV;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 9b5d047..0e3a4dc 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -218,6 +218,7 @@ struct i2c_adapter {
 	/* data fields that are valid for all devices	*/
 	struct mutex bus_lock;
 	struct mutex clist_lock;
+	unsigned short depth; 		/* "logical" nesting of devices (for lockdep) */
 
 	int timeout;
 	int retries;


-- 
Jiri Kosina
