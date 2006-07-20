Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWGTKu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWGTKu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 06:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWGTKu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 06:50:59 -0400
Received: from web38507.mail.mud.yahoo.com ([209.191.125.53]:63828 "HELO
	web38507.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030239AbWGTKu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 06:50:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OeQGiSu70/I//lcVwnptoS1Ak7Bletp+Jg90D156S5CV4GKtVKVHv12SMfY+4yH8M0ulhp+EyXZAGu6c8gRO7+IKYjy8vkclHhaEhllzQp8kxPNbHj/svMpQmYs1eZhAby4ydkdpvkacS8AHk/YZjkM3go3UHdcANRUtlTWdpo4=  ;
Message-ID: <20060720105058.40166.qmail@web38507.mail.mud.yahoo.com>
Date: Thu, 20 Jul 2006 03:50:58 -0700 (PDT)
From: Levitsky Maxim <maximlevitsky@yahoo.com>
Subject: RFC: Block size > PAGE_SIZE
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have idea to lift software based limitation of 4K
maximum block size of block devices.

There are some devices that have bigger that 4K block
size. The most notable are packet driven CD/DVD
recorders, but for example Flash chips cannot erase
blocks that are bigger that 64K of even more.

The main reason for this limitation is the fact that
both buffer and page cache are stored in pages, and
each page have set of buffers that is pointed by it's
private field. So a page must contain at least one
buffer and thus buffer cannot be larger that 4K , the
IA32 default page size.

The extent based filesystems can also benefit from
bigger block size , they will be able to read a
cluster at time

My idea is storing a sector in number of pages.

Each buffer_head will have addition filed ->next that
will point in circuit to next buffer_head that stores
data from the same sector 
actually it is possible not to use this ->next field 
because buffer_heads are linked in list of same page
buffer_heads. but im my case page will contain only
one buffer head so I can reuse this field.

>From FS point of view , it may look difficult to
implement big block sizes because filesystems are not
aware of ether linked list of buffer_heads nor of big
block sizes.

But this can be fixed very easy. set_blocksize will
have addition flags parameter and all filesystems that
are unaware of new design or don't need big block
sized will pass 0 as this parameter. and they won't be
allowed to use new design. New or modified filesystems
will pass a flag and bigger that 4K block size to this
function, and then after each __getblk they will
examine not only returned buffer_head but also the
linked ones.

default address space operations will be changed too
to support both small and big block sizes. 

I thought a lot about changes is those functions but
it seems that changes small enough.

I didn't yet implemented this idea , because I want to
know whenever you like this idea or not. After all
this is not a simply work. 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
