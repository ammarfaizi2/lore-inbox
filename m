Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbUCUCbc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 21:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUCUCbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 21:31:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:41191 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263594AbUCUCaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 21:30:24 -0500
Subject: [PATCH] pmac: Improved G4 "windtunnel" fan controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079835418.911.121.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Mar 2004 13:16:59 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply,
Ben.

-----Forwarded Message-----
From: Samuel Rydh <samuel@ibrium.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Improved G4 "windtunnel" fan controller
Date: Sat, 20 Mar 2004 14:54:53 +0100


Hi Ben,

Here is an improved version of the G4 "windtunnel" fan controller.
It depends on the keywest bugfix...

/Samuel


===== drivers/macintosh/therm_windtunnel.c 1.1 vs edited =====
--- 1.1/drivers/macintosh/therm_windtunnel.c	Thu Feb  5 07:23:52 2004
+++ edited/drivers/macintosh/therm_windtunnel.c	Sat Mar 20 14:45:16 2004
@@ -1,24 +1,23 @@
 /* 
  *   Creation Date: <2003/03/14 20:54:13 samuel>
- *   Time-stamp: <2003/03/15 18:55:53 samuel>
+ *   Time-stamp: <2004/03/20 14:20:59 samuel>
  *   
  *	<therm_windtunnel.c>
  *	
- *	The G4 "windtunnel" has a single fan controlled by a
- *	DS1775 fan controller and an ADM1030 thermostat.
+ *	The G4 "windtunnel" has a single fan controlled by an
+ *	ADM1030 fan controller and a DS1775 thermostat.
  *
  *	The fan controller is equipped with a temperature sensor
- *	which measures the case temperature. The ADM censor
+ *	which measures the case temperature. The DS1775 sensor
  *	measures the CPU temperature. This driver tunes the
  *	behavior of the fan. It is based upon empirical observations
- *	of the 'AppleFan' driver under OSX.
+ *	of the 'AppleFan' driver under Mac OS X.
  *
  *	WARNING: This driver has only been testen on Apple's
- *	1.25 MHz Dual G4 (March 03). Other machines might have
- *	a different thermal design. It is tuned for a CPU
+ *	1.25 MHz Dual G4 (March 03). It is tuned for a CPU
  *	temperatur around 57 C.
  *
- *   Copyright (C) 2003 Samuel Rydh (samuel@ibrium.se)
+ *   Copyright (C) 2003, 2004 Samuel Rydh (samuel@ibrium.se)
  *
  *   Loosely based upon 'thermostat.c' written by Benjamin Herrenschmidt
  *   
@@ -38,50 +37,37 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/workqueue.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/sections.h>
-
-MODULE_AUTHOR("Samuel Rydh <samuel@ibrium.se>");
-MODULE_DESCRIPTION("Apple G4 (windtunnel) fan driver");
-MODULE_LICENSE("GPL");
+#include <asm/of_device.h>
 
 #define LOG_TEMP		0			/* continously log temperature */
 
-/* scan 0x48-0x4f (DS1775) and 0x2c-2x2f (ADM1030) */
-static unsigned short normal_i2c[] = { 0x49, 0x2c, I2C_CLIENT_END };
-static unsigned short normal_i2c_range[] = { 0x48, 0x4f, 0x2c, 0x2f, I2C_CLIENT_END };
-static struct work_struct poll_work;
-
-I2C_CLIENT_INSMOD;
-
 #define I2C_DRIVERID_G4FAN	0x9001			/* fixme */
-
 #define THERMOSTAT_CLIENT_ID	1
 #define FAN_CLIENT_ID		2
 
-struct temp_range {
-	u8			high;			/* start the fan */
-	u8			low;			/* stop the fan */
-};
-struct apple_thermal_info {
-	u8			id;			/* implementation ID */
-	u8			fan_count;		/* number of fans */
-	u8			thermostat_count;	/* number of thermostats */
-	u8			unused[5];
-	struct temp_range	ranges[4];		/* temperature ranges (may be [])*/
-};
+static int 			do_probe( struct i2c_adapter *adapter, int addr, int kind);
 
-static int do_detect( struct i2c_adapter *adapter, int addr, int kind);
+/* scan 0x48-0x4f (DS1775) and 0x2c-2x2f (ADM1030) */
+static unsigned short		normal_i2c[] = { 0x49, 0x2c, I2C_CLIENT_END };
+static unsigned short		normal_i2c_range[] = { 0x48, 0x4f, 0x2c, 0x2f, I2C_CLIENT_END };
+
+I2C_CLIENT_INSMOD;
 
 static struct {
+	volatile int		running;
+	struct completion	completion;
+	pid_t			poll_task;
+	
+	struct semaphore 	lock;
+	struct of_device	*of_dev;
+	
 	struct i2c_client	*thermostat;
 	struct i2c_client	*fan;
-	int			error;
-	struct timer_list	timer;
 
 	int			overheat_temp;		/* 100% fan at this temp */
 	int			overheat_hyst;
@@ -95,37 +81,54 @@
 	int			r0, r1, r20, r23, r25;	/* saved register */
 } x;
 
+#define T(x,y)			(((x)<<8) | (y)*0x100/10 )
+
 static struct {
+	int			fan_down_setting;
 	int			temp;
-	int			fan_setting;
-} fan_up_table[] = {
-	{ 0x0000, 11 },		/* min fan */
-	{ 0x3900, 8 },		/* 57.0 C */
-	{ 0x3a4a, 7 },		/* 58.3 C */
-	{ 0x3ad3, 6 },		/* 58.8 C */
-	{ 0x3b3c, 5 },		/* 59.2 C */
-	{ 0x3b94, 4 },		/* 59.6 C */
-	{ 0x3be3, 3 },		/* 58.9 C */
-	{ 0x3c29, 2 },		/* 59.2 C */
-	{ 0xffff, 1 }		/* on fire */
-};
-static struct {
-	int			temp;
-	int			fan_setting;
-} fan_down_table[] = {
-	{ 0x3700, 11 },		/* 55.0 C */
-	{ 0x374a, 6 },
-	{ 0x3800, 7 },		/* 56.0 C */
-	{ 0x3900, 8 },		/* 57.0 C */
-	{ 0x3a4a, 7 },		/* 58.3 C */
-	{ 0x3ad3, 6 },		/* 58.8 C */
-	{ 0x3b3c, 5 },		/* 59.2 C */
-	{ 0x3b94, 4 },		/* 58.9 C */
-	{ 0x3be3, 3 },		/* 58.9 C */
-	{ 0x3c29, 2 },		/* 59.2 C */
-	{ 0xffff, 1 }
+	int			fan_up_setting;
+} fan_table[] = {
+	{ 11, T(0,0),  11 },	/* min fan */
+	{ 11, T(55,0), 11 },
+	{  6, T(55,3), 11 },
+	{  7, T(56,0), 11 },
+	{  8, T(57,0), 8 },
+	{  7, T(58,3), 7 },
+	{  6, T(58,8), 6 },
+	{  5, T(59,2), 5 },
+	{  4, T(59,6), 4 },
+	{  3, T(59,9), 3 },
+	{  2, T(60,1), 2 },
+	{  1, 0xfffff, 1 }	/* on fire */
 };
 
+static void
+print_temp( const char *s, int temp )
+{
+	printk("%s%d.%d C", s ? s : "", temp>>8, (temp & 255)*10/256 );
+}
+
+static ssize_t
+show_cpu_temperature( struct device *dev, char *buf )
+{
+	return sprintf(buf, "%d.%d\n", x.temp>>8, (x.temp & 255)*10/256 );
+}
+
+static ssize_t
+show_case_temperature( struct device *dev, char *buf )
+{
+	return sprintf(buf, "%d.%d\n", x.casetemp>>8, (x.casetemp & 255)*10/256 );
+}
+
+static DEVICE_ATTR(cpu_temperature, S_IRUGO, show_cpu_temperature, NULL );
+static DEVICE_ATTR(case_temperature, S_IRUGO, show_case_temperature, NULL );
+
+
+
+/************************************************************************/
+/*	controller thread						*/
+/************************************************************************/
+
 static int
 write_reg( struct i2c_client *cl, int reg, int data, int len )
 {
@@ -159,37 +162,32 @@
 	return (len == 2)? ((unsigned int)buf[0] << 8) | buf[1] : buf[0];
 }
 
-
-static void
-print_temp( const char *s, int temp )
-{
-	printk("%s%d.%d C", s ? s : "", temp>>8, (temp & 255)*10/256 );
-}
-
 static void
 tune_fan( int fan_setting )
 {
 	int val = (fan_setting << 3) | 7;
-	x.fan_level = fan_setting;
-	
-	//write_reg( x.fan, 0x24, val, 1 );
+
+	/* write_reg( x.fan, 0x24, val, 1 ); */
 	write_reg( x.fan, 0x25, val, 1 );
 	write_reg( x.fan, 0x20, 0, 1 );
 	print_temp("CPU-temp: ", x.temp );
 	if( x.casetemp )
 		print_temp(", Case: ", x.casetemp );
-	printk("  Tuning fan: %d (%02x)\n", fan_setting, val );
+	printk(",  Fan: %d (tuned %+d)\n", 11-fan_setting, x.fan_level-fan_setting );
+
+	x.fan_level = fan_setting;
 }
 
 static void
-poll_temp( void *param )
+poll_temp( void )
 {
-	int temp = read_reg( x.thermostat, 0, 2 );
-	int i, level, casetemp;
+	int temp, i, level, casetemp;
+
+	temp = read_reg( x.thermostat, 0, 2 );
 
 	/* this actually occurs when the computer is loaded */
 	if( temp < 0 )
-		goto out;
+		return;
 
 	casetemp = read_reg(x.fan, 0x0b, 1) << 8;
 	casetemp |= (read_reg(x.fan, 0x06, 1) & 0x7) << 5;
@@ -197,37 +195,117 @@
 	if( LOG_TEMP && x.temp != temp ) {
 		print_temp("CPU-temp: ", temp );
 		print_temp(", Case: ", casetemp );
-		printk(",  Fan: %d\n", x.fan_level );
+		printk(",  Fan: %d\n", 11-x.fan_level );
 	}
 	x.temp = temp;
 	x.casetemp = casetemp;
 
 	level = -1;
-	for( i=0; (temp & 0xffff) > fan_down_table[i].temp ; i++ )
+	for( i=0; (temp & 0xffff) > fan_table[i].temp ; i++ )
 		;
 	if( i < x.downind )
-		level = fan_down_table[i].fan_setting;
+		level = fan_table[i].fan_down_setting;
 	x.downind = i;
 
-	for( i=0; (temp & 0xfffe) >= fan_up_table[i+1].temp ; i++ )
+	for( i=0; (temp & 0xffff) >= fan_table[i+1].temp ; i++ )
 		;
 	if( x.upind < i )
-		level = fan_up_table[i].fan_setting;
+		level = fan_table[i].fan_up_setting;
 	x.upind = i;
 
 	if( level >= 0 )
 		tune_fan( level );
- out:
-	x.timer.expires = jiffies + 8*HZ;
-	add_timer( &x.timer );
+}
+
+
+static void
+setup_hardware( void )
+{
+	int val;
+
+	/* save registers (if we unload the module) */
+	x.r0 = read_reg( x.fan, 0x00, 1 );
+	x.r1 = read_reg( x.fan, 0x01, 1 );
+	x.r20 = read_reg( x.fan, 0x20, 1 );
+	x.r23 = read_reg( x.fan, 0x23, 1 );
+	x.r25 = read_reg( x.fan, 0x25, 1 );
+
+	/* improve measurement resolution (convergence time 1.5s) */
+	if( (val=read_reg(x.thermostat, 1, 1)) >= 0 ) {
+		val |= 0x60;
+		if( write_reg( x.thermostat, 1, val, 1 ) )
+			printk("Failed writing config register\n");
+	}
+	/* disable interrupts and TAC input */
+	write_reg( x.fan, 0x01, 0x01, 1 );
+	/* enable filter */
+	write_reg( x.fan, 0x23, 0x91, 1 );
+	/* remote temp. controls fan */
+	write_reg( x.fan, 0x00, 0x95, 1 );
+
+	/* The thermostat (which besides measureing temperature controls
+	 * has a THERM output which puts the fan on 100%) is usually
+	 * set to kick in at 80 C (chip default). We reduce this a bit
+	 * to be on the safe side (OSX doesn't)...
+	 */
+	if( x.overheat_temp == (80 << 8) ) {
+		x.overheat_temp = 65 << 8;
+		x.overheat_hyst = 60 << 8;
+		write_reg( x.thermostat, 2, x.overheat_hyst, 2 );
+		write_reg( x.thermostat, 3, x.overheat_temp, 2 );
+
+		print_temp("Reducing overheating limit to ", x.overheat_temp );
+		print_temp(" (Hyst: ", x.overheat_hyst );
+		printk(")\n");
+	}
+
+	/* set an initial fan setting */
+	x.downind = 0xffff;
+	x.upind = -1;
+	/* tune_fan( fan_up_table[x.upind].fan_setting ); */
+
+	device_create_file( &x.of_dev->dev, &dev_attr_cpu_temperature );
+	device_create_file( &x.of_dev->dev, &dev_attr_case_temperature );
 }
 
 static void
-schedule_poll( unsigned long t )
+restore_regs( void )
 {
-	schedule_work(&poll_work);
+	device_remove_file( &x.of_dev->dev, &dev_attr_cpu_temperature );
+	device_remove_file( &x.of_dev->dev, &dev_attr_case_temperature );
+
+	write_reg( x.fan, 0x01, x.r1, 1 );
+	write_reg( x.fan, 0x20, x.r20, 1 );
+	write_reg( x.fan, 0x23, x.r23, 1 );
+	write_reg( x.fan, 0x25, x.r25, 1 );
+	write_reg( x.fan, 0x00, x.r0, 1 );
 }
 
+static int
+control_loop( void *dummy )
+{
+	daemonize("g4fand");
+
+	down( &x.lock );
+	setup_hardware();
+
+	while( x.running ) {
+		up( &x.lock );
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout( 8*HZ );
+		
+		down( &x.lock );
+		poll_temp();
+	}
+
+	restore_regs();
+	up( &x.lock );
+
+	complete_and_exit( &x.completion, 0 );
+}
+
+
 /************************************************************************/
 /*	i2c probing and setup						*/
 /************************************************************************/
@@ -235,7 +313,20 @@
 static int
 do_attach( struct i2c_adapter *adapter )
 {
-	return i2c_probe( adapter, &addr_data, &do_detect );
+	int ret = 0;
+
+	if( strncmp(adapter->name, "uni-n", 5) )
+		return 0;
+
+	if( !x.running ) {
+		ret = i2c_probe( adapter, &addr_data, &do_probe );
+		if( x.thermostat && x.fan ) {
+			x.running = 1;
+			init_completion( &x.completion );
+			x.poll_task = kernel_thread( control_loop, NULL, SIGCHLD | CLONE_KERNEL );
+		}
+	}
+	return ret;
 }
 
 static int
@@ -243,13 +334,23 @@
 {
 	int err;
 
-	printk("do_detach: id %d\n", client->id );
-	if( (err=i2c_detach_client(client)) ) {
-		printk("failed to detach thermostat client\n");
-		return err;
+	if( (err=i2c_detach_client(client)) )
+		printk(KERN_ERR "failed to detach thermostat client\n");
+	else {
+		if( x.running ) {
+			x.running = 0;
+			wait_for_completion( &x.completion );
+		}
+		if( client == x.thermostat )
+			x.thermostat = NULL;
+		else if( client == x.fan )
+			x.fan = NULL;
+		else {
+			printk(KERN_ERR "g4fan: bad client\n");
+		}
+		kfree( client );
 	}
-	kfree( client );
-	return 0;
+	return err;
 }
 
 static struct i2c_driver g4fan_driver = {  
@@ -262,24 +363,21 @@
 };
 
 static int
-detect_fan( struct i2c_client *cl )
+attach_fan( struct i2c_client *cl )
 {
+	if( x.fan )
+		goto out;
+
 	/* check that this is an ADM1030 */
 	if( read_reg(cl, 0x3d, 1) != 0x30 || read_reg(cl, 0x3e, 1) != 0x41 )
 		goto out;
-	printk("ADM1030 fan controller detected at %02x\n", cl->addr );
+	printk("ADM1030 fan controller [@%02x]\n", cl->addr );
 
-	if( x.fan ) {
-		x.error |= 2;
-		goto out;
-	}
-	x.fan = cl;
 	cl->id = FAN_CLIENT_ID;
-	strncpy( cl->name, "ADM1030 fan controller", sizeof(cl->name) );
+	strlcpy( cl->name, "ADM1030 fan controller", sizeof(cl->name) );
 
-	if( i2c_attach_client( cl ) )
-		goto out;
-	return 0;
+	if( !i2c_attach_client(cl) )
+		x.fan = cl;
  out:
 	if( cl != x.fan )
 		kfree( cl );
@@ -287,10 +385,13 @@
 }
 
 static int
-detect_thermostat( struct i2c_client *cl ) 
+attach_thermostat( struct i2c_client *cl ) 
 {
 	int hyst_temp, os_temp, temp;
 
+	if( x.thermostat )
+		goto out;
+
 	if( (temp=read_reg(cl, 0, 2)) < 0 )
 		goto out;
 	
@@ -302,44 +403,37 @@
 	if( hyst_temp < 0 || os_temp < 0 )
 		goto out;
 
-	printk("DS1775 digital thermometer detected at %02x\n", cl->addr );
+	printk("DS1775 digital thermometer [@%02x]\n", cl->addr );
 	print_temp("Temp: ", temp );
 	print_temp("  Hyst: ", hyst_temp );
 	print_temp("  OS: ", os_temp );
 	printk("\n");
 
-	if( x.thermostat ) {
-		x.error |= 1;
-		goto out;
-	}
 	x.temp = temp;
-	x.thermostat = cl;
 	x.overheat_temp = os_temp;
 	x.overheat_hyst = hyst_temp;
 	
 	cl->id = THERMOSTAT_CLIENT_ID;
-	strncpy( cl->name, "DS1775 thermostat", sizeof(cl->name) );
+	strlcpy( cl->name, "DS1775 thermostat", sizeof(cl->name) );
 
-	if( i2c_attach_client( cl ) )
-		goto out;
-	return 0;
+	if( !i2c_attach_client(cl) )
+		x.thermostat = cl;
 out:
-	kfree( cl );
+	if( cl != x.thermostat )
+		kfree( cl );
 	return 0;
 }
 
 static int
-do_detect( struct i2c_adapter *adapter, int addr, int kind )
+do_probe( struct i2c_adapter *adapter, int addr, int kind )
 {
 	struct i2c_client *cl;
 
-	if( strncmp(adapter->name, "uni-n", 5) )
-		return 0;
 	if( !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA
 				     | I2C_FUNC_SMBUS_WRITE_BYTE) )
 		return 0;
 
-	if( !(cl=kmalloc( sizeof(struct i2c_client), GFP_KERNEL )) )
+	if( !(cl=kmalloc(sizeof(*cl), GFP_KERNEL)) )
 		return -ENOMEM;
 	memset( cl, 0, sizeof(struct i2c_client) );
 
@@ -349,108 +443,94 @@
 	cl->flags = 0;
 
 	if( addr < 0x48 )
-		return detect_fan( cl );
-	return detect_thermostat( cl );
+		return attach_fan( cl );
+	return attach_thermostat( cl );
+}
+
+
+/************************************************************************/
+/*	initialization / cleanup					*/
+/************************************************************************/
+
+static int
+therm_of_probe( struct of_device *dev, const struct of_match *match )
+{
+	return i2c_add_driver( &g4fan_driver );
 }
 
-#define PRINT_REG( r )	printk("reg %02x = %02x\n", r, read_reg(x.fan, r, 1) )
+static int
+therm_of_remove( struct of_device *dev )
+{
+	return i2c_del_driver( &g4fan_driver );
+}
+
+static struct of_match therm_of_match[] = {{
+	.name		= "fan",
+	.type		= OF_ANY_MATCH,
+	.compatible	= "adm1030"
+    }, {}
+};
+
+static struct of_platform_driver therm_of_driver = {
+	.name		= "temperature",
+	.match_table	= therm_of_match,
+	.probe		= therm_of_probe,
+	.remove		= therm_of_remove,
+};
+
+struct apple_thermal_info {
+	u8		id;			/* implementation ID */
+	u8		fan_count;		/* number of fans */
+	u8		thermostat_count;	/* number of thermostats */
+	u8		unused;
+};
 
 static int __init
 g4fan_init( void )
 {
 	struct apple_thermal_info *info;
 	struct device_node *np;
-	int ret, val;
-	
-	np = of_find_node_by_name(NULL, "power-mgt");
-	if (np == NULL)
+
+	init_MUTEX( &x.lock );
+
+	if( !(np=of_find_node_by_name(NULL, "power-mgt")) )
 		return -ENODEV;
 	info = (struct apple_thermal_info*)get_property(np, "thermal-info", NULL);
 	of_node_put(np);
-	if (info == NULL)
-		return -ENODEV;
-	
-	/* check for G4 "Windtunnel" SMP */
-	if( machine_is_compatible("PowerMac3,6") ) {
-		if( info->id != 3 ) {
-			printk(KERN_ERR "g4fan: design id %d unknown\n", info->id);
-			return -ENODEV;
-		}
-	} else {
-		printk(KERN_ERR "g4fan: unsupported machine type\n");
-		return -ENODEV;
-	}
-	if( (ret=i2c_add_driver(&g4fan_driver)) )
-		return ret;
 
-	if( !x.thermostat || !x.fan ) {
-		i2c_del_driver(&g4fan_driver );
+	if( !info || !machine_is_compatible("PowerMac3,6") )
 		return -ENODEV;
-	}
-
-	/* save registers (if we unload the module) */
-	x.r0 = read_reg( x.fan, 0x00, 1 );
-	x.r1 = read_reg( x.fan, 0x01, 1 );
-	x.r20 = read_reg( x.fan, 0x20, 1 );
-	x.r23 = read_reg( x.fan, 0x23, 1 );
-	x.r25 = read_reg( x.fan, 0x25, 1 );
 
-	/* improve measurement resolution (convergence time 1.5s) */
-	if( (val=read_reg( x.thermostat, 1, 1 )) >= 0 ) {
-		val |= 0x60;
-		if( write_reg( x.thermostat, 1, val, 1 ) )
-			printk("Failed writing config register\n");
+	if( info->id != 3 ) {
+		printk(KERN_ERR "therm_windtunnel: unsupported thermal design %d\n", info->id );
+		return -ENODEV;
 	}
-	/* disable interrupts and TAC input */
-	write_reg( x.fan, 0x01, 0x01, 1 );
-	/* enable filter */
-	write_reg( x.fan, 0x23, 0x91, 1 );
-	/* remote temp. controls fan */
-	write_reg( x.fan, 0x00, 0x95, 1 );
-
-	/* The thermostat (which besides measureing temperature controls
-	 * has a THERM output which puts the fan on 100%) is usually
-	 * set to kick in at 80 C (chip default). We reduce this a bit
-	 * to be on the safe side (OSX doesn't)...
-	 */
-	if( x.overheat_temp == (80 << 8) ) {
-		x.overheat_temp = 65 << 8;
-		x.overheat_hyst = 60 << 8;
-		write_reg( x.thermostat, 2, x.overheat_hyst, 2 );
-		write_reg( x.thermostat, 3, x.overheat_temp, 2 );
+	if( !(np=of_find_node_by_name(NULL, "fan")) )
+		return -ENODEV;
+	x.of_dev = of_platform_device_create( np, "temperature" );
+	of_node_put( np );
 
-		print_temp("Reducing overheating limit to ", x.overheat_temp );
-		print_temp(" (Hyst: ", x.overheat_hyst );
-		printk(")\n");
+	if( !x.of_dev ) {
+		printk(KERN_ERR "Can't register fan controller!\n");
+		return -ENODEV;
 	}
 
-	/* set an initial fan setting */
-	x.upind = x.downind = 1;
-	tune_fan( fan_up_table[x.upind].fan_setting );
-
-	INIT_WORK(&poll_work, poll_temp, NULL);
-
-	init_timer( &x.timer );
-	x.timer.expires = jiffies + 8*HZ;
-	x.timer.function = schedule_poll;
-	add_timer( &x.timer );
+	of_register_driver( &therm_of_driver );
 	return 0;
 }
 
 static void __exit
 g4fan_exit( void )
 {
-	del_timer( &x.timer );
+	of_unregister_driver( &therm_of_driver );
 
-	write_reg( x.fan, 0x01, x.r1, 1 );
-	write_reg( x.fan, 0x20, x.r20, 1 );
-	write_reg( x.fan, 0x23, x.r23, 1 );
-	write_reg( x.fan, 0x25, x.r25, 1 );
-	write_reg( x.fan, 0x00, x.r0, 1 );
-
-	i2c_del_driver( &g4fan_driver );
+	if( x.of_dev )
+		of_device_unregister( x.of_dev );
 }
 
 module_init(g4fan_init);
 module_exit(g4fan_exit);
 
+MODULE_AUTHOR("Samuel Rydh <samuel@ibrium.se>");
+MODULE_DESCRIPTION("Apple G4 (windtunnel) fan controller");
+MODULE_LICENSE("GPL");
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

