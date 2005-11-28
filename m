Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVK1MqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVK1MqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 07:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVK1MqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 07:46:08 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:62166 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932076AbVK1MqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 07:46:07 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17290.64538.843580.695349@gargle.gargle.HOWL>
Date: Mon, 28 Nov 2005 15:46:18 +0300
To: Juergen Quade <quade@hsnr.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's wrong with this really simple function?
Newsgroups: gmane.linux.kernel
In-Reply-To: <20051128075505.GA7945@hsnr.de>
References: <afd776760511271057l5e3c4e3fq14b0b9ba4cdc7c9a@mail.gmail.com>
	<20051128075505.GA7945@hsnr.de>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Quade writes:
 > On Sun, Nov 27, 2005 at 12:57:47PM -0600, Mohamed El Dawy wrote:
 > > Hi,
 > >  I have created this 5-liner system call, which basically opens a
 > > file, write "Hello World" to it, and then returns. That's all.
 > > 
 > > Now, when I actually call it, it creates the file successfully but
 > > writes nothing to it. The file is created and is only zero bytes. So,
 > > either write didn't write, or close didn't close. Any help would be
 > > greatly appreciated.
 > > ...
 > 
 > The following (module-) code will create and write a file from
 > inside a kernel. Ok -- you know -- you should not use it
 > without really good reasons ...
 > 
 >           Juergen.
 > 
 > #include <linux/module.h>
 > #include <linux/moduleparam.h>
 > #include <linux/fs.h>
 > #include <asm/uaccess.h>
 > 
 > static char filename[255];
 > module_param_string( filename, filename, sizeof(filename), 666 );
 > struct file *log_file;
 > 
 > static int __init mod_init(void)
 > {
 > 	mm_segment_t oldfs;
 > 
 > 	if( filename[0]=='\0' )
 > 		strncpy( filename, "/tmp/kernel_file", sizeof(filename) );
 > 	printk("opening filename: %s\n", filename);
 > 	log_file = filp_open( filename, O_WRONLY | O_CREAT, 0644 );
 > 	printk("log_file: %p\n", log_file );
 > 	if( IS_ERR( log_file ) )
 > 		return -EIO;

This code is trivially exploitable: /tmp is usually a world-writable
directory, and everybody can do

$ ln -s /etc/shadow /tmp/kernel_file

or even

$ ln /etc/shadow /tmp/kernel_file

provided that /tmp and /etc are on the same file system.

Please do not use it.

Nikita.
