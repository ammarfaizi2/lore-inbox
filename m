Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbSKKCUw>; Sun, 10 Nov 2002 21:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265360AbSKKCUv>; Sun, 10 Nov 2002 21:20:51 -0500
Received: from packet.digeo.com ([12.110.80.53]:9673 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265355AbSKKCUv>;
	Sun, 10 Nov 2002 21:20:51 -0500
Message-ID: <3DCF1593.CB9C7AA4@digeo.com>
Date: Sun, 10 Nov 2002 18:27:31 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
CC: Ben Clifford <benc@hawaga.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.46: access permission filesystem
References: <Pine.LNX.4.44.0211101609220.2335-200000@barbarella.hawaga.org.uk> <87k7jkg969.fsf@goat.bogus.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 02:27:31.0393 (UTC) FILETIME=[E2F16310:01C28929]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:
> 
> Ben Clifford <benc@hawaga.org.uk> writes:
> 
> > I still get those stack traces, though...
> 
> I retested with CONFIG_PREEMPT=y and now I get those stack traces,
> too. So, it seems my code is not preempt safe.
> 

It's not that your code is unsafe with preemption.  It's just that
CONFIG_PREEMPT=y turns on the debugging infrastructure which allows
us to detect things like calling kmalloc(GFP_KERNEL) inside spinlock.

+static int accessfs_node_init(struct accessfs_direntry *parent, struct accessfs_entry *de, const char *name, size_t len, struct access_attr *attr, mode_t mode
+{
+       static unsigned long ino = 1;
+       de->name = kmalloc(len + 1, GFP_KERNEL);
+ ...
+
+static int accessfs_mknod(struct accessfs_direntry *dir, const char *name, struct access_attr *attr)
+{
+ ...
+       spin_lock(&accessfs_lock);
+       accessfs_node_init(dir, pe, name, strlen(name), attr, S_IFREG | attr->mo
