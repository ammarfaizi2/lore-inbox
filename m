Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279591AbRKATON>; Thu, 1 Nov 2001 14:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279589AbRKATNz>; Thu, 1 Nov 2001 14:13:55 -0500
Received: from saga5.Stanford.EDU ([171.64.15.135]:50675 "EHLO
	saga5.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S279588AbRKATNq>; Thu, 1 Nov 2001 14:13:46 -0500
Date: Thu, 1 Nov 2001 11:13:38 -0800 (PST)
From: Ken Ashcraft <kash@stanford.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [CHECKER] Is this a bug?
Message-ID: <Pine.GSO.4.33.0111011058500.10726-100000@saga5.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to figure out if the following is a bug, but I don't understand
well enough how files work.  This type of bug would be a security hole.
The user length "cmd" gets passed in to the sys_ioctl call. From there, if
it does not match one of the case statements, it is passed to a function
pointer.  Here is where I'm hung up: I think a potential function for that
function pointer is ip2_ipl_ioctl-- I think this because it is assigned to
the ioctl field of a file_operations struct at one place in the code:

/* 2.4.12/drivers/char/ip2main.c */
/* This is the driver descriptor for the ip2ipl device, which is used to
 * download the loadware to the boards.
 */
static struct file_operations ip2_ipl = {
	owner:		THIS_MODULE,
	read:		ip2_ipl_read,
	write:		ip2_ipl_write,
	ioctl:		ip2_ipl_ioctl,
	open:		ip2_ipl_open,
};

ip2_ipl_ioctl does not treat its command argument safely as shown below.

Here are the excerpts from the code:

/* 2.4.9-ac9/fs/ioctl.c:sys_ioctl */
asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long
arg)
{
	...
	switch (cmd) {
	...
	default:
		error = -ENOTTY;
		if (S_ISREG(filp->f_dentry->d_inode->i_mode))
			error = file_ioctl(filp, cmd, arg);
		else if (filp->f_op && filp->f_op->ioctl)
Call --->
			error = filp->f_op->ioctl(filp->f_dentry->d_inode,
filp, cmd, arg);
	}
}
/* 2.4.9-ac9/drivers/char/ip2main.c */
static int
ip2_ipl_ioctl ( struct inode *pInode, struct file *pFile, UINT cmd, ULONG
arg )
{
	...
	switch ( iplminor ) {
	...
	case 13:
		switch ( cmd ) {
		...
		default:
Error--->
			pCh = DevTable[cmd];
			if ( pCh )
			{
				COPY_TO_USER(rc, (char*)arg, (char*)pCh,
sizeof(i2ChanStr) );
			}
		}
	}
}

