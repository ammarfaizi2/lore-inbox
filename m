Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWBAEUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWBAEUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWBAEUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:20:13 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:27322 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030242AbWBAEUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:20:07 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Shaun Jackman <sjackman@gmail.com>
Subject: Re: Liyitec PS/2 touch panel driver [PATCH]
Date: Tue, 31 Jan 2006 23:20:04 -0500
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <7f45d9390601311459o45de3c34sd4d25fc7990c728d@mail.gmail.com>
In-Reply-To: <7f45d9390601311459o45de3c34sd4d25fc7990c728d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601312320.05143.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 January 2006 17:59, Shaun Jackman wrote:
> +
> +static int liyitec_connect(struct serio *serio, struct serio_driver *drv)
> +{
> +	struct liyitec *liyitec;
> +	struct input_dev *input_dev;
> +	int retval;
> +
> +	liyitec = kzalloc(sizeof *liyitec, GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (liyitec == NULL || input_dev == NULL) {
> +		retval = -ENOMEM;
> +		goto out;
> +	}
> +
> +	liyitec->serio = serio;
> +	liyitec->dev = input_dev;
> +	sprintf(liyitec->phys, "%s/input0", serio->phys);
> +
> +	input_dev->private = liyitec;
> +	input_dev->name = "Liyitec PS/2 touch screen";
> +	input_dev->phys = liyitec->phys;
> +	input_dev->id.bustype = BUS_I8042;
> +	input_dev->id.vendor = SERIO_LIYITEC;
> +	input_dev->id.product = 0;
> +	input_dev->id.version = 0x0100;
> +	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
> +	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
> +	input_dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_RIGHT);
> +	input_set_abs_params(liyitec->dev, ABS_X, 0, LIYITEC_MAX_X, 0, 0);
> +	input_set_abs_params(liyitec->dev, ABS_Y, 0, LIYITEC_MAX_Y, 0, 0);
> +
> +	serio_set_drvdata(serio, liyitec);
> +	retval = serio_open(serio, drv);
> +	if (retval)
> +		goto out;
> +	input_register_device(liyitec->dev);
> +
> +	liyitec->count = -2;
> +	retval = serio_write(serio, LIYITEC_CMD_SETSTREAM);
> +	if (retval)
> +		goto out;
> +	retval = serio_write(serio, LIYITEC_CMD_ENABLE);
> +

Hi Shaun,

Thank you for adding support for the new touchscreen, however I have a
couple of questions:

What stops this driver form binding to serio ports that have devices other
that Liyitec touchscreen connected to them? Such as keyboard port when
keyboard works in non-translated mode or regular AUX port with standard
PS/2 mouse? Is there a way to query for presence of the touchscreen?

Moreover this driver should be integrated into psmouse so proper protocol
is selected automatically.

-- 
Dmitry
