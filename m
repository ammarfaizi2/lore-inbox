Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTKOVyk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 16:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTKOVyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 16:54:40 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:45699 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S262101AbTKOVyi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 16:54:38 -0500
Date: Sat, 15 Nov 2003 21:54:41 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Harald Welte <laforge@netfilter.org>, <linux-kernel@vger.kernel.org>
Subject: Re: seq_file and exporting dynamically allocated data
In-Reply-To: <20031115213342.GR24159@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0311152135370.743-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Nov 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sat, Nov 15, 2003 at 08:50:55PM +0000, Tigran Aivazian wrote:
>  
> > Looking at mm/slab.c implementation I see that it just walks the integer 
> > distance from the head of the list. Simple but not 100% correct, I think. 
> > I.e. it can miss an entry if the list has changed between two read(2)s.
> 
> Define "miss".  What sort of warranties do you expect there?

Ok, suppose the list of entries consists of elements:

A -> B -> C -> D ->( A )

where "->" is a "next" pointer and the last element points back to A, i.e. 
circular list.

Suppose each element requires 2040 bytes of data to be passed to the user 
app.

Now, the user application issues a call:

struct elem elem[10];

len = read(fd, elem, 10*sizeof(struct elem));

(small digression about PAGE_SIZE Now, if you just strace dd
if=/proc/slabinfo bs=8192 you will see that a read for 8192 bytes returned
only 4056 bytes and then the next read for 8192 bytes returned 66 bytes.
This is why I was saying that a single read is limited to a single page.)

Now, back to our abstract list. The normal (intuitive, e.g. seq_printf())  
->show() implementation will manage to pack A and B into m->buf but
hitting the element C it will have to return -1 (otherwise the kernel will
oops because m->buf isn't large enough). So, the userspace got back A and
B in a single read, i.e. 4080 bytes. On the next read() the ->start()
routine will try to arrive at the element with offset 2 (I think it
counted from 0). And since ->stop()  routine was called we dropped the
spinlock guarding the list. So, which element is now at distance 2 from A?
It's not necessarily C because it could have been unlinked. But this is OK
because if C was unlinked then we don't want to see it anyway. The bad
case is if the element B was unlinked then the element at distance 2 would
be D and we would "miss" C.  This is the sense in which we can "miss" an
element.

Is there any error in the above?

Kind regards
Tigran

