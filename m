Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbUKTKO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUKTKO6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 05:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbUKTKO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 05:14:58 -0500
Received: from canuck.infradead.org ([205.233.218.70]:62983 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261545AbUKTKOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 05:14:20 -0500
Subject: Re: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
From: Arjan van de Ven <arjan@infradead.org>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: greg@kroah.com, phil@netroedge.com, khali@linux-fr.org,
       sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041118185612.GA20728@penguincomputing.com>
References: <20041102221745.GB18020@penguincomputing.com>
	 <NN38qQl1.1099468908.1237810.khali@gcu.info>
	 <20041103164354.GB20465@penguincomputing.com>
	 <20041118185612.GA20728@penguincomputing.com>
Content-Type: text/plain
Message-Id: <1100945635.2639.31.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 20 Nov 2004 11:13:56 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?ip=80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 10:56 -0800, Justin Thiessen wrote:
> MODULE_PARM(gpio_input,"1-17i");

new 2.6 drivers should NOT use MODULE_PARM, it's deprecated.
use module_param() instead

> int adm1026_attach_adapter(struct i2c_adapter *adapter)
> {
> 	if (!(adapter->class & I2C_CLASS_HWMON)) {
> 		return 0;
> 	}

no need for extra { }'s in such a case


> static ssize_t show_in(struct device *dev, char *buf, int nr)
> {
> 	struct adm1026_data *data = adm1026_update_device(dev);
> 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]));
> }

any chance you could make this use snprintf instead ?

> static ssize_t show_in_max(struct device *dev, char *buf, int nr)
> {
> 	struct adm1026_data *data = adm1026_update_device(dev);
> 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_max[nr]));
> }

same question

> static ssize_t store_pwm_reg(struct i2c_client *client, 
> 		struct adm1026_data *data, size_t count)
> {
> 	adm1026_write_value(client, ADM1026_REG_PWM, data->pwm1.pwm);
> 	up(&data->update_lock);
> 	return count;
> }
> static ssize_t set_pwm_reg(struct device *dev, const char *buf,
> 		size_t count)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct adm1026_data *data = i2c_get_clientdata(client);
> 	int     val;
> 
> 	if (data->pwm1.enable == 1) {
> 		down(&data->update_lock);
> 		val = simple_strtol(buf, NULL, 10);
> 		data->pwm1.pwm = PWM_TO_REG(val);
> 		return store_pwm_reg(client, data, count);
> 	}

this locking construct is rahter awkward; is it possible to refactor the
code such that you can down and up in the same function ?



> static ssize_t store_auto_pwm_min(struct i2c_client *client, 
> 		struct adm1026_data *data, size_t count)
> {
> 	data->pwm1.pwm = PWM_TO_REG((data->pwm1.pwm & 0x0f) |
> 		PWM_MIN_TO_REG(data->pwm1.auto_pwm_min)); 
> 	adm1026_write_value(client, ADM1026_REG_PWM, data->pwm1.pwm);
> 	up(&data->update_lock);
> 	return count;
> }
> static ssize_t set_auto_pwm_min(struct device *dev, const char *buf,
> 		size_t count)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct adm1026_data *data = i2c_get_clientdata(client);
> 	int     val;
> 
> 	down(&data->update_lock);
> 	val = simple_strtol(buf, NULL, 10);
> 	data->pwm1.auto_pwm_min = SENSORS_LIMIT(val,0,255);
> 	if (data->pwm1.enable == 2) { /* apply immediately */
> 		return store_auto_pwm_min(client, data, count);
> 	} else { /* wait til automatic fan control is enabled to apply */
> 		up(&data->update_lock);
> 		return count;
> 	}
> }

... here the same construct but even more awkward



