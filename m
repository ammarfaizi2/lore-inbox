Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263449AbVCEANF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbVCEANF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263421AbVCEAIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:08:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:1221 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263287AbVCDWGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:06:10 -0500
Date: Fri, 4 Mar 2005 14:01:19 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050304220116.GA1201@kroah.com>
References: <42225A47.3060206@us.ltcfwd.linux.ibm.com> <20050228063954.GB23595@kroah.com> <4228CE41.2000102@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4228CE41.2000102@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 04:08:17PM -0500, Wen Xiong wrote:
> +int get_jsm_board_number(void)
> +{
> +        struct list_head *tmp;
> +        struct jsm_board *cur_board_entry;
> +        int adapter_count = 0;
> +        u64 lock_flags;
> +
> +        spin_lock_irqsave(&jsm_board_head_lock, lock_flags);
> +        list_for_each(tmp, &jsm_board_head) {
> +        cur_board_entry =
> +                list_entry(tmp, struct jsm_board,
> +                        jsm_board_entry);
> +                adapter_count++;
> +        }
> +        spin_unlock_irqrestore(&jsm_board_head_lock, lock_flags);
> +
> +        return adapter_count;
> +}

Should this be static?

And it's returning the number of boards, not the current board number,
right?

And you have a indenting error in the list_for_each() section...

> +static ssize_t jsm_driver_version_show(struct device_driver *ddp, char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "jsm_version: %s\n", "jsm: 1.1-1-INKERNEL");

Shouldn't that value also be in MODULE_VERSION()?  And if so, it should
be a #define somewhere.

Also, don't put "jsm:" in your sysfs files, the file name describes what
the value should be.  That goes for a lot of your sysfs files.

> +static ssize_t jsm_driver_debug_show(struct device_driver *ddp, char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "0x%x\n", debug);
> +}

"debug" is not a nice variable to have in the global namespace :(

Also, why not just make this a module paramater, that way it can be
modified through that interface, and you don't have to create your own?

> +#define JSM_VERIFY_BOARD(p, bd)				\
> +	if (!p)						\
> +		return 0;				\
> +	bd = (struct jsm_board *)dev_get_drvdata(p);	\

Cast is not needed.

> +	if (!bd)					\
> +		return 0;				\
> +	if (bd->state != BOARD_READY)			\
> +		return 0;				\

Don't break out of functions from within a macro.  Will cause headaches
for people reviewing your code in the future.

And shouldn't you be returning an error if one of these checks fail?

> +static ssize_t jsm_ports_state_show(struct device *p, char *buf)
> +{
> +	struct jsm_board *bd;
> +	int count = 0;
> +	int i = 0;
> +
> +	JSM_VERIFY_BOARD(p, bd);
> +
> +	for (i = 0; i < bd->nasync; i++) {
> +		count += snprintf(buf + count, PAGE_SIZE - count,
> +			"%d %s\n", bd->channels[i]->ch_portnum,
> +			bd->channels[i]->ch_open_count ? "Open" : "Closed");
> +	}
> +	return count;

No, make this a per-port value.  You are showing more than one value in
a single file.  You do this for a few other sysfs files :(

And who cares about this value?

> +static ssize_t jsm_ports_baud_show(struct device *p, char *buf)
> +{
> +	struct jsm_board *bd;
> +	int count = 0;
> +	int i = 0;
> +
> +	JSM_VERIFY_BOARD(p, bd);
> +
> +	for (i = 0; i < bd->nasync; i++) {
> +		count +=  snprintf(buf + count, PAGE_SIZE - count,
> +			"%d %d\n", bd->channels[i]->ch_portnum, bd->channels[i]->ch_old_baud);
> +	}
> +	return count;
> +}
> +static DEVICE_ATTR(ports_baud, S_IRUSR, jsm_ports_baud_show, NULL);

What's wrong with the standard tty ioctls that return this value, and
the other values you are exporting through sysfs?  What is all of this
data needed for?

> +#define JSM_VERIFY_CHANNEL(p, ch)			\
> +	if (!p)						\
> +		return 0;				\
> +	ch = (struct jsm_channel *)class_get_devdata(p);\
> +	if (!ch)					\
> +		return 0;				\
> +	if (ch->ch_bd->state != BOARD_READY)		\
> +		return 0;				\

Again, don't put return in a macro, and return an error if there really
is one.

thanks,

greg k-h
