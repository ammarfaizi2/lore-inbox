Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285084AbRLQJ7u>; Mon, 17 Dec 2001 04:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285077AbRLQJ71>; Mon, 17 Dec 2001 04:59:27 -0500
Received: from mons.uio.no ([129.240.130.14]:35990 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S285073AbRLQJ7U>;
	Mon, 17 Dec 2001 04:59:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15389.49646.612985.293315@charged.uio.no>
Date: Mon, 17 Dec 2001 10:59:10 +0100
To: Dave Jones <davej@suse.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112170350070.29678-100000@Appserv.suse.de>
In-Reply-To: <15389.19300.179304.433697@charged.uio.no>
	<Pine.LNX.4.33.0112170350070.29678-100000@Appserv.suse.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@suse.de> writes:

     > And it fixes the problem, good work!  But.. (Here comes the
     > sting..)

     > The test progresses just a little further and hits another
     > bug..  http://www.codemonkey.org.uk/cruft/nfs-fsx2.txt

     > want tcpdump again?

Nah. I hit this one myself just half an hour after 1 fired off my last
mail.

'fattr' patch updated yet again...

The problem here was that the writer was creating a hole in the file
using the combination (llseek + write). Of course, the write was
cached, and so the server didn't know about the hole, and since the
subsequent read was to the hole, we didn't flush out any further
writes that might give the server a clue.
Result: server replies to our read request with a read of length
zero. Client then fails to zero out and mark those pages as uptodate
(bug!!!), and so 'generic_file_read' decides to return EIO.

Fixing the above has allowed me to progress a bit more. I've had fsx
running overnight (what little there has been). The good and bad news
is that it's still running.
However, 2 races + 4 bugs observed is already pretty much a record for
a single program. Kudos to the NeXT developers...

Cheers,
  Trond
