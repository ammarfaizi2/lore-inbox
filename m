Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWH2Izi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWH2Izi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWH2Izi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:55:38 -0400
Received: from web37903.mail.mud.yahoo.com ([209.191.91.165]:11885 "HELO
	web37903.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750726AbWH2Izi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:55:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=zfEoIe1W7ydC5uy3f2jCjKWOjiQ3+aEzlzpOP6nqsBiii84xw5cxYLRgdioAzY948XnNXA2vrpREfRI2oGSfjWT3s6TLy0sSsEeZBtmHEnkaG6pYXdSUQNEw8nMHFb4JFe74EIPOC66cibMHyVfC9zjUjaY6lGjlC0RUL+5f7V0=  ;
Message-ID: <20060829085537.22755.qmail@web37903.mail.mud.yahoo.com>
Date: Tue, 29 Aug 2006 01:55:37 -0700 (PDT)
From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [RPC] OLPC tablet input driver.
To: "Zephaniah E. Hull" <warp@aehallh.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>
In-Reply-To: <20060829073339.GA4181@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Zephaniah E. Hull" <warp@aehallh.com> wrote:

> 
> 
> That said, here the patch is for comments.
> (And possibly for the OLPC kernel tree for others with samples to
> play
> with.)
> 
> 
> Signed-off-by: Zephaniah E. Hull <warp@aehallh.com>
> 
> diff --git a/drivers/input/mouse/Makefile
> b/drivers/input/mouse/Makefile
> index 21a1de6..6218e5a 100644
> --- a/drivers/input/mouse/Makefile
> +++ b/drivers/input/mouse/Makefile
> @@ -14,4 +14,4 @@ obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
>  obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
>  obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
>  
> -psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o
> lifebook.o trackpoint.o
> +psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o
> lifebook.o trackpoint.o olpc.o

Where is KConfigurable entry ?

> diff --git a/drivers/input/mouse/olpc.c b/drivers/input/mouse/olpc.c
> new file mode 100644
> index 0000000..245f29e
> --- /dev/null
> +++ b/drivers/input/mouse/olpc.c
> @@ -0,0 +1,327 @@


> +/*
> + * OLPC touchpad PS/2 mouse driver
> + *
> +int olpc_init(struct psmouse *psmouse)
> +{
> +	struct olpc_data *priv;
> +	struct input_dev *dev = psmouse->dev;
> +	struct input_dev *dev2;
> +
> +	psmouse->private = priv = kzalloc(sizeof(struct olpc_data),
> GFP_KERNEL);

I think you should assign priv to private only if !NULL.

> +	dev2 = input_allocate_device();
> +	if (!priv || !dev2)
> +		goto init_fail;
> +
> +	priv->dev2 = dev2;
> +
> +	if (!(priv->i = olpc_get_model(psmouse)))
> +		goto init_fail;
> +
> +	if (olpc_absolute_mode(psmouse)) {
> +		printk(KERN_ERR "olpc.c: Failed to enable absolute mode\n");
> +		goto init_fail;
> +	}
> +
> +	dev->evbit[LONG(EV_KEY)] |= BIT(EV_KEY);
> +	dev->keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
> +	dev->keybit[LONG(BTN_TOOL_PEN)] |= BIT(BTN_TOOL_PEN);
> +	dev->keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT);
> +
> +	dev->evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
> +	input_set_abs_params(dev, ABS_X, 0, 1023, 0, 0);
> +	input_set_abs_params(dev, ABS_Y, 0, 1023, 0, 0);
> +
> +	snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
> psmouse->ps2dev.serio->phys);
> +	dev2->phys = priv->phys;
> +	dev2->name = "OLPC OLPC GlideSensor";
> +	dev2->id.bustype = BUS_I8042;
> +	dev2->id.vendor  = 0x0002;
> +	dev2->id.product = PSMOUSE_OLPC;
> +	dev2->id.version = 0x0000;
> +
> +	dev2->evbit[LONG(EV_KEY)] |= BIT(EV_KEY);
> +	dev2->evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
> +	input_set_abs_params(dev2, ABS_X, 0, 2047, 0, 0);
> +	input_set_abs_params(dev2, ABS_Y, 0, 1023, 0, 0);
> +	input_set_abs_params(dev2, ABS_PRESSURE, 0, 63, 0, 0);
> +	dev2->keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
> +	dev2->keybit[LONG(BTN_TOOL_FINGER)] |= BIT(BTN_TOOL_FINGER);
> +	dev2->keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT);
> +
> +	input_register_device(priv->dev2);

Please check the return value of input_register_device and its friends.

> +
> +
> +	psmouse->protocol_handler = olpc_process_byte;
> +	psmouse->poll = olpc_poll;
> +	psmouse->disconnect = olpc_disconnect;
> +	psmouse->reconnect = olpc_reconnect;
> +	psmouse->pktsize = 9;
> +
> +	/* We are having trouble resyncing OLPC touchpads so disable it for
> now */
> +	psmouse->resync_time = 0;
> +
> +	return 0;
> +
> +init_fail:
> +	input_free_device(dev2);
> +	kfree(priv);
> +	return -1;
> +}
> +


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
