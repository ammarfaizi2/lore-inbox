Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbSJ2Nar>; Tue, 29 Oct 2002 08:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261860AbSJ2Nar>; Tue, 29 Oct 2002 08:30:47 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:64236 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261856AbSJ2Naq>; Tue, 29 Oct 2002 08:30:46 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Race in net/socket.c?
Date: Tue, 29 Oct 2002 14:37:16 +0100
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210291437.16928.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to understand the locking in net/socket.c.
Suppose the system is uniprocessor (no preemption).
Then the various locking routines do nothing:

#define net_family_write_lock() do { } while(0)
#define net_family_write_unlock() do { } while(0)
#define net_family_read_lock() do { } while(0)
#define net_family_read_unlock() do { } while(0)

Look in sock_create:

        net_family_read_lock();
	...
        if ((i = net_families[family]->create(sock, protocol)) < 0)   <= may sleep
	...
        net_family_read_unlock();

The call to create(...) may sleep.  Suppose during this sleep a task is
run that calls sock_unregister:

int sock_unregister(int family)
{
        if (family < 0 || family >= NPROTO)
                return -1;

        net_family_write_lock();
        net_families[family]=NULL;
        net_family_write_unlock();
        return 0;
}

Since net_family_write_lock() is a noop, this succeeds, and returns.
Happy is my task!  It has returned from sock_unregister, so can now,
for example, free memory used for implementing that protocol.  But the
original create(...) call is in the middle of using that protocol.  Unhappy
am I!  I am dead!

What have I missed?

Ciao, Duncan.

