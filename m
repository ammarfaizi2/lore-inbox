Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWGLLf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWGLLf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWGLLf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:35:58 -0400
Received: from alea.erlm.siemens.de ([217.194.35.70]:18910 "EHLO
	alea.erlm.siemens.de") by vger.kernel.org with ESMTP
	id S1751307AbWGLLf5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:35:57 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: [SYSFS] Kernel Null pointer dereference in sysfs_readdir()
Date: Wed, 12 Jul 2006 13:35:50 +0200
Message-ID: <5B0042046ADE774687F32BF3652F5BB9021C9190@kher9eaa.ww007.siemens.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [SYSFS] Kernel Null pointer dereference in sysfs_readdir()
Thread-Index: Acalp1NzlTlQAy+5THCAijMb/o261g==
From: "Duetsch, Thomas  LDE1" <thomas.duetsch@siemens.com>
To: <linux-kernel@vger.kernel.org>
Cc: <maneesh@in.ibm.com>, "Steven Rostedt" <rostedt@goodmis.org>,
       <mingo@elte.hu>
X-OriginalArrivalTime: 12 Jul 2006 11:35:51.0114 (UTC) FILETIME=[53D3AAA0:01C6A5A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently working on a custom kernel based on Ingo's -rt patch
(2.6.16-rt29).

While rebooting my machine, I came across a kernel null pointer
dereference in this code segment in fs/sysfs/dir.c, function
sysfs_readdir():

		for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
			struct sysfs_dirent *next;
			const char * name;
			int len;

			next = list_entry(p, struct sysfs_dirent,
					   s_sibling);
			if (!next->s_element)
				continue;

			name = sysfs_get_name(next);
			len = strlen(name);
			if (next->s_dentry)
PROBLEM ->			ino = next->s_dentry->d_inode->i_ino;
			else
				ino = iunique(sysfs_sb, 2);

Checking the mailing list, I came across this thread:
"What protection does sysfs_readdir have with SMP/Preemption?"
http://lkml.org/lkml/2005/11/22/293
Which handels the exact same problem (And I'm working on the kernel
Steve was working back then).
Reading through your suggestions and solutions, I was wondering, what
would happen if a sysfs file would be deleted instead of created, while
a sysfs_readdir were in progress.
Looking through the code, I don't see, where the parents inode mutex is
taken, to prevent a race condition.

Unfortunately, I can't reproduce the behaviour, nor do I know, which
file was accessed, when this happens.

Like Steve said back then, this might well be a problem in our code, but

since we didn't change the sysfs, maybe it's a vanilla problem as well.

Thomas

