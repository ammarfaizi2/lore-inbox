Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWGIBTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWGIBTP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 21:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWGIBTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 21:19:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:17289 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161031AbWGIBTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 21:19:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kX2p8opjc3x0Ozkt6Ozb6/hM6vOpN6q1ifSYpfhUZMSqfE/0tWNATOq5pCw++19n7pGqo+SUyGzWgJqLwX/N857W4iNz0AlaIOws0zCGovWj5SMrCFN4iyzYfCvHK7i9Hwr79C6kdYMyL+79Xvby+9cZV6ZQpy7ooavdT4saq/w=
Message-ID: <abcd72470607081819j30e775cdx6cc8841e43f49373@mail.gmail.com>
Date: Sat, 8 Jul 2006 18:19:13 -0700
From: "Avinash Ramanath" <avinashr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Zeroing data blocks
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to zero data blocks whenever an unlink is invoked as part
of a secure delete filesystem.
I tried to zero the file by writing a buffer (of file size) with
zeroes onto the file.
But the system hangs.
I see the printk "In page_left loop" being printed, but nothing after that.
Could someone let me know what might be happening with the code below?
Also could you recommend me what is the best operation for writing
zeroes onto a file?

Thanks,
Avinash.

I saw that the file size is 12, with page_number being 0 and page_left 12.

Code:
=====

int overwrite(dentry_t *dentry, int overwrite_num)
{
        int err = 0;
	int n, m;
	file_t *fip, *fop;
	char *readbuf, *writebuf;
	mm_segment_t oldfs;
	int size = 0;
	int page_number, page_left;
	int i, j;
	oldfs.seg = 0;

	printk("overwrite number is %d\n", overwrite_num);
	printk("Overwriting file name %s\n", dentry->d_name.name);
	fip = filp_open(dentry->d_name.name, O_RDONLY, 0);
	if(!S_ISREG(fip->f_dentry->d_inode->i_mode))
	{
		printk("%s is not a regular file\n", dentry->d_name.name);
		err = -EINVAL;
		goto error;
	}
	if(!fip || IS_ERR(fip))
	{
		err = -EPERM;
		printk("Cannot open input file\n");
		goto error;
	}
	if(!fip->f_op->read)
	{
		err = -EPERM;
		printk("Cannot read from input file\n");
		goto error;
	}		
	fop = filp_open(dentry->d_name.name, O_WRONLY, 0);
	if(!S_ISREG(fop->f_dentry->d_inode->i_mode))
	{
		printk("%s is not a regular file\n", dentry->d_name.name);
		err = -EINVAL;
		goto error;
	}
	if(!fop || IS_ERR(fop))
	{
		err = -EPERM;
		printk("Cannot open input file\n");
		goto error;
	}
	if(!fop->f_op->write)
	{
		err = -EPERM;
		printk("Cannot write to input file\n");
		goto error;
	}		
	fip->f_pos = 0;
	fop->f_pos = 0;
	oldfs = get_fs();
	set_fs(KERNEL_DS);
	readbuf = kmalloc(PAGE_CACHE_SIZE,GFP_KERNEL);
	if( !readbuf)
	{
		err = -ENOMEM;
		printk("Could not allocate buffer for reading\n");
		goto error;
	}
	writebuf = kmalloc(PAGE_CACHE_SIZE,GFP_KERNEL);
	if( !writebuf)
	{
		err = -ENOMEM;
		printk("Could not allocate buffer for writing\n");
		goto error;
	}
	printk("After allocating read/write buffers\n");
	memset(readbuf,0,PAGE_CACHE_SIZE);
	memset(writebuf,0,PAGE_CACHE_SIZE);
	printk("After memsetting...\n");
	while((n=fip->f_op->read(fip,readbuf,PAGE_CACHE_SIZE,&fip->f_pos))>0)
	{
		size += n;
	}
	if (fip) fput(fip);
	printk("After reading...\n");

	page_number = size / PAGE_CACHE_SIZE;
	page_left = size % PAGE_CACHE_SIZE;
	printk("After reading the file, size is %d, page_number is %d,
page_left is %d\n", size, page_number, page_left);
	for (i=0; i < overwrite_num; i++)
	{
		printk("In I loop i is %d\n", i);
		for (j=0; j < page_number; j++)
		{
			printk("In J loop, j is %d\n", j);
			if ((m=(fop->f_op->write(fop,writebuf,PAGE_CACHE_SIZE,&fop->f_pos))) < 0)
			{
				err = -EPERM;
				printk("Could not write zeroes to the file\n");
				goto error;
			}
			printk("After writing\n");
		}
		printk("After I loop\n");
		if (page_left)
		{
			printk("In page_left loop\n");
			if ((m=(fop->f_op->write(fop,writebuf,page_left,&fop->f_pos))) < 0)
			{
				err = -EPERM;	
				printk("Could not write zeroes to the file\n");
			}
			printk("After writing zeroes\n");
		}
		printk("setting f_pos to zero\n");
		fop->f_pos = 0;
		printk("After setting f_pos to zero\n");
	}
	printk("After for loop...\n");
	if (fop) fput(fop);
	printk("After putting fop\n");
	if (writebuf) kfree(writebuf);
	printk("After freeing writebuf\n");
	if (readbuf) kfree(readbuf);
	printk("After freeing readbuf\n");
	printk("After overwriting file...\n");
	error:
	set_fs(oldfs);
	return err;
}
