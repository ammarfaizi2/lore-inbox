Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTAZKbH>; Sun, 26 Jan 2003 05:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbTAZKbH>; Sun, 26 Jan 2003 05:31:07 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:4069 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266796AbTAZKaz>;
	Sun, 26 Jan 2003 05:30:55 -0500
Date: Sun, 26 Jan 2003 11:39:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: yokotak@rmail.plala.or.jp
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gamecon (added support for Sega Saturn controller), kernel 2.4.20
Message-ID: <20030126113957.A21550@ucw.cz>
References: <20021206143353.VNBN20966.mps3.plala.or.jp@rmail.mail.plala.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021206143353.VNBN20966.mps3.plala.or.jp@rmail.mail.plala.or.jp>; from yokotak@rmail.plala.or.jp on Fri, Dec 06, 2002 at 11:22:09PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 11:22:09PM +0900, yokotak@rmail.plala.or.jp wrote:

> Dear Sirs,
> This patch for char/joystick/gamecon.c will adds support for Sega
> Saturn Pad on parallel port with DirectPad Pro interface. Please set
> parameters "8" for Saturn, like "gc=0,8,8,8".
> I tested it with several digital controller, multitap, mission stick,
> shuttle-mouse(it returns Y-axis inverted value against joystick),
> multi controller and racing controller on extra-5volt-powered 1st
> connector. It not supports saturn keyboard, virtua gun, electric train
> controller and pachinko controller. And I have not tested on 2nd
> connector yet.

Why are you adding it into gamecon.c and not fixing it in db9.c instead?

> --- linux-2.4.20/drivers/char/joystick/gamecon.c	2001-09-13 07:34:06.000000000 +0900
> +++ linux/drivers/char/joystick/gamecon.c	2002-12-04 09:56:13.000000000 +0900
> @@ -11,7 +11,7 @@
>   */
>  
>  /*
> - * NES, SNES, N64, Multi1, Multi2, PSX gamepad driver for Linux
> + * NES, SNES, N64, Multi1, Multi2, PSX, SATURN gamepad driver for Linux
>   */
>  
>  /*
> @@ -41,11 +41,14 @@
>  #include <linux/parport.h>
>  #include <linux/input.h>
>  
> +#define GC_PADS_MAX 5
> +#define GC_MAX_ARG "6"		/* GC_PADS_MAX + 1 */
> +
>  MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
>  MODULE_LICENSE("GPL");
> -MODULE_PARM(gc, "2-6i");
> -MODULE_PARM(gc_2,"2-6i");
> -MODULE_PARM(gc_3,"2-6i");
> +MODULE_PARM(gc, "2-" GC_MAX_ARG "i");
> +MODULE_PARM(gc_2, "2-" GC_MAX_ARG "i");
> +MODULE_PARM(gc_3, "2-" GC_MAX_ARG "i");
>  
>  #define GC_SNES		1
>  #define GC_NES		2
> @@ -54,29 +57,31 @@
>  #define GC_MULTI2	5
>  #define GC_N64		6	
>  #define GC_PSX		7
> +#define GC_SATURN	8
>  
> -#define GC_MAX		7
> +#define GC_MAX		8
>  
>  #define GC_REFRESH_TIME	HZ/100
>   
>  struct gc {
>  	struct pardevice *pd;
> -	struct input_dev dev[5];
> +	struct input_dev dev[GC_PADS_MAX];
>  	struct timer_list timer;
> -	unsigned char pads[GC_MAX + 1];
> +	unsigned pads[GC_MAX + 1];
>  	int used;
>  };
>  
>  static struct gc *gc_base[3];
>  
> -static int gc[] __initdata = { -1, 0, 0, 0, 0, 0 };
> -static int gc_2[] __initdata = { -1, 0, 0, 0, 0, 0 };
> -static int gc_3[] __initdata = { -1, 0, 0, 0, 0, 0 };
> +static int gc[GC_PADS_MAX + 1] __initdata = { -1, 0, 0, 0, 0, 0 };
> +static int gc_2[GC_PADS_MAX + 1] __initdata = { -1, 0, 0, 0, 0, 0 };
> +static int gc_3[GC_PADS_MAX + 1] __initdata = { -1, 0, 0, 0, 0, 0 };
>  
> -static int gc_status_bit[] = { 0x40, 0x80, 0x20, 0x10, 0x08 };
> +static unsigned gc_status_bit[] = { 0x40, 0x80, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01,
> +				    0x8000, 0x4000, 0x2000, 0x1000, 0x0800, 0x0400, 0x0200, 0x0100 };
>  
>  static char *gc_names[] = { NULL, "SNES pad", "NES pad", "NES FourPort", "Multisystem joystick",
> -				"Multisystem 2-button joystick", "N64 controller", "PSX controller" };
> +			    "Multisystem 2-button joystick", "N64 controller", "PSX controller", "SATURN controller" };
>  /*
>   * N64 support.
>   */
> @@ -287,17 +292,239 @@
>  }
>  
>  /*
> + * SATURN support
> + *
> + * References
> + *
> + * Mr. Philhower's DirectPad Pro source code and circuit
> + *  joysrc.txt
> + *  saturn.gif
> + * http://www.ziplabel.com/
> + * http://www.arcadecontrols.com/Mirrors/www.ziplabel.com/dpadpro/dpadpr50.zip
> + *
> + * Mr. Kashima's SATURN pad analysis documentation
> + * http://Lillith.sk.tsukuba.ac.jp/~kashima/games/saturn-e.html
> + *
> + * Mr. Nagato's IF-SEGA documentation (Japanese)
> + * http://www.geocities.co.jp/Playtown-Dice/4434/ifsspad.htm
> + *
> + * Mr. Saka's PA (Windows 9x IF-SEGA driver) source code
> + *  PA.ASM
> + * http://blue.ribbon.to/~als4kmaniac/i2/pa.lzh
> + *
> + * Mr. Murata's linux IF-SEGA driver documentation (Japanese) and header file
> + *  DEVICE.txt
> + *  ifsega.h ("DEV TYPE" section)
> + * http://www1.tcnet.ne.jp/fmurata/linux/ifsega/ifsega-0.17.tar.gz
> + *
> + * Mr. Kimura's PSXPAD circuit
> + *  saturn_wiring.jpg
> + * http://speed.dynu.com/function/Wiring_e.html
> + */
> +
> +#define GC_SATURN_PADS_MAX 12
> +#define GC_SATURN_LENGTH 60	/* multitap (1 (id) + 9 (known max)) byte x 6 connector */
> +#define GC_SATURN_ANALOG_DELAY 400	/* micro-second (200-700) */
> +#define GC_SATURN_DISABLE_EMPTY_CONNECTOR 1	/* when connector is empty, warn and disable device */
> +
> +/* output */
> +#define GC_SATURN_P1_SEL1 0x01	/* db25 pin 2 */
> +#define GC_SATURN_P1_SEL2 0x02	/* db25 pin 3 */
> +#define GC_SATURN_P2_SEL1 0x10	/* db25 pin 6 */
> +#define GC_SATURN_P2_SEL2 0x20	/* db25 pin 7 */
> +#define GC_SATURN_POWER 0x08	/* db25 pin 5 */
> +#define GC_SATURN_POWER_SUB 0x04	/* db25 pin 4 */
> +#define GC_SATURN_P1_GND_HIGH 0x40	/* db25 pin 8 */
> +#define GC_SATURN_P2_GND_HIGH 0x80	/* db25 pin 9 */
> +/* input */
> +#define GC_SATURN_DATA4 0x10	/* db25 pin 13 */
> +#define GC_SATURN_DATA3 0x20	/* db25 pin 12 */
> +#define GC_SATURN_DATA2 0x40	/* db25 pin 10 */
> +#define GC_SATURN_DATA1 0x80	/* db25 pin 11 */
> +
> +static short gc_saturn_abs[] = { ABS_X, ABS_Y, ABS_RX, ABS_RY, ABS_RZ, ABS_Z,
> +				 ABS_HAT0X, ABS_HAT0Y, ABS_HAT1X, ABS_HAT1Y };
> +static short gc_saturn_btn[] = { BTN_A, BTN_B, BTN_C, BTN_X, BTN_Y, BTN_Z,
> +				 BTN_TL, BTN_TR, BTN_START };
> +static int gc_saturn_btn_byte[] = { 1, 1, 1, 2, 2, 2, 2, 2, 1 };
> +static unsigned char gc_saturn_btn_mask[] = { 0x04, 0x01, 0x02, 0x40, 0x20,
> +					      0x10, 0x08, 0x80, 0x08 };
> +
> +/*
> + * gc_saturn_read_sub() reads parallel port and returns formatted 4 bit data.
> + */
> +
> +static unsigned char gc_saturn_read_sub(struct gc *gc)
> +{
> +	unsigned char data;
> +
> +	/* read parallel port and invert bit 7 (pin 11) */
> +	data = parport_read_status(gc->pd->port) ^ 0x80;
> +
> +	return (data & GC_SATURN_DATA1 ? 1 : 0) | (data & GC_SATURN_DATA2 ? 2 : 0)
> +	    | (data & GC_SATURN_DATA3 ? 4 : 0) | (data & GC_SATURN_DATA4 ? 8 : 0);
> +}
> +
> +/*
> + * gc_saturn_read_analog() sends clock and returns 8 bit data.
> + */
> +
> +static unsigned char gc_saturn_read_analog(struct gc *gc, unsigned char power, unsigned char sel2)
> +{
> +	unsigned char data;
> +
> +	/* sel2 low  - sel1 low */
> +	parport_write_data(gc->pd->port, power);
> +	udelay(GC_SATURN_ANALOG_DELAY);
> +	data = gc_saturn_read_sub(gc) << 4;
> +
> +	/* sel2 high - sel1 low */
> +	parport_write_data(gc->pd->port, power | sel2);
> +	udelay(GC_SATURN_ANALOG_DELAY);
> +	data |= gc_saturn_read_sub(gc);
> +
> +	return data;
> +}
> +
> +/*
> + * gc_saturn_read_packet() reads a whole saturn packet at connector 
> + * and returns device identifier code.
> + */
> +
> +static unsigned gc_saturn_read_packet(struct gc *gc, unsigned char *data, int connector, int power_by_port)
> +{
> +	int i, j;
> +	unsigned char power, sel1, sel2, tmp;
> +
> +	if (!connector) {
> +		/* connector 1 */
> +		power = GC_SATURN_P2_GND_HIGH + GC_SATURN_P2_SEL1 + GC_SATURN_P2_SEL2 
> +		  + (power_by_port ? GC_SATURN_POWER : 0);
> +		sel1 = GC_SATURN_P1_SEL1;
> +		sel2 = GC_SATURN_P1_SEL2;
> +	} else {
> +		/* connector 2 */
> +		power = GC_SATURN_P1_GND_HIGH + GC_SATURN_P1_SEL1 + GC_SATURN_P1_SEL2 
> +		  + (power_by_port ? GC_SATURN_POWER : 0);
> +		sel1 = GC_SATURN_P2_SEL1;
> +		sel2 = GC_SATURN_P2_SEL2;
> +	}
> +
> +	/* read digital id */
> +	parport_write_data(gc->pd->port, power | sel2 | sel1);
> +	data[0] = gc_saturn_read_sub(gc) & 0x0f;
> +
> +	switch (data[0]) {
> +
> +	case 0xf:
> +		/* 1111  no pad */
> +		return data[0] = 0xff;
> +
> +	case 0x4:
> +	case 0x4 | 0x8:
> +		/* ?100 : digital controller
> +		 * data[ 0] data[ 1] data[ 2]
> +		 * 00000010 rlduSACB RXYZL100
> +		 */
> +		power += (power_by_port ? GC_SATURN_POWER_SUB : 0);
> +		/* pin 4 and pin 9 are connected in digital device. */
> +
> +		parport_write_data(gc->pd->port, power | sel2);
> +		data[1] = gc_saturn_read_sub(gc) << 4;
> +		parport_write_data(gc->pd->port, power | sel1);
> +		data[1] |= gc_saturn_read_sub(gc);
> +		parport_write_data(gc->pd->port, power);
> +		data[2] = gc_saturn_read_sub(gc) << 4;
> +		parport_write_data(gc->pd->port, power | sel2 | sel1);
> +		data[2] |= gc_saturn_read_sub(gc);
> +		return data[0] = 0x02; /* digital controller id in analog style */
> +
> +	case 0x1:
> +		/* 0001 : analog controller */
> +		parport_write_data(gc->pd->port, power | sel2);
> +		udelay(GC_SATURN_ANALOG_DELAY);
> +		/* read analog id */
> +		data[0] = gc_saturn_read_analog(gc, power, sel2);
> +		if (data[0] != 0x41) {
> +			/* read controller
> +			 * data[ 0] data[ 1] data[ 2] data[ 3] ..
> +			 * deviceID rlduSACB RXYZL/// analog_1 ..   
> +			 */
> +			for (i = 0; i < (data[0] & 0x0f); i++)
> +				data[i + 1] = gc_saturn_read_analog(gc, power, sel2);
> +			parport_write_data(gc->pd->port, power | sel1 | sel2);
> +			return data[0];
> +		} else {
> +			/* read multitap 
> +			 * 0x41 : multitap id
> +			 *
> +			 * 0x60 : multitap id-2
> +			 *
> +			 * data[ 0] data[ 1] data[ 2] data[ 3] .. : connector 1
> +			 * deviceID rlduSACB RXYZL/// analog_1 ..
> +			 *
> +			 * data[10] .. : connector 2
> +			 * deviceID ..
> +			 * .
> +			 * .
> +			 * data[n0] data[n1] data[n2]   
> +			 * 00000010 rlduSACB RXYZL000 : digital pad
> +			 *
> +			 * data[m0]
> +			 * 11111111 : no pad
> +			 * .
> +			 * .
> +			 * data[50] data[51] data[52] data[53] .. data[59] : connector 6
> +			 * deviceID rlduSACB RXYZL/// analog_1 .. analog_6   mission stick x2
> +			 */ 
> +			 
> +			/* check multitap id-2 */
> +			if (gc_saturn_read_analog(gc, power, sel2) != 0x60)
> +				return data[0] = 0xff;
> +
> +			for (i = 0; i < 60; i += 10) {
> +				data[i] = gc_saturn_read_analog(gc, power, sel2);
> +				if (data[i] != 0xff) {
> +					/* read pad */
> +					for (j = 0; j < (data[i] & 0x0f); j++)
> +						if (j < 9)
> +							data[i + j + 1] = gc_saturn_read_analog(gc, power, sel2);
> +				}
> +			}
> +			parport_write_data(gc->pd->port, power | sel2 | sel1);
> +			return 0x41; /* multitap id */
> +		}
> +
> +	case 0x0:
> +		/* 0000 : mouse */
> +		parport_write_data(gc->pd->port, power | sel2);
> +		udelay(GC_SATURN_ANALOG_DELAY);
> +		tmp = gc_saturn_read_analog(gc, power, sel2);
> +		if (tmp == 0xff) {
> +			for (i = 0; i < 3; i++)
> +				data[i + 1] = gc_saturn_read_analog(gc, power, sel2);
> +			parport_write_data(gc->pd->port, power | sel2 | sel1);
> +			return data[0] = 0xe3;	/* mouse id */
> +		}
> +
> +	default:
> +		/* unknown */
> +		return data[0];
> +	}
> +}
> +
> +/*
>   * gc_timer() reads and analyzes console pads data.
>   */
>  
> -#define GC_MAX_LENGTH GC_N64_LENGTH
> +#define GC_MAX_LENGTH GC_SATURN_LENGTH
>  
>  static void gc_timer(unsigned long private)
>  {
>  	struct gc *gc = (void *) private;
>  	struct input_dev *dev = gc->dev;
>  	unsigned char data[GC_MAX_LENGTH];
> -	int i, j, s;
> +	int i, j, k, s, n;
>  
>  /*
>   * N64 pads - must be read first, any read confuses them for 200 us
> @@ -307,7 +534,7 @@
>  
>  		gc_n64_read_packet(gc, data);
>  
> -		for (i = 0; i < 5; i++) {
> +		for (i = 0; i < GC_PADS_MAX; i++) {
>  
>  			s = gc_status_bit[i];
>  
> @@ -432,6 +659,83 @@
>  		}
>  	}
>  
> +/*
> + * SATURN controllers
> + */
> +
> +	if (gc->pads[GC_SATURN]) {
> +		for (n = 0, i = 0; i < 2; i++) {
> +			s = gc_saturn_read_packet(gc, data, i, 1) == 0x41 ? 60 : 10;
> +			for (j = 0; j < s; j += 10, n++) {
> +				if (gc_status_bit[n] & gc->pads[GC_SATURN]) {
> +					switch (data[j]) {
> +
> +					case 0x16:
> +						/* multi controller (analog 4 axis) */
> +						input_report_abs(dev + n, ABS_Z, data[j + 6]);
> +					case 0x15:
> +						/* mission stick (analog 3 axis) */
> +						input_report_abs(dev + n, ABS_RY, data[j + 4]);
> +						input_report_abs(dev + n, ABS_RZ, data[j + 5]);
> +					case 0x13:
> +						/* racing controller (analog 1 axis) */
> +						input_report_abs(dev + n, ABS_RX, data[j + 3]);
> +					case 0x02:
> +						/* digital pad (digital 2 axis + buttons) */
> +						input_report_abs(dev + n, ABS_X,
> +								 (data[j + 1] & 128 ? 0 : 1) - (data[j + 1] & 64 ? 0 : 1));
> +						input_report_abs(dev + n, ABS_Y,
> +								 (data[j + 1] & 32 ? 0 : 1) - (data[j + 1] & 16 ? 0 : 1));
> +						for (k = 0; k < 9; k++)
> +							input_report_key(dev + n, gc_saturn_btn[k],
> +									 ~data[j + gc_saturn_btn_byte[k]] & gc_saturn_btn_mask[k]);
> +						break;
> +
> +					case 0x19:
> +						/* mission stick x2 (analog 6 axis + digital 4 axis + buttons) */
> +						input_report_abs(dev + n, ABS_X,
> +								 (data[j + 1] & 128 ? 0 : 1) - (data[j + 1] & 64 ? 0 : 1));
> +						input_report_abs(dev + n, ABS_Y,
> +								 (data[j + 1] & 32 ? 0 : 1) - (data[j + 1] & 16 ? 0 : 1));
> +						for (k = 0; k < 9; k++)
> +							input_report_key(dev + n, gc_saturn_btn[k],
> +									 ~data[j + gc_saturn_btn_byte[k]] & gc_saturn_btn_mask[k]);
> +						input_report_abs(dev + n, ABS_RX, data[j + 3]);
> +						input_report_abs(dev + n, ABS_RY, data[j + 4]);
> +						input_report_abs(dev + n, ABS_RZ, data[j + 5]);
> +						input_report_abs(dev + n, ABS_HAT1X,
> +								 (data[j + 6] & 128 ? 0 : 1) - (data[j + 6] & 64 ? 0 : 1));
> +						input_report_abs(dev + n, ABS_HAT1Y,
> +								 (data[j + 6] & 32 ? 0 : 1) - (data[j + 6] & 16 ? 0 : 1));
> +						input_report_abs(dev + n, ABS_HAT0X, data[j + 7]);
> +						input_report_abs(dev + n, ABS_HAT0Y, data[j + 8]);
> +						input_report_abs(dev + n, ABS_Z, data[j + 9]);
> +						break;
> +
> +					case 0xe3:
> +						/* shuttle mouse (analog 2 axis + buttons. signed value) */
> +						input_report_key(dev + n, BTN_START, data[j + 1] & 0x08);
> +						input_report_key(dev + n, BTN_A, data[j + 1] & 0x04);
> +						input_report_key(dev + n, BTN_C, data[j + 1] & 0x02);
> +						input_report_key(dev + n, BTN_B, data[j + 1] & 0x01);
> +						input_report_abs(dev + n, ABS_RX, data[j + 2] ^ 0x80);
> +						input_report_abs(dev + n, ABS_RY, data[j + 3] ^ 0x80);
> +						break;
> +
> +					case 0xff:
> +					default:
> +						/* no pad */
> +						input_report_abs(dev + n, ABS_X, 0);
> +						input_report_abs(dev + n, ABS_Y, 0);
> +						for (k = 0; k < 9; k++)
> +							input_report_key(dev + n, gc_saturn_btn[k], 0);
> +						break;
> +					}
> +				}
> +			}
> +		}
> +	}
> +
>  	mod_timer(&gc->timer, jiffies + GC_REFRESH_TIME);
>  }
>  
> @@ -460,8 +764,8 @@
>  {
>  	struct gc *gc;
>  	struct parport *pp;
> -	int i, j, psx;
> -	unsigned char data[32];
> +	int i, j, k, n, psx;
> +	unsigned char data[GC_MAX_LENGTH];
>  
>  	if (config[0] < 0)
>  		return NULL;
> @@ -492,7 +796,7 @@
>  	gc->timer.data = (long) gc;
>  	gc->timer.function = gc_timer;
>  
> -	for (i = 0; i < 5; i++) {
> +	for (i = 0; i < GC_PADS_MAX; i++) {
>  
>  		if (!config[i + 1])
>  			continue;
> @@ -588,6 +892,53 @@
>  							" please report to <vojtech@suse.cz>.\n", psx);
>  				}
>  				break;
> +
> +		case GC_SATURN:
> +			if (i >= GC_SATURN_PADS_MAX) {
> +				gc->pads[GC_SATURN] &= ~gc_status_bit[i];
> +				printk(KERN_ERR "gamecon.c: Max %d SATURN controllers supported.\n",GC_SATURN_PADS_MAX);
> +				break;
> +			}
> +			for (n = 0, j = 0; j < 2; j++) {
> +				gc_saturn_read_packet(gc, data, j, 1);	/* dummy read */
> +				udelay(20000); /* enough long time */
> +				psx = (gc_saturn_read_packet(gc, data, j, 1) == 0x41) ? 60 : 10;
> +				for (k = 0; k < psx ; k += 10, n++) {
> +					if (n == i) {
> +						if (data[k] == 0xff && GC_SATURN_DISABLE_EMPTY_CONNECTOR) {
> +							gc->pads[GC_SATURN] &= ~gc_status_bit[i];
> +							printk(KERN_ERR "gamecon.c: No SATURN controller found.\n");
> +						}
> +						if (data[k] == 0x11) {
> +							/* with external 5 volt powered single connector,
> +							   analog device returns 0x11 when read connector 2. */
> +							gc->pads[GC_SATURN] &= ~gc_status_bit[i];
> +							printk(KERN_WARNING "gamecon.c: Single SATURN connector?\n");
> +						}
> +					}
> +				}
> +			}
> +			if (i > n - 1) {
> +				gc->pads[GC_SATURN] &= ~gc_status_bit[i];
> +				printk(KERN_ERR "gamecon.c: No more connector.(%d exists)\n",n);
> +				break;
> +			}
> +			if (gc->pads[GC_SATURN] & gc_status_bit[i]) {
> +				for (j = 0; j < 9; j++)
> +					set_bit(gc_saturn_btn[j], gc->dev[i].keybit);
> +				for (j = 0; j < 10; j++) {
> +					set_bit(gc_saturn_abs[j], gc->dev[i].absbit);
> +					if (j < 2 || j > 7) {
> +						gc->dev[i].absmin[gc_saturn_abs[j]] = -1;
> +						gc->dev[i].absmax[gc_saturn_abs[j]] = 1;
> +					} else {
> +						gc->dev[i].absmin[gc_saturn_abs[j]] = 1;
> +						gc->dev[i].absmax[gc_saturn_abs[j]] = 255;
> +						gc->dev[i].absflat[gc_saturn_abs[j]] = 0;
> +					}
> +				}
> +			}
> +			break;
>  		}
>  
>                  gc->dev[i].name = gc_names[config[i + 1]];
> @@ -605,7 +956,7 @@
>  		return NULL;
>  	}
>  
> -	for (i = 0; i < 5; i++) 
> +	for (i = 0; i < GC_PADS_MAX; i++)
>  		if (gc->pads[0] & gc_status_bit[i]) {
>  			input_register_device(gc->dev + i);
>  			printk(KERN_INFO "input%d: %s on %s\n", gc->dev[i].number, gc->dev[i].name, gc->pd->port->name);
> @@ -617,25 +968,26 @@
>  #ifndef MODULE
>  int __init gc_setup(char *str)
>  {
> -	int i, ints[7];
> +	int i, ints[GC_PADS_MAX + 2];
>  	get_options(str, ARRAY_SIZE(ints), ints);
> -	for (i = 0; i <= ints[0] && i < 6; i++) gc[i] = ints[i + 1];
> +	for (i = 0; i <= ints[0] && i < GC_PADS_MAX + 1; i++) gc[i] = ints[i + 1];
>  	return 1;
>  }
>  int __init gc_setup_2(char *str)
>  {
> -	int i, ints[7];
> +	int i, ints[GC_PADS_MAX + 2];
>  	get_options(str, ARRAY_SIZE(ints), ints);
> -	for (i = 0; i <= ints[0] && i < 6; i++) gc_2[i] = ints[i + 1];
> +	for (i = 0; i <= ints[0] && i < GC_PADS_MAX + 1; i++) gc_2[i] = ints[i + 1];
>  	return 1;
>  }
>  int __init gc_setup_3(char *str)
>  {
> -	int i, ints[7];
> +	int i, ints[GC_PADS_MAX + 2];
>  	get_options(str, ARRAY_SIZE(ints), ints);
> -	for (i = 0; i <= ints[0] && i < 6; i++) gc_3[i] = ints[i + 1];
> +	for (i = 0; i <= ints[0] && i < GC_PADS_MAX + 1; i++) gc_3[i] = ints[i + 1];
>  	return 1;
>  }
> +
>  __setup("gc=", gc_setup);
>  __setup("gc_2=", gc_setup_2);
>  __setup("gc_3=", gc_setup_3);
> @@ -659,7 +1011,7 @@
>  
>  	for (i = 0; i < 3; i++)
>  		if (gc_base[i]) {
> -			for (j = 0; j < 5; j++)
> +			for (j = 0; j < GC_PADS_MAX; j++)
>  				if (gc_base[i]->pads[0] & gc_status_bit[j])
>  					input_unregister_device(gc_base[i]->dev + j); 
>  			parport_unregister_device(gc_base[i]->pd);
> 
> 
> 
> ---
> YOKOTA, Ken-ichi

-- 
Vojtech Pavlik
SuSE Labs
