Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264539AbUEJGUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbUEJGUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 02:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUEJGUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 02:20:41 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:2688 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264539AbUEJGU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 02:20:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: logips2pp driver update (MX510/310 support), cleanup
Date: Mon, 10 May 2004 01:20:24 -0500
User-Agent: KMail/1.6.2
References: <20040506212654.GA17915@Muzzle>
In-Reply-To: <20040506212654.GA17915@Muzzle>
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405100120.24630.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 May 2004 04:26 pm, Eric Wong wrote:
> I've updated the logips2pp driver to detect the MX310 and MX510 mice
> and also made it more maintainable by putting everything into one
> table instead of having 4 arrays for them (the MX700 support wasn't
> added correctly in the last revision).  Please apply.\

Hi Eric,

I have been working on changing psmouse driver so it would not alter
psmouse structure when probing for supported extensions unless asked.
Would you mind against re-arranging logips2.pp driver in the following
fashion:

/*
 * Logitech PS/2++ mouse driver
 *
 * Copyright (c) 1999-2003 Vojtech Pavlik <vojtech@suse.cz>
 * Copyright (c) 2003 Eric Wong <eric@yhbt.net>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation.
 */

#include <linux/input.h>
#include <linux/serio.h>
#include "psmouse.h"
#include "logips2pp.h"

/* Logitech mouse types */
#define PS2PP_KIND_WHEEL	1
#define PS2PP_KIND_MX		2
#define PS2PP_KIND_TP3		3

/* Logitech mouse features */
#define PS2PP_WHEEL		0x01
#define PS2PP_HWHEEL		0x02
#define PS2PP_SIDE_BTN		0x04
#define PS2PP_EXTRA_BTN		0x08
#define PS2PP_TASK_BTN		0x10
#define PS2PP_NAV_BTN		0x20

struct ps2pp_info {
	const int model;
	unsigned const int kind;
	unsigned const int features;
};

/*
 * Process a PS2++ or PS2T++ packet.
 */

void ps2pp_process_packet(struct psmouse *psmouse)
{
	struct input_dev *dev = &psmouse->dev;
        unsigned char *packet = psmouse->packet;

	if ((packet[0] & 0x48) == 0x48 && (packet[1] & 0x02) == 0x02) {

		switch ((packet[1] >> 4) | (packet[0] & 0x30)) {

			case 0x0d: /* Mouse extra info */

				input_report_rel(dev, packet[2] & 0x80 ? REL_HWHEEL : REL_WHEEL,
					(int) (packet[2] & 8) - (int) (packet[2] & 7));
				input_report_key(dev, BTN_SIDE, (packet[2] >> 4) & 1);
				input_report_key(dev, BTN_EXTRA, (packet[2] >> 5) & 1);

				break;

			case 0x0e: /* buttons 4, 5, 6, 7, 8, 9, 10 info */

				input_report_key(dev, BTN_SIDE, (packet[2]) & 1);
				input_report_key(dev, BTN_EXTRA, (packet[2] >> 1) & 1);
				input_report_key(dev, BTN_BACK, (packet[2] >> 3) & 1);
				input_report_key(dev, BTN_FORWARD, (packet[2] >> 4) & 1);
				input_report_key(dev, BTN_TASK, (packet[2] >> 2) & 1);

				break;

			case 0x0f: /* TouchPad extra info */

				input_report_rel(dev, packet[2] & 0x08 ? REL_HWHEEL : REL_WHEEL,
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

static int ps2pp_cmd(struct psmouse *psmouse, unsigned char *param, unsigned char command)
{
	if (psmouse_sliced_command(psmouse, command))
		return -1;

	if (psmouse_command(psmouse, param, PSMOUSE_CMD_POLL))
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

static void ps2pp_set_smartscroll(struct psmouse *psmouse)
{
	unsigned char param[4];

	ps2pp_cmd(psmouse, param, 0x32);

	param[0] = 0;
	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);

	if (psmouse_smartscroll < 2) {
		/* 0 - disabled, 1 - enabled */
		param[0] = psmouse_smartscroll;
		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
	}
}

/*
 * Support 800 dpi resolution _only_ if the user wants it (there are good
 * reasons to not use it even if the mouse supports it, and of course there are
 * also good reasons to use it, let the user decide).
 */

void ps2pp_set_800dpi(struct psmouse *psmouse)
{
	unsigned char param = 3;
	psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command(psmouse, &param, PSMOUSE_CMD_SETRES);
}

static struct ps2pp_info *get_model_info(unsigned char model)
{
	static struct ps2pp_info ps2pp_list[] = {
		{ 12,	0,			PS2PP_SIDE_BTN},
		{ 13,	0,			0 },
		{ 40,	0,			PS2PP_SIDE_BTN },
		{ 41,	0,			PS2PP_SIDE_BTN },
		{ 42,	0,			PS2PP_SIDE_BTN },
		{ 43,	0,			PS2PP_SIDE_BTN },
		{ 50,	0,			0 },
		{ 51,	0,			0 },
		{ 52,	PS2PP_KIND_WHEEL,	PS2PP_SIDE_BTN | PS2PP_WHEEL },
		{ 53,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
		{ 61,	PS2PP_KIND_MX,
				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },	/* MX700 */
		{ 73,	0,			PS2PP_SIDE_BTN },
		{ 75,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
		{ 76,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
		{ 80,	PS2PP_KIND_WHEEL,	PS2PP_SIDE_BTN | PS2PP_WHEEL },
		{ 81,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
		{ 83,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
		{ 88,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
		{ 96,	0,			0 },
		{ 97,	PS2PP_KIND_TP3,		PS2PP_WHEEL | PS2PP_HWHEEL },
		{ 100,	PS2PP_KIND_MX,
				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },	/* MX510 */
		{ 112,	PS2PP_KIND_MX,
				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },	/* MX500 */
		{ 114,	PS2PP_KIND_MX,
				PS2PP_WHEEL | PS2PP_SIDE_BTN |
				PS2PP_TASK_BTN | PS2PP_EXTRA_BTN },	/* M310 */
		{ }
	};
	int i;

	for (i = 0; ps2pp_list[i].model; i++)
		if (model == ps2pp_list[i].model)
			return &ps2pp_list[i];
	return NULL;
}

/*
 * Set up input device's properties based on the detected mouse model.
 */

static void ps2pp_set_model_properties(struct psmouse *psmouse, struct ps2pp_info *model_info)
{
	if (model_info->features & PS2PP_SIDE_BTN)
		set_bit(BTN_SIDE, psmouse->dev.keybit);

	if (model_info->features & PS2PP_EXTRA_BTN)
		set_bit(BTN_EXTRA, psmouse->dev.keybit);

	if (model_info->features & PS2PP_TASK_BTN)
		set_bit(BTN_TASK, psmouse->dev.keybit);

	if (model_info->features & PS2PP_NAV_BTN) {
		set_bit(BTN_FORWARD, psmouse->dev.keybit);
		set_bit(BTN_BACK, psmouse->dev.keybit);
	}

	if (model_info->features & PS2PP_WHEEL)
		set_bit(REL_WHEEL, psmouse->dev.relbit);

	if (model_info->features & PS2PP_HWHEEL)
		set_bit(REL_HWHEEL, psmouse->dev.relbit);

	switch (model_info->kind) {
		case PS2PP_KIND_WHEEL:
			psmouse->name = "Wheel Mouse";
			break;

		case PS2PP_KIND_MX:
			psmouse->name = "MX Mouse";
			break;

		case PS2PP_KIND_TP3:
			psmouse->name = "TouchPad 3";
			break;
	}
}


/*
 * Logitech magic init. Detect whether the mouse is a Logitech one
 * and its exact model and try turning on extended protocol for ones
 * that support it.
 */

int ps2pp_init(struct psmouse *psmouse, int set_properties)
{
	unsigned char param[4];
	unsigned char protocol = PSMOUSE_PS2;
	unsigned char model, buttons;
	struct ps2pp_info *model_info;

	param[0] = 0;
	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
	param[1] = 0;
	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);

	if (param[1] != 0) {
		model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);
		buttons = param[1];
		model_info = get_model_info(model);

/*
 * Do Logitech PS2++ / PS2T++ magic init.
 */
		if (model == 97) { /* Touch Pad 3 */

			/* Unprotect RAM */
			param[0] = 0x11; param[1] = 0x04; param[2] = 0x68;
			psmouse_command(psmouse, param, 0x30d1);
			/* Enable features */
			param[0] = 0x11; param[1] = 0x05; param[2] = 0x0b;
			psmouse_command(psmouse, param, 0x30d1);
			/* Enable PS2++ */
			param[0] = 0x11; param[1] = 0x09; param[2] = 0xc3;
			psmouse_command(psmouse, param, 0x30d1);

			param[0] = 0;
			if (!psmouse_command(psmouse, param, 0x13d1) &&
			    param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14) {
				protocol = PSMOUSE_PS2TPP;
			}

		} else if (get_model_info(model) != NULL) {

			param[0] = param[1] = param[2] = 0;
			ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
			ps2pp_cmd(psmouse, param, 0xDB);

			if ((param[0] & 0x78) == 0x48 &&
			    (param[1] & 0xf3) == 0xc2 &&
			    (param[2] & 0x03) == ((param[1] >> 2) & 3)) {
				ps2pp_set_smartscroll(psmouse);
				protocol = PSMOUSE_PS2PP;
			}
		}

		if (set_properties) {
			psmouse->vendor = "Logitech";
			psmouse->model = model;

			if (buttons < 3)
				clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
			if (buttons < 2)
				clear_bit(BTN_RIGHT, psmouse->dev.keybit);

			if (model_info)
				ps2pp_set_model_properties(psmouse, model_info);
		}
	}

	return protocol;
}


-- 
Dmitry
