Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTH0MhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 08:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbTH0MhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 08:37:21 -0400
Received: from ip213-185-36-189.laajakaista.mtv3.fi ([213.185.36.189]:53476
	"EHLO oma.irssi.org") by vger.kernel.org with ESMTP id S263375AbTH0MhT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 08:37:19 -0400
Subject: Lockless file reading
From: Timo Sirainen <tss@iki.fi>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1061987837.1455.107.camel@hurina>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 27 Aug 2003 15:37:18 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Maybe a bit off topic, but I couldn't get answers elsewhere and it is
about kernel behaviour)

The question is what can happen if I read() a file that's being
simultaneously updated by a write() in another process? If I'm writing
123 over XXX, is it possible that read() returns 1X3 in some conditions?
Is the behaviour filesystem specific? Any idea about other operating
systems?

I'm thinking about implementing lockless file reads that work like:

void write_data(int fd, off_t offset, void *data, size_t size) {
  lock_file(fd);
  pwrite(fd, data, size, offset); // or writev() or copy+single pwrite()
  pwrite(fd, data, size, offset + size);
  unlock_file(fd);
}

void read_data(int fd, off_t offset, void *data, size_t size) {
  unsigned char buf{size*2];
  for (;;) {
    pread(fd, buf, size*2, offset); // or shared mmap()ed access
    if (memcmp(buf, buf+size, size) == 0) break;
    usleep(10);
  }
  memcpy(data, buf, size);
}

The only case when I see that it would break is if we write "1212" but
pread() sees "1X1X" or "X2X2" there.


