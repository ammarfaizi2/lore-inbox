Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTIIT3a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264423AbTIIT33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:29:29 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:28756 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264393AbTIIT3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:29:18 -0400
Date: Tue, 9 Sep 2003 13:29:13 -0600
From: hendriks@lanl.gov
To: linux-kernel@vger.kernel.org
Subject: 2.4.21 -> 2.4.22 kernel thread oddities
Message-ID: <20030909192913.GE10623@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "unshare_files" addition to execve() is having some unexpected
side effects for a funky init() program that I use on our clusters.
Basically the problem is that standard-equipment type kernel threads
(e.g. kupdated, bdflush) are ending up with open file descriptors on a
file system that I wish to unmount.


As far as I can tell the following is going on:

Those kernel threads are started from process 1 before starting init.
They are started with CLONE_FILES so they share a file table with
init.

Right before init is started, the kernel does open("/dev/console").
The kernel threads end up with this in their file table because of the
CLONE_FILES.

On Linux 2.4.22, execve("/sbin/init") causes the file table to be
unshared which leaves no way of closing those file descriptors.  This
in turn, means I have no way to unmount the file system.

On Linux 2.4.21, the file table was still shared so closing the file
descriptors in init, closed them for the threads as well and
everything was fine.


A quick one line hack around this would be to "unshare_files" right
before doing the open("/dev/console").  This doesn't strike me as
being a particularly good answer.

It seems like kernel_threads should be responsible for cleaning up
what they don't need with __exit_files() and so on.

- Erik


