Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUJGRhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUJGRhQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267585AbUJGRKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:10:30 -0400
Received: from us1.server44secre01.de ([80.190.243.163]:63212 "EHLO
	us1.server44secre01.de") by vger.kernel.org with ESMTP
	id S267522AbUJGQym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:54:42 -0400
Date: Thu, 7 Oct 2004 18:54:10 +0200
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: video_usercopy() enforces change of VideoText IOCTLs since 2.6.8
Message-ID: <20041007165410.GA2306@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gerd,

from kernel 2.6.7 to 2.6.8 function video_usercopy() in 
videodev.c was modified in a way that IOCTLs which do not
use the _IO macros defined in linux/ioctl.h will get their
driver's ioctl function called with arg = 0.

This means that the videotext drivers (saa5246a and saa5249)
only produce segmentation faults in kernel version >= 2.6.8.

Shall we change the IOCTL definitions in include/linux/videotext.h?
This would mean that existing userspace programs will have to be 
recompiled in order to work with the latest kernel version.

Nevertheless I suggest changing these IOCTLs to the new method. 
I will work out a patch if you agree.

Below is the change I'm talking about:

int
video_usercopy(struct inode *inode, struct file *file,
	       unsigned int cmd, unsigned long arg,
	       int (*func)(struct inode *inode, struct file *file,
			   unsigned int cmd, void *arg))
{
	char	sbuf[128];
	void    *mbuf = NULL;
	void	*parg = NULL;
	int	err  = -EINVAL;

	cmd = video_fix_command(cmd);

	/*  Copy arguments into temp kernel buffer  */
	switch (_IOC_DIR(cmd)) {
	case _IOC_NONE:
===> 2.6.7:
		parg = (void *)arg;
===> 2.6.8:
		parg = NULL;
        ...

	/* call driver */
	err = func(inode, file, cmd, parg);

Bye,
Michael
