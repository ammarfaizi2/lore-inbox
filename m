Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVJUShu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVJUShu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbVJUSht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:37:49 -0400
Received: from magic.adaptec.com ([216.52.22.17]:31113 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965078AbVJUShq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:37:46 -0400
Message-ID: <43593569.1090000@adaptec.com>
Date: Fri, 21 Oct 2005 14:37:29 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: dougg@torque.net, andrew.patterson@hp.com, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <43587F74.6080600@torque.net> <4358887C.6020200@pobox.com>
In-Reply-To: <4358887C.6020200@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 18:37:34.0025 (UTC) FILETIME=[807B7B90:01C5D66E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05 02:19, Jeff Garzik wrote:
> With the inevitable result that most ioctl code is poorly written, and 
> causes bugs and special case synchronization problems :)  Driver writers 
> love to stuff way too much stuff into ioctls, without thinking about 
> overall design.

Could you please use adjectives, like "some" or "all" before
"Device writers"?  Could you also use a qualifier like, "excluding me",
etc.  Thanks.

> Only for the most simple interfaces.  sysfs is for exporting kernel data 
> structures to userspace, using read(2) and write(2).  You can quite 
> literally accomplish anything with that.  sysfs could export an event 
> directory entry, and a response directory entry.  The response dirent 
> could provide all the error reporting you could ever want.  That's just 
> a 2-second off-the-cuff example.

For the 3-second "off-the-cuff example" see how the "smp_portal" sysfs
binary attribute works in drivers/scsi/sas/sas_expander.c at the bottom
of the file, whereby user space first writes and then reads as much data
it is expecting.

(Thus there is _no_ hardcoding of the amount of data SMP request can
return (as is done in SDI).)

Here are the tiny functions for refresh:

/* ---------- SMP portal ---------- */

static ssize_t smp_portal_write(struct kobject *kobj, char *buf, loff_t offs,
				size_t size)
{
	struct domain_device *dev = to_dom_device(kobj);
	struct expander_device *ex = &dev->ex_dev;

	if (offs != 0)
		return -EFBIG;
	else if (size == 0)
		return 0;

	down_interruptible(&ex->smp_sema);
	if (ex->smp_req)
		kfree(ex->smp_req);
	ex->smp_req = kzalloc(size, GFP_USER);
	if (!ex->smp_req) {
		up(&ex->smp_sema);
		return -ENOMEM;
	}
	memcpy(ex->smp_req, buf, size);
	ex->smp_req_size = size;
	ex->smp_portal_pid = current->pid;
	up(&ex->smp_sema);

	return size;
}

static ssize_t smp_portal_read(struct kobject *kobj, char *buf, loff_t offs,
			       size_t size)
{
	struct domain_device *dev = to_dom_device(kobj);
	struct expander_device *ex = &dev->ex_dev;
	u8 *smp_resp;
	int res = -EINVAL;

	down_interruptible(&ex->smp_sema);
	if (!ex->smp_req || ex->smp_portal_pid != current->pid ||
	    offs != ex->smp_req_size)
		goto out;

	res = 0;
	if (size == 0)
		goto out;

	res = -ENOMEM;
	smp_resp = alloc_smp_resp(size);
	if (!smp_resp)
		goto out;
	res = smp_execute_task(dev, ex->smp_req, ex->smp_req_size,
			       smp_resp, size);
	if (!res) {
		memcpy(buf, smp_resp, size);
		res = size;
	}

	kfree(smp_resp);
out:
	kfree(ex->smp_req);
	ex->smp_req = NULL;
	ex->smp_req_size = 0;
	ex->smp_portal_pid = -1;
	up(&ex->smp_sema);
	return res;
}

> Note, I'm _not_ suggesting this is the best route for an SMP interface, 
> just stating sysfs generalities.  sysfs is flexible enough that it could 
> completely replace SG_IO (though that would not be a wise idea).

Indeed, sysfs _is_ very flexible, and with a single process open(2) it could
satisfy the transaction needed functionality.

	Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
