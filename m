Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317276AbSFRCIO>; Mon, 17 Jun 2002 22:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317277AbSFRCIN>; Mon, 17 Jun 2002 22:08:13 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:31432 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S317276AbSFRCIM>; Mon, 17 Jun 2002 22:08:12 -0400
Date: Mon, 17 Jun 2002 19:08:13 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 3x slower file reading oddity
In-Reply-To: <20020618014513.GK22427@clusterfs.com>
Message-ID: <Pine.LNX.4.44.0206171858100.18507-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Andreas Dilger wrote:

> On Jun 17, 2002  17:36 -0700, Andrew Morton wrote:
> > You can probably lessen the seek-rate by accessing the files in the correct
> > order.  Read all the files from a directory before descending into any of
> > its subdirectories.  Can find(1) do that?  You should be able to pretty
> > much achieve disk bandwidth this way - it depends on how bad the inter-
> > and intra-file fragmentation has become.
>
> Just FYI - "find -depth" will do that, from find(1):
> 	-depth Process each directory's contents before the directory itself.

not quite... even with this, find processes a directory's contents in the
order that the filenames appear on disk ... and this will recurse into
subdirs before finishing with all the files.

what i think andrew was suggesting is to process all non-directory entries
before handling the directory entries.

i'm working with something like this:

find -type f -print \
	| perl -ne '@c = split(/\//); print $#c . " $_";' \
	| sort -k 1,1nr -k 2,2 \
	| perl -pe 's#^\d+ ##;' \
	> filelist

(deliberately not using perl's sort because i want the thing to scale of
course ;)

that reverse sorts by number of path components first, pathname second.

it seems to be worth another 10% or so improvement on the single reader
test.

i figured handling the leaves first was best... hard to tell if there's
any difference if i remove the "r".  (this is on a live system with other
loads perturbing the results unfortunately.)

-dean

