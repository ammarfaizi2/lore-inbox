Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWIVXmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWIVXmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWIVXmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:42:43 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:55458 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964934AbWIVXmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:42:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Sdxuf7M438IOQJyXxtTWStG33+/rl0wNiNS1JirM4cpbMQN2egPB5CnKJBojchxgkvxqxkFsJ0CetvLZ1LoPRhZQd4EJeo53FDQuqSzUBs4hw8q4yJUCl0XJhUHXhXfY4OHwvFtUcL2wKcdpOsJxrLJOibVBlhz0hjFgHDrWHW8=
Message-ID: <35a82d00609221642u2e4a5026w434584ff77b7b9bb@mail.gmail.com>
Date: Fri, 22 Sep 2006 16:42:41 -0700
From: "Scott Baker" <smbaker@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: fault when using iget() on XFS file system (2.6.9)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm working on a kernel module that needs to perform an iget() on an
inode that lies in the XFS file system. Most of the time, this works
fine, but occasionally the iget will cause a fault by jumping to
EIP=0. I traced the fault to where iget calls sb->s_op->read_inode,
and I found that XFS doesn't provide a read_inode function. iget
attempts to call the read_inode operation if the inode's state has the
I_NEW bit set. Thus, the kernel jumps off to nowhere.

The code works flawlessly on an uniprocessor system, but fails
intermittently under smp. This leads me to believe that there's a
race. XFS is probably filling in the inode structure on one cpu while
my module is performing the iget on the other.

Does anyone have a suggestion of where I should go from here?
Modifying XFS or the kernel is out of the question. I can re-implement
iget myself, detect the error condition, and sleep until XFS finishes
filling in the inode, but that seems like a bit of a hack.

Thanks,
Scott
