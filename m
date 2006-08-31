Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWHaHkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWHaHkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 03:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWHaHkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 03:40:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1190 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751212AbWHaHky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 03:40:54 -0400
Date: Thu, 31 Aug 2006 00:40:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-Id: <20060831004049.65924fe3.akpm@osdl.org>
In-Reply-To: <20060830062338.GA10285@kroah.com>
References: <20060830062338.GA10285@kroah.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 23:23:38 -0700
Greg KH <greg@kroah.com> wrote:

> +static ssize_t store_sig_pid(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	iio_dummy_signal.pid = simple_strtol(buf, NULL, 10);
> +	if (iio_dummy_signal.pid == 0) {
> +		if (iio_dummy_signal.it_process) {
> +			put_task_struct(iio_dummy_signal.it_process);
> +			iio_dummy_signal.it_process = NULL;
> +		}
> +
> +		iio_dummy_signal.pid = 0;
> +		return count;
> +	}
> +
> +	if (iio_dummy_signal.pid == 1)
> +		goto out;
> +
> +	iio_dummy_signal.it_process = find_task_by_pid(iio_dummy_signal.pid);
> +	if (iio_dummy_signal.it_process) {
> +		get_task_struct(iio_dummy_signal.it_process);
> +		iio_dummy_signal.it_sigev_notify = SIGEV_SIGNAL;
> +		iio_dummy_signal.it_sigev_signo = SIGALRM;
> +		iio_dummy_signal.it_sigev_value.sival_int = 0;
> +
> +		return count;
> +	}
> +out:
> +	iio_dummy_signal.pid = 0;
> +	return -EINVAL;
> +}

This is racy: find_task_by_pid() needs tasklist_lock or rcu_read_lock().

It doesn't work as a module due to missing __put_task_struct.


It is also rather nasty.  Why go shoving some random pid into a sysfs file,
then hang onto a ref on a task_struct for some process which exitted last
week?  It would be cleaner and more idiomatic to require that the
controlling process hold an fd open against the instance so that resources
can be managed correctly.  Maybe use SIGIO too, so the driver doesn't need
to know about pids and task_structs and things.  Which all maps better onto
ioctls than sysfs (ties self to stake)

<looks>

iio_dev.c seems to already be doing this.  Why does iio_dummy.c exist?
