Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263629AbUFMKbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUFMKbg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 06:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264983AbUFMKbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 06:31:33 -0400
Received: from web25103.mail.ukl.yahoo.com ([217.12.10.51]:28540 "HELO
	web25103.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263629AbUFMKb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 06:31:28 -0400
Message-ID: <20040613103127.57355.qmail@web25103.mail.ukl.yahoo.com>
Date: Sun, 13 Jun 2004 11:31:27 +0100 (BST)
From: =?iso-8859-1?q?Shaun=20Colley?= <shaunige@yahoo.co.uk>
Subject: i2c device driver bugs
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I wanted to discuss this a little, so I sent the bug
reports here.  This will avoid me writing a complete
bug report, especially if a bug doesn't exist.  I'd
like your opinions on these bugs.



drivers/i2c/i2c-dev.c
i2cdev_ioctl()
Integer overflow
-----------------------

There seems to be a possible integer overflow, which
can come into play when allocating memory.  See below:

--
case I2C_RDWR:
                if (copy_from_user(&rdwr_arg,
                                   (struct
i2c_rdwr_ioctl_data *)arg,
                                   sizeof(rdwr_arg)))
                        return -EFAULT;

                rdwr_pa = (struct i2c_msg *)
                        kmalloc(rdwr_arg.nmsgs *
sizeof(struct i2c_msg),
                        GFP_KERNEL);

                if (rdwr_pa == NULL) return -ENOMEM;

                res = 0;
                for( i=0; i<rdwr_arg.nmsgs; i++ )
                {

[...]
--

As the code shows, the problem exists when parsing the
I2C_RDWR ioctl option.  It seems like an integer
overflow could occur in the below line:

kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg),
                        GFP_KERNEL);

If rdwr_arg_nmsgs held a number which is not
representable when multiplied by sizeof(struct
i2c_msg), an integer overflow could occur.  Since
rdwr_arg.nmsgs is user-supplied, this could warrant a
problem, especially since the integer overflow occurs
during the allocation in memory.

As far as I can tell, the for() loop following the
memory allocation could cause for data to be written
past the allocated memory, since the integer overflow
is likely to have caused too little memory to have
been allocated -- this could warrant a security
problem, if a bug exists as I've interpreted.


drivers/i2c/i2c-core.c
i2cproc_bus_read()
Integer overflow
-----------------------

There is a possible integer overflow problem when
allocating a chunk of memory:

[...]

if (count > 4096)
                return -EINVAL;

[...]

/* We need a bit of slack in the kernel buffer; this
makes the
                   sprintf safe. */
                        if (! (kbuf = kmalloc(count +
80,GFP_KERNEL)))
                                return -ENOMEM;

[...]

---

Although checks are made to ensure that the 'count'
variable doesn't exceed 4096, no checks are made for
negative numbers.  Since kmalloc() takes it count
argument as an unsigned int, a negative number would
be represented as a very large number.  Then, 80 is
added to this number to allocate a would-be large
chunk of memory, but by adding 80, an integer overflow
can occur.  For example, if -1 was passed as count,
kmalloc() would interpret the number as 0xffffffff +
80, which would definitely cause an integer overflow. 
This could cause too little memory to be allocated --
this would cause a problem, since the following
sprintf() calls will almost definately write past the
allocated memory.  Again, this might be a security
issue.


Are any of these bugs likely to be an issue?  I'd like
to hear your comments please :)

(please CC me, I'm not subscribed to the list)




Thank you for your time.
Shaun.





	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - sooooo many all-new ways to express yourself http://uk.messenger.yahoo.com
