Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757190AbWKVXuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190AbWKVXuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757189AbWKVXuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:50:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17587 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757187AbWKVXuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:50:16 -0500
Message-ID: <4564E162.8040901@redhat.com>
Date: Wed, 22 Nov 2006 15:46:42 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru>
In-Reply-To: <11641265982190@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> + int kevent_wait(int ctl_fd, unsigned int num, __u64 timeout);
> +
> +ctl_fd - file descriptor referring to the kevent queue 
> +num - number of processed kevents 
> +timeout - this timeout specifies number of nanoseconds to wait until there is 
> +		free space in kevent queue 
> +
> +Return value:
> + number of events copied into ring buffer or negative error value.

This is not quite sufficient.  What we also need is a parameter which 
specifies which ring buffer the code assumes is currently active.  This 
is just like the EWOULDBLOCK error in the futex.  I.e., the kernel 
doesn't move the thread on the wait list if the index has changed. 
Otherwise asynchronous ring buffer filling is impossible.  Assume this

     thread                             kernel

     get current ring buffer idx

     front and tail pointer the same

                                        add new entry to ring buffer

                                        bump front pointer

     call kevent_wait()


With the interface above this leads to a deadlock.  The kernel delivered 
the event and is done with it.

If the kevent_wait() syscall gets an additional parameter which 
specifies the expected front pointer the kernel wouldn't put the thread 
to sleep since, in this case, the front pointer changed since last checked.

The kernel cannot and should not check the ring buffer is empty. 
Userlevel should maintain the tail pointer all by itself.  And even if 
the tail pointer is available to the kernel, the program might want to 
handle the queued events differently.

The above also comes to bear without asynchronous queuing if a thread 
waits for more than one event and it is possible to handle both events 
concurrently in two threads.

Passing in the expected front pointer value is flexible and efficient.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
