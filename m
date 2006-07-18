Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWGRJKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWGRJKB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWGRJKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:10:01 -0400
Received: from [216.208.38.107] ([216.208.38.107]:2944 "EHLO OTTLS.pngxnet.com")
	by vger.kernel.org with ESMTP id S932092AbWGRJKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:10:00 -0400
Subject: Re: How to explain to lock validator: locking inodes in inode order
From: Arjan van de Ven <arjan@infradead.org>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bda6d13a0607172119v3c908ac8u8a39acd315dc6336@mail.gmail.com>
References: <bda6d13a0607171924v5cd15811v7c9749ad481b232d@mail.gmail.com>
	 <1153193513.4533.3.camel@testmachine>
	 <bda6d13a0607172119v3c908ac8u8a39acd315dc6336@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 11:09:56 +0200
Message-Id: <1153213796.3038.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Yes. It never takes a lock on any higher inode without holding the lock on a
> lower inode first. I have a full proof across the VFS+FS [see below].

ok just checking. The reason this is important is that once you tell
lockdep this is a special situation, it better be that, since you're
losing any checking for the "but what if not" case. 
> 
> >
> > all places in the kernel that take this mutex in that order only do it
> > in i_ino order, including all directory operations like cross directory
> > rename?
> 
> I had to disable the kernel's locking of multiple objects in namei.c using a
> new FS_ flag because it would actually deadlock for this filesystem.

ok fun ;) It might be interesting to talk to Al Viro about this at some
point, maybe there is something interesting in your locking that could
improve the linux VFS locking scheme

To annotate for lockdep,  you probably can use the same constants as we
used for inodes (after all you're sort of doing the same anyway); so
your code can be made to look roughly like this: 

if ( < ) {
   mutex_lock_nested( ..... , I_MUTEX_PARENT);
   mutex_lock_nested( ..... , I_MUTEX_CHILD);
} else {
   mutex_lock_nested( ..... , I_MUTEX_PARENT);
   mutex_lock_nested( ..... , I_MUTEX_CHILD);
}

this means that you tell that the first mutex taken is the parent in a
parent-child relationship which is hierarchical for "external" reasons
(in this case your sorting).

Greetings,
    Arjan van de Ven

