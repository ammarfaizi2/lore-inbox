Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263941AbTH1I6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 04:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTH1I5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:57:39 -0400
Received: from ip213-185-36-189.laajakaista.mtv3.fi ([213.185.36.189]:52552
	"EHLO oma.irssi.org") by vger.kernel.org with ESMTP id S263941AbTH1I5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 04:57:21 -0400
Subject: Re: Lockless file reading
From: Timo Sirainen <tss@iki.fi>
To: Jamie Lokier <jamie@shareable.org>
Cc: root@chaos.analogic.com, Martin Konold <martin.konold@erfrakon.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030828061333.GA5822@mail.jlokier.co.uk>
References: <20030828015027.GA4715@mail.jlokier.co.uk>
	 <3217CEE6-D906-11D7-A165-000393CC2E90@iki.fi>
	 <20030828061333.GA5822@mail.jlokier.co.uk>
Content-Type: text/plain
Message-Id: <1062061038.1459.240.camel@hurina>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Aug 2003 11:57:18 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 09:13, Jamie Lokier wrote:
> Timo Sirainen wrote:
> > I'm sure someone has figured out a way to make a checksum of data that 
> > can detect if there's even a single bit wrong, if the checksum is 
> > allowed to take as much space as the data itself. I should read more 
> > about algorithms..
> 
> You said that MD5 wasn't strong enough, and you would like a guarantee.

Yes. I don't really like it if my program heavily relies on something
that can go wrong in some situations.

> You won't find a guarantee unless you are prepared to use memory
> barriers in your code.  _Any_ checksum is going to have a chance of
> false validation if you are doing out-of-order reads which can observe
> parts of the old and new data, and parts of the old and new checksum.

Not really. With {b1, b2, b1 xor b2} it doesn't matter what you read or
write first, no matter what the old data was. If they match, the result
is always either old or new.

If I want to get a checksum of 4 bytes then, I have to divide them into
two parts. Using the b1^b2 I can know if either one of them is valid,
but I can't know if they belong together.

Assuming that it's always either the previous one or the new one, I
think (once again :) that it's possible to check that by getting mixed
checksums: data = ABCD, c1 = A^B, c2 = C^D, c3 = A^C, c4 = B^D.

Except that the old data that read() sees could be even older than the
previous value. Maybe here works the growing xor-byte. I haven't thought
that far yet.


