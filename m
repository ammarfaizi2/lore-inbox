Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbULJQT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbULJQT4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbULJQT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:19:56 -0500
Received: from main.gmane.org ([80.91.229.2]:31105 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261750AbULJQTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:19:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Date: Fri, 10 Dec 2004 11:19:28 -0500
Message-ID: <87pt1i15yn.fsf@coraid.com>
References: <87acsrqval.fsf@coraid.com>
	<1102349564.2721.103.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Cc: Arjan van de Ven <arjan@fenrus.demon.nl>
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:evB2LrTkonvBdIq12hnyHGqPxtk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@fenrus.demon.nl> writes:

[helpful suggestions]
...
>> +struct Aoedev {
>> +	Aoedev *next;
>> +	uchar addr[6];		/* remote mac addr */
>> +	ushort flags;
>> +	ulong sysminor;
>> +	ulong aoemajor;
>> +	ulong aoeminor;
>
> sounds like the wrong type, why not use dev_t ?

These are ATA over Ethernet major and minor addresses, not device node
major and minor numbers.

>> +	ulong nopen;		/* user count */
>
> why do you need this ?
>
>> +static int
>> +aoeblk_release(struct inode *inode, struct file *filp)
>> +{
>> +	Aoedev *d;
>> +	ulong flags;
>> +
>> +	d = (Aoedev *) inode->i_bdev->bd_disk->private_data;
>> +
>> +	spin_lock_irqsave(&d->lock, flags);
>> +	if (--d->nopen == 0)
>
> eh why not just a ->release function instead that uses the blocklayer
> refcounting instead of doing your own ?

Do you just mean we should use inode->i_bdev->bd_openers instead of
having d->nopen?

>> +int
>> +aoeblk_make_request(request_queue_t *q, struct bio *bio)
>> +{
>> +	Aoedev *d;
>> +	Buf *buf;
>> +	struct sk_buff *sl;
>> +	ulong flags;
>> +
>> +	blk_queue_bounce(q, &bio);
>> +
>> +	buf = kallocz(sizeof *buf, GFP_KERNEL);
>
> this is deadlocky; you HAVE to use a mempool for allocations here!

OK.  Thanks for pointing that out.

-- 
  Ed L Cashin <ecashin@coraid.com>

