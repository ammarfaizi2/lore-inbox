Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284601AbRLETHJ>; Wed, 5 Dec 2001 14:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284599AbRLETG6>; Wed, 5 Dec 2001 14:06:58 -0500
Received: from alageremail1.agere.com ([192.19.192.106]:22728 "EHLO
	alageremail1.agere.com") by vger.kernel.org with ESMTP
	id <S284587AbRLETFc>; Wed, 5 Dec 2001 14:05:32 -0500
Message-ID: <C093F2B9DDFD544283D02A8BB12588430445344F@pai820excuag02.ags.agere.com>
From: "Zimmermann, Christopher (Chris)" <cbzimmermann@agere.com>
To: linux-kernel@vger.kernel.org
Subject: System Freeze in 2.4.2-2 (RedHat 7.1)
Date: Wed, 5 Dec 2001 14:05:24 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing a system freeze (no oops message) in RedHat Linux 7.1 when
calling the function devinet_ioctl() with the SIOCSIFADDR command from
within a kernel module.  The function is called within the scope of
userspace addressing in the following manner.

int devinet_ioctl_wrapper(unsigned int cmd, struct ifreq *arg)
{
	int res;
	
	mm_segment_t oldfs = get_fs();
	set_fs(get_ds());
	res = devinet_ioctl(cmd,arg);
	set_fs(oldfs);
	
	return res;
}

This is how ipconfig.c illustrates how to use this function from within a
kernel module, see ic_dev_ioctl() function in the source file.

When running in the scope of a kgdb patched kernel, an assertion is flagged
the first (and only first) time this function is called from within my
kernel module for skb_alloc being called non-atomically with interrupts
enabled.  But, allowing the kernel to continue from this point, there is no
system freeze and everything appears to operate according to design.

Is there anything I am supposed to do before calling this function?  


Thanks,
Chris
