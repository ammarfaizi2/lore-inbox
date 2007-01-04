Return-Path: <linux-kernel-owner+w=401wt.eu-S932208AbXADA04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbXADA04 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbXADA04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:26:56 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35217 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932208AbXADA0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:26:55 -0500
Date: Wed, 3 Jan 2007 16:26:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
Message-Id: <20070103162643.5c479836.akpm@osdl.org>
In-Reply-To: <459C4038.6020902@redhat.com>
References: <459C4038.6020902@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jan 2007 17:46:00 -0600
Eric Sandeen <sandeen@redhat.com> wrote:

> Take 2... all in one file.  I suppose I really did know better than 
> to create that new header.   ;-) 
> 
> Better?
> 
> ---
> 
> CVE-2006-5753 is for a case where an inode can be marked bad, switching 
> the ops to bad_inode_ops, which are all connected as:
> 
> static int return_EIO(void)
> {
>         return -EIO;
> }
> 
> #define EIO_ERROR ((void *) (return_EIO))
> 
> static struct inode_operations bad_inode_ops =
> {
>         .create         = bad_inode_create
> ...etc...
> 
> The problem here is that the void cast causes return types to not be 
> promoted, and for ops such as listxattr which expect more than 32 bits of
> return value, the 32-bit -EIO is interpreted as a large positive 64-bit 
> number, i.e. 0x00000000fffffffa instead of 0xfffffffa.
> 
> This goes particularly badly when the return value is taken as a number of
> bytes to copy into, say, a user's buffer for example...
> 
> I originally had coded up the fix by creating a return_EIO_<TYPE> macro
> for each return type, like this:
> 
> static int return_EIO_int(void)
> {
> 	return -EIO;
> }
> #define EIO_ERROR_INT ((void *) (return_EIO_int))
> 
> static struct inode_operations bad_inode_ops =
> {
> 	.create		= EIO_ERROR_INT,
> ...etc...
> 
> but Al felt that it was probably better to create an EIO-returner for each 
> actual op signature.  Since so few ops share a signature, I just went ahead 
> & created an EIO function for each individual file & inode op that returns
> a value.
> 

Al is correct, of course.  But the patch takes bad_inode.o from 280 up to 703
bytes, which is a bit sad for some cosmetic thing which nobody ever looks
at or modifies.

Perhaps you can do

static int return_EIO_int(void)
{
	return -EIO;
}

static int bad_file_release(struct inode * inode, struct file * filp)
	__attribute__((alias("return_EIO_int")));
static int bad_file_fsync(struct inode * inode, struct file * filp)
	__attribute__((alias("return_EIO_int")));

etcetera?
