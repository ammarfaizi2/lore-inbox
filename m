Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVK1HzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVK1HzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 02:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVK1HzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 02:55:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:24315 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932118AbVK1HzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 02:55:07 -0500
Date: Mon, 28 Nov 2005 08:55:05 +0100
From: Juergen Quade <quade@hsnr.de>
To: Mohamed El Dawy <msdawy@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's wrong with this really simple function?
Message-ID: <20051128075505.GA7945@hsnr.de>
References: <afd776760511271057l5e3c4e3fq14b0b9ba4cdc7c9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afd776760511271057l5e3c4e3fq14b0b9ba4cdc7c9a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:62881f34614f951289f18c8df869d6ac
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 12:57:47PM -0600, Mohamed El Dawy wrote:
> Hi,
>  I have created this 5-liner system call, which basically opens a
> file, write "Hello World" to it, and then returns. That's all.
> 
> Now, when I actually call it, it creates the file successfully but
> writes nothing to it. The file is created and is only zero bytes. So,
> either write didn't write, or close didn't close. Any help would be
> greatly appreciated.
> ...

The following (module-) code will create and write a file from
inside a kernel. Ok -- you know -- you should not use it
without really good reasons ...

          Juergen.

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/fs.h>
#include <asm/uaccess.h>

static char filename[255];
module_param_string( filename, filename, sizeof(filename), 666 );
struct file *log_file;

static int __init mod_init(void)
{
	mm_segment_t oldfs;

	if( filename[0]=='\0' )
		strncpy( filename, "/tmp/kernel_file", sizeof(filename) );
	printk("opening filename: %s\n", filename);
	log_file = filp_open( filename, O_WRONLY | O_CREAT, 0644 );
	printk("log_file: %p\n", log_file );
	if( IS_ERR( log_file ) )
		return -EIO;

	oldfs = get_fs();
	set_fs( KERNEL_DS );
	vfs_write( log_file, "hallo\n", 6, &log_file->f_pos );
	set_fs( oldfs );
	filp_close( log_file, NULL );
	return 0;
}

static void __exit mod_exit(void)
{
}
module_init( mod_init );
module_exit( mod_exit );
MODULE_LICENSE("GPL");
/* vim:set ts=4 sw=4 ic aw: */
