Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWH2MxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWH2MxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWH2MxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:53:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:28802 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932284AbWH2MxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:53:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TkpV7t5ytfwW6Y0eHqTRsoFMOaUKkNxfT19BEbjJqIWMWh+8KcmSCXx9pg/VDbbYFMaWusvn2VjuNqgaJ8BpYanIr9Ge4hB81fu43w7P1q53criGhKT0kl0gIIZKvO67cDa6JGQzxIJaJvaH6AJZ9FjTRNS4pHl3LUG/rfaits0=
Message-ID: <d120d5000608290553t275b4acar925f66b3d0c7434b@mail.gmail.com>
Date: Tue, 29 Aug 2006 08:53:17 -0400
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Marcelo Tosatti" <mtosatti@redhat.com>
Subject: Re: [RPC] OLPC tablet input driver.
In-Reply-To: <20060829073339.GA4181@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060829073339.GA4181@aehallh.com>
X-Google-Sender-Auth: 20cd255af7a97a0b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/29/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> The OLPC will ship with a somewhat unique input device made by ALPS,
> connected via PS/2 and speaking a protocol only loosely based on that
> spoken by other ALPS devices.
>

Do you have a formal programming spec for it?

> This is required by the noticeable different between this device and
> others made by alps, specificly that it is very wide, with the center
> 1/3rd usable with the GS sensor, and the entire area usable with the PT
> sensor, with support for using both at once.
>

Coudl youp please tell me what GS and PT stand for?

> The protocol differs enough that I split the driver for this off from
> the ALPS driver.
>
> The patch is below, but there are a few things of note.
>
> 1: Cosmetic: Some line lengths, and outputs with debugging enabled, are
> over 80 columns wide.  Will be fixed in the next version of this patch.
>

If going to 80 colums will require monstrocities like this:

... do_bla(struct_b->
               array_g[
               index_i].
               submember);

(and I seen quite a few such attempts to "improve" code) then please don't ;)

> 2: Cosmetic: Input device IDs need to be decided on, some feedback on
> the best values to use here would be appreciated.

I think what you've done is fine.

>
> 3: Patch stuff: Because the protocol uses 9 byte packets I had to
> increase the size of the buffer in struct psmouse.  Should this be split
> off into a separate patch?
>

No.

> 4: Technical/policy: Buttons are currently sent to both of the input
> devices we generate, I don't see any way to avoid this that is not a
> policy decision on which buttons belong to which device, but I'm open to
> suggestions.
>

Is it not known how actual hardware wired?

> 5: Technical: Min/max on absolute values are currently reported as the
> protocol limits (10 bits on GS X, GS Y, and PT Y.  11 bits on PT X.  7
> bits on GS pressure).  Until we get samples based on the newer design
> and do some testing to see how big the variations are, we just don't
> have any numbers to put here.
>

Using protocol limits is fine, I don't think anyone actually uses it.
Synaptics X driver allows users to tweak it to their preference.

> 6: Technical, maybe: The early samples I have that speak this protocol
> are doing some odd things with this driver.  Mostly in the realm of
> sample rate and pressure reporting.  I'm fairly sure that this is
> hardware related, but it's worth mentioning.
>
>
> That said, here the patch is for comments.
> (And possibly for the OLPC kernel tree for others with samples to play
> with.)
>
>
> Signed-off-by: Zephaniah E. Hull <warp@aehallh.com>
>
> diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
> index 21a1de6..6218e5a 100644
> --- a/drivers/input/mouse/Makefile
> +++ b/drivers/input/mouse/Makefile
> @@ -14,4 +14,4 @@ obj-$(CONFIG_MOUSE_SERIAL)    += sermouse.o
>  obj-$(CONFIG_MOUSE_HIL)                += hil_ptr.o
>  obj-$(CONFIG_MOUSE_VSXXXAA)    += vsxxxaa.o
>
> -psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o trackpoint.o
> +psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o trackpoint.o olpc.o
> diff --git a/drivers/input/mouse/olpc.c b/drivers/input/mouse/olpc.c
> new file mode 100644
> index 0000000..245f29e
> --- /dev/null
> +++ b/drivers/input/mouse/olpc.c
> @@ -0,0 +1,327 @@
> +/*
> + * OLPC touchpad PS/2 mouse driver
> + *
> + * Copyright (c) 2006 One Laptop Per Child, inc.
> + * Author Zephaniah E. Hull.
> + *
> + * This driver is partly based on the ALPS driver, which is:
> + *
> + * Copyright (c) 2003 Neil Brown <neilb@cse.unsw.edu.au>
> + * Copyright (c) 2003-2005 Peter Osterlund <petero2@telia.com>
> + * Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
> + * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/*
> + * The touchpad on the OLPC is fairly wide, with the entire area usable
> + * as a tablet, and the center 1/3rd also usable as a touchpad.
> + *
> + * The device has simultanious reporting, so that both can be used at once.
> + *
> + * The PT+GS protocol is similar to the base ALPS protocol, in that the
> + * GS data is where the ALPS parser would expect to find it, however
> + * there are several additional bytes, the button bits are in a
> + * different byte, and the bits used for finger and gesture indication
> + * are replaced by two bits which indicate if it is reporting PT or GS
> + * coordinate data in that packet.
> + */
> +
> +#include <linux/input.h>
> +#include <linux/serio.h>
> +#include <linux/libps2.h>
> +
> +#include "psmouse.h"
> +#include "olpc.h"
> +
> +#undef DEBUG
> +#ifdef DEBUG
> +#define dbg(format, arg...) printk(KERN_INFO "olpc.c(%d): " format "\n", __LINE__, ## arg)
> +#else
> +#define dbg(format, arg...) do {} while (0)
> +#endif
> +
> +#define OLPC_PT                0x01
> +#define OLPC_GS                0x02
> +#define OLPC_PTGS      0x04
> +

Do you need a separate #define? I'd expect it to be OLPC_PT | OLPC_GS?

> +static struct olpc_model_info olpc_model_data[] = {
> +       { { 0x67, 0x00, 0x0a }, 0xeb, 0xff, OLPC_PTGS },        /* OLPC in PT+GS mode. */
> +};
> +
> +/*
> + * OLPC absolute Mode - new format
> + *
> + * byte 0:  1    ?    ?    ?    1    ?    ?    ?
> + * byte 1:  0   x6   x5   x4   x3   x2   x1   x0
> + * byte 2:  0   x10  x9   x8   x7    ?  fin  ges
> + * byte 3:  0   y9   y8   y7    1    0    R    L
> + * byte 4:  0   y6   y5   y4   y3   y2   y1   y0
> + * byte 5:  0   z6   z5   z4   z3   z2   z1   z0
> + *
> + * ?'s can have different meanings on different models,
> + * such as wheel rotation, extra buttons, stick buttons
> + * on a dualpoint, etc.
> + */
> +
> +static void olpc_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
> +{
> +       struct olpc_data *priv = psmouse->private;
> +       unsigned char *packet = psmouse->packet;
> +       struct input_dev *dev = psmouse->dev;
> +       struct input_dev *dev2 = priv->dev2;
> +       int px, py, gx, gy, gz, gs_down, pt_down, left, right;
> +
> +       input_regs(dev, regs);
> +
> +       left = packet[6] & 1;
> +       right = packet[6] & 2;
> +       gx = packet[1] | ((packet[2] & 0x78) << (7 - 3));
> +       gy = packet[4] | ((packet[3] & 0x70) << (7 - 4));
> +       gz = packet[5];
> +       px = packet[8] | ((packet[2] & 0x7) << 7);
> +       py = packet[7] | ((packet[6] & 0x70) << (7 - 4));
> +
> +       pt_down = packet[3] & 1;
> +       gs_down = packet[3] & 2;
> +
> +       input_report_key(dev, BTN_LEFT, left);
> +       input_report_key(dev2, BTN_LEFT, left);
> +       input_report_key(dev, BTN_RIGHT, right);
> +       input_report_key(dev2, BTN_RIGHT, right);
> +
> +       input_report_key(dev, BTN_TOUCH, pt_down);
> +       input_report_key(dev, BTN_TOOL_PEN, pt_down);
> +       input_report_key(dev2, BTN_TOUCH, gs_down);
> +       input_report_key(dev2, BTN_TOOL_FINGER, gs_down);
> +
> +       if (gs_down) {
> +               input_report_abs(dev2, ABS_X, gx);
> +               input_report_abs(dev2, ABS_Y, gy);
> +       }
> +       input_report_abs(dev2, ABS_PRESSURE, gz);
> +
> +       if (pt_down) {
> +               input_report_abs(dev, ABS_X, px);
> +               input_report_abs(dev, ABS_Y, py);
> +       }
> +
> +       input_sync(dev);
> +}
> +
> +static psmouse_ret_t olpc_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
> +{
> +       struct olpc_data *priv = psmouse->private;
> +       psmouse_ret_t ret = PSMOUSE_BAD_DATA;
> +
> +       if ((psmouse->packet[0] & priv->i->mask0) != priv->i->byte0) {
> +               ret = PSMOUSE_BAD_DATA;
> +               goto out;
> +       }
> +
> +       /* Bytes 2 - 6 should have 0 in the highest bit */
> +       if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 9 &&
> +               (psmouse->packet[psmouse->pktcnt - 1] & 0x80)) {
> +           ret = PSMOUSE_BAD_DATA;
> +           goto out;
> +       }
> +
> +       if ((psmouse->pktcnt == 4 || psmouse->pktcnt == 7) &&
> +               ((psmouse->packet[psmouse->pktcnt - 1] & 0x88) != 8)) {
> +           ret = PSMOUSE_BAD_DATA;
> +           goto out;
> +       }
> +
> +       if (psmouse->pktcnt == 9) {
> +           olpc_process_packet(psmouse, regs);
> +
> +           ret = PSMOUSE_FULL_PACKET;
> +           goto out;
> +       }
> +
> +       ret = PSMOUSE_GOOD_DATA;
> +out:
> +       if (ret != PSMOUSE_GOOD_DATA)
> +               dbg("ret: %d, len: %u, data: %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x", ret, psmouse->pktcnt,
> +                       psmouse->packet[0], psmouse->packet[1], psmouse->packet[2],
> +                       psmouse->packet[3], psmouse->packet[4], psmouse->packet[5],
> +                       psmouse->packet[6], psmouse->packet[7], psmouse->packet[8]);
> +       return ret;
> +}
> +
> +static struct olpc_model_info *olpc_get_model(struct psmouse *psmouse)
> +{
> +       struct ps2dev *ps2dev = &psmouse->ps2dev;
> +       unsigned char param[4];
> +       int i;
> +
> +       /*
> +        * Now try "E7 report". Allowed responses are in
> +        * olpc_model_data[].signature
> +        */
> +       if (ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
> +           ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
> +           ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21))
> +               return NULL;
> +
> +       param[0] = param[1] = param[2] = 0xff;
> +       if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> +               return NULL;
> +
> +       dbg("E7 report: %2.2x %2.2x %2.2x", param[0], param[1], param[2]);
> +
> +       for (i = 0; i < ARRAY_SIZE(olpc_model_data); i++)
> +               if (!memcmp(param, olpc_model_data[i].signature, sizeof(olpc_model_data[i].signature)))
> +                       return olpc_model_data + i;
> +
> +       return NULL;
> +}
> +
> +static int olpc_absolute_mode(struct psmouse *psmouse)
> +{
> +       struct ps2dev *ps2dev = &psmouse->ps2dev;
> +       unsigned char param;
> +
> +       /* Switch to 'Advanced mode.', four disables in a row. */
> +       if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
> +           ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
> +           ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
> +           ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE))
> +               return -1;
> +
> +       /*
> +        * Switch to simultanious mode, F2 (GETID) three times with no
> +        * arguments or reply, followed by SETRES with an argument of 2.
> +        */
> +       ps2_command(ps2dev, NULL, 0xF2);
> +       ps2_command(ps2dev, NULL, 0xF2);
> +       ps2_command(ps2dev, NULL, 0xF2);
> +       param = 0x02;
> +       ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
> +
> +       return 0;
> +}
> +
> +/*
> + * olpc_poll() - poll the touchpad for current motion packet.
> + * Used in resync.
> + */
> +static int olpc_poll(struct psmouse *psmouse)
> +{
> +       /*
> +        * FIXME: We can't poll, find a way to make resync work better.
> +        */
> +       return 0;
> +}

I'd expect it to return -1. It's OK that it can't poll, it looks like
it should resync fairly well on its own.

> +
> +static int olpc_reconnect(struct psmouse *psmouse)
> +{
> +       struct olpc_data *priv = psmouse->private;
> +
> +       psmouse_reset(psmouse);
> +
> +       if (!(priv->i = olpc_get_model(psmouse)))
> +               return -1;
> +
> +       if (olpc_absolute_mode(psmouse)) {
> +               printk(KERN_ERR "olpc.c: Failed to reenable absolute mode\n");
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +static void olpc_disconnect(struct psmouse *psmouse)
> +{
> +       struct olpc_data *priv = psmouse->private;
> +
> +       psmouse_reset(psmouse);
> +       input_unregister_device(priv->dev2);
> +       kfree(priv);
> +}
> +
> +int olpc_init(struct psmouse *psmouse)
> +{
> +       struct olpc_data *priv;
> +       struct input_dev *dev = psmouse->dev;
> +       struct input_dev *dev2;
> +
> +       psmouse->private = priv = kzalloc(sizeof(struct olpc_data), GFP_KERNEL);
> +       dev2 = input_allocate_device();
> +       if (!priv || !dev2)
> +               goto init_fail;
> +
> +       priv->dev2 = dev2;
> +
> +       if (!(priv->i = olpc_get_model(psmouse)))
> +               goto init_fail;
> +
> +       if (olpc_absolute_mode(psmouse)) {
> +               printk(KERN_ERR "olpc.c: Failed to enable absolute mode\n");
> +               goto init_fail;
> +       }
> +
> +       dev->evbit[LONG(EV_KEY)] |= BIT(EV_KEY);
> +       dev->keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
> +       dev->keybit[LONG(BTN_TOOL_PEN)] |= BIT(BTN_TOOL_PEN);
> +       dev->keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT);
> +
> +       dev->evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
> +       input_set_abs_params(dev, ABS_X, 0, 1023, 0, 0);
> +       input_set_abs_params(dev, ABS_Y, 0, 1023, 0, 0);
> +
> +       snprintf(priv->phys, sizeof(priv->phys), "%s/input1", psmouse->ps2dev.serio->phys);
> +       dev2->phys = priv->phys;
> +       dev2->name = "OLPC OLPC GlideSensor";

"OLPC OLPC"?

> +       dev2->id.bustype = BUS_I8042;
> +       dev2->id.vendor  = 0x0002;
> +       dev2->id.product = PSMOUSE_OLPC;
> +       dev2->id.version = 0x0000;
> +
> +       dev2->evbit[LONG(EV_KEY)] |= BIT(EV_KEY);
> +       dev2->evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
> +       input_set_abs_params(dev2, ABS_X, 0, 2047, 0, 0);
> +       input_set_abs_params(dev2, ABS_Y, 0, 1023, 0, 0);
> +       input_set_abs_params(dev2, ABS_PRESSURE, 0, 63, 0, 0);
> +       dev2->keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
> +       dev2->keybit[LONG(BTN_TOOL_FINGER)] |= BIT(BTN_TOOL_FINGER);
> +       dev2->keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT);
> +
> +       input_register_device(priv->dev2);
> +
> +
> +       psmouse->protocol_handler = olpc_process_byte;
> +       psmouse->poll = olpc_poll;
> +       psmouse->disconnect = olpc_disconnect;
> +       psmouse->reconnect = olpc_reconnect;
> +       psmouse->pktsize = 9;
> +
> +       /* We are having trouble resyncing OLPC touchpads so disable it for now */
> +       psmouse->resync_time = 0;
> +
> +       return 0;
> +
> +init_fail:
> +       input_free_device(dev2);
> +       kfree(priv);
> +       return -1;
> +}
> +
> +int olpc_detect(struct psmouse *psmouse, int set_properties)
> +{
> +       struct olpc_model_info *model;
> +
> +       if (!(model = olpc_get_model(psmouse)))
> +               return -1;
> +
> +       if (set_properties) {
> +               psmouse->vendor = "OLPC";
> +               psmouse->name = "PenTablet";
> +               psmouse->model = 0;
> +       }
> +       return 0;
> +}
> +
> diff --git a/drivers/input/mouse/olpc.h b/drivers/input/mouse/olpc.h
> new file mode 100644
> index 0000000..49f4e3e
> --- /dev/null
> +++ b/drivers/input/mouse/olpc.h
> @@ -0,0 +1,37 @@
> +/*
> + * OLPC touchpad PS/2 mouse driver
> + *
> + * Copyright (c) 2006 One Laptop Per Child, inc.
> + *
> + * This driver is partly based on the ALPS driver.
> + * Copyright (c) 2003 Peter Osterlund <petero2@telia.com>
> + * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#ifndef _OLPC_H
> +#define _OLPC_H
> +
> +int olpc_detect(struct psmouse *psmouse, int set_properties);
> +int olpc_init(struct psmouse *psmouse);
> +
> +struct olpc_model_info {
> +        unsigned char signature[3];
> +        unsigned char byte0, mask0;
> +        unsigned char flags;
> +};
> +
> +struct olpc_data {
> +       struct input_dev *dev2;         /* Relative device */
> +       char name[32];                  /* Name */
> +       char phys[32];                  /* Phys */
> +       struct olpc_model_info *i;      /* Info */
> +       int prev_fin_pt;                /* Finger bit from previous packet */
> +       int prev_fin_gs;                /* Finger bit from previous packet */

Bad (duplicate) comment?

> +};
> +
> +
> +#endif
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index 8bc9f51..20060b0 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -26,6 +26,7 @@
>  #include "synaptics.h"
>  #include "logips2pp.h"
>  #include "alps.h"
> +#include "olpc.h"
>  #include "lifebook.h"
>  #include "trackpoint.h"
>
> @@ -616,6 +617,15 @@ static int psmouse_extensions(struct psm
>  */
>                        max_proto = PSMOUSE_IMEX;
>                }
> +               ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
> +               if (olpc_detect(psmouse, set_properties) == 0) {
> +                       if (!set_properties || olpc_init(psmouse) == 0)
> +                               return PSMOUSE_OLPC;
> +/*
> + * Init failed, try basic relative protocols
> + */
> +                       max_proto = PSMOUSE_IMEX;
> +               }
>        }
>
>        if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)
> @@ -726,6 +736,13 @@ static struct psmouse_protocol psmouse_p
>                .detect         = trackpoint_detect,
>        },
>        {
> +               .type           = PSMOUSE_OLPC,
> +               .name           = "OLPC",
> +               .alias          = "olpc",
> +               .maxproto       = 1,
> +               .detect         = olpc_detect,
> +       },
> +       {
>                .type           = PSMOUSE_AUTO,
>                .name           = "auto",
>                .alias          = "any",
> diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
> index 4d9107f..f3d7199 100644
> --- a/drivers/input/mouse/psmouse.h
> +++ b/drivers/input/mouse/psmouse.h
> @@ -42,7 +42,7 @@ struct psmouse {
>        struct work_struct resync_work;
>        char *vendor;
>        char *name;
> -       unsigned char packet[8];
> +       unsigned char packet[9];
>        unsigned char badbyte;
>        unsigned char pktcnt;
>        unsigned char pktsize;
> @@ -86,6 +86,7 @@ enum psmouse_type {
>        PSMOUSE_ALPS,
>        PSMOUSE_LIFEBOOK,
>        PSMOUSE_TRACKPOINT,
> +       PSMOUSE_OLPC,
>        PSMOUSE_AUTO            /* This one should always be last */
>  };
>
> --
>          1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
>           92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
>            CCs of replies from mailing lists are requested.
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.5 (GNU/Linux)
>
> iD8DBQFE8+3TRFMAi+ZaeAERAhiNAJ4t4uF3q9G+bdsGUAYDafNearwMUgCeN0kl
> se5meohSaoJEMhbRsrxtIOo=
> =Vd5o
> -----END PGP SIGNATURE-----
>
>
>


-- 
Dmitry
