Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311269AbSCSOWG>; Tue, 19 Mar 2002 09:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311277AbSCSOVv>; Tue, 19 Mar 2002 09:21:51 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:9226 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S311267AbSCSOUb>; Tue, 19 Mar 2002 09:20:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Henrique Gobbi <henrique@cyclades.com>
Reply-To: henrique@cyclades.com
Organization: Cyclades Corporation
To: linux-kernel@vger.kernel.org
Subject: TTY driver kernel panic
Date: Tue, 19 Mar 2002 11:21:35 -0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02031911213504.03840@henrique.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all !!!

I am trying to make a simple tty driver to illustrate the tty driver 
interface. I have made this the module and the application listed below. When 
I run the application I get a kernel segmentation fault.

My "call trace" shows that the error is in function write_chan from n_tty.c 
and I did not find the reason for the fault.

Could anyone help me ?

Thanks in advance
---
Henrique Gobbi
henrique@cyclades.com

---------------------------------------------------------------------------------
* This module make nothing. It is just to illustrate 
 * some aspects of tty driver interface
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/timer.h>
#include <linux/interrupt.h>
#include <linux/tty.h>
#include <linux/serial.h>
#include <linux/major.h>
#include <linux/string.h>
#include <linux/fcntl.h>
#include <linux/ptrace.h>
#include <linux/mm.h>
#include <linux/ioport.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <linux/spinlock.h>
#include <linux/proc_fs.h>
#include <linux/slab.h>

#include <asm/system.h>
#include <asm/io.h>
#include <asm/irq.h>
#include <asm/uaccess.h>
#include <asm/bitops.h>

#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/pci.h>
#include <linux/version.h>
#include <linux/stat.h>

static struct tty_driver cy_serial_driver;
static int serial_refcount;

static struct tty_struct *serial_table;
static struct termios *serial_termios;
static struct termios *serial_termios_locked;

static unsigned char * tmp_buf;

void cy_cleanup_module(void) {
	printk("Driver - GoodBye, cruel world\n");
}

static int cy_open (struct tty_struct *tty, struct file *filp) {
	unsigned long page;
	MOD_INC_USE_COUNT;
	printk("Driver - open. Minor: %d\n", MINOR(tty->device) );

	if ( !tmp_buf ) {
		page = get_free_page(GFP_KERNEL);
		if ( !page ) {
			return -ENOMEM;
		}
		if ( tmp_buf ) {
			free_page(page);
		} else {
			tmp_buf = (unsigned char *) page;
		}
	}
	
	return 0;
}

static void cy_close (struct tty_struct * tty, struct file *filp) {
	printk("Driver - close\n");	
	MOD_DEC_USE_COUNT;

	if (tmp_buf) {
		free_page( (unsigned long) tmp_buf );
		tmp_buf = NULL;
	}
	
	return;
}

static int cy_write ( struct tty_struct * tty, int from_user, const unsigned 
char *buf, int count) {
	printk("Driver - Trying to write %d bytes\n", count);
	return 0;
}

int __init cy_init(void)
{
	printk("Driver - init\n");	
	/* Initialize the tty_driver structure */

	memset(&cy_serial_driver, 0, sizeof(struct tty_driver));
	cy_serial_driver.magic = TTY_DRIVER_MAGIC;
	cy_serial_driver.driver_name = "curso";
#ifdef CONFIG_DEVFS_FS
	cy_serial_driver.name = "tts/curso%d";
#else
	cy_serial_driver.name = "ttycurso%d";
#endif
	cy_serial_driver.major = 87;
	cy_serial_driver.minor_start = 0;
	cy_serial_driver.num = 1;
	cy_serial_driver.type = TTY_DRIVER_TYPE_SERIAL;
	cy_serial_driver.subtype = SERIAL_TYPE_NORMAL;
	cy_serial_driver.init_termios = tty_std_termios;
	cy_serial_driver.init_termios.c_cflag =
		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
	cy_serial_driver.init_termios.c_oflag |= OPOST;
	cy_serial_driver.flags = TTY_DRIVER_REAL_RAW;
	cy_serial_driver.refcount = &serial_refcount;
	cy_serial_driver.table = & serial_table;
	cy_serial_driver.termios = & serial_termios;
	cy_serial_driver.termios_locked = & serial_termios_locked;

	cy_serial_driver.open = cy_open;
	cy_serial_driver.close = cy_close;
	cy_serial_driver.write = cy_write;
	
	if (tty_register_driver(&cy_serial_driver))
		panic("Couldn't register Cyclades serial driver\n");

	return 0;

}

module_init(cy_init);
module_exit(cy_cleanup_module);
----------------------------------------------------------------------------------
//  Application

# include <stdio.h>
# include <sys/types.h>
# include <sys/stat.h>
# include <fcntl.h>
# include <errno.h>
# include <unistd.h>

int main (void) {
		int fd;
		int aux;
		char buf[100];
		
		printf("User - Opening the device\n");
		fd = open ("/dev/ttycurso0", O_RDWR | O_NONBLOCK);
		if ( fd == -1) {
			perror("User - Error opening the device, exiting");
			return 1;
		}
	
		strcpy(buf, "Espero 13");
		
		printf("User - Writing 10 bytes to device");
		aux = write(fd, buf, 10);
		printf("User - Writing return: %d", aux);
		
		printf("User - Closing the device\n");
		aux = close(fd);
		if ( aux == -1) {
			perror("User - Error closing the device, exiting");
			return 1;
		}

		return 0;
}
--------------------------------------------------------------------------------------
