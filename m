Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265809AbSKAXGY>; Fri, 1 Nov 2002 18:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265810AbSKAXGY>; Fri, 1 Nov 2002 18:06:24 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:35741 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S265809AbSKAXGX>; Fri, 1 Nov 2002 18:06:23 -0500
Message-Id: <5.1.0.14.2.20021101145232.0810d608@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 01 Nov 2002 15:12:47 -0800
To: linux-kernel@vger.kernel.org
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Initialize seq->private before seq_start()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Currently seq_file API doesn't provide any way to initialize seq->private before
seq_start() is called. In most cases seq_start() uses global tables and 
stuff and therefor doesn't need seq->private. However there are cases like
        proc/something/0/table
        ...
        proc/something/N/table
and seq_start() has to know where to look for table N.

So, how about something like:

#define seq_open(file, op) __seq_open(file, op, NULL)

int __seq_open(struct file *file, struct seq_operations *op, void *priv)
{
        struct seq_file *p = kmalloc(sizeof(*p), GFP_KERNEL);
        if (!p)
                return -ENOMEM;
        memset(p, 0, sizeof(*p));
        sema_init(&p->sem, 1);
        p->op = op;
         p->private = priv;
        file->private_data = p;
        return 0;
}

Those who need seq->private in seq_start() (that'd be me :)) will use __seq_open().

Currently I have 
static int hci_seq_open(struct file *file, struct seq_operations *op, void *priv)
{
        struct seq_file *seq;

        if (seq_open(file, op))
                return -ENOMEM;

        seq = file->private_data;
        seq->private = priv;
        return 0;
}
and it'd be nice if I could get rid of that function and use __seq_file instead.


Max

http://bluez.sf.net
http://vtun.sf.net

