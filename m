Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbTH1Aw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 20:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbTH1Aw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 20:52:26 -0400
Received: from ip213-185-36-189.laajakaista.mtv3.fi ([213.185.36.189]:53811
	"EHLO oma.irssi.org") by vger.kernel.org with ESMTP id S262723AbTH1AwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 20:52:24 -0400
Subject: Re: Lockless file reading
From: Timo Sirainen <tss@iki.fi>
To: Jamie Lokier <jamie@shareable.org>
Cc: root@chaos.analogic.com, Martin Konold <martin.konold@erfrakon.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030827233903.GB3759@mail.jlokier.co.uk>
References: <Pine.LNX.4.53.0308270925550.278@chaos>
	 <A43789CE-D89E-11D7-9D97-000393CC2E90@iki.fi>
	 <20030827233903.GB3759@mail.jlokier.co.uk>
Content-Type: text/plain
Message-Id: <1062031942.1454.147.camel@hurina>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Aug 2003 03:52:22 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 02:39, Jamie Lokier wrote:
> Timo Sirainen wrote:
> > Maybe it would be possible to use some kind of error detection 
> > checksums which would guarantee that the data either is valid or isn't, 
> > regardless of the order in which it is written. I don't really know how 
> > that could be done though.
> 
> You can use a strong checksum like MD5, if that is really faster than
> locking.  (Over NFS it probably is faster than fcntl()-locking, for
> small data blocks).

While MD5 is probably good enough, it doesn't _guarantee_ the
consistency. I just thought of a simple algorithm that I think would.
I'll go and use that unless someone proves it wrong :)

Except of course if there's 256 writes and the last one is non-ordered
and it all happens while a read() is executing.. Less than unlikely I'd
say.

I don't think there's any other potential problems with read() than that
it may not have all data up to date? Such as it would never temporarily
show the data as zero?

static int verify(const unsigned char *buf, size_t size)
{
	const unsigned char *checksum = buf + size;
	unsigned char xor;
	size_t i;

	xor = buf[0] ^ checksum[0];
	for (i = 1; i < size; i++) {
		if ((buf[i] ^ xor) != checksum[i])
			return 0;
	}
	return 1;
}

void write_data(const void *data, size_t size)
{
	unsigned char *checksum = buf + size;
	unsigned char xor;
	size_t i;

	memcpy(buf, data, size);

	checksum[0]++;
	xor = buf[0] ^ checksum[0];

	for (i = 1; i < size; i++)
		checksum[i] = buf[i] ^ xor;
}

void read_data(void *data, size_t size)
{
	unsigned char copy[size*2];

	do {
		memcpy(copy, buf, size*2);
	} while (!verify(copy, size));
	memcpy(data, copy, size);
}


