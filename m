Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUE1Tn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUE1Tn4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUE1Tmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:42:55 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:5832 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263826AbUE1Tjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:39:42 -0400
To: linux-kernel@vger.kernel.org
Cc: Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       Giuseppe Bilotta <bilotta78@hotpop.com>, Andrew Morton <akpm@osdl.org>
References: <20040507193519.06062655.akpm@osdl.org> <20040525201616.GE6512@gucio> <MPG.1b2111558bc2d299896a2@news.gmane.org> <Pine.GSO.4.58.0405072348120.21057@stekt37> <xb7aczscv0q.fsf@savona.informatik.uni-freiburg.de> <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
Subject: 2.6.* useland replacements of the atkbd and psmouse modules
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 28 May 2004 21:39:38 +0200
Message-ID: <xb765agcpdx.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/#userdrivers

These userspace  drivers are ported  from kernel code based  on 2.6.6.
They are  still in  alpha stage.  Some  "difficult features"  (or code
that I don't understand) are dropped.

However, they  do demonstrate that using the  SERIO_USERDEV patch (see
message   <Pine.GSO.4.58.0405072348120.21057@stekt37>,   available  at
http://lkml.org/lkml/2004/5/7/143), it is really possible to implement
the PS2 mouse/keyboard drivers in user space.


--=-=-=
Content-Disposition: attachment; filename=atkbd.c

/*
 * AT and PS/2 keyboard driver
 *
 * Copyright (c) 1999-2002 Vojtech Pavlik
 * Copyright (c) 2004 Sau Dan LEE
 */

/*
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation.
 */

/*
  This program is based on linux-2.6.6/drivers/input/serio/atkbd.c
  The difference is that this program now runs in user-space (swappable),
  while the kernel driver runs in kernel-space.

  Usage: atkbd /dev/misc/isa0060/serio0

  Prerequisites:
     1) 'uinput' module loaded or compiled in
         If not using 'devfs', you have to create the /dev/uinput char
         device with major 10.  The minor number can be found in
	 "cat /proc/misc" after loading the 'uinput' module.
     2) 'serio' module with SERIO_USERDEV patch loaded or compiled in
     3) 'i8042' module loaded or compiled in
     4) 'atkbd' module UNloaded and NOT compiled in
        Note: if you're accessing from console, keyboard will be disabled
        when 'atkbd' is unloaded.  It's more convenient to connect from
	remote to do this.  Alternatively, write some shell scripts
	to invoke unload 'atkbd' and activate this program at once.

  TODO:
     - this program current ignore LED events -- BUG
     - options parsing should be added to allow user to
       specify the module parameters.
     - daemonize this program, so as to make it easy to run from /etc/inittab
     - soft_repeat is not supported yet.  (How useful is this?)
*/

/*
 * This driver can handle standard AT keyboards and PS/2 keyboards in
 * Translated and Raw Set 2 and Set 3, as well as AT keyboards on dumb
 * input-only controllers and AT keyboards connected over a one way RS232
 * converter.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/time.h>
#include <sys/types.h>
#include <linux/input.h>
#include <linux/uinput.h>

/* older kernel headers lack the following two key codes */

#ifndef KEY_HANGUEL
#define KEY_HANGUEL             122
#endif

#ifndef KEY_HANJA
#define KEY_HANJA               123
#endif


#define module_param_named(name,var,type,defl) struct dummy
#define MODULE_PARM_DESC(name,desc) struct dummy


#define warn(...) fprintf(stderr, "atkbd: (warning) " __VA_ARGS__)
#define err(...)  fprintf(stderr, "atkbd: ERROR " __VA_ARGS__)
#define info(...) printf("atkbd: " __VA_ARGS__)
#define perr(msg)  do{fprintf(stderr, "atkbd: ERROR: "); perror(msg);}while(0)
#define perrx(msg) do{perr(msg); exit(1);}while(0)
#define pferrx() perrx(__FUNCTION__)


static int atkbd_set = 2;
module_param_named(set, atkbd_set, int, 0);
MODULE_PARM_DESC(set, "Select keyboard code set (2 = default, 3 = PS/2 native)");

#if defined(__i386__) || defined(__x86_64__) || defined(__hppa__)
static int atkbd_reset;
#else
static int atkbd_reset = 1;
#endif
module_param_named(reset, atkbd_reset, bool, 0);
MODULE_PARM_DESC(reset, "Reset keyboard during initialization");

static int atkbd_softrepeat;
module_param_named(softrepeat, atkbd_softrepeat, bool, 0);
MODULE_PARM_DESC(softrepeat, "Use software keyboard repeat");

static int atkbd_scroll;
module_param_named(scroll, atkbd_scroll, bool, 0);
MODULE_PARM_DESC(scroll, "Enable scroll-wheel on MS Office and similar keyboards");

static int atkbd_extra;
module_param_named(extra, atkbd_extra, bool, 0);
MODULE_PARM_DESC(extra, "Enable extra LEDs and keys on IBM RapidAcces, EzKey and similar keyboards");

/*
 * Scancode to keycode tables. These are just the default setting, and
 * are loadable via an userland utility.
 */

#if defined(__hppa__)
#include "hpps2atkbd.h"
#else

static unsigned char atkbd_set2_keycode[512] = {

	  0, 67, 65, 63, 61, 59, 60, 88,  0, 68, 66, 64, 62, 15, 41,117,
	  0, 56, 42, 93, 29, 16,  2,  0,  0,  0, 44, 31, 30, 17,  3,  0,
	  0, 46, 45, 32, 18,  5,  4, 95,  0, 57, 47, 33, 20, 19,  6,183,
	  0, 49, 48, 35, 34, 21,  7,184,  0,  0, 50, 36, 22,  8,  9,185,
	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
	  0, 89, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0, 85,
	  0, 86, 91, 90, 92,  0, 14, 94,  0, 79,124, 75, 71,121,  0,  0,
	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,

	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
	217,100,255,  0, 97,165,  0,  0,156,  0,  0,  0,  0,  0,  0,125,
	173,114,  0,113,  0,  0,  0,126,128,  0,  0,140,  0,  0,  0,127,
	159,  0,115,  0,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
	157,  0,  0,  0,  0,  0,  0,  0,155,  0, 98,  0,  0,163,  0,  0,
	226,  0,  0,  0,  0,  0,  0,  0,  0,255, 96,  0,  0,  0,143,  0,
	  0,  0,  0,  0,  0,  0,  0,  0,  0,107,  0,105,102,  0,  0,112,
	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119,  0,

	  0,  0,  0, 65, 99,
};


static unsigned char atkbd_set3_keycode[512] = {

	  0,  0,  0,  0,  0,  0,  0, 59,  1,138,128,129,130, 15, 41, 60,
	131, 29, 42, 86, 58, 16,  2, 61,133, 56, 44, 31, 30, 17,  3, 62,
	134, 46, 45, 32, 18,  5,  4, 63,135, 57, 47, 33, 20, 19,  6, 64,
	136, 49, 48, 35, 34, 21,  7, 65,137,100, 50, 36, 22,  8,  9, 66,
	125, 51, 37, 23, 24, 11, 10, 67,126, 52, 53, 38, 39, 25, 12, 68,
	113,114, 40, 43, 26, 13, 87, 99, 97, 54, 28, 27, 43, 43, 88, 70,
	108,105,119,103,111,107, 14,110,  0, 79,106, 75, 71,109,102,104,
	 82, 83, 80, 76, 77, 72, 69, 98,  0, 96, 81,  0, 78, 73, 55,183,

	184,185,186,187, 74, 94, 92, 93,  0,  0,  0,125,126,127,112,  0,
	  0,139,150,163,165,115,152,150,166,140,160,154,113,114,167,168,
	148,149,147,140
};

static unsigned char atkbd_unxlate_table[128] = {
          0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
         21, 29, 36, 45, 44, 53, 60, 67, 68, 77, 84, 91, 90, 20, 28, 27,
         35, 43, 52, 51, 59, 66, 75, 76, 82, 14, 18, 93, 26, 34, 33, 42,
         50, 49, 58, 65, 73, 74, 89,124, 17, 41, 88,  5,  6,  4, 12,  3,
         11,  2, 10,  1,  9,119,126,108,117,125,123,107,115,116,121,105,
        114,122,112,113,127, 96, 97,120,  7, 15, 23, 31, 39, 47, 55, 63,
         71, 79, 86, 94,  8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 87,111,
         19, 25, 57, 81, 83, 92, 95, 98, 99,100,101,103,104,106,109,110
};

#define ATKBD_CMD_SETLEDS	0x10ed
#define ATKBD_CMD_GSCANSET	0x11f0
#define ATKBD_CMD_SSCANSET	0x10f0
#define ATKBD_CMD_GETID		0x02f2
#define ATKBD_CMD_SETREP	0x10f3
#define ATKBD_CMD_ENABLE	0x00f4
#define ATKBD_CMD_RESET_DIS	0x00f5
#define ATKBD_CMD_SETALL_MBR	0x00fa
#define ATKBD_CMD_RESET_BAT	0x02ff
#define ATKBD_CMD_RESEND	0x00fe
#define ATKBD_CMD_EX_ENABLE	0x10ea
#define ATKBD_CMD_EX_SETLEDS	0x20eb
#define ATKBD_CMD_OK_GETID	0x02e8


#define ATKBD_RET_ACK		0xfa
#define ATKBD_RET_NAK		0xfe
#define ATKBD_RET_BAT		0xaa
#define ATKBD_RET_EMUL0		0xe0
#define ATKBD_RET_EMUL1		0xe1
#define ATKBD_RET_RELEASE	0xf0
#define ATKBD_RET_HANGUEL	0xf1
#define ATKBD_RET_HANJA		0xf2
#define ATKBD_RET_ERR		0xff

#define ATKBD_KEY_UNKNOWN	  0
#define ATKBD_KEY_NULL		255

#define ATKBD_SCR_1		254
#define ATKBD_SCR_2		253
#define ATKBD_SCR_4		252
#define ATKBD_SCR_8		251
#define ATKBD_SCR_CLICK		250

#define ATKBD_SPECIAL		250

static unsigned char atkbd_scroll_keys[5][2] = {
	{ ATKBD_SCR_1,     0x45 },
	{ ATKBD_SCR_2,     0x29 },
	{ ATKBD_SCR_4,     0x36 },
	{ ATKBD_SCR_8,     0x27 },
	{ ATKBD_SCR_CLICK, 0x60 },
};

#endif
/*
 * The atkbd control structure
 */

struct atkbd {
	unsigned char keycode[512];
	char name[64];
	char phys[32];
	unsigned char cmdbuf[4];
	unsigned char cmdcnt;
	unsigned char set;
	unsigned char extra;
	unsigned char release;
	int lastkey;
	volatile signed char ack;
	unsigned char emul;
	unsigned short id;
	unsigned char write;
	unsigned char translated;
	unsigned char resend;
	unsigned char bat_xl;
	unsigned int last;
};

static struct atkbd atkbd_data;
static struct atkbd * const atkbd = &atkbd_data;

static const char* phys_filename;

/********** functions for interacting with 'uinput' **********/

static const char *uinput_dev_name = NULL;
static int uinput_fd;

static void uinput_open() {
	uinput_fd = open(uinput_dev_name, O_WRONLY);
}

static void uinput_set_evbit(int bit) {
	int r;

	r = ioctl(uinput_fd, UI_SET_EVBIT, bit);
	if (r==-1) { pferrx(); }
}

static void uinput_set_ledbit(int bit) {
	int r;

	r = ioctl(uinput_fd, UI_SET_LEDBIT, bit);
	if (r==-1) { pferrx();}
}

static void uinput_set_keybit(int bit) {
	int r;

	r = ioctl(uinput_fd, UI_SET_KEYBIT, bit);
	if (r==-1) { pferrx(); }
}

static void uinput_set_relbit(int bit) {
	int r;

	r = ioctl(uinput_fd, UI_SET_RELBIT, bit);
	if (r==-1) { pferrx(); }
}

static void uinput_create() {
	struct uinput_user_dev uinput = {
		.name = "atkbd ",
	};
	int r;

	snprintf(uinput.name, UINPUT_MAX_NAME_SIZE,
		 "atkbd %s", phys_filename);

	r = write(uinput_fd, &uinput, sizeof(uinput));
	if (r==-1) { pferrx(); }

	r = ioctl(uinput_fd, UI_DEV_CREATE);
	if (r==-1) { pferrx(); }
}

static void uinput_destroy() {
	int r;

	r = ioctl(uinput_fd, UI_DEV_DESTROY);
	if (r==-1) { pferrx(); }
}

static void uinput_close() {
	int r;

	r = close(uinput_fd);
	if (r==-1) { pferrx(); }
}

static void uinput_event(__u16 type, __u16 code, __s32 value) {
	struct input_event ev = {
		.type = type,
		.code = code,
		.value = value
	};
	int r;

	r = write(uinput_fd, &ev, sizeof(ev));
	if (r!=sizeof(ev)) { pferrx(); }
}


#define uinput_report_key(code,value) uinput_event(EV_KEY, (code), (value))
#define uinput_report_rel(code,value) uinput_event(EV_REL, (code), (value))
#define uinput_sync() uinput_event(EV_SYN, 0, 0)


/********** functions for accessing the raw keyboard device **********/

static int phys_fd = -1;
static const char* phys_filename;

static int phys_open() {
	phys_fd = open(phys_filename, O_RDWR);
	if (phys_fd == -1) {
		const int e = errno;
		perr(phys_filename);
		switch (e) {
		case EACCES:
			err("read-write access required.  Are you 'root'?\n");
			break;
		}
		exit(1);
	}
	return 0;
}

static int phys_write(unsigned char byte) {
	int r;
	r = write(phys_fd, &byte, 1);
	if (r==-1) { pferrx(); }
	if (r!=1) { err("cannot write"); exit(1); }
	return 0;
}

static void atkbd_interrupt(unsigned char data,
			    unsigned int flags);

static int phys_wait_for_input(int *ptimeout) {
	unsigned char byte;
	int r;

	if (ptimeout != NULL) {
		fd_set fds;
		struct timeval tv;

		FD_ZERO(&fds);
		FD_SET(phys_fd, &fds);
		tv.tv_sec=0; tv.tv_usec=*ptimeout;
		r = select(phys_fd+1, &fds, NULL, &fds, &tv);
		*ptimeout = tv.tv_sec*1000000 + tv.tv_usec;
		if (r==-1) { pferrx(); }
		if (r==0) { return -1; } /* timeout */
		if (r!=1) { err("cannot select"); exit(1); }
	}

	r = read(phys_fd, &byte, 1);
	if (r==-1) { pferrx(); }
	if (r!=1) { err("cannot read"); exit(1); }

	atkbd_interrupt(byte, 0);
	return 0;
}

static void phys_close() {
	int r;
	r = close(phys_fd);
	if (r==-1) { pferrx(); }
}

static int atkbd_connect();
static void atkbd_disconnect();

static void phys_rescan() {
	atkbd_disconnect();
	atkbd_connect();
}



static void atkbd_report_key(int code, int value)
{
	if (value == 3) {
		uinput_report_key(code, 1);
		uinput_report_key(code, 0);
	} else
		uinput_event(EV_KEY, code, value);
	uinput_sync();
}



/*
 * atkbd_interrupt(). Here takes place processing of data received from
 * the keyboard into events.
 */

static void atkbd_interrupt(unsigned char data,
			    unsigned int flags)
{
	unsigned int code = data;
	int scroll = 0, click = -1;
	int value;

#ifdef ATKBD_DEBUG
	printk(KERN_DEBUG "atkbd.c: Received %02x flags %02x\n", data, flags);
#endif

#if !defined(__i386__) && !defined (__x86_64__)
	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && (~flags & SERIO_TIMEOUT) && !atkbd->resend && atkbd->write) {
		printk("atkbd.c: frame/parity error: %02x\n", flags);
		serio_write(serio, ATKBD_CMD_RESEND);
		atkbd->resend = 1;
		goto out;
	}

	if (!flags && data == ATKBD_RET_ACK)
		atkbd->resend = 0;
#endif

	if (!atkbd->ack)
		switch (code) {
			case ATKBD_RET_ACK:
				atkbd->ack = 1;
				goto out;
			case ATKBD_RET_NAK:
				atkbd->ack = -1;
				goto out;
		}

	if (atkbd->cmdcnt) {
		atkbd->cmdbuf[--atkbd->cmdcnt] = code;
		goto out;
	}

	if (atkbd->translated) {

		if (atkbd->emul ||
		    !(code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1 ||
		      code == ATKBD_RET_HANGUEL || code == ATKBD_RET_HANJA ||
		      code == ATKBD_RET_ERR ||
	             (code == ATKBD_RET_BAT && !atkbd->bat_xl))) {
			atkbd->release = code >> 7;
			code &= 0x7f;
		}

		if (!atkbd->emul &&
		     (code & 0x7f) == (ATKBD_RET_BAT & 0x7f))
			atkbd->bat_xl = !atkbd->release;
	}

	switch (code) {
		case ATKBD_RET_BAT:
			phys_rescan();
			goto out;
		case ATKBD_RET_EMUL0:
			atkbd->emul = 1;
			goto out;
		case ATKBD_RET_EMUL1:
			atkbd->emul = 2;
			goto out;
		case ATKBD_RET_RELEASE:
			atkbd->release = 1;
			goto out;
		case ATKBD_RET_HANGUEL:
			atkbd_report_key(KEY_HANGUEL, 3);
			goto out;
		case ATKBD_RET_HANJA:
			atkbd_report_key(KEY_HANJA, 3);
			goto out;
		case ATKBD_RET_ERR:
			warn("Keyboard reports too many keys pressed.\n");
			goto out;
	}

	if (atkbd->set != 3)
		code = (code & 0x7f) | ((code & 0x80) << 1);
	if (atkbd->emul) {
		if (--atkbd->emul)
			goto out;
		code |= (atkbd->set != 3) ? 0x80 : 0x100;
	}

	switch (atkbd->keycode[code]) {
		case ATKBD_KEY_NULL:
			break;
		case ATKBD_KEY_UNKNOWN:
			warn("Unknown key %s (%s set %d, code %#x).\n",
				atkbd->release ? "released" : "pressed",
				atkbd->translated ? "translated" : "raw",
				atkbd->set, code);
			if (atkbd->translated && atkbd->set == 2 && code == 0x7a)
				warn("This is an XFree86 bug. It shouldn't access"
				     " hardware directly.\n");
			else
				warn("Use 'setkeycodes %s%02x <keycode>' to make it known.\n",						code & 0x80 ? "e0" : "", code & 0x7f);
			break;
		case ATKBD_SCR_1:
			scroll = 1 - atkbd->release * 2;
			break;
		case ATKBD_SCR_2:
			scroll = 2 - atkbd->release * 4;
			break;
		case ATKBD_SCR_4:
			scroll = 4 - atkbd->release * 8;
			break;
		case ATKBD_SCR_8:
			scroll = 8 - atkbd->release * 16;
			break;
		case ATKBD_SCR_CLICK:
			click = !atkbd->release;
			break;
		default:
			value = atkbd->release ? 0 :
				(1 + (!atkbd_softrepeat));

			switch (value) { 	/* Workaround Toshiba laptop multiple keypress */
				case 0:
					atkbd->last = 0;
					break;
				case 1:
					atkbd->last = code;
					break;
				case 2:
					value = 1;
					break;
			}

			atkbd_report_key(atkbd->keycode[code], value);
	}

	if (scroll || click != -1) {
		uinput_report_key(BTN_MIDDLE, click);
		uinput_report_rel(REL_WHEEL, scroll);
		uinput_sync();
	}

	atkbd->release = 0;
out:
	return;
}

/*
 * atkbd_sendbyte() sends a byte to the keyboard, and waits for
 * acknowledge. It doesn't handle resends according to the keyboard
 * protocol specs, because if these are needed, the keyboard needs
 * replacement anyway, and they only make a mess in the protocol.
 */

static int atkbd_sendbyte(unsigned char byte)
{
	int timeout = 20000; /* 200 msec */
	atkbd->ack = 0;

#ifdef ATKBD_DEBUG
	printk(KERN_DEBUG "atkbd.c: Sent: %02x\n", byte);
#endif
	if (phys_write(byte))
		return -1;

	while (!atkbd->ack && timeout>0)
		phys_wait_for_input(&timeout);

	return -(atkbd->ack <= 0);
}

/*
 * atkbd_command() sends a command, and its parameters to the keyboard,
 * then waits for the response and puts it in the param array.
 */

static int atkbd_command(unsigned char *param, int command)
{
	int timeout = 500000; /* 500 msec */
	int send = (command >> 12) & 0xf;
	int receive = (command >> 8) & 0xf;
	int i;

	atkbd->cmdcnt = receive;

	if (command == ATKBD_CMD_RESET_BAT)
		timeout = 2000000; /* 2 sec */

	if (receive && param)
		for (i = 0; i < receive; i++)
			atkbd->cmdbuf[(receive - 1) - i] = param[i];

	if (command & 0xff)
		if (atkbd_sendbyte(command & 0xff))
			return (atkbd->cmdcnt = 0) - 1;

	for (i = 0; i < send; i++)
		if (atkbd_sendbyte(param[i]))
			return (atkbd->cmdcnt = 0) - 1;

	while (atkbd->cmdcnt && timeout>0) {

		if (atkbd->cmdcnt == 1 &&
		    command == ATKBD_CMD_RESET_BAT && timeout > 100000)
			timeout = 100000;

		if (atkbd->cmdcnt == 1 && command == ATKBD_CMD_GETID &&
		    atkbd->cmdbuf[1] != 0xab && atkbd->cmdbuf[1] != 0xac) {
			atkbd->cmdcnt = 0;
			break;
		}

		phys_wait_for_input(&timeout);
	}

	if (param)
		for (i = 0; i < receive; i++)
			param[i] = atkbd->cmdbuf[(receive - 1) - i];

	if (command == ATKBD_CMD_RESET_BAT && atkbd->cmdcnt == 1)
		atkbd->cmdcnt = 0;

	if (atkbd->cmdcnt) {
		atkbd->cmdcnt = 0;
		return -1;
	}

	return 0;
}
#if 0

/*
 * Event callback from the input module. Events that change the state of
 * the hardware are processed here.
 */

static int atkbd_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
{
	struct atkbd *atkbd = dev->private;
	const short period[32] =
		{ 33,  37,  42,  46,  50,  54,  58,  63,  67,  75,  83,  92, 100, 109, 116, 125,
		 133, 149, 167, 182, 200, 217, 232, 250, 270, 303, 333, 370, 400, 435, 470, 500 };
	const short delay[4] =
		{ 250, 500, 750, 1000 };
	unsigned char param[2];
	int i, j;

	if (!atkbd->write)
		return -1;

	switch (type) {

		case EV_LED:

			param[0] = (test_bit(LED_SCROLLL, dev->led) ? 1 : 0)
			         | (test_bit(LED_NUML,    dev->led) ? 2 : 0)
			         | (test_bit(LED_CAPSL,   dev->led) ? 4 : 0);
		        atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS);

			if (atkbd->extra) {
				param[0] = 0;
				param[1] = (test_bit(LED_COMPOSE, dev->led) ? 0x01 : 0)
					 | (test_bit(LED_SLEEP,   dev->led) ? 0x02 : 0)
					 | (test_bit(LED_SUSPEND, dev->led) ? 0x04 : 0)
				         | (test_bit(LED_MISC,    dev->led) ? 0x10 : 0)
				         | (test_bit(LED_MUTE,    dev->led) ? 0x20 : 0);
				atkbd_command(atkbd, param, ATKBD_CMD_EX_SETLEDS);
			}

			return 0;


		case EV_REP:

			if (atkbd_softrepeat) return 0;

			i = j = 0;
			while (i < 32 && period[i] < dev->rep[REP_PERIOD]) i++;
			while (j < 4 && delay[j] < dev->rep[REP_DELAY]) j++;
			dev->rep[REP_PERIOD] = period[i];
			dev->rep[REP_DELAY] = delay[j];
			param[0] = i | (j << 5);
			atkbd_command(atkbd, param, ATKBD_CMD_SETREP);

			return 0;
	}

	return -1;
}
#endif

/*
 * atkbd_probe() probes for an AT keyboard on a serio port.
 */

static int atkbd_probe()
{
	unsigned char param[2];

/*
 * Some systems, where the bit-twiddling when testing the io-lines of the
 * controller may confuse the keyboard need a full reset of the keyboard. On
 * these systems the BIOS also usually doesn't do it for us.
 */

	if (atkbd_reset)
		if (atkbd_command(NULL, ATKBD_CMD_RESET_BAT))
			warn("keyboard reset failed on\n");

/*
 * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
 * Some keyboards report different values, but the first byte is always 0xab or
 * 0xac. Some old AT keyboards don't report anything. If a mouse is connected, this
 * should make sure we don't try to set the LEDs on it.
 */

	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
	if (atkbd_command(param, ATKBD_CMD_GETID)) {

/*
 * If the get ID command failed, we check if we can at least set the LEDs on
 * the keyboard. This should work on every keyboard out there. It also turns
 * the LEDs off, which we want anyway.
 */
		param[0] = 0;
		if (atkbd_command(param, ATKBD_CMD_SETLEDS))
			return -1;
		atkbd->id = 0xabba;
		return 0;
	}

	if (param[0] != 0xab && param[0] != 0xac)
		return -1;
	atkbd->id = (param[0] << 8) | param[1];

	if (atkbd->id == 0xaca1 && atkbd->translated) {
		err("NCD terminal keyboards are only supported on non-translating\n");
		err("controllers. Use i8042.direct=1 to disable translation.\n");
		return -1;
	}

	return 0;
}

/*
 * atkbd_set_3 checks if a keyboard has a working Set 3 support, and
 * sets it into that. Unfortunately there are keyboards that can be switched
 * to Set 3, but don't work well in that (BTC Multimedia ...)
 */

static int atkbd_set_3()
{
	unsigned char param[2];

/*
 * For known special keyboards we can go ahead and set the correct set.
 * We check for NCD PS/2 Sun, NorthGate OmniKey 101 and
 * IBM RapidAccess / IBM EzButton / Chicony KBP-8993 keyboards.
 */

	if (atkbd->translated)
		return 2;

	if (atkbd->id == 0xaca1) {
		param[0] = 3;
		atkbd_command(param, ATKBD_CMD_SSCANSET);
		return 3;
	}

	if (atkbd_extra) {
		param[0] = 0x71;
		if (!atkbd_command(param, ATKBD_CMD_EX_ENABLE)) {
			atkbd->extra = 1;
			return 2;
		}
	}

	if (atkbd_set != 3)
		return 2;

	if (!atkbd_command(param, ATKBD_CMD_OK_GETID)) {
		atkbd->id = param[0] << 8 | param[1];
		return 2;
	}

	param[0] = 3;
	if (atkbd_command(param, ATKBD_CMD_SSCANSET))
		return 2;

	param[0] = 0;
	if (atkbd_command(param, ATKBD_CMD_GSCANSET))
		return 2;

	if (param[0] != 3) {
		param[0] = 2;
		if (atkbd_command(param, ATKBD_CMD_SSCANSET))
		return 2;
	}

	atkbd_command(param, ATKBD_CMD_SETALL_MBR);

	return 3;
}

static int atkbd_enable()
{
	unsigned char param[1];

/*
 * Set the LEDs to a defined state.
 */

	param[0] = 0;
	if (atkbd_command(param, ATKBD_CMD_SETLEDS))
		return -1;

/*
 * Set autorepeat to fastest possible.
 */

	param[0] = 0;
	if (atkbd_command(param, ATKBD_CMD_SETREP))
		return -1;

/*
 * Enable the keyboard to receive keystrokes.
 */

	if (atkbd_command(NULL, ATKBD_CMD_ENABLE)) {
		err("Failed to enable keyboard\n");
		return -1;
	}

	return 0;
}

/*
 * atkbd_disconnect() closes and frees.
 */

static void atkbd_disconnect()
{
	phys_close();
}

/*
 * atkbd_connect() is called when the serio module finds and interface
 * that isn't handled yet by an appropriate device driver. We check if
 * there is an AT keyboard out there and if yes, we register ourselves
 * to the input module.
 */

static int atkbd_connect()
{
	int i;

	memset(atkbd, 0, sizeof(struct atkbd));

#if 0
	switch (serio->type & SERIO_TYPE) {

		case SERIO_8042_XL:
			atkbd->translated = 1;
		case SERIO_8042:
			if (serio->write)
				atkbd->write = 1;
			break;
		case SERIO_RS232:
			if ((serio->type & SERIO_PROTO) == SERIO_PS2SER)
				break;
		default:
			kfree(atkbd);
			return;
	}
#else
	atkbd->translated = 1;
	atkbd->write = 1;
#endif

	if (phys_open()) {
		return -1;
	}

	if (atkbd->write) {
		uinput_set_evbit(EV_KEY);
		uinput_set_evbit(EV_LED);
		uinput_set_evbit(EV_REP);

		uinput_set_ledbit(LED_NUML);
		uinput_set_ledbit(LED_CAPSL);
		uinput_set_ledbit(LED_SCROLLL);
	} else  {
		uinput_set_evbit(EV_KEY);
		uinput_set_evbit(EV_REP);
	}

	if (atkbd_softrepeat) {
		assert("not implemented yet" == 0); 
	}

	atkbd->ack = 1;


	if (atkbd->write) {

		if (atkbd_probe()) {
			return -1;
		}

		atkbd->set = atkbd_set_3();
		atkbd_enable();

	} else {
		atkbd->set = 2;
		atkbd->id = 0xab00;
	}

	if (atkbd->extra) {
		uinput_set_ledbit(LED_COMPOSE);
		uinput_set_ledbit(LED_SUSPEND);
		uinput_set_ledbit(LED_SLEEP);
		uinput_set_ledbit(LED_MUTE);
		uinput_set_ledbit(LED_MISC);

		sprintf(atkbd->name, "AT Set 2 Extra keyboard");
	} else
		sprintf(atkbd->name, "AT %s Set %d keyboard",
			atkbd->translated ? "Translated" : "Raw", atkbd->set);

	if (atkbd_scroll) {
		for (i = 0; i < 5; i++)
			atkbd_set2_keycode[atkbd_scroll_keys[i][1]] = atkbd_scroll_keys[i][0];
		uinput_set_evbit(EV_REL);
		uinput_set_relbit(REL_WHEEL);
		uinput_set_keybit(BTN_MIDDLE);
	}

	if (atkbd->translated) {
		for (i = 0; i < 128; i++) {
			atkbd->keycode[i] = atkbd_set2_keycode[atkbd_unxlate_table[i]];
			atkbd->keycode[i | 0x80] = atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
		}
	} else if (atkbd->set == 3) {
		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
	} else {
		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
	}

	for (i = 0; i < 512; i++)
		if (atkbd->keycode[i] && atkbd->keycode[i] < ATKBD_SPECIAL)
			uinput_set_keybit(atkbd->keycode[i]);

	info("keyboard %s\n", atkbd->name);
	return 0;
}


int main(int argc, char**argv) {
	if (argc != 2) {
		fprintf(stderr, "Usage: %s raw_kbd_device\n", argv[0]);
		return 1;
	}

	phys_filename = argv[1];

	/* try devfs name first */
	uinput_dev_name = "/dev/misc/uinput";
	uinput_open();
	if (uinput_fd == -1 && errno==ENOENT) {
		/* was not found: try non-devfs name */
		uinput_dev_name = "/dev/uinput";
		uinput_open();
	}
	if (uinput_fd == -1) {
		const int e = errno;
		perr(uinput_dev_name);

		switch (e) {
		case ENOENT:
			err("Have you loaded the 'uinput' module?\n");
			break;
		case EACCES:
			err("Write access needed.  Are you 'root'?\n");
			break;
		}
		exit (1);
	}



	if (atkbd_connect() != 0) {
		fprintf(stderr, "cannot connect to device\n");
		return 1;
	}

	uinput_create();

	for (;;) {
		phys_wait_for_input(NULL);
	}

	uinput_destroy();

	atkbd_disconnect();
	uinput_close();
	return 0;
}

--=-=-=
Content-Disposition: attachment; filename=psmouse.tgz
Content-Transfer-Encoding: 8bit

psmouse/#define _UINPUT_H_

extern void uinput_open(void);
extern void uinput_create(void);
extern void uinput_event(int type, int code, int value);
extern void uinput_report_key(int code, int value);
extern void uinput_report_rel(int code, int value);
extern void uinput_report_abs(int code, int value);
extern void uinput_sync();

extern void uinput_set_evbit(unsigned int bit);
extern void uinput_set_ledbit(unsigned int bit);
extern void uinput_set_relbit(unsigned int bit);
extern void uinput_set_keybit(unsigned int bit);
extern void uinput_clear_keybit(unsigned int bit);


#endif /* _UINPUT_H_ */
#include <fcntl.h>
#include <linux/input.h>
#include <linux/uinput.h>
#include "psmouse.h"
#include "uinput.h"

#define UI_DEV "/dev/misc/uinput"

static int uinput_fd = -1;

void uinput_open(void) {
	uinput_fd = open(UI_DEV, O_WRONLY);
	if (uinput_fd == -1) {
		perror("Can't open");
		err("Have you loaded the 'uinput' module?\n");
		exit(1);
	}
}

void uinput_create(void) {
	struct uinput_user_dev uinput_user_dev;
	int r;

	strncpy(uinput_user_dev.name, psmouse->name,
		UINPUT_MAX_NAME_SIZE);

	r = write(uinput_fd, &uinput_user_dev, sizeof(uinput_user_dev));
	if (r != sizeof(uinput_user_dev)) {
		if (r==-1) perror("Can't write");
		else err("Can't write");
		exit(1);
	}

	r = ioctl(uinput_fd, UI_DEV_CREATE);
	if (r==-1) {
		perror("Can't create uinput device");
		exit(1);
	}
}

void uinput_event(int type, int code, int value) {
	struct input_event ev = {
		.type = type,
		.code = code,
		.value = value,
	};
	int r;

	r = write(uinput_fd, &ev, sizeof(ev));
	if (r != sizeof(ev)) {
		if (r==-1) perror("Can't write");
		else err("Can't write");
		exit(1);
	}
}

void uinput_report_key(int code, int value) {
	uinput_event(EV_KEY, code, value);
}

void uinput_report_rel(int code, int value) {
	uinput_event(EV_REL, code, value);
}

void uinput_report_abs(int code, int value) {
	uinput_event(EV_ABS, code, value);
}

void uinput_sync() {
	uinput_event(EV_SYN, SYN_REPORT, 0);
}

static void uinput_set_bit(int command, unsigned int bit) {
	if (ioctl(uinput_fd, command, bit) == -1) {
		perror("Can't ioctl");
		exit(1);
	}
}

void uinput_set_evbit(unsigned int bit) {
  uinput_set_bit(UI_SET_EVBIT, bit);
}
void uinput_set_ledbit(unsigned int bit)  {
  uinput_set_bit(UI_SET_LEDBIT, bit);
}
void uinput_set_relbit(unsigned int bit) {
  uinput_set_bit(UI_SET_RELBIT, bit);
}
void uinput_set_keybit(unsigned int bit) {
  uinput_set_bit(UI_SET_KEYBIT, bit);
}

void uinput_clear_keybit(unsigned int bit) {
  //FIXME!
}


 * Synaptics TouchPad PS/2 mouse driver
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation.
 */

#ifndef _SYNAPTICS_H
#define _SYNAPTICS_H

extern void synaptics_process_byte();
extern int synaptics_detect();
extern int synaptics_init();
extern void synaptics_reset();

/* synaptics queries */
#define SYN_QUE_IDENTIFY		0x00
#define SYN_QUE_MODES			0x01
#define SYN_QUE_CAPABILITIES		0x02
#define SYN_QUE_MODEL			0x03
#define SYN_QUE_SERIAL_NUMBER_PREFIX	0x06
#define SYN_QUE_SERIAL_NUMBER_SUFFIX	0x07
#define SYN_QUE_RESOLUTION		0x08
#define SYN_QUE_EXT_CAPAB		0x09

/* synatics modes */
#define SYN_BIT_ABSOLUTE_MODE		(1 << 7)
#define SYN_BIT_HIGH_RATE		(1 << 6)
#define SYN_BIT_SLEEP_MODE		(1 << 3)
#define SYN_BIT_DISABLE_GESTURE		(1 << 2)
#define SYN_BIT_FOUR_BYTE_CLIENT	(1 << 1)
#define SYN_BIT_W_MODE			(1 << 0)

/* synaptics model ID bits */
#define SYN_MODEL_ROT180(m)		((m) & (1 << 23))
#define SYN_MODEL_PORTRAIT(m)		((m) & (1 << 22))
#define SYN_MODEL_SENSOR(m)		(((m) >> 16) & 0x3f)
#define SYN_MODEL_HARDWARE(m)		(((m) >> 9) & 0x7f)
#define SYN_MODEL_NEWABS(m)		((m) & (1 << 7))
#define SYN_MODEL_PEN(m)		((m) & (1 << 6))
#define SYN_MODEL_SIMPLIC(m)		((m) & (1 << 5))
#define SYN_MODEL_GEOMETRY(m)		((m) & 0x0f)

/* synaptics capability bits */
#define SYN_CAP_EXTENDED(c)		((c) & (1 << 23))
#define SYN_CAP_PASS_THROUGH(c)		((c) & (1 << 7))
#define SYN_CAP_SLEEP(c)		((c) & (1 << 4))
#define SYN_CAP_FOUR_BUTTON(c)		((c) & (1 << 3))
#define SYN_CAP_MULTIFINGER(c)		((c) & (1 << 1))
#define SYN_CAP_PALMDETECT(c)		((c) & (1 << 0))
#define SYN_CAP_VALID(c)		((((c) & 0x00ff00) >> 8) == 0x47)
#define SYN_EXT_CAP_REQUESTS(c)		((((c) & 0x700000) >> 20) == 1)
#define SYN_CAP_MULTI_BUTTON_NO(ec)	(((ec) & 0x00f000) >> 12)

/* synaptics modes query bits */
#define SYN_MODE_ABSOLUTE(m)		((m) & (1 << 7))
#define SYN_MODE_RATE(m)		((m) & (1 << 6))
#define SYN_MODE_BAUD_SLEEP(m)		((m) & (1 << 3))
#define SYN_MODE_DISABLE_GESTURE(m)	((m) & (1 << 2))
#define SYN_MODE_PACKSIZE(m)		((m) & (1 << 1))
#define SYN_MODE_WMODE(m)		((m) & (1 << 0))

/* synaptics identify query bits */
#define SYN_ID_MODEL(i) 		(((i) >> 4) & 0x0f)
#define SYN_ID_MAJOR(i) 		((i) & 0x0f)
#define SYN_ID_MINOR(i) 		(((i) >> 16) & 0xff)
#define SYN_ID_IS_SYNAPTICS(i)		((((i) >> 8) & 0xff) == 0x47)

/* synaptics special commands */
#define SYN_PS_SET_MODE2		0x14
#define SYN_PS_CLIENT_CMD		0x28

/* synaptics packet types */
#define SYN_NEWABS			0
#define SYN_NEWABS_STRICT		1
#define SYN_NEWABS_RELAXED		2
#define SYN_OLDABS			3

/*
 * A structure to describe the state of the touchpad hardware (buttons and pad)
 */

struct synaptics_hw_state {
	int x;
	int y;
	int z;
	int w;
	int left;
	int right;
	int up;
	int down;
	int b0;
	int b1;
	int b2;
	int b3;
	int b4;
	int b5;
	int b6;
	int b7;
};

struct synaptics_data {
	/* Data read from the touchpad */
	unsigned long int model_id;		/* Model-ID */
	unsigned long int capabilities; 	/* Capabilities */
	unsigned long int ext_cap; 		/* Extended Capabilities */
	unsigned long int identity;		/* Identification */

	/* Data for normal processing */
	unsigned int out_of_sync;		/* # of packets out of sync */
	int old_w;				/* Previous w value */
	unsigned char pkt_type;			/* packet type - old, new, etc */
};

#endif /* _SYNAPTICS_H */
 * Synaptics TouchPad PS/2 mouse driver
 *
 *   2004 Sau Dan LEE
 *
 *   2003 Dmitry Torokhov <dtor@mail.ru>
 *     Added support for pass-through port. Special thanks to Peter Berg Larsen
 *     for explaining various Synaptics quirks.
 *
 *   2003 Peter Osterlund <petero2@telia.com>
 *     Ported to 2.5 input device infrastructure.
 *
 *   Copyright (C) 2001 Stefan Gmeiner <riddlebox@freesurf.ch>
 *     start merging tpconfig and gpm code to a xfree-input module
 *     adding some changes and extensions (ex. 3rd and 4th button)
 *
 *   Copyright (c) 1997 C. Scott Ananian <cananian@alumni.priceton.edu>
 *   Copyright (c) 1998-2000 Bruce Kalk <kall@compass.com>
 *     code for the special synaptics commands (from the tpconfig-source)
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation.
 *
 * Trademarks are the property of their respective owners.
 */

#include <stdio.h>
#include <stdlib.h>
#include <linux/input.h>
#include "psmouse.h"
#include "synaptics.h"

/*
 * The x/y limits are taken from the Synaptics TouchPad interfacing Guide,
 * section 2.3.2, which says that they should be valid regardless of the
 * actual size of the sensor.
 */
#define XMIN_NOMINAL 1472
#define XMAX_NOMINAL 5472
#define YMIN_NOMINAL 1408
#define YMAX_NOMINAL 4448

/*****************************************************************************
 *	Synaptics communications functions
 ****************************************************************************/

/*
 * Use the Synaptics extended ps/2 syntax to write a special command byte.
 * special command: 0xE8 rr 0xE8 ss 0xE8 tt 0xE8 uu where (rr*64)+(ss*16)+(tt*4)+uu
 *                  is the command. A 0xF3 or 0xE9 must follow (see synaptics_send_cmd
 *                  and synaptics_mode_cmd)
 */
static int synaptics_special_cmd(unsigned char command)
{
	int i;

	if (psmouse_command(NULL, PSMOUSE_CMD_SETSCALE11))
		return -1;

	for (i = 6; i >= 0; i -= 2) {
		unsigned char d = (command >> i) & 3;
		if (psmouse_command(&d, PSMOUSE_CMD_SETRES))
			return -1;
	}

	return 0;
}

/*
 * Send a command to the synpatics touchpad by special commands
 */
static int synaptics_send_cmd(unsigned char c, unsigned char *param)
{
	if (synaptics_special_cmd(c))
		return -1;
	if (psmouse_command(param, PSMOUSE_CMD_GETINFO))
		return -1;
	return 0;
}

/*
 * Set the synaptics touchpad mode byte by special commands
 */
static int synaptics_mode_cmd(struct psmouse *psmouse, unsigned char mode)
{
	unsigned char param[1];

	if (synaptics_special_cmd(mode))
		return -1;
	param[0] = SYN_PS_SET_MODE2;
	if (psmouse_command(param, PSMOUSE_CMD_SETRATE))
		return -1;
	return 0;
}

/*
 * Read the model-id bytes from the touchpad
 * see also SYN_MODEL_* macros
 */
static int synaptics_model_id()
{
	struct synaptics_data *priv = psmouse->private;
	unsigned char mi[3];

	if (synaptics_send_cmd(SYN_QUE_MODEL, mi))
		return -1;
	priv->model_id = (mi[0]<<16) | (mi[1]<<8) | mi[2];
	return 0;
}

/*
 * Read the capability-bits from the touchpad
 * see also the SYN_CAP_* macros
 */
static int synaptics_capability()
{
	struct synaptics_data *priv = psmouse->private;
	unsigned char cap[3];

	if (synaptics_send_cmd(SYN_QUE_CAPABILITIES, cap))
		return -1;
	priv->capabilities = (cap[0]<<16) | (cap[1]<<8) | cap[2];
	priv->ext_cap = 0;
	if (!SYN_CAP_VALID(priv->capabilities))
		return -1;

	if (SYN_EXT_CAP_REQUESTS(priv->capabilities)) {
		if (synaptics_send_cmd(SYN_QUE_EXT_CAPAB, cap)) {
			err("Synaptics claims to have extended capabilities,"
			       " but I'm not able to read them.");
		} else
			priv->ext_cap = (cap[0]<<16) | (cap[1]<<8) | cap[2];
	}
	return 0;
}

/*
 * Identify Touchpad
 * See also the SYN_ID_* macros
 */
static int synaptics_identify()
{
	struct synaptics_data *priv = psmouse->private;
	unsigned char id[3];

	if (synaptics_send_cmd(SYN_QUE_IDENTIFY, id))
		return -1;
	priv->identity = (id[0]<<16) | (id[1]<<8) | id[2];
	if (SYN_ID_IS_SYNAPTICS(priv->identity))
		return 0;
	return -1;
}

static void print_ident(struct synaptics_data *priv)
{
	info("Synaptics Touchpad, model: %ld\n", SYN_ID_MODEL(priv->identity));
	info(" Firmware: %ld.%ld\n", SYN_ID_MAJOR(priv->identity),
	       SYN_ID_MINOR(priv->identity));
	if (SYN_MODEL_ROT180(priv->model_id))
		info(" 180 degree mounted touchpad\n");
	if (SYN_MODEL_PORTRAIT(priv->model_id))
		info(" portrait touchpad\n");
	info(" Sensor: %ld\n", SYN_MODEL_SENSOR(priv->model_id));
	if (SYN_MODEL_NEWABS(priv->model_id))
		info(" new absolute packet format\n");
	if (SYN_MODEL_PEN(priv->model_id))
		info(" pen detection\n");

	if (SYN_CAP_EXTENDED(priv->capabilities)) {
		info(" Touchpad has extended capability bits\n");
		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
		    SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) <= 8)
			info(" -> %d multi-buttons, i.e. besides standard buttons\n",
			       (int)(SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)));
		else if (SYN_CAP_FOUR_BUTTON(priv->capabilities))
			info(" -> four buttons\n");
		if (SYN_CAP_MULTIFINGER(priv->capabilities))
			info(" -> multifinger detection\n");
		if (SYN_CAP_PALMDETECT(priv->capabilities))
			info(" -> palm detection\n");
		if (SYN_CAP_PASS_THROUGH(priv->capabilities))
			info(" -> pass-through port\n");
	}
}

static int synaptics_query_hardware()
{
	int retries = 0;

	while ((retries++ < 3) && psmouse_reset())
		err("synaptics reset failed\n");

	if (synaptics_identify())
		return -1;
	if (synaptics_model_id())
		return -1;
	if (synaptics_capability())
		return -1;

	return 0;
}

static int synaptics_set_mode(struct psmouse *psmouse, int mode)
{
	struct synaptics_data *priv = psmouse->private;

	mode |= SYN_BIT_ABSOLUTE_MODE;
	if (psmouse_rate >= 80)
		mode |= SYN_BIT_HIGH_RATE;
	if (SYN_ID_MAJOR(priv->identity) >= 4)
		mode |= SYN_BIT_DISABLE_GESTURE;
	if (SYN_CAP_EXTENDED(priv->capabilities))
		mode |= SYN_BIT_W_MODE;
	if (synaptics_mode_cmd(psmouse, mode))
		return -1;

	return 0;
}


/*****************************************************************************
 *	Driver initialization/cleanup functions
 ****************************************************************************/

#if 0
static inline void set_abs_params(struct input_dev *dev, int axis, int min, int max, int fuzz, int flat)
{
	dev->absmin[axis] = min;
	dev->absmax[axis] = max;
	dev->absfuzz[axis] = fuzz;
	dev->absflat[axis] = flat;

	set_bit(axis, dev->absbit);
}

static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
{
	set_bit(EV_ABS, dev->evbit);
	set_abs_params(dev, ABS_X, XMIN_NOMINAL, XMAX_NOMINAL, 0, 0);
	set_abs_params(dev, ABS_Y, YMIN_NOMINAL, YMAX_NOMINAL, 0, 0);
	set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
	set_bit(ABS_TOOL_WIDTH, dev->absbit);

	set_bit(EV_KEY, dev->evbit);
	set_bit(BTN_TOUCH, dev->keybit);
	set_bit(BTN_TOOL_FINGER, dev->keybit);
	set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
	set_bit(BTN_TOOL_TRIPLETAP, dev->keybit);

	set_bit(BTN_LEFT, dev->keybit);
	set_bit(BTN_RIGHT, dev->keybit);
	set_bit(BTN_FORWARD, dev->keybit);
	set_bit(BTN_BACK, dev->keybit);
	if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)) {
		switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
		default:
			/*
			 * if nExtBtn is greater than 8 it should be considered
			 * invalid and treated as 0
			 */
			break;
		case 8:
			set_bit(BTN_7, dev->keybit);
			set_bit(BTN_6, dev->keybit);
		case 6:
			set_bit(BTN_5, dev->keybit);
			set_bit(BTN_4, dev->keybit);
		case 4:
			set_bit(BTN_3, dev->keybit);
			set_bit(BTN_2, dev->keybit);
		case 2:
			set_bit(BTN_1, dev->keybit);
			set_bit(BTN_0, dev->keybit);
			break;
		}
	}

	clear_bit(EV_REL, dev->evbit);
	clear_bit(REL_X, dev->relbit);
	clear_bit(REL_Y, dev->relbit);
}
#endif

void synaptics_reset()
{
	/* reset touchpad back to relative mode, gestures enabled */
	synaptics_mode_cmd(psmouse, 0);
}

static void synaptics_disconnect()
{
	synaptics_reset(psmouse);
}

static int synaptics_reconnect()
{
	struct synaptics_data *priv = psmouse->private;
	struct synaptics_data old_priv = *priv;

	if (!synaptics_detect())
		return -1;

	if (synaptics_query_hardware()) {
		err("Unable to query Synaptics hardware.\n");
		return -1;
	}

	if (old_priv.identity != priv->identity ||
	    old_priv.model_id != priv->model_id ||
	    old_priv.capabilities != priv->capabilities ||
    	    old_priv.ext_cap != priv->ext_cap)
    		return -1;

	if (synaptics_set_mode(psmouse, 0)) {
		err("Unable to initialize Synaptics hardware.\n");
		return -1;
	}

	return 0;
}

int synaptics_detect()
{
	unsigned char param[4];

	param[0] = 0;

	psmouse_command(param, PSMOUSE_CMD_SETRES);
	psmouse_command(param, PSMOUSE_CMD_SETRES);
	psmouse_command(param, PSMOUSE_CMD_SETRES);
	psmouse_command(param, PSMOUSE_CMD_SETRES);
	psmouse_command(param, PSMOUSE_CMD_GETINFO);

	return param[1] == 0x47;
}

int synaptics_init()
{
	struct synaptics_data *priv;

	psmouse->private = priv = calloc(1, sizeof(struct synaptics_data));
	if (!priv)
		return -1;

	if (synaptics_query_hardware(psmouse)) {
		err("Unable to query Synaptics hardware.\n");
		goto init_fail;
	}

	if (synaptics_set_mode(psmouse, 0)) {
		err("Unable to initialize Synaptics hardware.\n");
		goto init_fail;
	}

	priv->pkt_type = SYN_MODEL_NEWABS(priv->model_id) ? SYN_NEWABS : SYN_OLDABS;

	print_ident(priv);

	psmouse->disconnect = synaptics_disconnect;
	psmouse->reconnect = synaptics_reconnect;

	return 0;

 init_fail:
	return -1;
}

/*****************************************************************************
 *	Functions to interpret the absolute mode packets
 ****************************************************************************/

static void synaptics_parse_hw_state(unsigned char buf[], struct synaptics_data *priv, struct synaptics_hw_state *hw)
{
	memset(hw, 0, sizeof(struct synaptics_hw_state));

	if (SYN_MODEL_NEWABS(priv->model_id)) {
		hw->x = (((buf[3] & 0x10) << 8) |
			 ((buf[1] & 0x0f) << 8) |
			 buf[4]);
		hw->y = (((buf[3] & 0x20) << 7) |
			 ((buf[1] & 0xf0) << 4) |
			 buf[5]);

		hw->z = buf[2];
		hw->w = (((buf[0] & 0x30) >> 2) |
			 ((buf[0] & 0x04) >> 1) |
			 ((buf[3] & 0x04) >> 2));

		hw->left  = (buf[0] & 0x01) ? 1 : 0;
		hw->right = (buf[0] & 0x02) ? 1 : 0;
		if (SYN_CAP_EXTENDED(priv->capabilities) &&
		    (SYN_CAP_FOUR_BUTTON(priv->capabilities))) {
			hw->up = ((buf[3] & 0x01)) ? 1 : 0;
			if (hw->left)
				hw->up = !hw->up;
			hw->down = ((buf[3] & 0x02)) ? 1 : 0;
			if (hw->right)
				hw->down = !hw->down;
		}
		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
		    ((buf[3] & 2) ? !hw->right : hw->right)) {
			switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
			default:
				/*
				 * if nExtBtn is greater than 8 it should be
				 * considered invalid and treated as 0
				 */
				break;
			case 8:
				hw->b7 = ((buf[5] & 0x08)) ? 1 : 0;
				hw->b6 = ((buf[4] & 0x08)) ? 1 : 0;
			case 6:
				hw->b5 = ((buf[5] & 0x04)) ? 1 : 0;
				hw->b4 = ((buf[4] & 0x04)) ? 1 : 0;
			case 4:
				hw->b3 = ((buf[5] & 0x02)) ? 1 : 0;
				hw->b2 = ((buf[4] & 0x02)) ? 1 : 0;
			case 2:
				hw->b1 = ((buf[5] & 0x01)) ? 1 : 0;
				hw->b0 = ((buf[4] & 0x01)) ? 1 : 0;
			}
		}
	} else {
		hw->x = (((buf[1] & 0x1f) << 8) | buf[2]);
		hw->y = (((buf[4] & 0x1f) << 8) | buf[5]);

		hw->z = (((buf[0] & 0x30) << 2) | (buf[3] & 0x3F));
		hw->w = (((buf[1] & 0x80) >> 4) | ((buf[0] & 0x04) >> 1));

		hw->left  = (buf[0] & 0x01) ? 1 : 0;
		hw->right = (buf[0] & 0x02) ? 1 : 0;
	}
}

/*
 *  called for each full received packet from the touchpad
 */
static void synaptics_process_packet()
{
	struct synaptics_data *priv = psmouse->private;
	struct synaptics_hw_state hw;
	int num_fingers;
	int finger_width;

	synaptics_parse_hw_state(psmouse->packet, priv, &hw);

	if (hw.z > 0) {
		num_fingers = 1;
		finger_width = 5;
		if (SYN_CAP_EXTENDED(priv->capabilities)) {
			switch (hw.w) {
			case 0 ... 1:
				if (SYN_CAP_MULTIFINGER(priv->capabilities))
					num_fingers = hw.w + 2;
				break;
			case 2:
				if (SYN_MODEL_PEN(priv->model_id))
					;   /* Nothing, treat a pen as a single finger */
				break;
			case 4 ... 15:
				if (SYN_CAP_PALMDETECT(priv->capabilities))
					finger_width = hw.w;
				break;
			}
		}
	} else {
		num_fingers = 0;
		finger_width = 0;
	}

	/* Post events
	 * BTN_TOUCH has to be first as mousedev relies on it when doing
	 * absolute -> relative conversion
	 */
	if (hw.z > 30) uinput_report_key(BTN_TOUCH, 1);
	if (hw.z < 25) uinput_report_key(BTN_TOUCH, 0);

	if (hw.z > 0) {
		uinput_report_abs(ABS_X, hw.x);
		uinput_report_abs(ABS_Y, YMAX_NOMINAL + YMIN_NOMINAL - hw.y);
	}
	uinput_report_abs(ABS_PRESSURE, hw.z);

	uinput_report_abs(ABS_TOOL_WIDTH, finger_width);
	uinput_report_key(BTN_TOOL_FINGER, num_fingers == 1);
	uinput_report_key(BTN_TOOL_DOUBLETAP, num_fingers == 2);
	uinput_report_key(BTN_TOOL_TRIPLETAP, num_fingers == 3);

	uinput_report_key(BTN_LEFT,    hw.left);
	uinput_report_key(BTN_RIGHT,   hw.right);
	uinput_report_key(BTN_FORWARD, hw.up);
	uinput_report_key(BTN_BACK,    hw.down);
	if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
		switch(SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
		default:
			/*
			 * if nExtBtn is greater than 8 it should be considered
			 * invalid and treated as 0
			 */
			break;
		case 8:
			uinput_report_key(BTN_7,       hw.b7);
			uinput_report_key(BTN_6,       hw.b6);
		case 6:
			uinput_report_key(BTN_5,       hw.b5);
			uinput_report_key(BTN_4,       hw.b4);
		case 4:
			uinput_report_key(BTN_3,       hw.b3);
			uinput_report_key(BTN_2,       hw.b2);
		case 2:
			uinput_report_key(BTN_1,       hw.b1);
			uinput_report_key(BTN_0,       hw.b0);
			break;
		}
	uinput_sync();
}

static int synaptics_validate_byte(unsigned char packet[], int idx, unsigned char pkt_type)
{
	static unsigned char newabs_mask[]	= { 0xC8, 0x00, 0x00, 0xC8, 0x00 };
	static unsigned char newabs_rel_mask[]	= { 0xC0, 0x00, 0x00, 0xC0, 0x00 };
	static unsigned char newabs_rslt[]	= { 0x80, 0x00, 0x00, 0xC0, 0x00 };
	static unsigned char oldabs_mask[]	= { 0xC0, 0x60, 0x00, 0xC0, 0x60 };
	static unsigned char oldabs_rslt[]	= { 0xC0, 0x00, 0x00, 0x80, 0x00 };

	switch (pkt_type) {
		case SYN_NEWABS:
		case SYN_NEWABS_RELAXED:
			return (packet[idx] & newabs_rel_mask[idx]) == newabs_rslt[idx];

		case SYN_NEWABS_STRICT:
			return (packet[idx] & newabs_mask[idx]) == newabs_rslt[idx];

		case SYN_OLDABS:
			return (packet[idx] & oldabs_mask[idx]) == oldabs_rslt[idx];

		default:
			err("synaptics: unknown packet type %d\n", pkt_type);
			return 0;
	}
}

static unsigned char synaptics_detect_pkt_type(struct psmouse *psmouse)
{
	int i;

	for (i = 0; i < 5; i++)
		if (!synaptics_validate_byte(psmouse->packet, i, SYN_NEWABS_STRICT)) {
			info("synaptics: using relaxed packet validation\n");
			return SYN_NEWABS_RELAXED;
		}

	return SYN_NEWABS_STRICT;
}

void synaptics_process_byte()
{
	struct synaptics_data *priv = psmouse->private;

	if (psmouse->pktcnt >= 6) { /* Full packet received */
		if (priv->out_of_sync) {
			priv->out_of_sync = 0;
			notice("Synaptics driver resynced.\n");
		}

		if (unlikely(priv->pkt_type == SYN_NEWABS))
			priv->pkt_type = synaptics_detect_pkt_type(psmouse);

		synaptics_process_packet();
		psmouse->pktcnt = 0;

	} else if (psmouse->pktcnt &&
		   !synaptics_validate_byte(psmouse->packet, psmouse->pktcnt - 1, priv->pkt_type)) {
		warn("Synaptics driver lost sync at byte %d\n", psmouse->pktcnt);
		psmouse->pktcnt = 0;
		if (++priv->out_of_sync == psmouse_resetafter) {
			psmouse->state = PSMOUSE_IGNORE;
			notice("synaptics: issuing reconnect request\n");
			phys_reconnect();
		}
	}
}
#define _PSMOUSE_H

#define PSMOUSE_CMD_SETSCALE11	0x00e6
#define PSMOUSE_CMD_SETRES	0x10e8
#define PSMOUSE_CMD_GETINFO	0x03e9
#define PSMOUSE_CMD_SETSTREAM	0x00ea
#define PSMOUSE_CMD_POLL	0x03eb
#define PSMOUSE_CMD_GETID	0x02f2
#define PSMOUSE_CMD_SETRATE	0x10f3
#define PSMOUSE_CMD_ENABLE	0x00f4
#define PSMOUSE_CMD_RESET_DIS	0x00f6
#define PSMOUSE_CMD_RESET_BAT	0x02ff

#define PSMOUSE_RET_BAT		0xaa
#define PSMOUSE_RET_ID		0x00
#define PSMOUSE_RET_ACK		0xfa
#define PSMOUSE_RET_NAK		0xfe

/* psmouse states */
#define PSMOUSE_CMD_MODE	0
#define PSMOUSE_ACTIVATED	1
#define PSMOUSE_IGNORE		2

struct psmouse;

struct psmouse {
	void *private;
	char *vendor;
	char *name;
	unsigned char cmdbuf[8];
	unsigned char packet[8];
	unsigned char cmdcnt;
	unsigned char pktcnt;
	unsigned char type;
	unsigned char model;
	unsigned char state;
	char acking;
	volatile char ack;
	char error;
	char devname[64];
	long long last;

	int (*reconnect)();
	void (*disconnect)();
};

#define PSMOUSE_PS2		1
#define PSMOUSE_PS2PP		2
#define PSMOUSE_PS2TPP		3
#define PSMOUSE_GENPS		4
#define PSMOUSE_IMPS		5
#define PSMOUSE_IMEX		6
#define PSMOUSE_SYNAPTICS 	7

extern int psmouse_command(unsigned char *param, int command);
extern int psmouse_reset(void);

extern void phys_reconnect();

extern int psmouse_smartscroll;
extern unsigned int psmouse_rate;
extern unsigned int psmouse_resetafter;

extern struct psmouse * const psmouse;


extern void uinput_set_evbit(int bit);
extern void uinput_set_ledbit(int bit);
extern void uinput_set_keybit(int bit);
extern void uinput_set_relbit(int bit);

extern void uinput_event(__u16 type, __u16 code, __s32 value);
#define uinput_report_key(code,value) uinput_event(EV_KEY, (code), (value))
#define uinput_report_rel(code,value) uinput_event(EV_REL, (code), (value))
#define uinput_report_abs(code,value) uinput_event(EV_ABS, (code), (value))
#define uinput_sync() uinput_event(EV_SYN, 0, 0)



#define warn(...) fprintf(stderr, "psmouse: (warning) " __VA_ARGS__)
#define err(...)  fprintf(stderr, "psmouse: ERROR " __VA_ARGS__)
#define info(...) printf("psmouse: " __VA_ARGS__)
#define notice(...) printf("psmouse: NOTE " __VA_ARGS__)
#define perr(msg)  do{fprintf(stderr, "psmouse: ERROR: "); perror(msg);}while(0)
#define perrx(msg) do{perr(msg); exit(1);}while(0)
#define pferrx() perrx(__FUNCTION__)
#define unlikely /* */

#endif /* _PSMOUSE_H */
 * PS/2 mouse driver
 *
 * Copyright (c) 1999-2002 Vojtech Pavlik
 * Copyright (c) 2004 Sau Dan LEE
 */

/*
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation.
 */

/*
  This program is based on linux-2.6.6/drivers/input/mouse/*
  The difference is that this program 'psmouse' now runs in user-space
  (swappable),  while the kernel driver runs in kernel-space.

  Usage: psmouse /dev/misc/isa0060/serio0

  Prerequisites:
     1) 'uinput' module loaded or compiled in
         If not using 'devfs', you have to create the /dev/uinput char
         device with major 10.  The minor number can be found in
	 "cat /proc/misc" after loading the 'uinput' module.
     2) 'serio' module with SERIO_USERDEV patch loaded or compiled in
     3) 'i8042' module loaded or compiled in
     4) 'psmouse' module UNloaded and NOT compiled in
     5) 'mousedev' loaded to do anything really useful

  TODO:
     - options parsing should be added to allow user to
       specify the module parameters.
     - daemonize this program, so as to make it easy to run from /etc/inittab
     - pass-through port of synaptics devices is not supported yet.
*/


#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/time.h>
#include <linux/input.h>
#include <linux/uinput.h>
#include "psmouse.h"

#define module_param_named(name,var,type,defl) struct dummy
#define MODULE_PARM_DESC(name,desc) struct dummy




static char *psmouse_proto;
static unsigned int psmouse_max_proto = -1U;
module_param_named(proto, psmouse_proto, charp, 0);
MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps). Useful for KVM switches.");

int psmouse_resolution = 200;
module_param_named(resolution, psmouse_resolution, uint, 0);
MODULE_PARM_DESC(resolution, "Resolution, in dpi.");

unsigned int psmouse_rate = 100;
module_param_named(rate, psmouse_rate, uint, 0);
MODULE_PARM_DESC(rate, "Report rate, in reports per second.");

int psmouse_smartscroll = 1;
module_param_named(smartscroll, psmouse_smartscroll, bool, 0);
MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");

unsigned int psmouse_resetafter;
module_param_named(resetafter, psmouse_resetafter, uint, 0);
MODULE_PARM_DESC(resetafter, "Reset Synaptics Touchpad after so many bad packets (0 = never).");


static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};


static struct psmouse psmouse_data;
struct psmouse * const psmouse = &psmouse_data;


/********** functions for interacting with 'uinput' **********/

static const char *uinput_dev_name = NULL;
static int uinput_fd;

static void uinput_open() {
	uinput_fd = open(uinput_dev_name, O_WRONLY);
}

void uinput_set_evbit(int bit) {
	int r;

	r = ioctl(uinput_fd, UI_SET_EVBIT, bit);
	if (r==-1) { pferrx(); }
}

void uinput_set_ledbit(int bit) {
	int r;

	r = ioctl(uinput_fd, UI_SET_LEDBIT, bit);
	if (r==-1) { pferrx();}
}

void uinput_set_keybit(int bit) {
	int r;

	r = ioctl(uinput_fd, UI_SET_KEYBIT, bit);
	if (r==-1) { pferrx(); }
}

void uinput_set_relbit(int bit) {
	int r;

	r = ioctl(uinput_fd, UI_SET_RELBIT, bit);
	if (r==-1) { pferrx(); }
}


static const char* phys_filename;
static void uinput_create() {
	struct uinput_user_dev uinput = {
		.name = "psmouse ",
	};
	int r;

	snprintf(uinput.name, UINPUT_MAX_NAME_SIZE,
		 "psmouse %s", phys_filename);

	r = write(uinput_fd, &uinput, sizeof(uinput));
	if (r==-1) { pferrx(); }

	r = ioctl(uinput_fd, UI_DEV_CREATE);
	if (r==-1) { pferrx(); }
}

static void uinput_destroy() {
	int r;

	r = ioctl(uinput_fd, UI_DEV_DESTROY);
	if (r==-1) { pferrx(); }
}

static void uinput_close() {
	int r;

	r = close(uinput_fd);
	if (r==-1) { pferrx(); }
}

void uinput_event(__u16 type, __u16 code, __s32 value) {
	struct input_event ev = {
		.type = type,
		.code = code,
		.value = value
	};
	int r;

	r = write(uinput_fd, &ev, sizeof(ev));
	if (r!=sizeof(ev)) { pferrx(); }
}



/********** functions for accessing the raw keyboard device **********/

static int phys_fd = -1;
static const char* phys_filename;

static int phys_open() {
	phys_fd = open(phys_filename, O_RDWR);
	if (phys_fd == -1) {
		const int e = errno;
		perr(phys_filename);
		switch (e) {
		case EACCES:
			err("read-write access required.  Are you 'root'?\n");
			break;
		}
		exit(1);
	}
	return 0;
}

static int phys_write(unsigned char byte) {
	int r;
	r = write(phys_fd, &byte, 1);
	if (r==-1) { pferrx(); }
	if (r!=1) { err("cannot write"); exit(1); }
	return 0;
}

static void psmouse_interrupt(unsigned char data,
			      unsigned int flags);

static int phys_wait_for_input(int *ptimeout) {
	unsigned char byte;
	int r;

	if (ptimeout != NULL) {
		fd_set fds;
		struct timeval tv;

		FD_ZERO(&fds);
		FD_SET(phys_fd, &fds);
		tv.tv_sec=0; tv.tv_usec=*ptimeout;
		r = select(phys_fd+1, &fds, NULL, &fds, &tv);
		*ptimeout = tv.tv_sec*1000000 + tv.tv_usec;
		if (r==-1) { pferrx(); }
		if (r==0) { return -1; } /* timeout */
		if (r!=1) { err("cannot select"); exit(1); }
	}

	r = read(phys_fd, &byte, 1);
	if (r==-1) { pferrx(); }
	if (r!=1) { err("cannot read"); exit(1); }

	psmouse_interrupt(byte, 0);
	return 0;
}

static void phys_close() {
	int r;
	r = close(phys_fd);
	if (r==-1) { pferrx(); }
}

static int psmouse_connect();
static void psmouse_disconnect();
static int psmouse_reconnect();

static void phys_rescan() {
	psmouse_disconnect();
	psmouse_connect();
}

void phys_reconnect() {
	psmouse_reconnect();
}



/*
 * psmouse_process_packet() analyzes the PS/2 mouse packet contents and
 * reports relevant events to the input module.
 */

static void psmouse_process_packet()
{
	unsigned char *packet = psmouse->packet;


/*
 * The PS2++ protocol is a little bit complex
 */

	if (psmouse->type == PSMOUSE_PS2PP || psmouse->type == PSMOUSE_PS2TPP)
		ps2pp_process_packet();

/*
 * Scroll wheel on IntelliMice, scroll buttons on NetMice
 */

	if (psmouse->type == PSMOUSE_IMPS || psmouse->type == PSMOUSE_GENPS)
		uinput_report_rel(REL_WHEEL, -(signed char) packet[3]);

/*
 * Scroll wheel and buttons on IntelliMouse Explorer
 */

	if (psmouse->type == PSMOUSE_IMEX) {
		uinput_report_rel(REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
		uinput_report_key(BTN_SIDE, (packet[3] >> 4) & 1);
		uinput_report_key(BTN_EXTRA, (packet[3] >> 5) & 1);
	}

/*
 * Extra buttons on Genius NewNet 3D
 */

	if (psmouse->type == PSMOUSE_GENPS) {
		uinput_report_key(BTN_SIDE, (packet[0] >> 6) & 1);
		uinput_report_key(BTN_EXTRA, (packet[0] >> 7) & 1);
	}

/*
 * Generic PS/2 Mouse
 */

	uinput_report_key(BTN_LEFT,    packet[0]       & 1);
	uinput_report_key(BTN_MIDDLE, (packet[0] >> 2) & 1);
	uinput_report_key(BTN_RIGHT,  (packet[0] >> 1) & 1);

	uinput_report_rel(REL_X, packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0);
	uinput_report_rel(REL_Y, packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);

	uinput_sync();
}

/*
 * psmouse_interrupt() handles incoming characters, either gathering them into
 * packets or passing them to the command routine as command output.
 */

static void psmouse_interrupt(unsigned char data, unsigned int flags)
{
	if (psmouse->state == PSMOUSE_IGNORE)
		goto out;

	if (psmouse->acking) {
		switch (data) {
			case PSMOUSE_RET_ACK:
				psmouse->ack = 1;
				break;
			case PSMOUSE_RET_NAK:
				psmouse->ack = -1;
				break;
			default:
				psmouse->ack = 1;	/* Workaround for mice which don't ACK the Get ID command */
				if (psmouse->cmdcnt)
					psmouse->cmdbuf[--psmouse->cmdcnt] = data;
				break;
		}
		psmouse->acking = 0;
		goto out;
	}

	if (psmouse->cmdcnt) {
		psmouse->cmdbuf[--psmouse->cmdcnt] = data;
		goto out;
	}

	{
	struct timeval tv;
	long long jiffies;
	int r;

	r = gettimeofday(&tv, NULL);
	if (r==-1) { pferrx(); }
	jiffies = tv.tv_sec * 1000000 + tv.tv_usec;

	if (psmouse->state == PSMOUSE_ACTIVATED &&
	    psmouse->pktcnt 
	    &&  jiffies > psmouse->last + 500000) {
		warn("%s lost synchronization, throwing %d bytes away.\n",
		       psmouse->name, psmouse->pktcnt);
		psmouse->pktcnt = 0;
	}

	psmouse->last = jiffies;
	}

	psmouse->packet[psmouse->pktcnt++] = data;

	if (psmouse->packet[0] == PSMOUSE_RET_BAT) {
		if (psmouse->pktcnt == 1)
			goto out;

		if (psmouse->pktcnt == 2) {
			if (psmouse->packet[1] == PSMOUSE_RET_ID) {
				psmouse->state = PSMOUSE_IGNORE;
				phys_rescan();
				goto out;
			}
			if (psmouse->type == PSMOUSE_SYNAPTICS) {
				/* neither 0xAA nor 0x00 are valid first bytes
				 * for a packet in absolute mode
				 */
				psmouse->pktcnt = 0;
				goto out;
			}
		}
	}

	if (psmouse->type == PSMOUSE_SYNAPTICS) {
		/*
		 * The synaptics driver has its own resync logic,
		 * so it needs to receive all bytes one at a time.
		 */
		synaptics_process_byte(psmouse);
		goto out;
	}

	if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {
		psmouse_process_packet();
		psmouse->pktcnt = 0;
		goto out;
	}
out:
	return;
}

/*
 * psmouse_sendbyte() sends a byte to the mouse, and waits for acknowledge.
 * It doesn't handle retransmission, though it could - because when there would
 * be need for retransmissions, the mouse has to be replaced anyway.
 */

static int psmouse_sendbyte(unsigned char byte)
{
	int timeout = 10000; /* 100 msec */
	psmouse->ack = 0;
	psmouse->acking = 1;

	if (phys_write(byte)) {
		psmouse->acking = 0;
		return -1;
	}

	while (!psmouse->ack && timeout>0)
		phys_wait_for_input(&timeout);

	return -(psmouse->ack <= 0);
}

/*
 * psmouse_command() sends a command and its parameters to the mouse,
 * then waits for the response and puts it in the param array.
 */

int psmouse_command(unsigned char *param, int command)
{
	int timeout = 500000; /* 500 msec */
	int send = (command >> 12) & 0xf;
	int receive = (command >> 8) & 0xf;
	int i;

	psmouse->cmdcnt = receive;

	if (command == PSMOUSE_CMD_RESET_BAT)
                timeout = 4000000; /* 4 sec */

	/* initialize cmdbuf with preset values from param */
	if (receive)
	   for (i = 0; i < receive; i++)
		psmouse->cmdbuf[(receive - 1) - i] = param[i];

	if (command & 0xff)
		if (psmouse_sendbyte(command & 0xff))
			return (psmouse->cmdcnt = 0) - 1;

	for (i = 0; i < send; i++)
		if (psmouse_sendbyte(param[i]))
			return (psmouse->cmdcnt = 0) - 1;

	while (psmouse->cmdcnt && timeout>0) {

		if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_RESET_BAT &&
				timeout > 100000) /* do not run in a endless loop */
			timeout = 100000; /* 1 sec */

		if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_GETID &&
		    psmouse->cmdbuf[1] != 0xab && psmouse->cmdbuf[1] != 0xac) {
			psmouse->cmdcnt = 0;
			break;
		}

		phys_wait_for_input(&timeout);
	}

	for (i = 0; i < receive; i++)
		param[i] = psmouse->cmdbuf[(receive - 1) - i];

	if (psmouse->cmdcnt)
		return (psmouse->cmdcnt = 0) - 1;

	return 0;
}


/*
 * psmouse_reset() resets the mouse into power-on state.
 */
int psmouse_reset()
{
	unsigned char param[2];

	if (psmouse_command(param, PSMOUSE_CMD_RESET_BAT))
		return -1;

	if (param[0] != PSMOUSE_RET_BAT && param[1] != PSMOUSE_RET_ID)
		return -1;

	return 0;
}


/*
 * Genius NetMouse magic init.
 */
static int genius_detect()
{
	unsigned char param[4];

	param[0] = 3;
	psmouse_command(param, PSMOUSE_CMD_SETRES);
	psmouse_command( NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command( NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command( NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command(param, PSMOUSE_CMD_GETINFO);

	return param[0] == 0x00 && param[1] == 0x33 && param[2] == 0x55;
}

/*
 * IntelliMouse magic init.
 */
static int intellimouse_detect()
{
	unsigned char param[2];

	param[0] = 200;
	psmouse_command(param, PSMOUSE_CMD_SETRATE);
	param[0] = 100;
	psmouse_command(param, PSMOUSE_CMD_SETRATE);
	param[0] =  80;
	psmouse_command(param, PSMOUSE_CMD_SETRATE);
	psmouse_command(param, PSMOUSE_CMD_GETID);

	return param[0] == 3;
}

/*
 * Try IntelliMouse/Explorer magic init.
 */
static int im_explorer_detect()
{
	unsigned char param[2];

	param[0] = 200;
	psmouse_command(param, PSMOUSE_CMD_SETRATE);
	param[0] = 200;
	psmouse_command(param, PSMOUSE_CMD_SETRATE);
	param[0] =  80;
	psmouse_command(param, PSMOUSE_CMD_SETRATE);
	psmouse_command(param, PSMOUSE_CMD_GETID);

	return param[0] == 4;
}

/*
 * psmouse_extensions() probes for any extensions to the basic PS/2 protocol
 * the mouse may have.
 */

static int psmouse_extensions()
{
	int synaptics_hardware = 0;

	psmouse->vendor = "Generic";
	psmouse->name = "Mouse";
	psmouse->model = 0;

/*
 * Try Synaptics TouchPad
 */
	if (psmouse_max_proto > PSMOUSE_PS2 && synaptics_detect()) {
		synaptics_hardware = 1;
		psmouse->vendor = "Synaptics";
		psmouse->name = "TouchPad";

		if (psmouse_max_proto > PSMOUSE_IMEX) {
			if (synaptics_init() == 0)
				return PSMOUSE_SYNAPTICS;
/*
 * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).
 * Unfortunately Logitech/Genius probes confuse some firmware versions so
 * we'll have to skip them.
 */
			psmouse_max_proto = PSMOUSE_IMEX;
		}
/*
 * Make sure that touchpad is in relative mode, gestures (taps) are enabled
 */
		synaptics_reset();
	}

	if (psmouse_max_proto > PSMOUSE_IMEX && genius_detect()) {
		uinput_set_keybit(BTN_EXTRA);
		uinput_set_keybit(BTN_SIDE);
		uinput_set_relbit(REL_WHEEL);

		psmouse->vendor = "Genius";
		psmouse->name = "Wheel Mouse";
		return PSMOUSE_GENPS;
	}

	if (psmouse_max_proto > PSMOUSE_IMEX) {
		int type = ps2pp_detect();
		if (type)
			return type;
	}

	if (psmouse_max_proto >= PSMOUSE_IMPS && intellimouse_detect()) {
		uinput_set_relbit(REL_WHEEL);

		if (psmouse_max_proto >= PSMOUSE_IMEX &&
					im_explorer_detect()) {
			uinput_set_keybit(BTN_SIDE);
			uinput_set_keybit(BTN_EXTRA);

			psmouse->name = "Explorer Mouse";
			return PSMOUSE_IMEX;
		}

		psmouse->name = "Wheel Mouse";
		return PSMOUSE_IMPS;
	}

/*
 * Okay, all failed, we have a standard mouse here. The number of the buttons
 * is still a question, though. We assume 3.
 */
	if (synaptics_hardware) {
/*
 * We detected Synaptics hardware but it did not respond to IMPS/2 probes.
 * We need to reset the touchpad because if there is a track point on the
 * pass through port it could get disabled while probing for protocol
 * extensions.
 */
		psmouse_reset();
		psmouse_command(NULL, PSMOUSE_CMD_RESET_DIS);
	}

	return PSMOUSE_PS2;
}

/*
 * psmouse_probe() probes for a PS/2 mouse.
 */

static int psmouse_probe()
{
	unsigned char param[2];

/*
 * First, we check if it's a mouse. It should send 0x00 or 0x03
 * in case of an IntelliMouse in 4-byte mode or 0x04 for IM Explorer.
 */

	param[0] = 0xa5;

	if (psmouse_command(param, PSMOUSE_CMD_GETID))
		return -1;

	if (param[0] != 0x00 && param[0] != 0x03 && param[0] != 0x04)
		return -1;

/*
 * Then we reset and disable the mouse so that it doesn't generate events.
 */

	if (psmouse_command(NULL, PSMOUSE_CMD_RESET_DIS))
		warn("Failed to reset mouse\n");

/*
 * And here we try to determine if it has any extensions over the
 * basic PS/2 3-button mouse.
 */

	return psmouse->type = psmouse_extensions();
}

/*
 * Here we set the mouse resolution.
 */

static void psmouse_set_resolution()
{
	unsigned char param[1];

	if (psmouse->type == PSMOUSE_PS2PP && psmouse_resolution > 400) {
		ps2pp_set_800dpi(psmouse);
		return;
	}

	if (!psmouse_resolution || psmouse_resolution >= 200)
		param[0] = 3;
	else if (psmouse_resolution >= 100)
		param[0] = 2;
	else if (psmouse_resolution >= 50)
		param[0] = 1;
	else if (psmouse_resolution)
		param[0] = 0;

        psmouse_command(param, PSMOUSE_CMD_SETRES);
}

/*
 * Here we set the mouse report rate.
 */

static void psmouse_set_rate()
{
	unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
	int i = 0;

	while (rates[i] > psmouse_rate) i++;
	psmouse_command(rates + i, PSMOUSE_CMD_SETRATE);
}

/*
 * psmouse_initialize() initializes the mouse to a sane state.
 */

static void psmouse_initialize()
{
	unsigned char param[2];

/*
 * We set the mouse report rate, resolution and scaling.
 */

	if (psmouse_max_proto != PSMOUSE_PS2) {
		psmouse_set_rate();
		psmouse_set_resolution();
		psmouse_command(NULL, PSMOUSE_CMD_SETSCALE11);
	}

/*
 * We set the mouse into streaming mode.
 */

	psmouse_command(param, PSMOUSE_CMD_SETSTREAM);
}

/*
 * psmouse_activate() enables the mouse so that we get motion reports from it.
 */

static void psmouse_activate()
{
	if (psmouse_command(NULL, PSMOUSE_CMD_ENABLE))
		warn("Failed to enable mouse\n");

	psmouse->state = PSMOUSE_ACTIVATED;
}

#if 0
/*
 * psmouse_cleanup() resets the mouse into power-on state.
 */

static void psmouse_cleanup(struct serio *serio)
{
	struct psmouse *psmouse = serio->private;

	psmouse_reset(psmouse);
}
#endif

/*
 * psmouse_disconnect() closes and frees.
 */

static void psmouse_disconnect()
{
	psmouse->state = PSMOUSE_CMD_MODE;

	if (psmouse->disconnect)
		psmouse->disconnect(psmouse);

	psmouse->state = PSMOUSE_IGNORE;

	phys_close();
}

/*
 * psmouse_connect() is a callback from the serio module when
 * an unhandled serio port is found.
 */
static int psmouse_connect()
{
	memset(psmouse, 0, sizeof(struct psmouse));

	uinput_set_evbit(EV_KEY);
	uinput_set_evbit(EV_REL);

	uinput_set_keybit(BTN_LEFT);
	uinput_set_keybit(BTN_MIDDLE);
	uinput_set_keybit(BTN_RIGHT);

	uinput_set_relbit(REL_X);
	uinput_set_relbit(REL_Y);

	psmouse->state = PSMOUSE_CMD_MODE;

	if (phys_open()) {
		return -1;
	}

	if (psmouse_probe() <= 0) {
		return -1;
	}

	sprintf(psmouse->devname, "%s %s %s",
		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
	info("%s\n", psmouse->devname);

	psmouse_initialize();

	psmouse_activate();

	return 0;
}

static int psmouse_reconnect()
{
	int old_type;

	old_type = psmouse->type;

	psmouse->state = PSMOUSE_CMD_MODE;
	psmouse->type = psmouse->acking = psmouse->cmdcnt = psmouse->pktcnt = 0;
	if (psmouse->reconnect) {
	       if (psmouse->reconnect())
			return -1;
	} else if (psmouse_probe() != old_type)
		return -1;

	/* ok, the device type (and capabilities) match the old one,
	 * we can continue using it, complete intialization
	 */
	psmouse->type = old_type;
	psmouse_initialize();

	psmouse_activate();
	return 0;
}
#if 0


static struct serio_dev psmouse_dev = {
	.interrupt =	psmouse_interrupt,
	.connect =	psmouse_connect,
	.reconnect =	psmouse_reconnect,
	.disconnect =	psmouse_disconnect,
	.cleanup =	psmouse_cleanup,
};

static inline void psmouse_parse_proto(void)
{
	if (psmouse_proto) {
		if (!strcmp(psmouse_proto, "bare"))
			psmouse_max_proto = PSMOUSE_PS2;
		else if (!strcmp(psmouse_proto, "imps"))
			psmouse_max_proto = PSMOUSE_IMPS;
		else if (!strcmp(psmouse_proto, "exps"))
			psmouse_max_proto = PSMOUSE_IMEX;
		else
			printk(KERN_ERR "psmouse: unknown protocol type '%s'\n", psmouse_proto);
	}
}

#endif

int main(int argc, char**argv) {
	if (argc != 2) {
		fprintf(stderr, "Usage: %s raw_ps2_mouse_device\n", argv[0]);
		return 1;
	}

	phys_filename = argv[1];

	/* try devfs name first */
	uinput_dev_name = "/dev/misc/uinput";
	uinput_open();
	if (uinput_fd == -1 && errno==ENOENT) {
		/* was not found: try non-devfs name */
		uinput_dev_name = "/dev/uinput";
		uinput_open();
	}
	if (uinput_fd == -1) {
		const int e = errno;
		perr(uinput_dev_name);

		switch (e) {
		case ENOENT:
			err("Have you loaded the 'uinput' module?\n");
			break;
		case EACCES:
			err("Write access needed.  Are you 'root'?\n");
			break;
		}
		exit (1);
	}


	if (psmouse_connect() != 0) {
		fprintf(stderr, "cannot connect to device\n");
		return 1;
	}

	uinput_create();

	for (;;) {
		phys_wait_for_input(NULL);
	}

	uinput_destroy();

	psmouse_disconnect();
	uinput_close();
	return 0;
}
 * Logitech PS/2++ mouse driver header
 *
 * Copyright (c) 2003 Vojtech Pavlik <vojtech@suse.cz>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation.
 */

#ifndef _LOGIPS2PP_H
#define _LOGIPS2PP_H

#define PS2PP_4BTN	0x01
#define PS2PP_WHEEL	0x02
#define PS2PP_MX	0x04
#define PS2PP_MX310	0x08

struct psmouse;
void ps2pp_process_packet();
void ps2pp_set_800dpi();
int ps2pp_detect();
#endif
 * Logitech PS/2++ mouse driver
 *
 * Copyright (c) 1999-2003 Vojtech Pavlik <vojtech@suse.cz>
 * Copyright (c) 2003 Eric Wong <eric@yhbt.net>
 * Copyright (c) 2004 Sau Dan LEE
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation.
 */

#include <stdlib.h>
#include <linux/input.h>
#include "psmouse.h"
#include "logips2pp.h"

/*
 * Process a PS2++ or PS2T++ packet.
 */

void ps2pp_process_packet()
{
        unsigned char *packet = psmouse->packet;

	if ((packet[0] & 0x48) == 0x48 && (packet[1] & 0x02) == 0x02) {

		switch ((packet[1] >> 4) | (packet[0] & 0x30)) {

			case 0x0d: /* Mouse extra info */

				uinput_report_rel(packet[2] & 0x80 ? REL_HWHEEL : REL_WHEEL,
					(int) (packet[2] & 8) - (int) (packet[2] & 7));
				uinput_report_key(BTN_SIDE, (packet[2] >> 4) & 1);
				uinput_report_key(BTN_EXTRA, (packet[2] >> 5) & 1);

				break;

			case 0x0e: /* buttons 4, 5, 6, 7, 8, 9, 10 info */

				uinput_report_key(BTN_SIDE, (packet[2]) & 1);
				uinput_report_key(BTN_EXTRA, (packet[2] >> 1) & 1);
				uinput_report_key(BTN_BACK, (packet[2] >> 3) & 1);
				uinput_report_key(BTN_FORWARD, (packet[2] >> 4) & 1);
				uinput_report_key(BTN_TASK, (packet[2] >> 2) & 1);

				break;

			case 0x0f: /* TouchPad extra info */

				uinput_report_rel(packet[2] & 0x08 ? REL_HWHEEL : REL_WHEEL,
					(int) ((packet[2] >> 4) & 8) - (int) ((packet[2] >> 4) & 7));
				packet[0] = packet[2] | 0x08;
				break;

#ifdef DEBUG
			default:
				printk(KERN_WARNING "psmouse.c: Received PS2++ packet #%x, but don't know how to handle.\n",
					(packet[1] >> 4) | (packet[0] & 0x30));
#endif
		}

		packet[0] &= 0x0f;
		packet[1] = 0;
		packet[2] = 0;

	}
}

/*
 * ps2pp_cmd() sends a PS2++ command, sliced into two bit
 * pieces through the SETRES command. This is needed to send extended
 * commands to mice on notebooks that try to understand the PS/2 protocol
 * Ugly.
 */

static int ps2pp_cmd(unsigned char *param, unsigned char command)
{
	unsigned char d;
	int i;

	if (psmouse_command(NULL, PSMOUSE_CMD_SETSCALE11))
		return -1;

	for (i = 6; i >= 0; i -= 2) {
		d = (command >> i) & 3;
		if(psmouse_command(&d, PSMOUSE_CMD_SETRES))
			return -1;
	}

	if (psmouse_command(param, PSMOUSE_CMD_POLL))
		return -1;

	return 0;
}

/*
 * SmartScroll / CruiseControl for some newer Logitech mice Defaults to
 * enabled if we do nothing to it. Of course I put this in because I want it
 * disabled :P
 * 1 - enabled (if previously disabled, also default)
 * 0/2 - disabled 
 */

static void ps2pp_set_smartscroll()
{
	unsigned char param[4];

	ps2pp_cmd(param, 0x32);

	param[0] = 0;
	psmouse_command(param, PSMOUSE_CMD_SETRES);
	psmouse_command(param, PSMOUSE_CMD_SETRES);
	psmouse_command(param, PSMOUSE_CMD_SETRES);

	if (psmouse_smartscroll == 1) 
		param[0] = 1;
	else
	if (psmouse_smartscroll > 2)
		return;

	/* else leave param[0] == 0 to disable */
	psmouse_command(param, PSMOUSE_CMD_SETRES);
}

/*
 * Support 800 dpi resolution _only_ if the user wants it (there are good
 * reasons to not use it even if the mouse supports it, and of course there are
 * also good reasons to use it, let the user decide).
 */

void ps2pp_set_800dpi()
{
	unsigned char param = 3;
	psmouse_command(NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command(NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command(NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command(&param, PSMOUSE_CMD_SETRES);
}

/*
 * Detect the exact model and features of a PS2++ or PS2T++ Logitech mouse or
 * touchpad.
 */

static int ps2pp_detect_model(unsigned char *param)
{
	int i;
	static struct _logips2_list {
		const int model;
		unsigned const int features;
	} logips2pp_list [] = {
		{ 12,	PS2PP_4BTN},
		{ 13,	0 },
		{ 40,	PS2PP_4BTN },
		{ 41,	PS2PP_4BTN },
		{ 42,	PS2PP_4BTN },
		{ 43,	PS2PP_4BTN },
		{ 50,	0 },
		{ 51,	0 },
		{ 52,	PS2PP_4BTN | PS2PP_WHEEL },
		{ 53,	PS2PP_WHEEL },
		{ 61,	PS2PP_WHEEL | PS2PP_MX },	/* MX700 */
		{ 73,	PS2PP_4BTN },
		{ 75,	PS2PP_WHEEL },
		{ 76,	PS2PP_WHEEL },
		{ 80,	PS2PP_4BTN | PS2PP_WHEEL },
		{ 81,	PS2PP_WHEEL },
		{ 83,	PS2PP_WHEEL },
		{ 88,	PS2PP_WHEEL },
		{ 96,	0 },
		{ 97,	0 },
		{ 100 ,	PS2PP_WHEEL | PS2PP_MX },	/* MX510 */
		{ 112 ,	PS2PP_WHEEL | PS2PP_MX },	/* MX500 */
		{ 114 ,	PS2PP_WHEEL | PS2PP_MX | PS2PP_MX310 },	/* MX310 */
		{ }
	};

	psmouse->vendor = "Logitech";
	psmouse->model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);

#if 0
	if (param[1] < 3)
		clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
	if (param[1] < 2)
		clear_bit(BTN_RIGHT, psmouse->dev.keybit);
#endif

	psmouse->type = PSMOUSE_PS2;

	for (i = 0; logips2pp_list[i].model; i++){
		if (logips2pp_list[i].model == psmouse->model){
			psmouse->type = PSMOUSE_PS2PP;
			if (logips2pp_list[i].features & PS2PP_4BTN)
				uinput_set_keybit(BTN_SIDE);

			if (logips2pp_list[i].features & PS2PP_WHEEL){
				uinput_set_relbit(REL_WHEEL);
				psmouse->name = "Wheel Mouse";
			}
			if (logips2pp_list[i].features & PS2PP_MX) {
				uinput_set_keybit(BTN_SIDE);
				uinput_set_keybit(BTN_EXTRA);
				uinput_set_keybit(BTN_TASK);
				if (!(logips2pp_list[i].features & PS2PP_MX310)){
					uinput_set_keybit(BTN_BACK);
					uinput_set_keybit(BTN_FORWARD);
				}
				psmouse->name = "MX Mouse";
			}
			break;
		}
	}
/*
 * Do Logitech PS2++ / PS2T++ magic init.
 */
	if (psmouse->type == PSMOUSE_PS2PP) {

		if (psmouse->model == 97) { /* TouchPad 3 */

			uinput_set_relbit(REL_WHEEL);
			uinput_set_relbit(REL_HWHEEL);

			param[0] = 0x11; param[1] = 0x04; param[2] = 0x68; /* Unprotect RAM */
			psmouse_command(param, 0x30d1);
			param[0] = 0x11; param[1] = 0x05; param[2] = 0x0b; /* Enable features */
			psmouse_command(param, 0x30d1);
			param[0] = 0x11; param[1] = 0x09; param[2] = 0xc3; /* Enable PS2++ */
			psmouse_command(param, 0x30d1);

			param[0] = 0;
			if (!psmouse_command(param, 0x13d1) &&
				param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14) {
				psmouse->name = "TouchPad 3";
				return PSMOUSE_PS2TPP;
			}

		} else {

			param[0] = param[1] = param[2] = 0;
			ps2pp_cmd(param, 0x39); /* Magic knock */
			ps2pp_cmd(param, 0xDB);

			if ((param[0] & 0x78) == 0x48 && (param[1] & 0xf3) == 0xc2 &&
				(param[2] & 3) == ((param[1] >> 2) & 3)) {
					ps2pp_set_smartscroll();
					return PSMOUSE_PS2PP;
			}
		}
	}

	return 0;
}

/*
 * Logitech magic init.
 */
int ps2pp_detect()
{
	unsigned char param[4];

	param[0] = 0;
	psmouse_command(param, PSMOUSE_CMD_SETRES);
	psmouse_command( NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command( NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command( NULL, PSMOUSE_CMD_SETSCALE11);
	param[1] = 0;
	psmouse_command(param, PSMOUSE_CMD_GETINFO);

	return param[1] != 0 ? ps2pp_detect_model(param) : 0;
}

	$(LINK.c) -o $@ $^

logips2pp.o: logips2pp.c psmouse.h logips2pp.h
psmouse-base.o: psmouse-base.c psmouse.h uinput.h synaptics.h logips2pp.h
synaptics.o: synaptics.c psmouse.h synaptics.h
--=-=-=
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: quoted-printable




--=20
Sau Dan LEE                     =A7=F5=A6u=B4=B0(Big5)                    ~=
{@nJX6X~}(HZ)=20

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

--=-=-=--

