Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbTJGWrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 18:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbTJGWrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 18:47:12 -0400
Received: from mail.inter-page.com ([12.5.23.93]:14342 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S262937AbTJGWrI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 18:47:08 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: Tue, 7 Oct 2003 15:46:09 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAQemaQXZL7UqvO6rldPpFKgEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <1065139380.736.109.camel@cube>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can say that (virtually) any programmer who does a lot of threads work is
going to presume that he may pass file handles between threads safely.

IMHO it would be exceptionally bad to break this assumption.

At the purist level, when I pass an abstraction (data structure etc) around
between my threads, having done my due-diligence WRT locking and such, I
expect that when the abstraction gets there it will still be valid.

Consider:

class ObjectList { /* whatever */ };

class CachedObjectList: public ObjectList {
    iostream	SlowStorage;
    /* whatever */
};

/* global, locks not shown */ vector<ObjectList*> central_registry;

One would *expect* that one could add CachedObjectList objects to the
central registry and then use them in any thread as long as access/locking
paradigms were strictly followed.

If every thread *doesn't* have the exact same set of files open in exactly
the same handles, this would not be true.

I would go as far as saying that if CLONE_THREAD *MUST* imply CLONE_FILES
automatically or Very Bad Things(tm) could happen.

For instance, if two threads have opened different files as fd==10, when the
shared data structure above passed from one thread to the other (with
SlowStorage attached to fd 10), the buffered output from the first task
could get flushed into the file opened by the second thread at whatever its
write pointer happens to be set to.  Etc.

Rob. 


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Albert Cahalan
Sent: Thursday, October 02, 2003 5:03 PM
To: Ulrich Drepper
Cc: Albert Cahalan; Linus Torvalds; Mikael Pettersson; Kernel Mailing List
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?


No. I mean "ban" like we ban CLONE_THREAD w/o CLONE_DETACHED.
Remember, the last stable release of the kernel (2.4.xx)
didn't have the ability to do CLONE_THREAD at all. So it
isn't as if real-world apps are depending on the ability
to do CLONE_THREAD w/o sharing file descriptors.




