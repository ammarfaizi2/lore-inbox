Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVCHNnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVCHNnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 08:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVCHNnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 08:43:47 -0500
Received: from 213-239-234-136.clients.your-server.de ([213.239.234.136]:58821
	"EHLO suckfuell.net") by vger.kernel.org with ESMTP id S262061AbVCHNne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 08:43:34 -0500
Date: Tue, 8 Mar 2005 14:43:32 +0100
From: Jochen Suckfuell <jo-lkml@suckfuell.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11 bug: unbacked private shared memory segments missing in core dump
Message-ID: <20050308134332.GA2356@ds217-115-141-141.dedicated.hosteurope.de>
Mail-Followup-To: Jochen Suckfuell <jo-lkml@suckfuell.net>,
	linux-kernel@vger.kernel.org
References: <20050301170614.GA6121@ds217-115-141-141.dedicated.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301170614.GA6121@ds217-115-141-141.dedicated.hosteurope.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Since 2.6.10, unbacked private shared memory allocated via shmget is not
included in core dumps.

This is a simple example code demonstrating the bug:

#include <sys/shm.h>

int main(int argc, char ** argv)
{
	int size = 1000;
	int id = shmget(IPC_PRIVATE, size, (IPC_CREAT | 0660));
	if(id < 0) return(1);
	int *buffer = (int *)shmat(id, 0, 0);
	int i;
	for(i = 0; i < 1000; i++)
		buffer[i] = i;

	// now dump core
	*((unsigned long *)1) = 0;

	// The private shared memory is not included in the core dump,
	// although it's not backed and cannot be accessed any more in any
	// way.
	return 0;
}

This bug was introduced in 2.6.10 by a patch to binfmt_elf.c that
resulted in:

static int maydump(struct vm_area_struct *vma)
{
	/* Do not dump I/O mapped devices, shared memory, or special mappings */
	if (vma->vm_flags & (VM_IO | VM_SHARED | VM_RESERVED))
		return 0;
...

(See the thread at
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.2/1890.html)

Excluding all pages with VM_SHARED set is also excluding the unbacked
private mapping and should be replaced by a more specific criterion.

Bye
Jochen

