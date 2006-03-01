Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWCADgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWCADgH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWCADgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:36:07 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:4500 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750865AbWCADgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:36:06 -0500
Message-ID: <44051696.7070801@cfl.rr.com>
Date: Tue, 28 Feb 2006 22:35:50 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: "Li, Peng" <ringer9cs@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thread safety for epoll/libaio
References: <598a055d0602281236m7eac9c09oc60af9ce28e7e4bf@mail.gmail.com>
In-Reply-To: <598a055d0602281236m7eac9c09oc60af9ce28e7e4bf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You don't mix epoll with io_submit; they are two completely different 
methods for doing IO.  The former is for use with bsd style non blocking 
IO, and the latter is truly async io.  epoll will signal you whenever a 
file can be read ( the read ahead buffer is non empty ) or written ( 
there's memory available to buffer writes ).  io_getevents() won't 
notify you of anything until you actually request a read or write, in 
which case, it lets you know when that has completed.

The two systems are completely non interchangeable.  With the former you 
wait first, then request some IO, which completes immediately.  With the 
latter, you request some IO ( possibly many ), then wait for some to 
finish.

Li, Peng wrote:
> I apologize if I should not post this on LKML, but there seems to be
> some lack of documentation for using epoll/AIO with threads.  Are
> these interfaces thread-safe?  Can I use them safely in the following
> way:
> 
> Thread A:  while(1) { io_getevents();  ... }
> // wait forever until an event occurs, then handles the event and loop
> 
> Thread B:  while(1) { epoll_wait();  ... }
> // same as thread A
> 
> Thread C:  ... io_submit(); ...
> 
> Thread D:  ... epoll_ctl(); ....
> 
> Suppose thread B calls epoll_wait and blocks before thread D calls
> epoll_ctl.  Is it safe to do so? Will thread B be notified for the
> event submitted by thread D?  Thread A and C pose the same question
> for AIO.
> 
> I wrote a simple program to test these interfaces and they seem to
> work without problems, but I am not sure if it is really safe to do so
> in general.  If all of them works, it seems easy to use epoll and AIO
> together as I can simply use another thread to harvest events from
> thread A and B and make it look like a unified event notification
> interface.
> 
> Peng

