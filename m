Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVFLDAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVFLDAI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 23:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVFLDAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 23:00:08 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:54332 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261349AbVFLDAB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 23:00:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IURui/V2XvBwj6jYtOXpnkxe0uNGK/uf/x/Dj6myix2rDqBvRw91VgAZtz9tDN9+dRkVf9KS0xklQXvOEnuboqIiGMqgGusJYWCQWSWLuiEtddSMt5kLuzk6/1nboAyOgGIqdVZOJwWd71GlcNk8Vn4hpp2QEkVk+nmDNJbbWrU=
Message-ID: <9e47339105061120007061d7b1@mail.gmail.com>
Date: Sat, 11 Jun 2005 23:00:00 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: off by one in sysfs
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs/file.c

static int 
fill_write_buffer(struct sysfs_buffer * buffer, const char __user *
buf, size_t count)
{
	int error;

	if (!buffer->page)
		buffer->page = (char *)get_zeroed_page(GFP_KERNEL);
	if (!buffer->page)
		return -ENOMEM;

	if (count >= PAGE_SIZE)
		count = PAGE_SIZE - 1;
	error = copy_from_user(buffer->page,buf,count);
	buffer->needs_read_fill = 1;
	return error ? -EFAULT : count;
}

count = PAGE_SIZE - 1;
should be 
count = PAGE_SIZE;

Even if your are trying to zero terminate which is unneeded when there
is a count, the count still needs to include the zero otherwise it is
inconsistent when count is less than PAGE_SIZE. Why get a zero page
too?

My attribute is a color_map described by 255 lines of 15 chars plus \n.

-- 
Jon Smirl
jonsmirl@gmail.com
