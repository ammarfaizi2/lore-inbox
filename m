Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWG0BDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWG0BDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 21:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWG0BDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 21:03:45 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:25038 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751159AbWG0BDo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 21:03:44 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch/rfc] s390: get rid of own uid16 compat system calls
Date: Thu, 27 Jul 2006 03:03:42 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20060710085142.GB9440@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060710085142.GB9440@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607270303.42959.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 July 2006 10:51, Heiko Carstens wrote:
> "Only" thing is that we unfortunately have different sizes for
> __kernel_old_[uid|gid]_t (16 bit on s390, 32 on s390x). I was tempted to
> change these just to find out that there are other users as well:
> 
> include/linux/ncp_fs.h:
>  #define NCP_IOC_GETMOUNTUID _IOW('n', 2, __kernel_old_uid_t)
> include/linux/smb_fs.h:
>  #define SMB_IOC_GETMOUNTUID _IOR('u', 1, __kernel_old_uid_t)
> 
> So, this is no option. Would anybody know of something to get this work?
> Or is this just a stupid idea?

Ok, I don't know exactly what you're talking about, but I have in the
past tried to hack that area as well. It's probably a good idea to
pick up my old patch and work from there, by making these two file systems
understand all possible ways:

#ifdef __KERNEL__
/* anything the user may be passing to us */
#define NCP_IOC_GETMOUNTUID16 _IOW('n', 2, u16)
#define NCP_IOC_GETMOUNTUID32 _IOW('n', 2, u32)
#define NCP_IOC_GETMOUNTUID64 _IOW('n', 2, u64)
#else
/* what the user is _supposed_ to pass */
#define NCP_IOC_GETMOUNTUID _IOW('n', 2, __kernel_old_uid_t) /* 16/32 bit */
#define NCP_IOC_GETMOUNTUID2 _IOW('n', 2, unsigned long) /* 32 or 64 bit */
#endif

int ncp_ioctl(struct inode *inode, struct file *filp, ...)
{
	...
	switch (arg) {
		...
	case NCP_IOC_GETMOUNTUID16:
	case NCP_IOC_GETMOUNTUID32:
	case NCP_IOC_GETMOUNTUID64:
		{
			unsigned long tmp = server->m.mounted_uid;

			if ((file_permission(filp, MAY_READ) != 0)
			    && (current->uid != server->m.mounted_uid))	{
				return -EACCES;
			}
			switch (arg) {
#ifdef CONFIG_UID16
			case NCP_IOC_GETMOUNTUID16:
				SET_UID(tmp, server->m.mounted_uid);
				if (put_user(tmp, (u16 __user *)argp)) 
					return -EFAULT;
#endif
			case NCP_IOC_GETMOUNTUID32:
				if (put_user(tmp, (u32 __user *)argp)) 
					return -EFAULT;
#ifdef CONFIG_64BIT
			case NCP_IOC_GETMOUNTUID64:
				if (put_user(tmp, (u64 __user *)argp)) 
					return -EFAULT;
			}
#endif
			return 0;
		}
	}
	...
}

I'm also posting the two patches I made a long time ago as a reference.

	Arnd <><
