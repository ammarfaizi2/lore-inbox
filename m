Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUFVKzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUFVKzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 06:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUFVKzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 06:55:47 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:29062 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262329AbUFVKzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 06:55:44 -0400
Date: Tue, 22 Jun 2004 19:57:00 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 1/4]Diskdump Update
In-reply-to: <20040621080129.GA27569@devserv.devel.redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org
Message-id: <E2C45847A4B0C6indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040621080129.GA27569@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004 10:01:29 +0200, Arjan van de Ven wrote:

>> On Fri, 11 Jun 2004 13:50:45 +0200, Arjan van de Ven wrote:
>> 
>> >> +#ifdef CONFIG_PROC_FS
>> >> +static int proc_ioctl(struct inode *inode, struct file *file, unsigned 
>> >> int cmd, unsigned long param)
>> >
>> >
>> >ehhh this looks evil
>> 
>> Do you mean I should use not ioctl but the following style?
>> 
>> echo "add /dev/hda1" > /proc/diskdump
>> echo "delete /dev/hda1" > /proc/diskdump
>
>well no since /dev/hda is pointless; major/minor pairs maybe.
>But why in /proc???? it sounds like a sysfs job to me, where you probably
>want to represent a dump relationship with a symlink, and use "rm" to remove
>an entry..

Plural devices(partitions) can be registered to the diskdump as dump
device, so it seems difficult to represent a dump relationship with a 
symlink.

Possible idea is adding new attribute to somewhere of sysfs entry,
for example /sys/block/sda/sda1/dumpdev.
When new device is added, echo 1 to this entry.
# echo 1 > /sys/block/sda/sda1/dumpdev

Its store function is as follows.

static ssize_t store(struct kobject * kobj, struct attribute * attr, 
                     const char * buf, size_t count)
{
        ssize_t ret;
        struct gendisk *disk = 
        	container_of(p->kobj.parent, struct gendisk, kobj);

        return dump_register_device(disk);
}

The problem is how to get scsi_device from gendisk.

It seems that the method using sysfs is more complex than current method
using proc...
It may be better to use simply module parameter like netdump.

Best Regards,
Takao Indoh
