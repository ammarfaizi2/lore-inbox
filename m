Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTEHV1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTEHV1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:27:54 -0400
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:49938 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S262127AbTEHV1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:27:44 -0400
Date: Thu, 8 May 2003 17:40:16 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Another it87 patch.
Message-ID: <20030508214016.GB2052@babylon.d2dc.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, greg@kroah.com
References: <20030508082524.GA32348@babylon.d2dc.net> <20030508145039.GA2052@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <20030508145039.GA2052@babylon.d2dc.net>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: multipart/mixed; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2003 at 10:50:39AM -0400, Zephaniah E. Hull wrote:
> On Thu, May 08, 2003 at 04:25:24AM -0400, Zephaniah E. Hull wrote:
> > This is against my last.
>=20
> And this is against that one.

And this against that, oi.

Don't provide min/max for in8, which allowed one to scribble on
registers one should not be messing with. (My fault, oops.)

The setting of the temp high/low registers was off by one, not mine this
time.  While I was at it, I reordered a few other register accesses to
be base 0 instead of base 1.

The temp interface was slightly incorrect, degrees * 100 instead of
degrees * 1000, also fixed.

And lastly, when changing the fan count divisor, fix up the min setting
to still be roughly the same. (Previously the meaning of the value in
the register changed, but not the value itself, resulting in, undesired
surprises.)


This one is attached instead of appended, because of the fact that I'm
also including a perl script.

The script parses /etc/sensors.conf, and scans through what I /hope/ is
the proper sysfs tree to find sensor data, giving output that is roughly
in the same ballpark of the sensors command, except that it actually
works with the sysfs interface.

It is far from perfect, the code is a mess, and it does not do things
like conversions between degrees C and degrees F.

If you want it to set things, run with the single argument of '-s'.

There is one new command for the /etc/sensors.conf, mostly because I
could not be bothered to try to dig up the alarm settings for every
single chip that is supported, so instead you get to do
'alarm_bit in0 8', if the 8th bit of the alarm bitmask goes to the in0
input.


Holler if problems show up, however I can make no promises, this was a
quick job just so that I can use things.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

Well, of course.  That's what Unix sysadmins do.  We make things
work.  Even if they're things which are outside our job description
or supposed area of expertise.

As to the other proposal of breaking them for 6 months first, I
will offer a quote from an MCSE I once met:

"You're a Unix sysadmin?  You're the bad guys.  You keep things
working."

Pretty obvious who gets paid when things break, and who gets paid
when they don't.
  -- Dan Birchall in the Scary Devil Monastery.

--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="it87_4.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.5.65/drivers/i2c/chips/it87.c	2003-05-08 17:06:48.000000000 -04=
00
+++ linux-2.5.69-mm1/drivers/i2c/chips/it87.c	2003-05-08 17:13:05.000000000=
 -0400
@@ -80,17 +80,17 @@
=20
 /* Monitors: 9 voltage (0 to 7, battery), 3 temp (1 to 3), 3 fan (1 to 3) =
*/
=20
-#define IT87_REG_FAN(nr)       (0x0c + (nr))
-#define IT87_REG_FAN_MIN(nr)   (0x0f + (nr))
+#define IT87_REG_FAN(nr)       (0x0d + (nr))
+#define IT87_REG_FAN_MIN(nr)   (0x10 + (nr))
 #define IT87_REG_FAN_CTRL      0x13
=20
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
-#define IT87_REG_TEMP(nr)      (0x28 + (nr))
+#define IT87_REG_TEMP(nr)      (0x29 + (nr))
=20
 #define IT87_REG_VIN_MAX(nr)   (0x30 + (nr) * 2)
 #define IT87_REG_VIN_MIN(nr)   (0x31 + (nr) * 2)
-#define IT87_REG_TEMP_HIGH(nr) (0x3e + (nr) * 2)
-#define IT87_REG_TEMP_LOW(nr)  (0x3f + (nr) * 2)
+#define IT87_REG_TEMP_HIGH(nr) (0x40 + ((nr) * 2))
+#define IT87_REG_TEMP_LOW(nr)  (0x41 + ((nr) * 2))
=20
 #define IT87_REG_I2C_ADDR      0x48
=20
@@ -289,6 +289,9 @@
 {								\
 	return show_in(dev, buf, 0x##offset);			\
 }								\
+static DEVICE_ATTR(in_input##offset, S_IRUGO, show_in##offset, NULL)
+
+#define limit_in_offset(offset)					\
 static ssize_t							\
 	show_in##offset##_min (struct device *dev, char *buf)	\
 {								\
@@ -309,20 +312,27 @@
 {								\
 	return set_in_max(dev, buf, count, 0x##offset);		\
 }								\
-static DEVICE_ATTR(in_input##offset, S_IRUGO, show_in##offset, NULL) 	\
 static DEVICE_ATTR(in_min##offset, S_IRUGO | S_IWUSR, 		\
 		show_in##offset##_min, set_in##offset##_min)	\
 static DEVICE_ATTR(in_max##offset, S_IRUGO | S_IWUSR, 		\
 		show_in##offset##_max, set_in##offset##_max)
=20
 show_in_offset(0);
+limit_in_offset(0);
 show_in_offset(1);
+limit_in_offset(1);
 show_in_offset(2);
+limit_in_offset(2);
 show_in_offset(3);
+limit_in_offset(3);
 show_in_offset(4);
+limit_in_offset(4);
 show_in_offset(5);
+limit_in_offset(5);
 show_in_offset(6);
+limit_in_offset(6);
 show_in_offset(7);
+limit_in_offset(7);
 show_in_offset(8);
=20
 /* 3 temperatures */
@@ -331,7 +341,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr])*10 );
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr])*100 );
 }
 /* more like overshoot temperature */
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
@@ -339,7 +349,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr])*10);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr])*100);
 }
 /* more like hysteresis temperature */
 static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
@@ -347,14 +357,14 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	it87_update_client(client);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr])*10);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr])*100);
 }
 static ssize_t set_temp_max(struct device *dev, const char *buf,=20
 		size_t count, int nr)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10)/10;
+	int val =3D simple_strtol(buf, NULL, 10)/100;
 	data->temp_high[nr] =3D TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
 	return count;
@@ -364,7 +374,7 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
-	int val =3D simple_strtol(buf, NULL, 10)/10;
+	int val =3D simple_strtol(buf, NULL, 10)/100;
 	data->temp_low[nr] =3D TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
 	return count;
@@ -480,7 +490,7 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	it87_write_value(client, IT87_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
 	return count;
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf,=20
@@ -489,8 +499,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
+	int i, min[3];
 	u8 old =3D it87_read_value(client, IT87_REG_FAN_DIV);
=20
+	for (i =3D 0; i < 3; i++)
+	    min[i] =3D FAN_FROM_REG(data->fan_min[i], DIV_FROM_REG(data->fan_div[=
i]));
+
 	switch (nr) {
 	    case 0:
 	    case 1:
@@ -508,6 +522,11 @@
 	if (data->fan_div[2] =3D=3D 3)
 	    val |=3D 0x1 << 6;
 	it87_write_value(client, IT87_REG_FAN_DIV, val);
+
+	for (i =3D 0; i < 3; i++) {
+	    data->fan_min[i]=3DFAN_TO_REG(min[i], DIV_FROM_REG(data->fan_div[i]));
+	    it87_write_value(client, IT87_REG_FAN_MIN(i), data->fan_min[i]);
+	}
 	return count;
 }
=20
@@ -700,7 +719,6 @@
 	device_create_file(&new_client->dev, &dev_attr_in_min5);
 	device_create_file(&new_client->dev, &dev_attr_in_min6);
 	device_create_file(&new_client->dev, &dev_attr_in_min7);
-	device_create_file(&new_client->dev, &dev_attr_in_min8);
 	device_create_file(&new_client->dev, &dev_attr_in_max0);
 	device_create_file(&new_client->dev, &dev_attr_in_max1);
 	device_create_file(&new_client->dev, &dev_attr_in_max2);
@@ -709,7 +727,6 @@
 	device_create_file(&new_client->dev, &dev_attr_in_max5);
 	device_create_file(&new_client->dev, &dev_attr_in_max6);
 	device_create_file(&new_client->dev, &dev_attr_in_max7);
-	device_create_file(&new_client->dev, &dev_attr_in_max8);
 	device_create_file(&new_client->dev, &dev_attr_temp_input1);
 	device_create_file(&new_client->dev, &dev_attr_temp_input2);
 	device_create_file(&new_client->dev, &dev_attr_temp_input3);
@@ -845,23 +862,23 @@
 	it87_write_value(client, IT87_REG_VIN_MAX(7),
 			 IN_TO_REG(IT87_INIT_IN_MAX_7));
 	/* Note: Battery voltage does not have limit registers */
-	it87_write_value(client, IT87_REG_FAN_MIN(1),
+	it87_write_value(client, IT87_REG_FAN_MIN(0),
 			 FAN_TO_REG(IT87_INIT_FAN_MIN_1, 2));
-	it87_write_value(client, IT87_REG_FAN_MIN(2),
+	it87_write_value(client, IT87_REG_FAN_MIN(1),
 			 FAN_TO_REG(IT87_INIT_FAN_MIN_2, 2));
-	it87_write_value(client, IT87_REG_FAN_MIN(3),
+	it87_write_value(client, IT87_REG_FAN_MIN(2),
 			 FAN_TO_REG(IT87_INIT_FAN_MIN_3, 2));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(1),
+	it87_write_value(client, IT87_REG_TEMP_HIGH(0),
 			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_1));
-	it87_write_value(client, IT87_REG_TEMP_LOW(1),
+	it87_write_value(client, IT87_REG_TEMP_LOW(0),
 			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_1));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(2),
+	it87_write_value(client, IT87_REG_TEMP_HIGH(1),
 			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_2));
-	it87_write_value(client, IT87_REG_TEMP_LOW(2),
+	it87_write_value(client, IT87_REG_TEMP_LOW(1),
 			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_2));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(3),
+	it87_write_value(client, IT87_REG_TEMP_HIGH(2),
 			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_3));
-	it87_write_value(client, IT87_REG_TEMP_LOW(3),
+	it87_write_value(client, IT87_REG_TEMP_LOW(2),
 			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_3));
=20
 	/* Enable voltage monitors */
@@ -914,18 +931,18 @@
 		data->in_min[8] =3D 0;
 		data->in_max[8] =3D 255;
=20
-		for (i =3D 1; i <=3D 3; i++) {
-			data->fan[i - 1] =3D
+		for (i =3D 0; i < 3; i++) {
+			data->fan[i] =3D
 			    it87_read_value(client, IT87_REG_FAN(i));
-			data->fan_min[i - 1] =3D
+			data->fan_min[i] =3D
 			    it87_read_value(client, IT87_REG_FAN_MIN(i));
 		}
-		for (i =3D 1; i <=3D 3; i++) {
-			data->temp[i - 1] =3D
+		for (i =3D 0; i < 3; i++) {
+			data->temp[i] =3D
 			    it87_read_value(client, IT87_REG_TEMP(i));
-			data->temp_high[i - 1] =3D
+			data->temp_high[i] =3D
 			    it87_read_value(client, IT87_REG_TEMP_HIGH(i));
-			data->temp_low[i - 1] =3D
+			data->temp_low[i] =3D
 			    it87_read_value(client, IT87_REG_TEMP_LOW(i));
 		}
=20

--3lcZGd9BuhuYXNfi
Content-Type: application/x-perl
Content-Disposition: attachment; filename="my_sen.pl"
Content-Transfer-Encoding: quoted-printable

#! /usr/bin/perl -W=0Ause strict;=0Ause FileHandle;=0Ause IO::Dir;=0Ause Fi=
le::stat;=0Ause Fcntl ':mode';=0A=0Asub get_config ()=0A{=0A    my ($file, =
$chip_ref) =3D @_;=0A    my ($fh, $line, $cur, $chip, $cmd, %var, $var, $re=
st);=0A=0A    $fh =3D new FileHandle;=0A    $fh->open($file, "r");=0A=0A   =
 $cur =3D 0;=0A=0A    while ($line =3D $fh->getline()) {=0A	chomp($line);=
=0A	$line =3D~ s/#.*$//;=0A	$line =3D~ s/^\s*//;=0A	if ($line eq "") {=0A	 =
   next;=0A	} elsif ($line =3D~ /^chip/i) {=0A	    $cur =3D 0;=0AL1:	    wh=
ile ($line =3D~ /"([^"]*)"/g) {=0A		$chip =3D $1;=0A		$chip =3D~ s/\*/.*/g;=
=0A		if ($$chip_ref{'name'} =3D~ /$chip/) {=0A		    $cur =3D 1;=0A		    las=
t L1;=0A		}=0A	    }=0A	} elsif ($cur) {=0A	    $line =3D~ /^([^\s]+)\s+([^=
\s]+)(\s+(.*))?$/i;=0A	    $cmd =3D $1;=0A	    %var =3D break_varname2($2);=
=0A	    $$chip_ref{$var{'id'}}{'id'}{'name'} =3D $var{'name'};=0A	    $$chi=
p_ref{$var{'id'}}{'id'}{'sub'} =3D $var{'sub'};=0A	    $$chip_ref{$var{'id'=
}}{'id'}{'num'} =3D $var{'num'};=0A	    $$chip_ref{$var{'id'}}{'id'}{'id'} =
=3D $var{'id'};=0A	    $rest =3D $4;=0A	    $var =3D $var{'id'};=0A	    if =
($cmd eq "ignore") {=0A		$$chip_ref{$var}{'ignore'} =3D 1;=0A	    } elsif (=
$cmd eq "label") {=0A		$rest =3D~ /"([^"]+)"/i;=0A		$$chip_ref{$var}{'label=
'} =3D $1;=0A	    } elsif ($cmd eq "compute") {=0A		$rest =3D~ /^\s*([^,]+)=
\s*,\s*(.*)\s*$/i;=0A		$$chip_ref{$var}{'compute_from'} =3D $1;=0A		$$chip_=
ref{$var}{'compute_to'} =3D $2;=0A	    } elsif ($cmd eq "set") {=0A		if (de=
fined($var{'sub'})) {=0A		    $$chip_ref{$var}{'subs'}{$var{'sub'}}{'force'=
} =3D $rest;=0A		} else {=0A		    $$chip_ref{$var}{'force'} =3D $rest;=0A		=
}=0A	    } elsif ($cmd eq "alarm_bit") {=0A		if (defined($var{'sub'})) {=0A=
		    $$chip_ref{$var}{'subs'}{$var{'sub'}}{'alarm_bit'} =3D $rest;=0A		} e=
lse {=0A		    $$chip_ref{$var}{'alarm_bit'} =3D $rest;=0A		}=0A	    } else =
{=0A		print("Line: -$line-\n");=0A	    }=0A	}=0A    }=0A}=0A=0Asub print_me=
ss ()=0A{=0A    my ($pre, $mess) =3D @_;=0A    my ($t1, $t2);=0A=0A    $t1 =
=3D ref($mess);=0A    if (!$t1) {=0A	print($mess . "\n");=0A    } elsif ($t=
1 eq "ARRAY") {=0A	print("[\n");=0A	foreach $t2 (@{$mess}) {=0A	    print($=
pre . "=3D ");=0A	    &print_mess($pre . "\t", $t2);=0A	}=0A	print($pre . "=
]\n");=0A    } elsif ($t1 eq "HASH") {=0A	print("{\n");=0A	foreach $t2 (sor=
t(keys(%{$mess}))) {=0A	    print("$pre$t2 =3D ");=0A	    &print_mess($pre =
=2E "\t", $$mess{$t2});=0A	}=0A	print($pre . "}\n");=0A    }=0A}=0A=0Asub b=
reak_varname ()=0A{=0A    my ($varname) =3D @_;=0A    my (%out);=0A=0A    i=
f ($varname =3D~ /div/) {=0A	$varname =3D~ /^([^0-9]*)([0-9]*)$/;=0A	$out{'=
name'} =3D $1;=0A	$out{'num'} =3D $2;=0A    } else {=0A	$varname =3D~ /^([^=
_0-9]*)(_([^0-9]*))?([0-9]*)?$/;=0A	$out{'name'} =3D $1;=0A	$out{'sub'} =3D=
 $3 if (defined($3) && $3 ne "input");=0A	$out{'num'} =3D $4;=0A    }=0A   =
 if ($out{'name'} eq 'temp' && defined($out{'sub'})) {=0A	if ($out{'sub'} e=
q 'over') {=0A	    $out{'sub'} =3D 'max';=0A	} elsif ($out{'sub'} eq 'hyst'=
) {=0A	    $out{'sub'} =3D 'min';=0A	}=0A    }=0A    $out{'id'} =3D $out{'n=
ame'};=0A    $out{'id'} .=3D $out{'num'} if (defined($out{'num'}));=0A    r=
eturn %out;=0A}=0A=0Asub break_varname2 ()=0A{=0A    my ($varname) =3D @_;=
=0A    my (%out);=0A=0A    if ($varname =3D~ /div/) {=0A	$varname =3D~ /^([=
^0-9]*)([0-9]*)_div$/;=0A	$out{'name'} =3D $1 . '_div';=0A	$out{'num'} =3D =
$2;=0A    } else {=0A	$varname =3D~ /^([^_0-9]*)([0-9]*)?(_([^0-9]*))?$/;=
=0A	$out{'name'} =3D $1;=0A	$out{'sub'} =3D $4 if (defined($4) && $4 ne "in=
put");=0A	$out{'num'} =3D $2;=0A    }=0A    if ($out{'name'} eq 'temp' && d=
efined($out{'sub'})) {=0A	if ($out{'sub'} eq 'over') {=0A	    $out{'sub'} =
=3D 'max';=0A	} elsif ($out{'sub'} eq 'hyst') {=0A	    $out{'sub'} =3D 'min=
';=0A	}=0A    }=0A    $out{'id'} =3D $out{'name'};=0A    $out{'id'} .=3D $o=
ut{'num'} if (defined($out{'num'}));=0A    return %out;=0A}=0A=0Asub do_exp=
ression ()=0A{=0A    my ($expr, $in) =3D @_;=0A    $expr =3D~ s/@/$in/g;=0A=
    return eval($expr);=0A}=0A=0Asub sensor_dir ()=0A{=0A    my ($dir_name,=
 $bus, $id) =3D @_;=0A    my (%chip, $dir, $fh, $file, $line, $value, %var)=
;=0A=0A    $fh =3D new FileHandle;=0A    $fh->open($dir_name . '/name', "r"=
);=0A    $line =3D $fh->getline(); chomp($line);=0A    $fh->close;=0A    $c=
hip{'name'} =3D "$line-$bus-$id";=0A=0A    $dir =3D new IO::Dir $dir_name;=
=0A    while (defined($file =3D $dir->read())) {=0A	next if ($file eq ".");=
=0A	next if ($file eq "..");=0A	next if ($file eq "name");=0A	next if ($fil=
e eq "power");=0A	%var =3D &break_varname($file);=0A	$fh =3D new FileHandle=
;=0A	$fh->open($dir_name . '/' . $file);=0A	$value =3D $fh->getline(); chom=
p($value);=0A	$fh->close();=0A=0A	if ($var{'name'} eq "in") {=0A	    $value=
 /=3D 1000;=0A	}=0A	if ($var{'name'} eq "temp") {=0A	    $value /=3D 1000;=
=0A	}=0A	=0A	$chip{$var{'id'}}{'id'}{'name'} =3D $var{'name'};=0A	$chip{$va=
r{'id'}}{'id'}{'sub'} =3D $var{'sub'};=0A	$chip{$var{'id'}}{'id'}{'num'} =
=3D $var{'num'};=0A	$chip{$var{'id'}}{'id'}{'id'} =3D $var{'id'};=0A	if (de=
fined($var{'sub'})) {=0A	    $chip{$var{'id'}}{'subs'}{$var{'sub'}}{'value'=
} =3D $value;=0A	} else {=0A	    $chip{$var{'id'}}{'value'} =3D $value;=0A	=
}=0A    }=0A=0A    &get_config("/etc/sensors.conf", \%chip);=0A=0A    &prin=
t_sensor(\%chip);=0A=0A    if (defined($ARGV[0]) && $ARGV[0] eq '-s') {=0A	=
&set_sensor($dir_name, \%chip);=0A    }=0A}=0A=0Asub set_sensor ()=0A{=0A  =
  my ($dir_name, $sensors) =3D @_;=0A    my ($key, $key2, $ref, $t1, $sen, =
$sub, $val, $file, $fh);=0A=0A    foreach $key (sort(keys(%{$sensors}))) {=
=0A	if (($ref =3D ref($$sensors{$key}))) {=0A	    $sen =3D $$sensors{$key};=
=0A	    next if ($$sen{'ignore'});=0A	    if (defined($$sen{'force'})) {=0A=
		$file =3D $dir_name . '/' . $$sen{'id'}{'name'};=0A		$file .=3D $$sen{'id=
'}{'num'} if (defined($$sen{'id'}{'num'}));=0A		$fh =3D new FileHandle;=0A	=
	die "$file" if (!$fh->open($file, "w"));=0A=0A		if (defined($$sen{'compute=
_to'})) {=0A		    $val =3D&do_expression($$sen{'compute_to'}, $$sen{'force'=
});=0A		} else {=0A		    $val =3D &do_expression($$sen{'force'}, 0);=0A		}=
=0A		$val *=3D 1000 if ($$sen{'id'}{'name'} eq 'in');=0A		$val *=3D 1000 if=
 ($$sen{'id'}{'name'} eq 'temp');=0A		$fh->print("$val\n");=0A		$fh->close(=
);=0A	    }=0A	    if (defined($$sen{'subs'})) {=0A		for $key2 (keys(%{$$se=
n{'subs'}})) {=0A		    $sub =3D $$sen{'subs'}{$key2};=0A		    next if (!def=
ined($$sub{'force'}));=0A		    $file =3D $dir_name . '/' . $$sen{'id'}{'nam=
e'};=0A		    $file .=3D '_' . $key2;=0A		    $file .=3D$$sen{'id'}{'num'} i=
f (defined($$sen{'id'}{'num'}));=0A		    $fh =3D new FileHandle;=0A		    if=
 (!$fh->open($file, "w")) {=0A			&print_mess("", $sen);=0A			print("$file n=
ot found!\n");=0A			next;=0A		    }=0A		    if (defined($$sen{'compute_to'}=
)) {=0A			$val=3D&do_expression($$sen{'compute_to'},$$sub{'force'});=0A		  =
  } else {=0A			$val =3D &do_expression($$sub{'force'}, 0);=0A		    }=0A		 =
   $val *=3D 1000 if ($$sen{'id'}{'name'} eq 'in');=0A		    $val *=3D 1000 =
if ($$sen{'id'}{'name'} eq 'temp');=0A		    $fh->print("$val\n");=0A		    $=
fh->close();=0A		}=0A	    }=0A	}=0A    }=0A}=0A=0Asub print_sensor ()=0A{=
=0A    my ($sensors) =3D @_;=0A    my ($key, $key2, $ref, $t1, $sen, $sub, =
$val, $name);=0A=0A    print("NAME : " . $$sensors{'name'} . "\n");=0A    f=
oreach $key (sort(keys(%{$sensors}))) {=0A	if (($ref =3D ref($$sensors{$key=
}))) {=0A	    $sen =3D $$sensors{$key};=0A	    next if ($$sen{'ignore'});=
=0A	    if (defined($$sen{'label'})) {=0A		$name =3D $$sen{'label'};=0A	   =
 } else {=0A		$name =3D $key;=0A	    }=0A	    if (defined($$sen{'value'})) =
{=0A		if (defined($$sen{'compute_from'})) {=0A		    $val =3D&do_expression(=
$$sen{'compute_from'}, $$sen{'value'});=0A		} else {=0A		    $val =3D $$sen=
{'value'};=0A		}=0A		printf("%12s : %-+5g", $name, $val);=0A		if (defined($=
$sen{'alarm_bit'}) && $$sensors{'alarm'}{'value'} & (1 << $$sen{'alarm_bit'=
})) {=0A		    printf("!");=0A		}=0A	    }=0A	    if (defined($$sen{'subs'})=
) {=0A		for $key2 (keys(%{$$sen{'subs'}})) {=0A		    $sub =3D $$sen{'subs'}=
{$key2};=0A		    next if (!defined($$sub{'value'}));=0A		    if (defined($$=
sen{'compute_from'})) {=0A			$val =3D&do_expression($$sen{'compute_from'}, =
$$sub{'value'});=0A		    } else {=0A			$val =3D $$sub{'value'};=0A		    }=
=0A		    printf("\t$key2 : %-+5g", $val);=0A		    if (defined($$sub{'alarm_=
bit'}) && $$sensors{'alarm'}{'value'} & (1 << $$sub{'alarm_bit'})) {=0A			p=
rintf("!");=0A		    }=0A		}=0A	    }=0A	    print("\n");=0A	}=0A    }=0A}=
=0A=0Asub find_sensors ()=0A{=0A    my ($d0, $d1, $f0, $f1, $f2, $fh, $bus,=
 $found, $name, $b0, $b1, $b2);=0A=0A    $b0 =3D '/sys/devices/legacy';=0A =
   if (!-d $b0) {=0A	die "No sensors found.\n";=0A    }=0A=0A    $d0 =3D ne=
w IO::Dir $b0;=0A    $found =3D 0;=0A    while(defined($f0 =3D $d0->read())=
) {=0A	next if (($f0 eq ".") || ($f0 eq ".."));=0A	$b1 =3D $b0 . '/' . $f0;=
=0A	if (-d $b1) {=0A	    $fh =3D new FileHandle ($b1 . '/name');=0A	    $na=
me =3D $fh->getline;=0A	    $fh->close;=0A	    chomp($name);=0A	    if ($na=
me eq "ISA main adapter") {=0A		$bus =3D "isa";=0A	    } else {=0A		$bus =
=3D "i2c";=0A	    }=0A=0A	    $d1 =3D new IO::Dir ($b1);=0A	    while(defin=
ed($f1 =3D $d1->read())) {=0A		next if (($f1 eq ".") || ($f1 eq ".."));=0A	=
	$b2 =3D $b1 . '/' . $f1;=0A		if (-d $b2) {=0A		    &sensor_dir($b2, $bus, =
$f1);=0A		    $found++;=0A		}=0A	    }=0A	}=0A    }=0A}=0A=0A#&sensor_dir($=
ARGV[0], $ARGV[1], $ARGV[2]);=0A&find_sensors();=0A
--3lcZGd9BuhuYXNfi--

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+us7ARFMAi+ZaeAERAv1WAJ9E2SEOdhaM4o/ioUYEq0B7detsNgCgqL+L
gOQym5787IdgP3cfm4eDo6A=
=rlDs
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
