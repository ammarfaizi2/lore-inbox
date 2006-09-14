Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWINFV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWINFV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 01:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWINFV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 01:21:58 -0400
Received: from web31510.mail.mud.yahoo.com ([68.142.198.139]:3218 "HELO
	web31510.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751341AbWINFV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 01:21:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HuvhZ24/rrS+O30Iisdq3e5pqdAhslPT588z5dh7PND41fAjxUWPVwUN9rBr1cT6EYox8Wx50Dlv/6OzKPLFm95rendiaosQ0M02Tb7Z5XtVq/r1UXbYTwyTzX8awyOXuJTbjqF5Ky1bW0XU7tSbRwC3gnE9UBY0EtRBy0nuQD4=  ;
Message-ID: <20060914052157.97020.qmail@web31510.mail.mud.yahoo.com>
Date: Wed, 13 Sep 2006 22:21:57 -0700 (PDT)
From: Jonathan Day <imipak@yahoo.com>
Subject: Sharing memory between kernelspace and userspace
To: linux-kernel@vger.kernel.org
Cc: imipak@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'll start with a summary of the problems I need
solved, and then get on with the explanation of why I
need them solved.

1. I need a kernel driver to be able to allocate and
deallocate, on a totally dynamic basis, userspace
memory that is reachable by multiple applications.

2. I need a Really Efficient Method(tm) of knowing if
a specified application (maybe thread) dies. Efficient
here primarily means not tampering with anything
outside the driver if at all humanly possible.

3. I would truly value some suggestions on which of
the many ways of communicating with the kernel would
offer the best way to handle a truly horrible number
of very simple signals. Speed, here, is an absolute
must. According to my boss, residual sanity on my part
is not.


Ok, now for an overview of what I'm trying to do:

I'm having what is probably the world's second-dumbest
problem. What I want to do is have a driver in
kernelspace be able to allocate multiple chunks of
memory that can be shared with userspace without
having to do copies. So far, that doesn't sound like
any big deal - the Linux Device Drivers book covers
essentially this task.

There are several problems, however, that make this
nasty. First, since the time before the kernel driver
or user application can start (and therefore finish)
processing a block of data is non-deterministic and
there is a requirement the mechanism be as close to
non-blocking as possible, so I need to be able to
create and destroy chunks entirely on-the-fly with the
least risk of either the driver or the application
ending up with unexpectedly invalid pointers.

The second problem is that the interface between
kernelspace and userspace is handling messages rather
than packets, so I've absolutely no idea in advance
how big a chunk is going to be. That is only known
just prior to the data being put in the chunk
allocated for it. Messages can be big (the specs
require the ability to send a message up to 2Gb in
size) which - if I'm reading the docs correctly -
means I can't create the chunks in kernelspace.

Having an application create a userspace buffer and
hand that off to the kernel is, again, documented. No
problem there. It's the reverse direction that is the
bugbear. I have to have the kernel driver ALSO create
a userspace buffer and it's not clear to me how to do
this.

Now we get to the fun part. The specs also require the
driver be able to deliver to multiple applications.
With zerocopy, this isn't a big deal as far as
processing is concerned - there's no extra overhead no
matter how many applications want to access the data.

The problem is that when any given application
performs the read is, again, non-deterministic, and
although the number of recipients is known in advance,
the number of recipients for any given chunk is not.
This means that the order in which chunks are deleted
is going to be essentially random. It also means I
need to watch the process table, 'cos I can't leave
blocks permanently allocated if one or more recipients
dies before signalling that it has finished with it.

The signals, overall, are all very simple. An
application joins or leaves a group interested in a
specific sequence of messages. An application finishes
reading a named chunk or finishes writing one. An
outbound sequence may be created or destroyed. An
inbound sequence may be terminated. The device is
either ready or it isn't.

There is, however, the interesting problem that some
of these signals (such as inbound sequences
terminating) that must be delivered to multiple
applications. I'm assuming this is going to have to be
done one application at a time, but if I can send such
signals to the whole lot at once, I would prefer it.

Suggestions and brain transplants welcome.

Jonathan Day

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
