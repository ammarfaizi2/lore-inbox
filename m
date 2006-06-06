Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWFFRmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWFFRmv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 13:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFFRmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 13:42:51 -0400
Received: from khc.piap.pl ([195.187.100.11]:38150 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750700AbWFFRmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 13:42:50 -0400
To: Andy Green <andy@warmcat.com>
Cc: linux list <linux-kernel@vger.kernel.org>,
       Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org
Subject: Re: Black box flight recorder for Linux
References: <44379AB8.6050808@superbug.co.uk>
	<m3psjqeeor.fsf@defiant.localdomain> <443A4927.5040801@warmcat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 06 Jun 2006 19:42:47 +0200
In-Reply-To: <443A4927.5040801@warmcat.com> (Andy Green's message of "Mon, 10 Apr 2006 13:01:43 +0100")
Message-ID: <m3zmgqxjs8.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Green <andy@warmcat.com> writes:

> Just an additional thought on this idea... both VGA and DVI connectors
> on modern video cards appear to have DDC-2 connections, which is in
> fact I2C.  This would provide an (inherently bidirectional :-) ) 3-pin
> digital interface out of a mostly dead box even on laptops and so on
> with no serial, parallel or legacy keyboard/mouse, so long as they had
> reasonably modern VGA or DVI out.  You would need to get access to the
> two I2C pins and Gnd somehow in that scenario.   Since I2C has a
> concept of addressing it should be possible to choose I2C addresses
> for this communication that doesn't address whatever may be listening
> on the same bus in the monitor.

I think I like the idea and have some (not yet finished but working)
code. Any comments?

The first part is the "console" driver (obvious parts removed). It works
with both my Asus A7V333 (VIA KT333, VIA SMBUS driver) and with VGA DDC
interface on a Cirrus Logic GD 5446 VGA chip (simplified source attached
as well). Using respectively 2464 and 24512 set to ID 0x57.

This is, of course, not yet intended for inclusion.

#define DRV "eelogger"
#define EEPROM_MAX_READ_SIZE 128
#define EEPROM_MAX_WRITE_SIZE 128

int bus = -1;
unsigned char device;
unsigned int page_size, size /* in bytes */;

MODULE_PARM_DESC(bus, "I2C bus number");
module_param(bus, int, 0);
MODULE_PARM_DESC(device, "I2C device address");
module_param(device, byte, 0);

MODULE_PARM_DESC(size, "Size of EEPROM in bytes");
module_param(size, uint, 0);
MODULE_PARM_DESC(page_size, "Size of EEPROM write page in bytes");
module_param(page_size, uint, 0);

struct drv_data {
	struct i2c_client client;
	atomic_t idle;
	int (*read_func)(struct i2c_client *client, u8 *address, char *data,
			 int count);
	int (*write_func)(struct i2c_client *client, const char *data,
			  int count);
	u16 max_write_size, write_address; /* bytes */
	u8 buffer[EEPROM_MAX_WRITE_SIZE + 2 /* address */];
};

static int drv_read_i2c(struct i2c_client *client, u8 *address, char *data,
			int count)
{
	struct i2c_msg msgs[2] = {{
			.addr = client->addr,
			.flags = 0,
			.len = 2,
			.buf = address,
		}, {
			.addr = client->addr,
			.flags = I2C_M_RD,
			.len = count,
			.buf = data,
		}};

	if (i2c_transfer(client->adapter, msgs, 2) < 0)
		return -EIO;

	return count;
}


static int drv_read_smbus(struct i2c_client *client, u8 *address, char *data,
			  int count)
{
	int i;

	if (i2c_smbus_write_byte_data(client, address[0], address[1])) {
		dev_dbg(&client->dev, "EEPROM read has failed\n");
		return -EIO;
	}

	for (i = 0; i < count; i++) {
		int val = i2c_smbus_read_byte(client);
		if (val < 0)
			return i ? i : -EIO;
		*(data++) = (u8)val;
	}
	return count;
}


static int drv_write_smbus(struct i2c_client *client, const char *data,
			   int count)
{
	return i2c_smbus_write_i2c_block_data(client, data[0], count - 1,
					      data + 1) >= 0 ? count : -1;
}


static ssize_t drv_read(struct kobject *kobj, char *buffer, loff_t offset,
			size_t count)
{
	struct i2c_client *client;
	struct drv_data *data;
	u8 address[2] = { offset >> 8, offset & 0xFF};

	client = to_i2c_client(container_of(kobj, struct device, kobj));
	data = i2c_get_clientdata(client);

	if (offset > size || count == 0)
		return 0;
	if (offset + count > size)
		count = size - offset;

/* I don't like/need eeprom.c buffering and prefer direct EEPROM read.
   Reads are limited to, say, 128 bytes */

	if (count > EEPROM_MAX_READ_SIZE)
		count = EEPROM_MAX_READ_SIZE;

	dev_dbg(&client->dev, "Reading EEPROM, offset 0x%llX, length %u\n",
		offset, count);

	return data->read_func(client, address, buffer, count);
}


static void console_write(struct console *co, const char *buffer,
			  unsigned count)
{
	struct i2c_client *client = co->data;
	struct drv_data *data = i2c_get_clientdata(client);
	int put_zero = 0, err;

	if (!count)
		return;

/* This atomic_* things are temporary, I thing I should protect
   console_write() and drv_read() from conflicting but it's not yet here.
*/
	if (!atomic_dec_and_test(&data->idle)) { /* would nest, debug only */
		printk(KERN_DEBUG "NESTED access!\n");
		atomic_inc(&data->idle);
		return;
	}

	do {
		unsigned long t;
		u16 len = page_size - (data->write_address & (page_size - 1));
		if (len > data->max_write_size - 2 /* address */)
			len = data->max_write_size - 2;

		if (len >= count + 1 /* zero */) {
			put_zero = 1; /* last part of the string */
			len = count + 1;
		}

		memcpy(data->buffer + 2 /* address */, buffer, len - put_zero);
		if (put_zero)
			data->buffer[2 /* address */ + len - 1] = '\x0';

		data->buffer[0] = data->write_address >> 8;
		data->buffer[1] = data->write_address & 0xFF;

/* not sure if a busy loop is best here but it avoids locking issues and
   console writes are not frequent. EEPROMs write a "row" (128 bytes with
   24512) within, say, 10 ms so I think no big deal here.
*/

		t = jiffies;
		do {
			err = data->write_func(client, data->buffer, len + 2);
			if (err >= 0)
				break;
		} while (time_before(jiffies, t + HZ / 20)); /* 50 ms */

		if (err < 0) {
			dev_dbg(&client->dev, "EEPROM write has failed\n");
			break;
		}

		count -= len - put_zero; /* overwrite trailing zero */
		buffer += len - put_zero;
		data->write_address += len - put_zero;
		data->write_address &= ~size;
	} while (!put_zero);
	atomic_inc(&data->idle);
}


static struct console cons = {
	.name	= "EEcons",
	.write	= console_write,
	.flags	= CON_PRINTBUFFER | CON_ENABLED,
};

static struct i2c_driver drv = {
	.driver = {
		.name	= "eelogger",
	},
	.id		= I2C_DRIVERID_EEPROM,
	.attach_adapter	= drv_attach_adapter,
	.detach_client	= drv_detach_client,
};

static struct bin_attribute drv_attr = {
	.attr = {
		.name = "eelogger",
		.mode = S_IRUGO,
		.owner = THIS_MODULE,
	},
	.read = drv_read,
};

/* I don't like searching for devices in this case, thus blind fixed
   param-based addressing.
*/

static int drv_attach_adapter(struct i2c_adapter *adapter)
{
	struct i2c_client *client;
	struct drv_data *data;
	int err, does_i2c, write_only = 0;

	if (i2c_check_addr(adapter, device)) /* Skip if already in use */
		return -EBUSY;

	if (i2c_adapter_id(adapter) != bus)
		return -ENOSYS;

	does_i2c = i2c_check_functionality(adapter, I2C_FUNC_I2C);

	if (!does_i2c &&
	    !i2c_check_functionality(adapter,
				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
		printk(KERN_WARNING DRV ": Adapter %u has no required"
		       " functionality\n", bus);
		return -ENOSYS;
	}

	if (!does_i2c &&
	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE |
				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
		printk(KERN_WARNING DRV ": Adapter %u is write-only\n",
		       bus);
		write_only = 1;
	}

	if (!(data = kzalloc(sizeof(struct drv_data), GFP_KERNEL)))
		return -ENOMEM;

	client = &data->client;
	i2c_set_clientdata(client, data);
	client->addr = device;
	client->adapter = adapter;
	client->driver = &drv;
	client->flags = 0;

	atomic_set(&data->idle, 1);
	if (does_i2c) {
		data->read_func = drv_read_i2c;
		data->write_func = i2c_master_send;
	} else {
		data->read_func = drv_read_smbus;
		data->write_func = drv_write_smbus;
	}
	data->max_write_size = EEPROM_MAX_WRITE_SIZE + 2 /* address */;
	if (!does_i2c && I2C_SMBUS_BLOCK_MAX + 1 < EEPROM_MAX_WRITE_SIZE + 2)
		data->max_write_size = I2C_SMBUS_BLOCK_MAX + 1 /* MSB */;

	/* Fill in the remaining client fields */
	strlcpy(client->name, "eelogger", I2C_NAME_SIZE);

	/* Tell the I2C layer a new client has arrived */
	if ((err = i2c_attach_client(client))) {
		kfree(data);
		return err;
	}

	cons.data = client;

	/* create the sysfs file */
	if (!write_only) {
		drv_attr.size = size;
		sysfs_create_bin_file(&client->dev.kobj, &drv_attr);
	}

	register_console(&cons);
	printk(KERN_ERR "EEPROM logger installed\n");
	return 0;
}

static int drv_detach_client(struct i2c_client *client)
{
	int err = i2c_detach_client(client);
	if (err)
		return err;

	unregister_console(&cons);

	kfree(i2c_get_clientdata(client));
	return 0;
}


static int __init bits(unsigned int value)
{
	int v = 0;
	while (!(value & 1) && v < 32) {
		value >>= 1;
		v++;
	}
	if (value == 1)
		return v;
	return -1;
}

static int __init drv_init(void)
{
	int b;

	/* sanity checks */

	if (bus < 0) {
		printk(KERN_WARNING DRV ": Invalid I^2C bus ID\n");
		return -EINVAL;
	}

	if (device < 0x50 || device > 0x57) {
		printk(KERN_WARNING DRV ": Invalid EEPROM device ID, "
		       "supported: 0x50 to 0x57\n");
		return -EINVAL;
	}

	/* EEPROMs smaller than 2432 have 1-byte address format and
	   are not handled here.
	   EEPROMs larger than 24512 will have to occupy more than
	   one I^2C device address and are not (yet) handled.
	   Multiple EEPROM chips are not (yet) handled either. */
	b = bits(size);
	if (b < 12 /* 2432 */ || b > 16 /* 24512 */) {
		printk(KERN_WARNING DRV ": Invalid EEPROM size, supported "
		       "sizes: 4096 to 65536 bytes\n");
		return -EINVAL;
	}

	b = bits(page_size);
	if (b < 0 || page_size > size) {
		printk(KERN_WARNING DRV ": Invalid EEPROM page size\n");
		return -EINVAL;
	}

	return i2c_add_driver(&drv);
}

static void __exit drv_exit(void)
{
	i2c_del_driver(&drv);
}


************************************************************************

The following is an adapter for Cirrus Logic 5446 VGA on my old R440LX
test machine:

There is a locking problem - the VGA is (can be) shared between VT console,
X11 and the driver. I'll look at CL FB driver to see how/if it's done.

static void *regbase = NULL; /* This CL VGA is legacy PIO-driven only */
static int scl, sda;

static void alpine_switch_i2c_bus(int bus /* 0 = internal or 1 = DDC */)
{
	u8 val = vga_rgfx(regbase, 0x17);

	if ((val & 0x60) != (bus * 0x60)) {
#ifdef DEBUG
		printk(KERN_DEBUG "Alpine: setting bus#\n");
#endif
		vga_wgfx(regbase, 0x17, (val & ~0x60) | (bus * 0x60));
	}
}

static void alpine_i2c_in(int b, int *clock, int *data)
{
        u8 reg;

        alpine_switch_i2c_bus(b);

        reg = vga_rseq(regbase, 0x08);
        if (clock)
		*clock = !!(reg & 0x04);
        if (data)
		*data  = !!(reg & 0x80);
}

static void alpine_i2c_out(int b, int clock, int data)
{
        u8 reg = 0xfc;
        alpine_switch_i2c_bus(b);

        if (clock)
		reg |= 1;
        if (data)
		reg |= 2;
        vga_wseq(regbase, 0x08, reg);
}

static void alpine_setsda(void *ptr, int state)
{
	alpine_i2c_out(1, scl, sda = state);
}

static void alpine_setscl(void *ptr, int state)
{
	alpine_i2c_out(1, scl = state, sda);
}

static int alpine_getsda(void *ptr)
{
	int val;
	alpine_i2c_in(1, NULL, &val);
	return val;
}

static int alpine_getscl(void *ptr)
{
	int val;
	alpine_i2c_in(1, &val, NULL);
	return val;
}

static struct i2c_algo_bit_data bit_alpine_data = {
	.setsda		= alpine_setsda,
	.setscl		= alpine_setscl,
	.getsda		= alpine_getsda,
	.getscl		= alpine_getscl,
	.udelay		= 5, /* 400 kHz access */
	.mdelay		= 1,
	.timeout	= HZ
};

static struct i2c_adapter alpine_ops = {
	.owner		= THIS_MODULE,
	.id		= I2C_HW_B_LP, /* test only */
	.algo_data	= &bit_alpine_data,
	.name		= "Cirrus Logic Alpine DDC I2C adapter driver",
};

static int __init dev_init_module(void)
{
/* don't change the signals unless requested */
	alpine_i2c_in(1, &scl, &sda);
	return i2c_bit_add_bus(&alpine_ops);
}

static void __exit dev_cleanup_module(void)
{
	i2c_bit_del_bus(&alpine_ops);
}

-- 
Krzysztof Halasa
