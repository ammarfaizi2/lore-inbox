Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRDQUXg>; Tue, 17 Apr 2001 16:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132619AbRDQUX0>; Tue, 17 Apr 2001 16:23:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63368 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132606AbRDQUXO>;
	Tue, 17 Apr 2001 16:23:14 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15068.42539.768756.883953@pizda.ninka.net>
Date: Tue, 17 Apr 2001 13:23:07 -0700 (PDT)
To: Jesse S Sipprell <jss@inflicted.net>
Cc: Jan Kasprzak <kas@informatics.muni.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        proftpd-devel@proftpd.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
In-Reply-To: <20010417161036.A21620@bastard.inflicted.net>
In-Reply-To: <20010417170206.C2589096@informatics.muni.cz>
	<E14pXxg-0002cI-00@the-village.bc.nu>
	<20010417181524.E2589096@informatics.muni.cz>
	<20010417161036.A21620@bastard.inflicted.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jesse S Sipprell writes:
 > A patch will be coming out soon, as it is a fairly trivial fix.

Thank you for tracking this down.

One more subtle note, for the case of error handling.  There is a
change to sendfile() in the zerocopy patches which causes sendfile()
to act more like sendmsg() when errors occur.

Specifically, sendmsg() works roughly like the following when an
error happens:

handle_error:
	if (sent_something)
		return how_much_we_sent;
	else
		return ERROR_CODE;

So when an error happens, and the kernel was able to send some of
the data, you see something like this in the trace:

	sendmsg() = N
	...
	sendmsg() = ERROR_CODE

sendfile() used to act differently, and this made it difficult to
directly transform a sendmsg()+local_buffer based server into a
sendfile() one because the error handling was so different.

Previously, sendfile() wouldn't give you the partial transfer length,
you'd just get the error _regardless_ of whether any data was sent
successfully during that call.  Alexey, myself, and others considered
this behavior bogus and inconsistent.  So it was changed.

The long and short of it is that sendfile() now acts just like
sendmsg() when errors happen mid-send.

Later,
David S. Miller
davem@redhat.com
