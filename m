Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757737AbWKXNHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757737AbWKXNHc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 08:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757740AbWKXNHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 08:07:32 -0500
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:55310 "EHLO
	smtp-vbr7.xs4all.nl") by vger.kernel.org with ESMTP
	id S1757736AbWKXNH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 08:07:29 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru> <456621AC.7000009@redhat.com> <45662522.9090101@garzik.org> <45663298.7000108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
Date: 24 Nov 2006 13:07:26 GMT
Message-ID: <4566ee8e$0$335$e4fe514c@news.xs4all.nl>
X-Trace: 1164373646 news.xs4all.nl 335 [::ffff:194.109.0.112]:50627
X-Complaints-To: abuse@xs4all.nl
In-Reply-To: <45663298.7000108@redhat.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <45663298.7000108@redhat.com>,
Ulrich Drepper  <drepper@redhat.com> wrote:
>Jeff Garzik wrote:
>> Considering current designs, it seems more likely that a single thread 
>> polls for socket activity, then dispatches work.  How often do you 
>> really see in userland multiple threads polling the same set of fds, 
>> then fighting to decide who will handle raised events?
>> 
>> More likely, you will see "prefork" (start N threads, each with its own 
>> ring) or a worker pool (single thread receives events, then dispatches 
>> to multiple threads for execution) or even one-thread-per-fd (single 
>> thread receives events, then starts new thread for handling).
>
>No, absolutely not.  This is exactly not what should/is/will happen.
>
>You create worker threads to handle to work for the entire program. 
>Look at something like a web server.  When creating several queues, how 
>do you distribute all the connections to the different queues?  To 
>ensure every connection is handled as quickly as possible you stuff them 
>all in the same queue and then have all threads use this one queue. 
>Whenever an event is posted a thread is woken.  _One_ thread.  If two 
>events are posted, two threads are woken.  In this situation we have a 
>few atomic ops at userlevel to make sure that the two threads don't pick 
>the same event but that's all there is wrt "fighting".

What you really want is if one thread is able to do all the work,
only keep that one thread busy. Only wake up other threads when
the currently running threads cannot handle the load.

Say you have 8 threads blocked in kevent_wait(). One or more events
become available. You wake one thread, and let it run.

If the one thread has done its work and returns to kevent_wait()
before its timeslice has run out, deliver the next event(s) (which
may already be outstanding) to the same thread, don't wake another one.

If the running thread blocks on say disk i/o, or its timeslice
runs out, the scheduler runs and wakes another thread that is
waiting in kevent_wait().

Mike.
