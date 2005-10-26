Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVJZSxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVJZSxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 14:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVJZSxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 14:53:23 -0400
Received: from kirby.webscope.com ([204.141.84.57]:44491 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S964852AbVJZSxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 14:53:22 -0400
Message-ID: <435FD09B.9070605@m1k.net>
Date: Wed, 26 Oct 2005 14:53:15 -0400
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Xin Zhao <uszhaoxin@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: can someone explain how to implement callback in kernel?
References: <4ae3c140510261006q193e466bjc90ace3e7979393c@mail.gmail.com>
In-Reply-To: <4ae3c140510261006q193e466bjc90ace3e7979393c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao wrote:

>I am writing a device driver. I want to achieve asynchronous I/O. What
>I want to do is as follows:
>
>1. the driver issues a request to the device. Instead of waiting , it
>schedules a callback,  then return.
>
>2. after the device serves the request, the callback should be
>triggered to finish the rest of work for this request.
>
>This seems to be a standard callback working flow. But I don't know
>how to implement this. Can someone give me a brief idea or point me to
>some link about this?
>
>Thanks in advance!
>  
>
If you'd like to see an example of this behavior in the current kernel, 
take a look at the callbacks used between the dvb and v4l subsystems.

For example, if you look inside drivers/media/video/cx88/cx88-dvb.c, 
you'll notice the following:

static int lgdt330x_pll_set(struct dvb_frontend* fe,
			    struct dvb_frontend_parameters* params)
{
	struct cx8802_dev *dev= fe->dvb->priv;
	struct cx88_core *core = dev->core;
	u8 buf[4];
	struct i2c_msg msg =
		{ .addr = dev->core->pll_addr, .flags = 0, .buf = buf, .len = 4 };
	int err;

	/* Put the analog decoder in standby to keep it quiet */
	cx88_call_i2c_clients (dev->core, TUNER_SET_STANDBY, NULL);

	dvb_pll_configure(core->pll_desc, buf, params->frequency, 0);
	dprintk(1, "%s: tuner at 0x%02x bytes: 0x%02x 0x%02x 0x%02x 0x%02x\n",
			__FUNCTION__, msg.addr, buf[0],buf[1],buf[2],buf[3]);
	if ((err = i2c_transfer(&core->i2c_adap, &msg, 1)) != 1) {
		printk(KERN_WARNING "cx88-dvb: %s error "
			   "(addr %02x <- %02x, err = %i)\n",
			   __FUNCTION__, buf[0], buf[1], err);
		if (err < 0)
			return err;
		else
			return -EREMOTEIO;
	}
	if (core->tuner_type == TUNER_LG_TDVS_H062F) {
		/* Set the Auxiliary Byte. */
		buf[2] &= ~0x20;
		buf[2] |= 0x18;
		buf[3] = 0x50;
		i2c_transfer(&core->i2c_adap, &msg, 1);
	}
	return 0;
}

[...]

static int lgdt330x_set_ts_param(struct dvb_frontend* fe, int is_punctured)
{
	struct cx8802_dev *dev= fe->dvb->priv;
	if (is_punctured)
		dev->ts_gen_cntrl |= 0x04;
	else
		dev->ts_gen_cntrl &= ~0x04;
	return 0;
}

[...]

static struct lgdt330x_config fusionhdtv_5_gold = {
	.demod_address    = 0x0e,
	.demod_chip       = LGDT3303,
	.serial_mpeg      = 0x40, /* TPSERIAL for 3303 in TOP_CONTROL */
	.pll_set          = lgdt330x_pll_set,
	.set_ts_params    = lgdt330x_set_ts_param,
};

[...]

static int dvb_register(struct cx8802_dev *dev)
{
	/* init struct videobuf_dvb */
	dev->dvb.name = dev->core->name;
	dev->ts_gen_cntrl = 0x0c;

	/* init frontend */
	switch (dev->core->board) {
[...]
	case CX88_BOARD_DVICO_FUSIONHDTV_5_GOLD:
		dev->ts_gen_cntrl = 0x08;
		{
		/* Do a hardware reset of chip before using it. */
		struct cx88_core *core = dev->core;

		cx_clear(MO_GP0_IO, 1);
		mdelay(100);
		cx_set(MO_GP0_IO, 1);
		mdelay(200);
		dev->core->pll_addr = 0x61;
		dev->core->pll_desc = &dvb_pll_tdvs_tua6034;
		dev->dvb.frontend = lgdt330x_attach(&fusionhdtv_5_gold,
						    &dev->core->i2c_adap);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is where we are passing the config struct (containing the callback functions) into the frontend module.

		}
		break;



... There is similar code in drivers/media/dvb/bt8xx/dvb-bt8xx.c (this is only in cvs right now... it will go to 2.6.15) :

static struct lgdt330x_config tdvs_tua6034_config = {
	.demod_address    = 0x0e,
	.demod_chip       = LGDT3303,
	.serial_mpeg      = 0x40, /* TPSERIAL for 3303 in TOP_CONTROL */
	.pll_set          = tdvs_tua6034_pll_set,
};

...as you might have noticed, the set_ts_params callback is not being set in this case.

	case BTTV_BOARD_DVICO_FUSIONHDTV_5_LITE:
		lgdt330x_reset(card);
		card->fe = lgdt330x_attach(&tdvs_tua6034_config, card->i2c_adapter);
		if (card->fe != NULL)
			dprintk ("dvb_bt8xx: lgdt330x detected\n");
		break;

The code above is how we set the callback and pass it into the calling module.  Now for actually calling it:

In drivers/media/dvb/frontends/lgdt330x.c:

here's the module attach function:

struct dvb_frontend* lgdt330x_attach(const struct lgdt330x_config* config,
				     struct i2c_adapter* i2c)
{
	struct lgdt330x_state* state = NULL;
	u8 buf[1];

	/* Allocate memory for the internal state */
	state = (struct lgdt330x_state*) kmalloc(sizeof(struct lgdt330x_state), GFP_KERNEL);
	if (state == NULL)
		goto error;
	memset(state,0,sizeof(*state));

	/* Setup the state */
	state->config = config;
	state->i2c = i2c;
	switch (config->demod_chip) {
	case LGDT3302:
		memcpy(&state->ops, &lgdt3302_ops, sizeof(struct dvb_frontend_ops));
		break;
	case LGDT3303:
		memcpy(&state->ops, &lgdt3303_ops, sizeof(struct dvb_frontend_ops));
		break;
	default:
		goto error;
	}

	/* Verify communication with demod chip */
	if (i2c_read_demod_bytes(state, 2, buf, 1))
		goto error;

	state->current_frequency = -1;
	state->current_modulation = -1;

	/* Create dvb_frontend */
	state->frontend.ops = &state->ops;
	state->frontend.demodulator_priv = state;
	return &state->frontend;

error:
	kfree(state);
	dprintk("%s: ERROR\n",__FUNCTION__);
	return NULL;
}

...and elsewhere in the code, we invoke the callback functions (after checking that they are set) like this:


		/* Select the requested mode */
		i2c_write_demod_bytes(state, top_ctrl_cfg,
				      sizeof(top_ctrl_cfg));
		if (state->config->set_ts_params)
			state->config->set_ts_params(fe, 0);

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ HERE

		state->current_modulation = param->u.vsb.modulation;
	}

	/* Tune to the specified frequency */
	if (state->config->pll_set)
		state->config->pll_set(fe, param);

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ AND HERE


SET_TS_PARAMS is not required in all implementations of this chip, but pll_set IS required in order to access the pll.


This is probably not the only way to get this done, but this is how we do it in the media tree.

I hope this helps...

-Michael Krufky



