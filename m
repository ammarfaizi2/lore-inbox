Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbTHaQ2u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTHaQ2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:28:50 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:48401 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262398AbTHaQ1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:27:38 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Date: Sun, 31 Aug 2003 20:25:41 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
References: <200307152214.38825.arvidjaar@mail.ru> <200308192319.01895.arvidjaar@mail.ru> <20030819194533.GA5738@kroah.com>
In-Reply-To: <20030819194533.GA5738@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FGiU/Y15yQDsY4h"
Message-Id: <200308312025.41472.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_FGiU/Y15yQDsY4h
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 19 August 2003 23:45, Greg KH wrote:
> On Tue, Aug 19, 2003 at 11:19:01PM +0400, Andrey Borzenkov wrote:
[...]
> > There are more issues than just type_name.
[...]
> > 1. I do not know where to get information on adapters (called busses
> > actually in libsensors) and algorithms. I.e. the information
> > corresponding to 2.4:
> >
> > {pts/2}% cat ~/tmp/i2c-bus
> > i2c-0   smbus           SMBus I801 adapter at e800              Non-I2C
> > SMBus adapter
>
> Look in /sys/class/i2c-adapter/
[...]
> Hm, a name file:
> $ cat /sys/class/i2c-adapter/i2c-0/device/name
> SMBus I801 adapter at 8000
>
> Ah, the same info as you showed for 2.4 :)
>

Sure it not the same info it is only part of it. I do not know if libsensor=
s=20
just using this for display or needs it internally. Thank you for pointer=20
though.

> > 2. I do not know - and sysfs does not provide any information - how to
> > identify chips-of-interest as opposed to generic i2c devices. I.e.
> > w83781d has both clients and subclients (2.4 again):
> >
> > {pts/2}% cat ~/tmp/i2c-0-bus
> > 2d      AS99127F chip                           W83781D sensor driver
> > 48      AS99127F subclient                      W83781D sensor driver
> > 49      AS99127F subclient                      W83781D sensor driver
> >
[...]
>
> That's what you are going to have to set the name file to in the
> i2c_client structure, much like your patch did.  Then look at the
> different name files in each device directory to see what kind of device
> it is (chip, subclient, etc.)
>

OK attached patch sets all names to just chip name for chips themselves and=
=20
"chipname subclient" when subclient ios registered.

> > 3. libsensors asks for hysteresis value. This one does not exist in sys=
fs
> > (so all temp readings fail). Is it emulated by kernel or read off chip?
>
> The kernel is exporting all of the info that it knows about through
> sysfs.

it just arbitrarily (re-)names them. "min" is not hysteresis; name is badly=
=20
chosen.
[...]
> > 4. I do not have the slightest idea how ISA adapters look like in sysfs
> > and where they are located. Anyone can give me example?
>
> They show up on the legacy bus:
>
> $ tree /sys/class/i2c-adapter/i2c-1/
> /sys/class/i2c-adapter/i2c-1/
>
> |-- device -> ../../../devices/legacy/i2c-1
>

This does not help much. Libsensors expects as adapter identification eithe=
r=20
"i2c-N" or "isa". If I set it to "isa" I do not have any way to determine=20
sysfs path except by rescanning /sys/class/i2c-adapter every time. Having=20
/sys/class/i2-adapter/isa/... would be better, apparently it is assumed tha=
t=20
only one such adapter can exist.
[...]
> > So the patch to ibsensors is actually trivial enough. Main issue is
> > contents of sysfs
>
> You might want to take a look at libsysfs, it makes finding all of the
> devices and attributes in the sysfs tree a whole lot easer.
>

No I did not want to make code dependent on libsysfs, besides arsing itself=
 is=20
trivial.

Attached is patch against 2.6.0-test3-bk8 that sets all chip names to simpl=
y=20
chip names :) and patch for libsensors that makes use of it. libsensors sti=
ll=20
needs to be built under 2.4, no attempt is made to allow building under 2.6=
=2E=20
I built it using make LINUX_HADERS=3D/home/bor/src/linux-2.4.21/linux=20
COMPILE_KERNEL=3D0. It is possible to get rid of this dependency but I'd li=
ke=20
to settle sysfs issue first. As can be seen the ugliest part is name=20
translation between sysfs attributes and libsensors feature names ... if=20
attributes were named consistently the whole would be much more simple.

This works perfectly for reading, writing does not work here but it is not =
my=20
patch. Reading:
{pts/2}% LD_LIBRARY_PATH=3D./lib ./prog/sensors/sensors
as99127f-i2c-0-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Not available via sysfs
VCore 1:   +1.70 V  (min =3D  +1.49 V, max =3D  +1.81 V)
+3.3V:     +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+5V:       +5.00 V  (min =3D  +4.52 V, max =3D  +5.48 V)
+12V:     +11.37 V  (min =3D +10.82 V, max =3D +13.13 V)
=2D12V:     -11.57 V  (min =3D -12.33 V, max =3D -15.07 V)       ALARM
=2D5V:       -5.03 V  (min =3D  -4.50 V, max =3D  -5.49 V)
CPU:      4787 RPM  (min =3D 3000 RPM, div =3D 2)
=46ront:    2922 RPM  (min =3D 3000 RPM, div =3D 2)              ALARM
MB:          +28=B0C  (limit =3D +127=B0C, hysteresis =3D  +60=B0C)
CPU:       +36.0=B0C  (limit =3D +111=B0C, hysteresis =3D  +97=B0C)
HDD:       +37.0=B0C  (limit =3D +120=B0C, hysteresis =3D +100=B0C)
vid:      +1.650 V
alarms:
beep_enable:
          Sound alarm enabled

writing:

{pts/2}% cat /sys/class/i2c-adapter/i2c-0/device/0-002d/in_max2
3632
{pts/2}% sudo zsh -c 'echo 3500 >=20
/sys/class/i2c-adapter/i2c-0/device/0-002d/in_max2'
{pts/2}% cat /sys/class/i2c-adapter/i2c-0/device/0-002d/in_max2
400

so writing is broken at least for w83781d driver

=2Dandrey

--Boundary-00=_FGiU/Y15yQDsY4h
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.0-test3-bk8-sensors_type_name-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test3-bk8-sensors_type_name-3.patch"

--- linux-2.6.0-test3-bk8/drivers/i2c/chips/adm1021.c.chip_name	2003-08-20 20:58:39.000000000 +0400
+++ linux-2.6.0-test3-bk8/drivers/i2c/chips/adm1021.c	2003-08-23 21:30:57.000000000 +0400
@@ -225,7 +225,6 @@ static int adm1021_detect(struct i2c_ada
 	struct adm1021_data *data;
 	int err = 0;
 	const char *type_name = "";
-	const char *client_name = "";
 
 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
 	   at this moment; i2c_detect really won't call us. */
@@ -291,28 +290,20 @@ static int adm1021_detect(struct i2c_ada
 
 	if (kind == max1617) {
 		type_name = "max1617";
-		client_name = "MAX1617 chip";
 	} else if (kind == max1617a) {
 		type_name = "max1617a";
-		client_name = "MAX1617A chip";
 	} else if (kind == adm1021) {
 		type_name = "adm1021";
-		client_name = "ADM1021 chip";
 	} else if (kind == adm1023) {
 		type_name = "adm1023";
-		client_name = "ADM1023 chip";
 	} else if (kind == thmc10) {
 		type_name = "thmc10";
-		client_name = "THMC10 chip";
 	} else if (kind == lm84) {
 		type_name = "lm84";
-		client_name = "LM84 chip";
 	} else if (kind == gl523sm) {
 		type_name = "gl523sm";
-		client_name = "GL523SM chip";
 	} else if (kind == mc1066) {
 		type_name = "mc1066";
-		client_name = "MC1066 chip";
 	} else {
 		dev_err(&adapter->dev, "Internal error: unknown kind (%d)?!?",
 			kind);
@@ -320,7 +311,7 @@ static int adm1021_detect(struct i2c_ada
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, client_name, DEVICE_NAME_SIZE);
+	strlcpy(new_client->name, type_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
 	new_client->id = adm1021_id++;
--- linux-2.6.0-test3-bk8/drivers/i2c/chips/it87.c.chip_name	2003-08-09 13:10:04.000000000 +0400
+++ linux-2.6.0-test3-bk8/drivers/i2c/chips/it87.c	2003-08-23 21:31:30.000000000 +0400
@@ -592,7 +592,6 @@ int it87_detect(struct i2c_adapter *adap
 	struct it87_data *data;
 	int err = 0;
 	const char *name = "";
-	const char *client_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 
 	if (!is_isa && 
@@ -681,10 +680,8 @@ int it87_detect(struct i2c_adapter *adap
 
 	if (kind == it87) {
 		name = "it87";
-		client_name = "IT87 chip";
 	} /* else if (kind == it8712) {
 		name = "it8712";
-		client_name = "IT87-J chip";
 	} */ else {
 		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
 			kind);
--- linux-2.6.0-test3-bk8/drivers/i2c/chips/lm78.c.chip_name	2003-08-09 13:10:04.000000000 +0400
+++ linux-2.6.0-test3-bk8/drivers/i2c/chips/lm78.c	2003-08-23 21:32:17.000000000 +0400
@@ -625,11 +625,11 @@ int lm78_detect(struct i2c_adapter *adap
 	}
 
 	if (kind == lm78) {
-		client_name = "LM78 chip";
+		client_name = "lm78";
 	} else if (kind == lm78j) {
-		client_name = "LM78-J chip";
+		client_name = "lm78-j";
 	} else if (kind == lm79) {
-		client_name = "LM79 chip";
+		client_name = "lm79";
 	} else {
 		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
 			kind);
--- linux-2.6.0-test3-bk8/drivers/i2c/chips/lm85.c.chip_name	2003-08-09 13:10:04.000000000 +0400
+++ linux-2.6.0-test3-bk8/drivers/i2c/chips/lm85.c	2003-08-23 21:32:59.000000000 +0400
@@ -853,24 +853,20 @@ int lm85_detect(struct i2c_adapter *adap
 	/* Fill in the chip specific driver values */
 	if ( kind == any_chip ) {
 		type_name = "lm85";
-		strlcpy(new_client->name, "Generic LM85", DEVICE_NAME_SIZE);
 	} else if ( kind == lm85b ) {
 		type_name = "lm85b";
-		strlcpy(new_client->name, "National LM85-B", DEVICE_NAME_SIZE);
 	} else if ( kind == lm85c ) {
 		type_name = "lm85c";
-		strlcpy(new_client->name, "National LM85-C", DEVICE_NAME_SIZE);
 	} else if ( kind == adm1027 ) {
 		type_name = "adm1027";
-		strlcpy(new_client->name, "Analog Devices ADM1027", DEVICE_NAME_SIZE);
 	} else if ( kind == adt7463 ) {
 		type_name = "adt7463";
-		strlcpy(new_client->name, "Analog Devices ADT7463", DEVICE_NAME_SIZE);
 	} else {
 		dev_dbg(&adapter->dev, "Internal error, invalid kind (%d)!", kind);
 		err = -EFAULT ;
 		goto ERROR1;
 	}
+	strlcpy(new_client->name, type_name, DEVICE_NAME_SIZE);
 
 	/* Fill in the remaining client fields */
 	new_client->id = lm85_id++;
--- linux-2.6.0-test3-bk8/drivers/i2c/chips/via686a.c.chip_name	2003-08-09 13:10:05.000000000 +0400
+++ linux-2.6.0-test3-bk8/drivers/i2c/chips/via686a.c	2003-08-23 21:33:22.000000000 +0400
@@ -671,7 +671,7 @@ static int via686a_detect(struct i2c_ada
 	struct i2c_client *new_client;
 	struct via686a_data *data;
 	int err = 0;
-	const char client_name[] = "via686a chip";
+	const char client_name[] = "via686a";
 	u16 val;
 
 	/* Make sure we are probing the ISA bus!!  */
--- linux-2.6.0-test3-bk8/drivers/i2c/chips/w83781d.c.chip_name	2003-08-09 13:10:05.000000000 +0400
+++ linux-2.6.0-test3-bk8/drivers/i2c/chips/w83781d.c	2003-08-23 21:34:51.000000000 +0400
@@ -1098,15 +1098,15 @@ w83781d_detect_subclients(struct i2c_ada
 	}
 
 	if (kind == w83781d)
-		client_name = "W83781D subclient";
+		client_name = "w83781d subclient";
 	else if (kind == w83782d)
-		client_name = "W83782D subclient";
+		client_name = "w83782d subclient";
 	else if (kind == w83783s)
-		client_name = "W83783S subclient";
+		client_name = "w83783s subclient";
 	else if (kind == w83627hf)
-		client_name = "W83627HF subclient";
+		client_name = "w83627hf subclient";
 	else if (kind == as99127f)
-		client_name = "AS99127F subclient";
+		client_name = "as99127f subclient";
 	else
 		client_name = "unknown subclient?";
 
@@ -1304,20 +1304,20 @@ w83781d_detect(struct i2c_adapter *adapt
 	}
 
 	if (kind == w83781d) {
-		client_name = "W83781D chip";
+		client_name = "w83781d";
 	} else if (kind == w83782d) {
-		client_name = "W83782D chip";
+		client_name = "w83782d";
 	} else if (kind == w83783s) {
-		client_name = "W83783S chip";
+		client_name = "w83783s";
 	} else if (kind == w83627hf) {
 		if (val1 == 0x90)
-			client_name = "W83627THF chip";
+			client_name = "w83627thf";
 		else
-			client_name = "W83627HF chip";
+			client_name = "w83627hf";
 	} else if (kind == as99127f) {
-		client_name = "AS99127F chip";
+		client_name = "as99127f";
 	} else if (kind == w83697hf) {
-		client_name = "W83697HF chip";
+		client_name = "w83697hf";
 	} else {
 		dev_err(&new_client->dev, "Internal error: unknown "
 						"kind (%d)?!?", kind);

--Boundary-00=_FGiU/Y15yQDsY4h
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="lm_sensors-2.8.0-sysfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lm_sensors-2.8.0-sysfs.patch"

--- lm_sensors-2.8.0/lib/proc.c.sysfs	2003-06-09 01:33:38.000000000 +0400
+++ lm_sensors-2.8.0/lib/proc.c	2003-08-23 22:23:33.000000000 +0400
@@ -20,6 +20,8 @@
 #include <stddef.h>
 #include <stdio.h>
 #include <string.h>
+#include <dirent.h>
+#include <unistd.h>
 #include <sys/sysctl.h>
 #include "kernel/include/sensors.h"
 #include "data.h"
@@ -59,6 +61,158 @@ static int sensors_get_chip_id(sensors_c
                                        &sensors_proc_bus_max,\
                                        sizeof(struct sensors_bus))
 
+static int using_sysfs;
+static char sysfs_i2c_bus[] = "/sys/bus/i2c/devices";
+static char sysfs_i2c_class[] = "/sys/class/i2c-adapter";
+
+/* This parses sysfs tree for available i2c chips */
+static int sensors_parse_sysfs_chips(void)
+{
+  DIR *dir;
+  struct dirent *dentry;
+  char path[256], buf[256];
+  FILE *f;
+  int len;
+  sensors_proc_chips_entry entry;
+
+  if ((dir = opendir(sysfs_i2c_bus)) == NULL)
+    return -SENSORS_ERR_PROC;
+
+  using_sysfs = 1;
+
+  while ((dentry = readdir(dir)) != NULL) {
+    if (dentry->d_name[0] == '.' || dentry->d_ino <= 0)
+      continue;
+    snprintf(path, sizeof(path), "%s/%s/name", sysfs_i2c_bus, dentry->d_name);
+    if ((f = fopen(path, "r")) == NULL)
+      continue;
+    buf[0] = '\0';
+    fgets(buf, sizeof(buf), f);
+    fclose(f);
+    len = strlen(buf) - 1;
+    if (buf[len] == '\n')
+      buf[len] = '\0';
+    if (strchr(buf, ' '))
+      continue; /* e.g. "as99127f subclient" */
+    sscanf(dentry->d_name, "%d-%x", &entry.name.bus, &entry.name.addr);
+    entry.name.prefix = strdup(buf);
+
+    add_proc_chips(&entry);
+  }
+  closedir(dir);
+  return 0;
+}
+
+static int sensors_parse_sysfs_class(void)
+{
+  DIR *dir;
+  struct dirent *dentry;
+  char path[256], buf[256];
+  FILE *f;
+  int len;
+  sensors_bus entry;
+
+  if ((dir = opendir(sysfs_i2c_class)) == NULL)
+    return -SENSORS_ERR_PROC;
+
+  while ((dentry = readdir(dir)) != NULL) {
+    if (dentry->d_name[0] == '.' || dentry->d_ino <= 0)
+      continue;
+
+    sscanf(dentry->d_name, "i2c-%d", &entry.number);
+    entry.algorithm = strdup("Not available via sysfs");
+    sprintf(path, "%s/%s/device/name", sysfs_i2c_class, dentry->d_name);
+    if ((f = fopen(path, "r")) == NULL) {
+      entry.adapter = strdup("UNKNOWN");
+      continue;
+    }
+    fgets(buf, sizeof(buf), f);
+    fclose(f);
+    len = strlen(buf) - 1;
+    if (buf[len] == '\n')
+      buf[len] = '\0';
+    entry.adapter = strdup(buf);
+    add_bus(&entry);
+  }
+
+  return 0;
+}
+  
+static int ends_with(const char *str, const char *suffix)
+{
+  int len = strlen(str);
+  int slen = strlen(suffix);
+
+  if (len <= slen)
+    return 0;
+
+  return strcmp(str + len - slen, suffix) == 0;
+}
+
+static void
+sensors_sysfs_convert_feature_name(const char *name, char *buf)
+{
+  char part1[256], part2[256];
+  int n;
+
+  if (sscanf(name, "temp%d", &n) == 1) {
+    if (ends_with(name, "_hyst"))
+      sprintf(buf, "temp_min%d", n);
+    else if (ends_with(name, "_over"))
+      sprintf(buf, "temp_max%d", n);
+    else
+      sprintf(buf, "temp_input%d", n);
+  } else if (sscanf(name, "%[^0-9]%d_%s", part1, &n, part2) == 3)
+    sprintf(buf, "%s_%s%d", part1, part2, n);
+  else if (sscanf(name, "%[^0-9]%d", part1, &n) == 2)
+    sprintf(buf, "%s_input%d", part1, n);
+  else if (strcmp(name, "beeps") == 0)
+    strcpy(buf, "beep_mask");
+  else
+    strcpy(buf, name);
+}
+
+/* This reads a feature /proc file */
+static int sensors_read_sysfs(sensors_chip_name name,
+  const sensors_chip_feature *the_feature, double *value)
+{
+  char path[256], buf[256];
+  FILE *f;
+  long l;
+  
+  sensors_sysfs_convert_feature_name(the_feature->name, buf);
+  snprintf(path, sizeof(path), "%s/%d-%04x/%s", sysfs_i2c_bus, name.bus, name.addr, buf);
+  if ((f = fopen(path, "r")) == NULL)
+    return -SENSORS_ERR_PROC;
+  fscanf(f, "%ld", &l);
+  fclose(f);
+  *value = l;
+  if (strncmp(buf, "in_", strlen("in_")) == 0
+      || strncmp(buf, "temp_", strlen("temp_")) == 0)
+    *value /= 10.0;
+  return 0;
+}
+  
+static int sensors_write_sysfs(sensors_chip_name name,
+  const sensors_chip_feature *the_feature, double value)
+{
+  char path[256], buf[256];
+  FILE *f;
+  long l;
+  
+  sensors_sysfs_convert_feature_name(the_feature->name, buf);
+  snprintf(path, sizeof(path), "%s/%d-%04x/%s", sysfs_i2c_bus, name.bus, name.addr, buf);
+  if (strncmp(buf, "in_", strlen("in_")) == 0
+      || strncmp(buf, "temp_", strlen("temp_")) == 0)
+    value *= 10.0;
+  l = (long) value;
+  if ((f = fopen(path, "w")) == NULL)
+    return -SENSORS_ERR_PROC;
+  fprintf(f, "%ld", l);
+  fclose(f);
+
+  return 0;
+}
 /* This reads /proc/sys/dev/sensors/chips into memory */
 int sensors_read_proc_chips(void)
 {
@@ -69,7 +223,7 @@ int sensors_read_proc_chips(void)
   int res,lineno;
 
   if (sysctl(name, 3, bufptr, &buflen, NULL, 0))
-    return -SENSORS_ERR_PROC;
+    return sensors_parse_sysfs_chips();
 
   lineno = 1;
   while (buflen >= sizeof(struct i2c_chips_data)) {
@@ -96,6 +250,9 @@ int sensors_read_proc_bus(void)
   sensors_bus entry;
   int lineno;
 
+  if (using_sysfs)
+    return sensors_parse_sysfs_class();
+
   f = fopen("/proc/bus/i2c","r");
   if (!f)
     return -SENSORS_ERR_PROC;
@@ -158,10 +315,17 @@ int sensors_read_proc(sensors_chip_name 
     return sysctl_name[2];
   if (! (the_feature = sensors_lookup_feature_nr(name.prefix,feature)))
     return -SENSORS_ERR_NO_ENTRY;
-  sysctl_name[3] = the_feature->sysctl;
-  if (sysctl(sysctl_name, 4, buf, &buflen, NULL, 0))
-    return -SENSORS_ERR_PROC;
-  *value = *((long *) (buf + the_feature->offset));
+
+  if (using_sysfs) {
+    int ret = sensors_read_sysfs(name, the_feature, value);
+    if (ret)
+      return ret;
+  } else {
+    sysctl_name[3] = the_feature->sysctl;
+    if (sysctl(sysctl_name, 4, buf, &buflen, NULL, 0))
+      return -SENSORS_ERR_PROC;
+    *value = *((long *) (buf + the_feature->offset));
+  }
   for (mag = the_feature->scaling; mag > 0; mag --)
     *value /= 10.0;
   for (; mag < 0; mag ++)
@@ -180,17 +344,22 @@ int sensors_write_proc(sensors_chip_name
     return sysctl_name[2];
   if (! (the_feature = sensors_lookup_feature_nr(name.prefix,feature)))
     return -SENSORS_ERR_NO_ENTRY;
-  sysctl_name[3] = the_feature->sysctl;
-  if (sysctl(sysctl_name, 4, buf, &buflen, NULL, 0))
-    return -SENSORS_ERR_PROC;
-  if (sysctl_name[0] != CTL_DEV) { sysctl_name[0] = CTL_DEV ; }
   for (mag = the_feature->scaling; mag > 0; mag --)
     value *= 10.0;
   for (; mag < 0; mag ++)
     value /= 10.0;
-  * ((long *) (buf + the_feature->offset)) = (long) value;
-  buflen = the_feature->offset + sizeof(long);
-  if (sysctl(sysctl_name, 4, NULL, 0, buf, buflen))
-    return -SENSORS_ERR_PROC;
-  return 0;
+
+  if (using_sysfs) {
+    return sensors_write_sysfs(name, the_feature, value);
+  } else {
+    sysctl_name[3] = the_feature->sysctl;
+    if (sysctl(sysctl_name, 4, buf, &buflen, NULL, 0))
+      return -SENSORS_ERR_PROC;
+    if (sysctl_name[0] != CTL_DEV) { sysctl_name[0] = CTL_DEV ; }
+    * ((long *) (buf + the_feature->offset)) = (long) value;
+    buflen = the_feature->offset + sizeof(long);
+    if (sysctl(sysctl_name, 4, NULL, 0, buf, buflen))
+      return -SENSORS_ERR_PROC;
+    return 0;
+  }
 }

--Boundary-00=_FGiU/Y15yQDsY4h--

