Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWH3Qfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWH3Qfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWH3Qfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:35:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:44442 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751149AbWH3Qfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:35:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WchV9wQKNjDmIQfBmZD2tjPS2AjJ+357eNMW7ITXKECLzALc1aLHt3sY2k80OkJomI/h/MtqQhqN8AqRl4kstQnyQBbXUUkEJo9hPe+zTP7eA4IDpFlJNmSqRgBInMlCKzZLW8FQr4/kQio0oQFd98v8CZkLsxL1kUGmRdZ1/HU=
Message-ID: <dc081bb90608300935h1d5346fbj742920754f4b4680@mail.gmail.com>
Date: Wed, 30 Aug 2006 11:35:44 -0500
From: "Gorka Guardiola" <paurealkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Buffer head async write
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to 	mark a buffer for async write, but I am  having a race condition
to unlock the buffer. I am doing.

        bh = getbmapst(bdev, nsect); //this function calls bread
	if (!bh) {
		printk(KERN_ALERT "I/O error, bitmap cannot be trusted\n");
		return -1;
	}
	
	lock_buffer(bh);	

	byte = bh->b_data + byteoffset;
	*byte |= 1 << bitoffset;
	lock_page(bh->b_page);
	mark_page_accessed(bh->b_page);
	__set_page_dirty_nobuffers(bh->b_page);
	unlock_page(bh->b_page);
	set_buffer_uptodate(bh);
	mark_buffer_dirty(bh);
	mark_buffer_async_write(bh);
	unlock_buffer(bh);
	brelse(bh);

What I want is the buffer head not to write synchronously when I do
the brelse, to
coalesce writes on it. It works normally, but this code has some form
of race condition.
The problem is that (in some circumstances, for example while using a
loop device against a file) this makes the fs/buffer.c:603
BUG_ON break. I am using the latest version of the kernel with SMP on a machine
with 4 processors.

Can anybody tell me what am I doing wrong?. I tried some other schemes, like
bit_spin_locking the BH_Uptodate_Lock, but it didn't work either.
