Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWGZKbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWGZKbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWGZKbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:31:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932293AbWGZKbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:31:45 -0400
Date: Wed, 26 Jul 2006 03:31:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, drepper@redhat.com,
       netdev@vger.kernel.org
Subject: Re: [1/4] kevent: core files.
Message-Id: <20060726033105.7cd173b8.akpm@osdl.org>
In-Reply-To: <11539054952689@2ka.mipt.ru>
References: <11539054941027@2ka.mipt.ru>
	<11539054952689@2ka.mipt.ru>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006 13:18:15 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> +static int kevent_ctl_process(struct file *file, 
> +		struct kevent_user_control *ctl, void __user *arg)
> +{
> +	int err;
> +	struct kevent_user *u = file->private_data;
> +
> +	if (!u)
> +		return -EINVAL;
> +
> +	switch (ctl->cmd) {
> +		case KEVENT_CTL_ADD:
> +			err = kevent_user_ctl_add(u, ctl, 
> +					arg+sizeof(struct kevent_user_control));
> +			break;
> +		case KEVENT_CTL_REMOVE:
> +			err = kevent_user_ctl_remove(u, ctl, 
> +					arg+sizeof(struct kevent_user_control));
> +			break;
> +		case KEVENT_CTL_MODIFY:
> +			err = kevent_user_ctl_modify(u, ctl, 
> +					arg+sizeof(struct kevent_user_control));
> +			break;
> +		case KEVENT_CTL_WAIT:
> +			err = kevent_user_wait(file, u, ctl, arg);
> +			break;
> +		case KEVENT_CTL_INIT:
> +			err = kevent_ctl_init();
> +		default:
> +			err = -EINVAL;
> +			break;
> +	}
> +
> +	return err;
> +}

Please indent the body of the switch one tabstop to the left.

> +asmlinkage long sys_kevent_ctl(int fd, void __user *arg)
> +{
> +	int err, fput_needed;
> +	struct kevent_user_control ctl;
> +	struct file *file;
> +
> +	if (copy_from_user(&ctl, arg, sizeof(struct kevent_user_control)))
> +		return -EINVAL;
> +
> +	if (ctl.cmd == KEVENT_CTL_INIT)
> +		return kevent_ctl_init();
> +
> +	file = fget_light(fd, &fput_needed);
> +	if (!file)
> +		return -ENODEV;
> +
> +	err = kevent_ctl_process(file, &ctl, arg);
> +
> +	fput_light(file, fput_needed);
> +	return err;
> +}

If the user passes this an fd which was obtained via means other than
kevent_ctl_init(), the kernel will explode.  Do

	if (file->f_fop != &kevent_user_fops)
		return -EINVAL;

