Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbTH1Buo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 21:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTH1Buo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 21:50:44 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:25222 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262937AbTH1Bun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 21:50:43 -0400
Date: Thu, 28 Aug 2003 02:50:27 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Timo Sirainen <tss@iki.fi>
Cc: root@chaos.analogic.com, Martin Konold <martin.konold@erfrakon.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828015027.GA4715@mail.jlokier.co.uk>
References: <Pine.LNX.4.53.0308270925550.278@chaos> <A43789CE-D89E-11D7-9D97-000393CC2E90@iki.fi> <20030827233903.GB3759@mail.jlokier.co.uk> <1062031942.1454.147.camel@hurina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062031942.1454.147.camel@hurina>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timo Sirainen wrote:
> 	checksum[0]++;
> 	xor = buf[0] ^ checksum[0];

Your algorithm isn't going to work if the new value of xor is the same
as the old value of xor.

> 	do {
> 		memcpy(copy, buf, size*2);
> 	} while (!verify(copy, size));
> 	memcpy(data, copy, size);

It isn't safe because the memcpy() can read writes done on another
processor out of order, and xor does not always change.

You can read some of the newly written bytes in both the buf[] and
checksum[] halves of the buffer, while reading some of the previous
bytes in each half.  If the set of new bytes in the first half matches
the set in the second half well enough (i.e. the two sets match for
bytes which aredifferent between the old and new data blocks), and the
xor values are the same between the old and new data blocks, then your
test will accept a mix of old and new data bytes.

-- Jamie
