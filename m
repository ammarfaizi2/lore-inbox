Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318269AbSIEUlT>; Thu, 5 Sep 2002 16:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318268AbSIEUlS>; Thu, 5 Sep 2002 16:41:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11274 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318265AbSIEUlR>; Thu, 5 Sep 2002 16:41:17 -0400
Date: Thu, 5 Sep 2002 13:48:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <3D77B1EF.97B1FDDD@zip.com.au>
Message-ID: <Pine.LNX.4.33.0209051339310.9149-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Btw, the update to do partial completion will need a few more fixes: right
now the different callers of "bio->bi_end_io(bio)" are not very careful
about updating the bio information, since no bi_end_io() function has had
any reason to care before.

That turns the 2-liner patch into slightly more, since for example the 
failure cases in __make_request() need to make sure that they pass in the 
right size/sector count. So the

		....
	end_io:
		bio->bi_end_io(bio);
		return 0;

would become something like

		....
	end_io:
		bio->bi_size = 0;
		bio->bi_end_io(bio, nr_sectors);
		return 0;

if we had this interface.

To avoid those kinds of silly bugs and to avoid havind the bi_end_io() 
function have to look up all the bio information, maybe the end_io calling 
convention really should be

	void bio_end_io(struct bio *bio,
		unsigned int completed,
		unsigned int left, 
		unsigned int uptodate);

and then a failure would just be

	bio->bi_end_io(bio, nr_sectors, 0, 0);

and the end-io function would have all the information it needs to decide 
how much has been done / is left undone directly in the arguments.

One final question would be whether we would want to make all of these
byte counts, for some future networked block device where we might be
getting the completions back in odd-sized chunks, for example? Right now
much of the bio code already is able to handle byte-sized stuff, and it 
might be nice to not have to maintain byte counts in NBD if the bio layer 
already does it anyway..

		Linus

