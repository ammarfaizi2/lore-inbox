Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUCKOny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUCKOny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:43:54 -0500
Received: from smtp-out.girce.epro.fr ([195.6.195.146]:25988 "EHLO
	srvsec2.girce.epro.fr") by vger.kernel.org with ESMTP
	id S261366AbUCKOld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:41:33 -0500
Message-ID: <00e401c40776$2a37eca0$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: [PATCH] therm_adt7467 update
Date: Thu, 11 Mar 2004 15:35:56 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00E1_01C4077E.8BB25350"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00E1_01C4077E.8BB25350
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

the fan driver I wrote for adt746x looks like it only handles the adt7467
chip found in iBooks G4; but it also handles the adt7460 chip found in the
Powerbook G4 Alu.
Here's a patch that renames the file to therm_adt746x.c and updates
Kconfig and Makefile. I also changed a few lines in therm_adt746x.c after
renaming it (the patch contains these), the diff is here for clarity:

--- drivers/macintosh/therm_adt7467.c 2004-03-11 03:55:37.000000000 +0100
+++ drivers/macintosh.new/therm_adt746x.c 2004-03-11 15:21:00.000000000
+0100
@@ -49,7 +49,7 @@
 static int fan_speed = -1;

 MODULE_AUTHOR("Colin Leroy <colin@colino.net>");
-MODULE_DESCRIPTION("Driver for ADT7467 thermostat in iBook G4");
+MODULE_DESCRIPTION("Driver for ADT746x thermostat in iBook G4 and
Powerbook G4 Alu");
 MODULE_LICENSE("GPL");

 MODULE_PARM(limit_adjust,"i");
@@ -161,7 +161,7 @@
 }

 static struct i2c_driver thermostat_driver = {
- .name  ="Apple Thermostat ADT7467",
+ .name  ="Apple Thermostat ADT746x",
  .id  =0xDEAD7467,
  .flags  =I2C_DF_NOTIFY,
  .attach_adapter =&attach_thermostat,
@@ -494,9 +494,6 @@
  struct device_node* np;
  u32 *prop;

- /* Currently, we only deal with the iBook G4, we will support
-  * all "2003" powerbooks later on
-  */
  np = of_find_node_by_name(NULL, "fan");
  if (!np)
   return -ENODEV;
-- 
Colin
  This message represents the official view of the voices
  in my head.

------=_NextPart_000_00E1_01C4077E.8BB25350
Content-Type: application/octet-stream;
	name="746x.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="746x.patch"

diff -urN drivers/macintosh/Kconfig drivers/macintosh.new/Kconfig=0A=
--- drivers/macintosh/Kconfig	2004-03-11 03:55:26.000000000 +0100=0A=
+++ drivers/macintosh.new/Kconfig	2004-03-11 15:21:30.000000000 +0100=0A=
@@ -174,7 +174,7 @@=0A=
 	  This driver provides some thermostat and fan control for the desktop=0A=
 	  G4 "Windtunnel"=0A=
 =0A=
-config THERM_ADT7467=0A=
+config THERM_ADT746X=0A=
 	tristate "Support for thermal mgmnt on laptops with ADT 7467 chipset"=0A=
 	depends on I2C && I2C_KEYWEST && PPC_PMAC && !PPC_PMAC64=0A=
 	help=0A=
diff -urN drivers/macintosh/Makefile drivers/macintosh.new/Makefile=0A=
--- drivers/macintosh/Makefile	2004-03-11 03:55:44.000000000 +0100=0A=
+++ drivers/macintosh.new/Makefile	2004-03-11 15:21:14.000000000 +0100=0A=
@@ -25,4 +25,4 @@=0A=
 =0A=
 obj-$(CONFIG_THERM_PM72)	+=3D therm_pm72.o=0A=
 obj-$(CONFIG_THERM_WINDTUNNEL)	+=3D therm_windtunnel.o=0A=
-obj-$(CONFIG_THERM_ADT7467)	+=3D therm_adt7467.o=0A=
+obj-$(CONFIG_THERM_ADT746X)	+=3D therm_adt746x.o=0A=
diff -urN drivers/macintosh/therm_adt7467.c =
drivers/macintosh.new/therm_adt7467.c=0A=
--- drivers/macintosh/therm_adt7467.c	2004-03-11 03:55:37.000000000 +0100=0A=
+++ drivers/macintosh.new/therm_adt7467.c	1970-01-01 01:00:00.000000000 =
+0100=0A=
@@ -1,562 +0,0 @@=0A=
-/*=0A=
- * Device driver for the i2c thermostat found on the iBook G4, Albook G4=0A=
- *=0A=
- * Copyright (C) 2003, 2004 Colin Leroy, Rasmus Rohde, Benjamin =
Herrenschmidt=0A=
- *=0A=
- * Documentation from=0A=
- * =
http://www.analog.com/UploadedFiles/Data_Sheets/115254175ADT7467_pra.pdf=0A=
- * =
http://www.analog.com/UploadedFiles/Data_Sheets/3686221171167ADT7460_b.pd=
f=0A=
- *=0A=
- */=0A=
-=0A=
-#include <linux/config.h>=0A=
-#include <linux/types.h>=0A=
-#include <linux/module.h>=0A=
-#include <linux/errno.h>=0A=
-#include <linux/kernel.h>=0A=
-#include <linux/delay.h>=0A=
-#include <linux/sched.h>=0A=
-#include <linux/i2c.h>=0A=
-#include <linux/slab.h>=0A=
-#include <linux/init.h>=0A=
-#include <linux/spinlock.h>=0A=
-#include <linux/smp_lock.h>=0A=
-#include <linux/wait.h>=0A=
-#include <asm/prom.h>=0A=
-#include <asm/machdep.h>=0A=
-#include <asm/io.h>=0A=
-#include <asm/system.h>=0A=
-#include <asm/sections.h>=0A=
-#include <asm/of_device.h>=0A=
-=0A=
-#undef DEBUG=0A=
-=0A=
-#define CONFIG_REG   0x40=0A=
-#define MANUAL_MASK  0xe0=0A=
-#define AUTO_MASK    0x20=0A=
-=0A=
-static u8 TEMP_REG[3]    =3D {0x26, 0x25, 0x27}; /* local, cpu, gpu */=0A=
-static u8 LIMIT_REG[3]   =3D {0x6b, 0x6a, 0x6c}; /* local, cpu, gpu */=0A=
-static u8 MANUAL_MODE[2] =3D {0x5c, 0x5d};       =0A=
-static u8 REM_CONTROL[2] =3D {0x00, 0x40};=0A=
-static u8 FAN_SPEED[2]   =3D {0x28, 0x2a};=0A=
-static u8 FAN_SPD_SET[2] =3D {0x30, 0x31};=0A=
-=0A=
-static u8 default_limits_local[3] =3D {70, 50, 70};    /* local, cpu, =
gpu */=0A=
-static u8 default_limits_chip[3] =3D {80, 65, 80};    /* local, cpu, =
gpu */=0A=
-=0A=
-static int limit_adjust =3D 0;=0A=
-static int fan_speed =3D -1;=0A=
-=0A=
-MODULE_AUTHOR("Colin Leroy <colin@colino.net>");=0A=
-MODULE_DESCRIPTION("Driver for ADT7467 thermostat in iBook G4");=0A=
-MODULE_LICENSE("GPL");=0A=
-=0A=
-MODULE_PARM(limit_adjust,"i");=0A=
-MODULE_PARM_DESC(limit_adjust,"Adjust maximum temperatures (50=B0C cpu, =
70=B0C gpu) by N =B0C.");=0A=
-MODULE_PARM(fan_speed,"i");=0A=
-MODULE_PARM_DESC(fan_speed,"Specify fan speed (0-255) when lim < temp < =
lim+8 (default 128)");=0A=
-=0A=
-struct thermostat {=0A=
-	struct i2c_client	clt;=0A=
-	u8			cached_temp[3];=0A=
-	u8			initial_limits[3];=0A=
-	u8			limits[3];=0A=
-	int			last_speed[2];=0A=
-	int			overriding[2];=0A=
-};=0A=
-=0A=
-static enum {ADT7460, ADT7467} therm_type;=0A=
-static int therm_bus, therm_address;=0A=
-static struct of_device * of_dev;=0A=
-static struct thermostat* thermostat;=0A=
-static pid_t monitor_thread_id;=0A=
-static int monitor_running;=0A=
-static struct completion monitor_task_compl;=0A=
-=0A=
-static int attach_one_thermostat(struct i2c_adapter *adapter, int addr, =
int busno);=0A=
-static void write_both_fan_speed(struct thermostat *th, int speed);=0A=
-static void write_fan_speed(struct thermostat *th, int speed, int fan);=0A=
-=0A=
-static int=0A=
-write_reg(struct thermostat* th, int reg, u8 data)=0A=
-{=0A=
-	u8 tmp[2];=0A=
-	int rc;=0A=
-	=0A=
-	tmp[0] =3D reg;=0A=
-	tmp[1] =3D data;=0A=
-	rc =3D i2c_master_send(&th->clt, (const char *)tmp, 2);=0A=
-	if (rc < 0)=0A=
-		return rc;=0A=
-	if (rc !=3D 2)=0A=
-		return -ENODEV;=0A=
-	return 0;=0A=
-}=0A=
-=0A=
-static int=0A=
-read_reg(struct thermostat* th, int reg)=0A=
-{=0A=
-	u8 reg_addr, data;=0A=
-	int rc;=0A=
-=0A=
-	reg_addr =3D (u8)reg;=0A=
-	rc =3D i2c_master_send(&th->clt, &reg_addr, 1);=0A=
-	if (rc < 0)=0A=
-		return rc;=0A=
-	if (rc !=3D 1)=0A=
-		return -ENODEV;=0A=
-	rc =3D i2c_master_recv(&th->clt, (char *)&data, 1);=0A=
-	if (rc < 0)=0A=
-		return rc;=0A=
-	return data;=0A=
-}=0A=
-=0A=
-static int=0A=
-attach_thermostat(struct i2c_adapter *adapter)=0A=
-{=0A=
-	unsigned long bus_no;=0A=
-=0A=
-	if (strncmp(adapter->name, "uni-n", 5))=0A=
-		return -ENODEV;=0A=
-	bus_no =3D simple_strtoul(adapter->name + 6, NULL, 10);=0A=
-	if (bus_no !=3D therm_bus)=0A=
-		return -ENODEV;=0A=
-	return attach_one_thermostat(adapter, therm_address, bus_no);=0A=
-}=0A=
-=0A=
-static int=0A=
-detach_thermostat(struct i2c_adapter *adapter)=0A=
-{=0A=
-	struct thermostat* th;=0A=
-	int i;=0A=
-	=0A=
-	if (thermostat =3D=3D NULL)=0A=
-		return 0;=0A=
-=0A=
-	th =3D thermostat;=0A=
-=0A=
-	if (monitor_running) {=0A=
-		monitor_running =3D 0;=0A=
-		wait_for_completion(&monitor_task_compl);=0A=
-	}=0A=
-		=0A=
-	printk(KERN_INFO "adt746x: Putting max temperatures back from %d, %d, =
%d,"=0A=
-		" to %d, %d, %d, (=B0C)\n", =0A=
-		th->limits[0], th->limits[1], th->limits[2],=0A=
-		th->initial_limits[0], th->initial_limits[1], th->initial_limits[2]);=0A=
-	=0A=
-	for (i =3D 0; i < 3; i++)=0A=
-		write_reg(th, LIMIT_REG[i], th->initial_limits[i]);=0A=
-=0A=
-	write_both_fan_speed(th, -1);=0A=
-=0A=
-	i2c_detach_client(&th->clt);=0A=
-=0A=
-	thermostat =3D NULL;=0A=
-=0A=
-	kfree(th);=0A=
-=0A=
-	return 0;=0A=
-}=0A=
-=0A=
-static struct i2c_driver thermostat_driver =3D {  =0A=
-	.name		=3D"Apple Thermostat ADT7467",=0A=
-	.id		=3D0xDEAD7467,=0A=
-	.flags		=3DI2C_DF_NOTIFY,=0A=
-	.attach_adapter	=3D&attach_thermostat,=0A=
-	.detach_adapter	=3D&detach_thermostat,=0A=
-};=0A=
-=0A=
-static int read_fan_speed(struct thermostat *th, u8 addr)=0A=
-{=0A=
-	u8 tmp[2];=0A=
-	u16 res;=0A=
-	=0A=
-	/* should start with low byte */=0A=
-	tmp[1] =3D read_reg(th, addr);=0A=
-	tmp[0] =3D read_reg(th, addr + 1);=0A=
-	=0A=
-	res =3D tmp[1] + (tmp[0] << 8);=0A=
-	return (90000*60)/res;=0A=
-}=0A=
-=0A=
-static void write_both_fan_speed(struct thermostat *th, int speed)=0A=
-{=0A=
-	write_fan_speed(th, speed, 0);=0A=
-	if (therm_type =3D=3D ADT7460)=0A=
-		write_fan_speed(th, speed, 1);=0A=
-}=0A=
-=0A=
-static void write_fan_speed(struct thermostat *th, int speed, int fan)=0A=
-{=0A=
-	u8 manual;=0A=
-	=0A=
-	if (speed > 0xff) =0A=
-		speed =3D 0xff;=0A=
-	else if (speed < -1) =0A=
-		speed =3D 0;=0A=
-	=0A=
-	if (therm_type =3D=3D ADT7467 && fan =3D=3D 1)=0A=
-		return;=0A=
-	=0A=
-	if (th->last_speed[fan] !=3D speed) {=0A=
-		if (speed =3D=3D -1)=0A=
-			printk(KERN_INFO "adt746x: Setting speed to: automatic for %s =
fan.\n",=0A=
-				fan?"GPU":"CPU");=0A=
-		else=0A=
-			printk(KERN_INFO "adt746x: Setting speed to: %d for %s fan.\n",=0A=
-				speed, fan?"GPU":"CPU");=0A=
-	} else=0A=
-		return;=0A=
-	=0A=
-	if (speed >=3D 0) {=0A=
-		manual =3D read_reg(th, MANUAL_MODE[fan]);=0A=
-		write_reg(th, MANUAL_MODE[fan], manual|MANUAL_MASK);=0A=
-		write_reg(th, FAN_SPD_SET[fan], speed);=0A=
-	} else {=0A=
-		/* back to automatic */=0A=
-		if(therm_type =3D=3D ADT7460) {=0A=
-			manual =3D read_reg(th, MANUAL_MODE[fan]) & (~MANUAL_MASK);=0A=
-			write_reg(th, MANUAL_MODE[fan], manual|REM_CONTROL[fan]);=0A=
-		} else {=0A=
-			manual =3D read_reg(th, MANUAL_MODE[fan]);=0A=
-			write_reg(th, MANUAL_MODE[fan], manual&(~AUTO_MASK));=0A=
-		}=0A=
-	}=0A=
-	=0A=
-	th->last_speed[fan] =3D speed;			=0A=
-}=0A=
-=0A=
-static int monitor_task(void *arg)=0A=
-{=0A=
-	struct thermostat* th =3D arg;=0A=
-	u8 temps[3];=0A=
-	u8 lims[3];=0A=
-	int i;=0A=
-#ifdef DEBUG=0A=
-	int mfan_speed;=0A=
-#endif=0A=
-	=0A=
-	lock_kernel();=0A=
-	daemonize("kfand");=0A=
-	unlock_kernel();=0A=
-	strcpy(current->comm, "thermostat");=0A=
-	monitor_running =3D 1;=0A=
-=0A=
-	while(monitor_running)=0A=
-	{=0A=
-		set_task_state(current, TASK_UNINTERRUPTIBLE);=0A=
-		schedule_timeout(2*HZ);=0A=
-=0A=
-		/* Check status */=0A=
-		/* local   : chip */=0A=
-		/* remote 1: CPU ?*/=0A=
-		/* remote 2: GPU ?*/=0A=
-#ifndef DEBUG=0A=
-		if (fan_speed !=3D -1) {=0A=
-#endif=0A=
-			for (i =3D 0; i < 3; i++) {=0A=
-				temps[i]  =3D read_reg(th, TEMP_REG[i]);=0A=
-				lims[i]   =3D th->limits[i];=0A=
-			}=0A=
-#ifndef DEBUG=0A=
-		}=0A=
-#endif		=0A=
-		if (fan_speed !=3D -1) {=0A=
-			int lastvar =3D 0;		/* for iBook */=0A=
-			for (i =3D 1; i < 3; i++) {	/* we don't care about local sensor */=0A=
-				int started =3D 0;=0A=
-				int fan_number =3D (therm_type =3D=3D ADT7460 && i =3D=3D 2);=0A=
-				int var =3D temps[i] - lims[i];=0A=
-				if (var > 8) {=0A=
-					if (th->overriding[fan_number] =3D=3D 0)=0A=
-						printk(KERN_INFO "adt746x: Limit exceeded by %d=B0C, overriding =
specified fan speed for %s.\n",=0A=
-							var, fan_number?"GPU":"CPU");=0A=
-					th->overriding[fan_number] =3D 1;=0A=
-					write_fan_speed(th, 255, fan_number);=0A=
-					started =3D 1;=0A=
-				} else if ((!th->overriding[fan_number] || var < 6) && var > 0) {=0A=
-					if (th->overriding[fan_number] =3D=3D 1)=0A=
-						printk(KERN_INFO "adt746x: Limit exceeded by %d=B0C, setting =
speed to specified for %s.\n",=0A=
-							var, fan_number?"GPU":"CPU");					=0A=
-					th->overriding[fan_number] =3D 0;=0A=
-					write_fan_speed(th, fan_speed, fan_number);=0A=
-					started =3D 1;=0A=
-				} else if (var < -1) {=0A=
-					/* don't stop iBook fan if GPU is cold and CPU is not=0A=
-					 * so cold (lastvar >=3D -1) */=0A=
-					if (therm_type =3D=3D ADT7460 || lastvar < -1 || i =3D=3D 1) {=0A=
-						if (th->last_speed[fan_number] !=3D 0)=0A=
-							printk(KERN_INFO "adt746x: Stopping %s fan.\n",=0A=
-								fan_number?"GPU":"CPU");=0A=
-						write_fan_speed(th, 0, fan_number);=0A=
-					}=0A=
-				}=0A=
-				=0A=
-				lastvar =3D var;=0A=
-				=0A=
-				if (started && therm_type =3D=3D ADT7467)=0A=
-					break; /* we don't want to re-stop the fan=0A=
-						* if CPU is heating and GPU is not */=0A=
-			}=0A=
-		}=0A=
-#ifdef DEBUG=0A=
-		mfan_speed =3D read_fan_speed(th, FAN_SPEED[0]);=0A=
-		/* only one fan in the iBook G4 */=0A=
-				=0A=
-		if (temps[0] !=3D th->cached_temp[0]=0A=
-		||  temps[1] !=3D th->cached_temp[1]=0A=
-		||  temps[2] !=3D th->cached_temp[2]) {=0A=
-			printk(KERN_INFO "adt746x: Temperature infos:"=0A=
-					 " thermostats: %d,%d,%d =B0C;"=0A=
-					 " limits: %d,%d,%d =B0C;"=0A=
-					 " fan speed: %d RPM\n",=0A=
-				temps[0], temps[1], temps[2],=0A=
-				lims[0],  lims[1],  lims[2],=0A=
-				mfan_speed);=0A=
-		}=0A=
-		th->cached_temp[0] =3D temps[0];=0A=
-		th->cached_temp[1] =3D temps[1];=0A=
-		th->cached_temp[2] =3D temps[2];=0A=
-#endif		=0A=
-	}=0A=
-=0A=
-	complete_and_exit(&monitor_task_compl, 0);=0A=
-	return 0;=0A=
-}=0A=
-=0A=
-static void=0A=
-set_limit(struct thermostat *th, int i)=0A=
-{=0A=
-		/* Set CPU limit higher to avoid powerdowns */ =0A=
-		th->limits[i] =3D default_limits_chip[i] + limit_adjust;=0A=
-		write_reg(th, LIMIT_REG[i], th->limits[i]);=0A=
-		=0A=
-		/* set our limits to normal */=0A=
-		th->limits[i] =3D default_limits_local[i] + limit_adjust;=0A=
-}=0A=
-	=0A=
-static int=0A=
-attach_one_thermostat(struct i2c_adapter *adapter, int addr, int busno)=0A=
-{=0A=
-	struct thermostat* th;=0A=
-	int rc;=0A=
-	int i;=0A=
-=0A=
-	if (thermostat)=0A=
-		return 0;=0A=
-	th =3D (struct thermostat *)kmalloc(sizeof(struct thermostat), =
GFP_KERNEL);=0A=
-	if (!th)=0A=
-		return -ENOMEM;=0A=
-	memset(th, 0, sizeof(*th));=0A=
-	th->clt.addr =3D addr;=0A=
-	th->clt.adapter =3D adapter;=0A=
-	th->clt.driver =3D &thermostat_driver;=0A=
-	th->clt.id =3D 0xDEAD7467;=0A=
-	strcpy(th->clt.name, "thermostat");=0A=
-=0A=
-	rc =3D read_reg(th, 0);=0A=
-	if (rc < 0) {=0A=
-		printk(KERN_ERR "adt746x: Thermostat failed to read config from bus =
%d !\n",=0A=
-			busno);=0A=
-		kfree(th);=0A=
-		return -ENODEV;=0A=
-	}=0A=
-	/* force manual control to start the fan quieter */=0A=
-	=0A=
-	if (fan_speed =3D=3D -1)=0A=
-		fan_speed=3D128;=0A=
-	=0A=
-	if(therm_type =3D=3D ADT7460) {=0A=
-		printk(KERN_INFO "adt746x: ADT7460 initializing\n");=0A=
-		/* The 7460 needs to be started explicitly */=0A=
-		write_reg(th, CONFIG_REG, 1);=0A=
-	} else=0A=
-		printk(KERN_INFO "adt746x: ADT7467 initializing\n");=0A=
-=0A=
-	for (i =3D 0; i < 3; i++) {=0A=
-		th->initial_limits[i] =3D read_reg(th, LIMIT_REG[i]);=0A=
-		set_limit(th, i);=0A=
-	}=0A=
-	=0A=
-	printk(KERN_INFO "adt746x: Lowering max temperatures from %d, %d, %d"=0A=
-		" to %d, %d, %d (=B0C)\n", =0A=
-		th->initial_limits[0], th->initial_limits[1], th->initial_limits[2], =0A=
-		th->limits[0], th->limits[1], th->limits[2]);=0A=
-=0A=
-	thermostat =3D th;=0A=
-=0A=
-	if (i2c_attach_client(&th->clt)) {=0A=
-		printk("adt746x: Thermostat failed to attach client !\n");=0A=
-		thermostat =3D NULL;=0A=
-		kfree(th);=0A=
-		return -ENODEV;=0A=
-	}=0A=
-=0A=
-	/* be sure to really write fan speed the first time */=0A=
-	th->last_speed[0] =3D -2;=0A=
-	th->last_speed[1] =3D -2;=0A=
-	=0A=
-	if (fan_speed !=3D -1) {=0A=
-		write_both_fan_speed(th, 0);=0A=
-	} else {=0A=
-		write_both_fan_speed(th, -1);=0A=
-	}=0A=
-	=0A=
-	init_completion(&monitor_task_compl);=0A=
-	=0A=
-	monitor_thread_id =3D kernel_thread(monitor_task, th,=0A=
-		SIGCHLD | CLONE_KERNEL);=0A=
-=0A=
-	return 0;=0A=
-}=0A=
-=0A=
-/* =0A=
- * Now, unfortunately, sysfs doesn't give us a nice void * we could=0A=
- * pass around to the attribute functions, so we don't really have=0A=
- * choice but implement a bunch of them...=0A=
- *=0A=
- */=0A=
-#define BUILD_SHOW_FUNC_DEG(name, data)				\=0A=
-static ssize_t show_##name(struct device *dev, char *buf)	\=0A=
-{								\=0A=
-	return sprintf(buf, "%d=B0C\n", data);			\=0A=
-}=0A=
-#define BUILD_SHOW_FUNC_INT(name, data)				\=0A=
-static ssize_t show_##name(struct device *dev, char *buf)	\=0A=
-{								\=0A=
-	return sprintf(buf, "%d\n", data);			\=0A=
-}=0A=
-=0A=
-#define BUILD_STORE_FUNC_DEG(name, data)			\=0A=
-static ssize_t store_##name(struct device *dev, const char *buf, size_t =
n) \=0A=
-{								\=0A=
-	int val;						\=0A=
-	int i;							\=0A=
-	val =3D simple_strtol(buf, NULL, 10);			\=0A=
-	printk(KERN_INFO "Adjusting limits by %d=B0C\n", val);	\=0A=
-	limit_adjust =3D val;					\=0A=
-	for (i=3D0; i < 3; i++)					\=0A=
-		set_limit(thermostat, i);			\=0A=
-	return n;						\=0A=
-}=0A=
-=0A=
-#define BUILD_STORE_FUNC_INT(name, data)			\=0A=
-static ssize_t store_##name(struct device *dev, const char *buf, size_t =
n) \=0A=
-{								\=0A=
-	u32 val;						\=0A=
-	val =3D simple_strtoul(buf, NULL, 10);			\=0A=
-	if (val < 0 || val > 255)				\=0A=
-		return -EINVAL;					\=0A=
-	printk(KERN_INFO "Setting fan speed to %d\n", val);	\=0A=
-	data =3D val;						\=0A=
-	return n;						\=0A=
-}=0A=
-=0A=
-BUILD_SHOW_FUNC_DEG(cpu_temperature,	 (read_reg(thermostat, =
TEMP_REG[1])))=0A=
-BUILD_SHOW_FUNC_DEG(gpu_temperature,	 (read_reg(thermostat, =
TEMP_REG[2])))=0A=
-BUILD_SHOW_FUNC_DEG(cpu_limit,		 thermostat->limits[1])=0A=
-BUILD_SHOW_FUNC_DEG(gpu_limit,		 thermostat->limits[2])=0A=
-=0A=
-BUILD_SHOW_FUNC_INT(specified_fan_speed, fan_speed)=0A=
-BUILD_SHOW_FUNC_INT(cpu_fan_speed,	 (read_fan_speed(thermostat, =
FAN_SPEED[0])))=0A=
-BUILD_SHOW_FUNC_INT(gpu_fan_speed,	 (read_fan_speed(thermostat, =
FAN_SPEED[1])))=0A=
-=0A=
-BUILD_STORE_FUNC_INT(specified_fan_speed,fan_speed)=0A=
-BUILD_SHOW_FUNC_INT(limit_adjust,	 limit_adjust)=0A=
-BUILD_STORE_FUNC_DEG(limit_adjust,	 thermostat)=0A=
-		=0A=
-static DEVICE_ATTR(cpu_temperature,	S_IRUGO,=0A=
-		   show_cpu_temperature,NULL);=0A=
-static DEVICE_ATTR(gpu_temperature,	S_IRUGO,=0A=
-		   show_gpu_temperature,NULL);=0A=
-static DEVICE_ATTR(cpu_limit,		S_IRUGO,=0A=
-		   show_cpu_limit,	NULL);=0A=
-static DEVICE_ATTR(gpu_limit,		S_IRUGO,=0A=
-		   show_gpu_limit,	NULL);=0A=
-=0A=
-static DEVICE_ATTR(specified_fan_speed,	S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH,=0A=
-		   show_specified_fan_speed,store_specified_fan_speed);=0A=
-=0A=
-static DEVICE_ATTR(cpu_fan_speed,	S_IRUGO,=0A=
-		   show_cpu_fan_speed,	NULL);=0A=
-static DEVICE_ATTR(gpu_fan_speed,	S_IRUGO,=0A=
-		   show_gpu_fan_speed,	NULL);=0A=
-=0A=
-static DEVICE_ATTR(limit_adjust,	S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH,=0A=
-		   show_limit_adjust,	store_limit_adjust);=0A=
-=0A=
-=0A=
-static int __init=0A=
-thermostat_init(void)=0A=
-{=0A=
-	struct device_node* np;=0A=
-	u32 *prop;=0A=
-	=0A=
-	/* Currently, we only deal with the iBook G4, we will support=0A=
-	 * all "2003" powerbooks later on=0A=
-	 */=0A=
-	np =3D of_find_node_by_name(NULL, "fan");=0A=
-	if (!np)=0A=
-		return -ENODEV;=0A=
-	if (device_is_compatible(np, "adt7460"))=0A=
-		therm_type =3D ADT7460;=0A=
-	else if (device_is_compatible(np, "adt7467"))=0A=
-		therm_type =3D ADT7467;=0A=
-	else=0A=
-		return -ENODEV;=0A=
-=0A=
-	prop =3D (u32 *)get_property(np, "reg", NULL);=0A=
-	if (!prop)=0A=
-		return -ENODEV;=0A=
-	therm_bus =3D ((*prop) >> 8) & 0x0f;=0A=
-	therm_address =3D ((*prop) & 0xff) >> 1;=0A=
-=0A=
-	printk(KERN_INFO "adt746x: Thermostat bus: %d, address: 0x%02x, =
limit_adjust: %d, fan_speed: %d\n",=0A=
-		therm_bus, therm_address, limit_adjust, fan_speed);=0A=
-=0A=
-	of_dev =3D of_platform_device_create(np, "temperatures");=0A=
-	=0A=
-	if (of_dev =3D=3D NULL) {=0A=
-		printk(KERN_ERR "Can't register temperatures device !\n");=0A=
-		return -ENODEV;=0A=
-	}=0A=
-	=0A=
-	device_create_file(&of_dev->dev, &dev_attr_cpu_temperature);=0A=
-	device_create_file(&of_dev->dev, &dev_attr_gpu_temperature);=0A=
-	device_create_file(&of_dev->dev, &dev_attr_cpu_limit);=0A=
-	device_create_file(&of_dev->dev, &dev_attr_gpu_limit);=0A=
-	device_create_file(&of_dev->dev, &dev_attr_limit_adjust);=0A=
-	device_create_file(&of_dev->dev, &dev_attr_specified_fan_speed);=0A=
-	device_create_file(&of_dev->dev, &dev_attr_cpu_fan_speed);=0A=
-	if(therm_type =3D=3D ADT7460)=0A=
-		device_create_file(&of_dev->dev, &dev_attr_gpu_fan_speed);=0A=
-=0A=
-#ifndef CONFIG_I2C_KEYWEST=0A=
-	request_module("i2c-keywest");=0A=
-#endif=0A=
-=0A=
-	return i2c_add_driver(&thermostat_driver);=0A=
-}=0A=
-=0A=
-static void __exit=0A=
-thermostat_exit(void)=0A=
-{=0A=
-	if (of_dev) {=0A=
-		device_remove_file(&of_dev->dev, &dev_attr_cpu_temperature);=0A=
-		device_remove_file(&of_dev->dev, &dev_attr_gpu_temperature);=0A=
-		device_remove_file(&of_dev->dev, &dev_attr_cpu_limit);=0A=
-		device_remove_file(&of_dev->dev, &dev_attr_gpu_limit);=0A=
-		device_remove_file(&of_dev->dev, &dev_attr_limit_adjust);=0A=
-		device_remove_file(&of_dev->dev, &dev_attr_specified_fan_speed);=0A=
-		device_remove_file(&of_dev->dev, &dev_attr_cpu_fan_speed);=0A=
-		if(therm_type =3D=3D ADT7460)=0A=
-			device_remove_file(&of_dev->dev, &dev_attr_gpu_fan_speed);=0A=
-		of_device_unregister(of_dev);=0A=
-	}=0A=
-	i2c_del_driver(&thermostat_driver);=0A=
-}=0A=
-=0A=
-module_init(thermostat_init);=0A=
-module_exit(thermostat_exit);=0A=
diff -urN drivers/macintosh/therm_adt746x.c =
drivers/macintosh.new/therm_adt746x.c=0A=
--- drivers/macintosh/therm_adt746x.c	1970-01-01 01:00:00.000000000 +0100=0A=
+++ drivers/macintosh.new/therm_adt746x.c	2004-03-11 15:21:00.000000000 =
+0100=0A=
@@ -0,0 +1,559 @@=0A=
+/*=0A=
+ * Device driver for the i2c thermostat found on the iBook G4, Albook G4=0A=
+ *=0A=
+ * Copyright (C) 2003, 2004 Colin Leroy, Rasmus Rohde, Benjamin =
Herrenschmidt=0A=
+ *=0A=
+ * Documentation from=0A=
+ * =
http://www.analog.com/UploadedFiles/Data_Sheets/115254175ADT7467_pra.pdf=0A=
+ * =
http://www.analog.com/UploadedFiles/Data_Sheets/3686221171167ADT7460_b.pd=
f=0A=
+ *=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>=0A=
+#include <linux/types.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/errno.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/spinlock.h>=0A=
+#include <linux/smp_lock.h>=0A=
+#include <linux/wait.h>=0A=
+#include <asm/prom.h>=0A=
+#include <asm/machdep.h>=0A=
+#include <asm/io.h>=0A=
+#include <asm/system.h>=0A=
+#include <asm/sections.h>=0A=
+#include <asm/of_device.h>=0A=
+=0A=
+#undef DEBUG=0A=
+=0A=
+#define CONFIG_REG   0x40=0A=
+#define MANUAL_MASK  0xe0=0A=
+#define AUTO_MASK    0x20=0A=
+=0A=
+static u8 TEMP_REG[3]    =3D {0x26, 0x25, 0x27}; /* local, cpu, gpu */=0A=
+static u8 LIMIT_REG[3]   =3D {0x6b, 0x6a, 0x6c}; /* local, cpu, gpu */=0A=
+static u8 MANUAL_MODE[2] =3D {0x5c, 0x5d};       =0A=
+static u8 REM_CONTROL[2] =3D {0x00, 0x40};=0A=
+static u8 FAN_SPEED[2]   =3D {0x28, 0x2a};=0A=
+static u8 FAN_SPD_SET[2] =3D {0x30, 0x31};=0A=
+=0A=
+static u8 default_limits_local[3] =3D {70, 50, 70};    /* local, cpu, =
gpu */=0A=
+static u8 default_limits_chip[3] =3D {80, 65, 80};    /* local, cpu, =
gpu */=0A=
+=0A=
+static int limit_adjust =3D 0;=0A=
+static int fan_speed =3D -1;=0A=
+=0A=
+MODULE_AUTHOR("Colin Leroy <colin@colino.net>");=0A=
+MODULE_DESCRIPTION("Driver for ADT746x thermostat in iBook G4 and =
Powerbook G4 Alu");=0A=
+MODULE_LICENSE("GPL");=0A=
+=0A=
+MODULE_PARM(limit_adjust,"i");=0A=
+MODULE_PARM_DESC(limit_adjust,"Adjust maximum temperatures (50=B0C cpu, =
70=B0C gpu) by N =B0C.");=0A=
+MODULE_PARM(fan_speed,"i");=0A=
+MODULE_PARM_DESC(fan_speed,"Specify fan speed (0-255) when lim < temp < =
lim+8 (default 128)");=0A=
+=0A=
+struct thermostat {=0A=
+	struct i2c_client	clt;=0A=
+	u8			cached_temp[3];=0A=
+	u8			initial_limits[3];=0A=
+	u8			limits[3];=0A=
+	int			last_speed[2];=0A=
+	int			overriding[2];=0A=
+};=0A=
+=0A=
+static enum {ADT7460, ADT7467} therm_type;=0A=
+static int therm_bus, therm_address;=0A=
+static struct of_device * of_dev;=0A=
+static struct thermostat* thermostat;=0A=
+static pid_t monitor_thread_id;=0A=
+static int monitor_running;=0A=
+static struct completion monitor_task_compl;=0A=
+=0A=
+static int attach_one_thermostat(struct i2c_adapter *adapter, int addr, =
int busno);=0A=
+static void write_both_fan_speed(struct thermostat *th, int speed);=0A=
+static void write_fan_speed(struct thermostat *th, int speed, int fan);=0A=
+=0A=
+static int=0A=
+write_reg(struct thermostat* th, int reg, u8 data)=0A=
+{=0A=
+	u8 tmp[2];=0A=
+	int rc;=0A=
+	=0A=
+	tmp[0] =3D reg;=0A=
+	tmp[1] =3D data;=0A=
+	rc =3D i2c_master_send(&th->clt, (const char *)tmp, 2);=0A=
+	if (rc < 0)=0A=
+		return rc;=0A=
+	if (rc !=3D 2)=0A=
+		return -ENODEV;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+read_reg(struct thermostat* th, int reg)=0A=
+{=0A=
+	u8 reg_addr, data;=0A=
+	int rc;=0A=
+=0A=
+	reg_addr =3D (u8)reg;=0A=
+	rc =3D i2c_master_send(&th->clt, &reg_addr, 1);=0A=
+	if (rc < 0)=0A=
+		return rc;=0A=
+	if (rc !=3D 1)=0A=
+		return -ENODEV;=0A=
+	rc =3D i2c_master_recv(&th->clt, (char *)&data, 1);=0A=
+	if (rc < 0)=0A=
+		return rc;=0A=
+	return data;=0A=
+}=0A=
+=0A=
+static int=0A=
+attach_thermostat(struct i2c_adapter *adapter)=0A=
+{=0A=
+	unsigned long bus_no;=0A=
+=0A=
+	if (strncmp(adapter->name, "uni-n", 5))=0A=
+		return -ENODEV;=0A=
+	bus_no =3D simple_strtoul(adapter->name + 6, NULL, 10);=0A=
+	if (bus_no !=3D therm_bus)=0A=
+		return -ENODEV;=0A=
+	return attach_one_thermostat(adapter, therm_address, bus_no);=0A=
+}=0A=
+=0A=
+static int=0A=
+detach_thermostat(struct i2c_adapter *adapter)=0A=
+{=0A=
+	struct thermostat* th;=0A=
+	int i;=0A=
+	=0A=
+	if (thermostat =3D=3D NULL)=0A=
+		return 0;=0A=
+=0A=
+	th =3D thermostat;=0A=
+=0A=
+	if (monitor_running) {=0A=
+		monitor_running =3D 0;=0A=
+		wait_for_completion(&monitor_task_compl);=0A=
+	}=0A=
+		=0A=
+	printk(KERN_INFO "adt746x: Putting max temperatures back from %d, %d, =
%d,"=0A=
+		" to %d, %d, %d, (=B0C)\n", =0A=
+		th->limits[0], th->limits[1], th->limits[2],=0A=
+		th->initial_limits[0], th->initial_limits[1], th->initial_limits[2]);=0A=
+	=0A=
+	for (i =3D 0; i < 3; i++)=0A=
+		write_reg(th, LIMIT_REG[i], th->initial_limits[i]);=0A=
+=0A=
+	write_both_fan_speed(th, -1);=0A=
+=0A=
+	i2c_detach_client(&th->clt);=0A=
+=0A=
+	thermostat =3D NULL;=0A=
+=0A=
+	kfree(th);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static struct i2c_driver thermostat_driver =3D {  =0A=
+	.name		=3D"Apple Thermostat ADT746x",=0A=
+	.id		=3D0xDEAD7467,=0A=
+	.flags		=3DI2C_DF_NOTIFY,=0A=
+	.attach_adapter	=3D&attach_thermostat,=0A=
+	.detach_adapter	=3D&detach_thermostat,=0A=
+};=0A=
+=0A=
+static int read_fan_speed(struct thermostat *th, u8 addr)=0A=
+{=0A=
+	u8 tmp[2];=0A=
+	u16 res;=0A=
+	=0A=
+	/* should start with low byte */=0A=
+	tmp[1] =3D read_reg(th, addr);=0A=
+	tmp[0] =3D read_reg(th, addr + 1);=0A=
+	=0A=
+	res =3D tmp[1] + (tmp[0] << 8);=0A=
+	return (90000*60)/res;=0A=
+}=0A=
+=0A=
+static void write_both_fan_speed(struct thermostat *th, int speed)=0A=
+{=0A=
+	write_fan_speed(th, speed, 0);=0A=
+	if (therm_type =3D=3D ADT7460)=0A=
+		write_fan_speed(th, speed, 1);=0A=
+}=0A=
+=0A=
+static void write_fan_speed(struct thermostat *th, int speed, int fan)=0A=
+{=0A=
+	u8 manual;=0A=
+	=0A=
+	if (speed > 0xff) =0A=
+		speed =3D 0xff;=0A=
+	else if (speed < -1) =0A=
+		speed =3D 0;=0A=
+	=0A=
+	if (therm_type =3D=3D ADT7467 && fan =3D=3D 1)=0A=
+		return;=0A=
+	=0A=
+	if (th->last_speed[fan] !=3D speed) {=0A=
+		if (speed =3D=3D -1)=0A=
+			printk(KERN_INFO "adt746x: Setting speed to: automatic for %s =
fan.\n",=0A=
+				fan?"GPU":"CPU");=0A=
+		else=0A=
+			printk(KERN_INFO "adt746x: Setting speed to: %d for %s fan.\n",=0A=
+				speed, fan?"GPU":"CPU");=0A=
+	} else=0A=
+		return;=0A=
+	=0A=
+	if (speed >=3D 0) {=0A=
+		manual =3D read_reg(th, MANUAL_MODE[fan]);=0A=
+		write_reg(th, MANUAL_MODE[fan], manual|MANUAL_MASK);=0A=
+		write_reg(th, FAN_SPD_SET[fan], speed);=0A=
+	} else {=0A=
+		/* back to automatic */=0A=
+		if(therm_type =3D=3D ADT7460) {=0A=
+			manual =3D read_reg(th, MANUAL_MODE[fan]) & (~MANUAL_MASK);=0A=
+			write_reg(th, MANUAL_MODE[fan], manual|REM_CONTROL[fan]);=0A=
+		} else {=0A=
+			manual =3D read_reg(th, MANUAL_MODE[fan]);=0A=
+			write_reg(th, MANUAL_MODE[fan], manual&(~AUTO_MASK));=0A=
+		}=0A=
+	}=0A=
+	=0A=
+	th->last_speed[fan] =3D speed;			=0A=
+}=0A=
+=0A=
+static int monitor_task(void *arg)=0A=
+{=0A=
+	struct thermostat* th =3D arg;=0A=
+	u8 temps[3];=0A=
+	u8 lims[3];=0A=
+	int i;=0A=
+#ifdef DEBUG=0A=
+	int mfan_speed;=0A=
+#endif=0A=
+	=0A=
+	lock_kernel();=0A=
+	daemonize("kfand");=0A=
+	unlock_kernel();=0A=
+	strcpy(current->comm, "thermostat");=0A=
+	monitor_running =3D 1;=0A=
+=0A=
+	while(monitor_running)=0A=
+	{=0A=
+		set_task_state(current, TASK_UNINTERRUPTIBLE);=0A=
+		schedule_timeout(2*HZ);=0A=
+=0A=
+		/* Check status */=0A=
+		/* local   : chip */=0A=
+		/* remote 1: CPU ?*/=0A=
+		/* remote 2: GPU ?*/=0A=
+#ifndef DEBUG=0A=
+		if (fan_speed !=3D -1) {=0A=
+#endif=0A=
+			for (i =3D 0; i < 3; i++) {=0A=
+				temps[i]  =3D read_reg(th, TEMP_REG[i]);=0A=
+				lims[i]   =3D th->limits[i];=0A=
+			}=0A=
+#ifndef DEBUG=0A=
+		}=0A=
+#endif		=0A=
+		if (fan_speed !=3D -1) {=0A=
+			int lastvar =3D 0;		/* for iBook */=0A=
+			for (i =3D 1; i < 3; i++) {	/* we don't care about local sensor */=0A=
+				int started =3D 0;=0A=
+				int fan_number =3D (therm_type =3D=3D ADT7460 && i =3D=3D 2);=0A=
+				int var =3D temps[i] - lims[i];=0A=
+				if (var > 8) {=0A=
+					if (th->overriding[fan_number] =3D=3D 0)=0A=
+						printk(KERN_INFO "adt746x: Limit exceeded by %d=B0C, overriding =
specified fan speed for %s.\n",=0A=
+							var, fan_number?"GPU":"CPU");=0A=
+					th->overriding[fan_number] =3D 1;=0A=
+					write_fan_speed(th, 255, fan_number);=0A=
+					started =3D 1;=0A=
+				} else if ((!th->overriding[fan_number] || var < 6) && var > 0) {=0A=
+					if (th->overriding[fan_number] =3D=3D 1)=0A=
+						printk(KERN_INFO "adt746x: Limit exceeded by %d=B0C, setting =
speed to specified for %s.\n",=0A=
+							var, fan_number?"GPU":"CPU");					=0A=
+					th->overriding[fan_number] =3D 0;=0A=
+					write_fan_speed(th, fan_speed, fan_number);=0A=
+					started =3D 1;=0A=
+				} else if (var < -1) {=0A=
+					/* don't stop iBook fan if GPU is cold and CPU is not=0A=
+					 * so cold (lastvar >=3D -1) */=0A=
+					if (therm_type =3D=3D ADT7460 || lastvar < -1 || i =3D=3D 1) {=0A=
+						if (th->last_speed[fan_number] !=3D 0)=0A=
+							printk(KERN_INFO "adt746x: Stopping %s fan.\n",=0A=
+								fan_number?"GPU":"CPU");=0A=
+						write_fan_speed(th, 0, fan_number);=0A=
+					}=0A=
+				}=0A=
+				=0A=
+				lastvar =3D var;=0A=
+				=0A=
+				if (started && therm_type =3D=3D ADT7467)=0A=
+					break; /* we don't want to re-stop the fan=0A=
+						* if CPU is heating and GPU is not */=0A=
+			}=0A=
+		}=0A=
+#ifdef DEBUG=0A=
+		mfan_speed =3D read_fan_speed(th, FAN_SPEED[0]);=0A=
+		/* only one fan in the iBook G4 */=0A=
+				=0A=
+		if (temps[0] !=3D th->cached_temp[0]=0A=
+		||  temps[1] !=3D th->cached_temp[1]=0A=
+		||  temps[2] !=3D th->cached_temp[2]) {=0A=
+			printk(KERN_INFO "adt746x: Temperature infos:"=0A=
+					 " thermostats: %d,%d,%d =B0C;"=0A=
+					 " limits: %d,%d,%d =B0C;"=0A=
+					 " fan speed: %d RPM\n",=0A=
+				temps[0], temps[1], temps[2],=0A=
+				lims[0],  lims[1],  lims[2],=0A=
+				mfan_speed);=0A=
+		}=0A=
+		th->cached_temp[0] =3D temps[0];=0A=
+		th->cached_temp[1] =3D temps[1];=0A=
+		th->cached_temp[2] =3D temps[2];=0A=
+#endif		=0A=
+	}=0A=
+=0A=
+	complete_and_exit(&monitor_task_compl, 0);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static void=0A=
+set_limit(struct thermostat *th, int i)=0A=
+{=0A=
+		/* Set CPU limit higher to avoid powerdowns */ =0A=
+		th->limits[i] =3D default_limits_chip[i] + limit_adjust;=0A=
+		write_reg(th, LIMIT_REG[i], th->limits[i]);=0A=
+		=0A=
+		/* set our limits to normal */=0A=
+		th->limits[i] =3D default_limits_local[i] + limit_adjust;=0A=
+}=0A=
+	=0A=
+static int=0A=
+attach_one_thermostat(struct i2c_adapter *adapter, int addr, int busno)=0A=
+{=0A=
+	struct thermostat* th;=0A=
+	int rc;=0A=
+	int i;=0A=
+=0A=
+	if (thermostat)=0A=
+		return 0;=0A=
+	th =3D (struct thermostat *)kmalloc(sizeof(struct thermostat), =
GFP_KERNEL);=0A=
+	if (!th)=0A=
+		return -ENOMEM;=0A=
+	memset(th, 0, sizeof(*th));=0A=
+	th->clt.addr =3D addr;=0A=
+	th->clt.adapter =3D adapter;=0A=
+	th->clt.driver =3D &thermostat_driver;=0A=
+	th->clt.id =3D 0xDEAD7467;=0A=
+	strcpy(th->clt.name, "thermostat");=0A=
+=0A=
+	rc =3D read_reg(th, 0);=0A=
+	if (rc < 0) {=0A=
+		printk(KERN_ERR "adt746x: Thermostat failed to read config from bus =
%d !\n",=0A=
+			busno);=0A=
+		kfree(th);=0A=
+		return -ENODEV;=0A=
+	}=0A=
+	/* force manual control to start the fan quieter */=0A=
+	=0A=
+	if (fan_speed =3D=3D -1)=0A=
+		fan_speed=3D128;=0A=
+	=0A=
+	if(therm_type =3D=3D ADT7460) {=0A=
+		printk(KERN_INFO "adt746x: ADT7460 initializing\n");=0A=
+		/* The 7460 needs to be started explicitly */=0A=
+		write_reg(th, CONFIG_REG, 1);=0A=
+	} else=0A=
+		printk(KERN_INFO "adt746x: ADT7467 initializing\n");=0A=
+=0A=
+	for (i =3D 0; i < 3; i++) {=0A=
+		th->initial_limits[i] =3D read_reg(th, LIMIT_REG[i]);=0A=
+		set_limit(th, i);=0A=
+	}=0A=
+	=0A=
+	printk(KERN_INFO "adt746x: Lowering max temperatures from %d, %d, %d"=0A=
+		" to %d, %d, %d (=B0C)\n", =0A=
+		th->initial_limits[0], th->initial_limits[1], th->initial_limits[2], =0A=
+		th->limits[0], th->limits[1], th->limits[2]);=0A=
+=0A=
+	thermostat =3D th;=0A=
+=0A=
+	if (i2c_attach_client(&th->clt)) {=0A=
+		printk("adt746x: Thermostat failed to attach client !\n");=0A=
+		thermostat =3D NULL;=0A=
+		kfree(th);=0A=
+		return -ENODEV;=0A=
+	}=0A=
+=0A=
+	/* be sure to really write fan speed the first time */=0A=
+	th->last_speed[0] =3D -2;=0A=
+	th->last_speed[1] =3D -2;=0A=
+	=0A=
+	if (fan_speed !=3D -1) {=0A=
+		write_both_fan_speed(th, 0);=0A=
+	} else {=0A=
+		write_both_fan_speed(th, -1);=0A=
+	}=0A=
+	=0A=
+	init_completion(&monitor_task_compl);=0A=
+	=0A=
+	monitor_thread_id =3D kernel_thread(monitor_task, th,=0A=
+		SIGCHLD | CLONE_KERNEL);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* =0A=
+ * Now, unfortunately, sysfs doesn't give us a nice void * we could=0A=
+ * pass around to the attribute functions, so we don't really have=0A=
+ * choice but implement a bunch of them...=0A=
+ *=0A=
+ */=0A=
+#define BUILD_SHOW_FUNC_DEG(name, data)				\=0A=
+static ssize_t show_##name(struct device *dev, char *buf)	\=0A=
+{								\=0A=
+	return sprintf(buf, "%d=B0C\n", data);			\=0A=
+}=0A=
+#define BUILD_SHOW_FUNC_INT(name, data)				\=0A=
+static ssize_t show_##name(struct device *dev, char *buf)	\=0A=
+{								\=0A=
+	return sprintf(buf, "%d\n", data);			\=0A=
+}=0A=
+=0A=
+#define BUILD_STORE_FUNC_DEG(name, data)			\=0A=
+static ssize_t store_##name(struct device *dev, const char *buf, size_t =
n) \=0A=
+{								\=0A=
+	int val;						\=0A=
+	int i;							\=0A=
+	val =3D simple_strtol(buf, NULL, 10);			\=0A=
+	printk(KERN_INFO "Adjusting limits by %d=B0C\n", val);	\=0A=
+	limit_adjust =3D val;					\=0A=
+	for (i=3D0; i < 3; i++)					\=0A=
+		set_limit(thermostat, i);			\=0A=
+	return n;						\=0A=
+}=0A=
+=0A=
+#define BUILD_STORE_FUNC_INT(name, data)			\=0A=
+static ssize_t store_##name(struct device *dev, const char *buf, size_t =
n) \=0A=
+{								\=0A=
+	u32 val;						\=0A=
+	val =3D simple_strtoul(buf, NULL, 10);			\=0A=
+	if (val < 0 || val > 255)				\=0A=
+		return -EINVAL;					\=0A=
+	printk(KERN_INFO "Setting fan speed to %d\n", val);	\=0A=
+	data =3D val;						\=0A=
+	return n;						\=0A=
+}=0A=
+=0A=
+BUILD_SHOW_FUNC_DEG(cpu_temperature,	 (read_reg(thermostat, =
TEMP_REG[1])))=0A=
+BUILD_SHOW_FUNC_DEG(gpu_temperature,	 (read_reg(thermostat, =
TEMP_REG[2])))=0A=
+BUILD_SHOW_FUNC_DEG(cpu_limit,		 thermostat->limits[1])=0A=
+BUILD_SHOW_FUNC_DEG(gpu_limit,		 thermostat->limits[2])=0A=
+=0A=
+BUILD_SHOW_FUNC_INT(specified_fan_speed, fan_speed)=0A=
+BUILD_SHOW_FUNC_INT(cpu_fan_speed,	 (read_fan_speed(thermostat, =
FAN_SPEED[0])))=0A=
+BUILD_SHOW_FUNC_INT(gpu_fan_speed,	 (read_fan_speed(thermostat, =
FAN_SPEED[1])))=0A=
+=0A=
+BUILD_STORE_FUNC_INT(specified_fan_speed,fan_speed)=0A=
+BUILD_SHOW_FUNC_INT(limit_adjust,	 limit_adjust)=0A=
+BUILD_STORE_FUNC_DEG(limit_adjust,	 thermostat)=0A=
+		=0A=
+static DEVICE_ATTR(cpu_temperature,	S_IRUGO,=0A=
+		   show_cpu_temperature,NULL);=0A=
+static DEVICE_ATTR(gpu_temperature,	S_IRUGO,=0A=
+		   show_gpu_temperature,NULL);=0A=
+static DEVICE_ATTR(cpu_limit,		S_IRUGO,=0A=
+		   show_cpu_limit,	NULL);=0A=
+static DEVICE_ATTR(gpu_limit,		S_IRUGO,=0A=
+		   show_gpu_limit,	NULL);=0A=
+=0A=
+static DEVICE_ATTR(specified_fan_speed,	S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH,=0A=
+		   show_specified_fan_speed,store_specified_fan_speed);=0A=
+=0A=
+static DEVICE_ATTR(cpu_fan_speed,	S_IRUGO,=0A=
+		   show_cpu_fan_speed,	NULL);=0A=
+static DEVICE_ATTR(gpu_fan_speed,	S_IRUGO,=0A=
+		   show_gpu_fan_speed,	NULL);=0A=
+=0A=
+static DEVICE_ATTR(limit_adjust,	S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH,=0A=
+		   show_limit_adjust,	store_limit_adjust);=0A=
+=0A=
+=0A=
+static int __init=0A=
+thermostat_init(void)=0A=
+{=0A=
+	struct device_node* np;=0A=
+	u32 *prop;=0A=
+	=0A=
+	np =3D of_find_node_by_name(NULL, "fan");=0A=
+	if (!np)=0A=
+		return -ENODEV;=0A=
+	if (device_is_compatible(np, "adt7460"))=0A=
+		therm_type =3D ADT7460;=0A=
+	else if (device_is_compatible(np, "adt7467"))=0A=
+		therm_type =3D ADT7467;=0A=
+	else=0A=
+		return -ENODEV;=0A=
+=0A=
+	prop =3D (u32 *)get_property(np, "reg", NULL);=0A=
+	if (!prop)=0A=
+		return -ENODEV;=0A=
+	therm_bus =3D ((*prop) >> 8) & 0x0f;=0A=
+	therm_address =3D ((*prop) & 0xff) >> 1;=0A=
+=0A=
+	printk(KERN_INFO "adt746x: Thermostat bus: %d, address: 0x%02x, =
limit_adjust: %d, fan_speed: %d\n",=0A=
+		therm_bus, therm_address, limit_adjust, fan_speed);=0A=
+=0A=
+	of_dev =3D of_platform_device_create(np, "temperatures");=0A=
+	=0A=
+	if (of_dev =3D=3D NULL) {=0A=
+		printk(KERN_ERR "Can't register temperatures device !\n");=0A=
+		return -ENODEV;=0A=
+	}=0A=
+	=0A=
+	device_create_file(&of_dev->dev, &dev_attr_cpu_temperature);=0A=
+	device_create_file(&of_dev->dev, &dev_attr_gpu_temperature);=0A=
+	device_create_file(&of_dev->dev, &dev_attr_cpu_limit);=0A=
+	device_create_file(&of_dev->dev, &dev_attr_gpu_limit);=0A=
+	device_create_file(&of_dev->dev, &dev_attr_limit_adjust);=0A=
+	device_create_file(&of_dev->dev, &dev_attr_specified_fan_speed);=0A=
+	device_create_file(&of_dev->dev, &dev_attr_cpu_fan_speed);=0A=
+	if(therm_type =3D=3D ADT7460)=0A=
+		device_create_file(&of_dev->dev, &dev_attr_gpu_fan_speed);=0A=
+=0A=
+#ifndef CONFIG_I2C_KEYWEST=0A=
+	request_module("i2c-keywest");=0A=
+#endif=0A=
+=0A=
+	return i2c_add_driver(&thermostat_driver);=0A=
+}=0A=
+=0A=
+static void __exit=0A=
+thermostat_exit(void)=0A=
+{=0A=
+	if (of_dev) {=0A=
+		device_remove_file(&of_dev->dev, &dev_attr_cpu_temperature);=0A=
+		device_remove_file(&of_dev->dev, &dev_attr_gpu_temperature);=0A=
+		device_remove_file(&of_dev->dev, &dev_attr_cpu_limit);=0A=
+		device_remove_file(&of_dev->dev, &dev_attr_gpu_limit);=0A=
+		device_remove_file(&of_dev->dev, &dev_attr_limit_adjust);=0A=
+		device_remove_file(&of_dev->dev, &dev_attr_specified_fan_speed);=0A=
+		device_remove_file(&of_dev->dev, &dev_attr_cpu_fan_speed);=0A=
+		if(therm_type =3D=3D ADT7460)=0A=
+			device_remove_file(&of_dev->dev, &dev_attr_gpu_fan_speed);=0A=
+		of_device_unregister(of_dev);=0A=
+	}=0A=
+	i2c_del_driver(&thermostat_driver);=0A=
+}=0A=
+=0A=
+module_init(thermostat_init);=0A=
+module_exit(thermostat_exit);=0A=

------=_NextPart_000_00E1_01C4077E.8BB25350--

