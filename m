Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133066AbRDWNUX>; Mon, 23 Apr 2001 09:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133073AbRDWNUN>; Mon, 23 Apr 2001 09:20:13 -0400
Received: from t2.redhat.com ([199.183.24.243]:57838 "EHLO
	warthog.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S133066AbRDWNUD>; Mon, 23 Apr 2001 09:20:03 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: alonz@nolaviz.org, linux-kernel@vger.kernel.org
Subject: Re: light weight user level semaphores 
In-Reply-To: Your message of "Sun, 22 Apr 2001 15:18:34 BST."
             <27025.987949114@redhat.com> 
Date: Mon, 23 Apr 2001 14:19:49 +0100
Message-ID: <4411.988031989@warthog.cambridge.redhat.com>
From: David Howells <dhowells@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
> alonz@nolaviz.org said:
> >  [BTW, another solution is to truly support opaque "handles" to kernel
> > objects; I believe David Howells is already working on something like
> > this for Wine?

Yes. However, it uses a different system call set to use them. They translate
to small object structures internally.

> > The poll interface can be trivially extended to support
> > waiting on those...]

No, they aren't files. I did not want to use "files" because this would incur
a fairly major penalty for each object:

	struct file + struct dentry + struct inode

Which would mean that Win32 File objects would require two of each, one set to
hold the extra Win32 attributes and one set for the actual Linux file.

The way I've chosen uses somewhat less memory and should be faster.

> ISTR it wasn't quite trivial to do it that way - it would require the 
> addition of an extra argument to the fops->poll() method.

Yes, the PulseEvent operation demands that all processes currently waiting on
the event should be woken, but that no processes attaching immediately
afterward get triggered.

This means that the PulseEvent handler has to be able to notify all the
processes currently waiting on the queue and only those processes. I got it to
do this by marking the waiter records each process links into the queue.

Oh... and WaitForMultipleObjects also has a "wait for all" option.

David
