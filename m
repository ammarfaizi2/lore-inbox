Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUIAXoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUIAXoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUIAXll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:41:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:38020 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267408AbUIAXbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:31:31 -0400
Date: Wed, 1 Sep 2004 16:34:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Simon Derr <Simon.Derr@bull.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Possible race in sysfs_read_file() and
 sysfs_write_file()
Message-Id: <20040901163436.263802bc.akpm@osdl.org>
In-Reply-To: <Pine.A41.4.53.0409010924250.122970@isabelle.frec.bull.fr>
References: <Pine.A41.4.53.0409010924250.122970@isabelle.frec.bull.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Derr <Simon.Derr@bull.net> wrote:
>
> I think there is a possibility for two threads from a single process to
> race in sysfs_read_file() if they call read() on the same file at the same
> time.

I think there is, too.

I also wonder what happens if the first read of a sysfs file is not at
offset zero (eg: pread()):

static ssize_t
sysfs_read_file(struct file *file, char __user *buf, size_t count, loff_t *ppos)
{
	struct sysfs_buffer * buffer = file->private_data;
	ssize_t retval = 0;

	if (!*ppos) {
		if ((retval = fill_read_buffer(file->f_dentry,buffer)))


we seem to not allocate the buffer at all?
