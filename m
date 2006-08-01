Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWHAAFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWHAAFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 20:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWHAAFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 20:05:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:37109 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751525AbWHAAFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 20:05:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hnKv9A5CCJryFObikslvbr5m/CS8LUUK3mnfEGy+DQFFPDsAT390Yqj3IBBHJEU5br1HuZrKqjjMNnjdO4nh7VkvyuLjLQjUDPhzl7+EXu1eQfqCYvYvx56PZpuatEDua/d0luSl/z28lgg5dfi4qAvabyGaCC7cTQFo2uuZIpk=
Message-ID: <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>
Date: Mon, 31 Jul 2006 17:05:51 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "David Lang" <dlang@digitalinsight.com>
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Cc: "Matthias Andree" <matthias.andree@gmx.de>,
       "Adrian Ulrich" <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>
	 <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>
	 <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>
	 <44CE7C31.5090402@gmx.de>
	 <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com>
	 <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz>
	 <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com>
	 <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, David Lang <dlang@digitalinsight.com> wrote:
> On Mon, 31 Jul 2006, Nate Diller wrote:
>
> > On 7/31/06, David Lang <dlang@digitalinsight.com> wrote:
> >> On Mon, 31 Jul 2006, Nate Diller wrote:
> >>
> >> >
> >> > On 7/31/06, Matthias Andree <matthias.andree@gmx.de> wrote:
> >> >> Adrian Ulrich wrote:
> >> >>
> >> >> > See also: http://spam.workaround.ch/dull/postmark.txt
> >> >> >
> >> >> > A quick'n'dirty ZFS-vs-UFS-vs-Reiser3-vs-Reiser4-vs-Ext3 'benchmark'
> >> >>
> >> >> Whatever Postmark does, this looks pretty besides the point.
> >> >
> >> > why's that?  postmark is one of the standard benchmarks...
> >> >
> >> >> Are these actual transactions with the "D"urability guarantee?
> >> >> 3000/s doesn't look too much like you're doing synchronous I/O (else
> >> >> figures around 70/s perhaps 100/s would be more adequate), and cache
> >> >> exercise is rather irrelevant for databases that manage real (=valuable)
> >> >> data...
> >> >
> >> > Data:
> >> >       204.62 megabytes read (8.53 megabytes per second)
> >> >       271.49 megabytes written (11.31 megabytes per second)
> >> >
> >> > looks pretty I/O bound to me, 11.31 MB/s isn't exactly your latest DDR
> >> > RAM bandwidth.  as far as the synchronous I/O question, Reiser4 in
> >> > this case acts more like a log-based FS.  That allows it to "overlap"
> >> > synchronous operations that are being submitted by multiple threads.
> >>
> >> what you are missing is that apps that need to do lots of syncing
> >> (databases,
> >> mail servers) need to wait for the data to hit non-volitile media before
> >> the
> >> write is complete. this limits such apps to ~1 write per revolution of the
> >> platters (yes it's possible for a limited time to have multiple writes to
> >> different things happen to be on the same track, but the counter is the
> >> extra
> >> seek time needed between tracks)
> >
> > this is true so long as there is only one thread submitting I/O and
> > doing fsync().  for something like a mail server, it can run
> > multi-threaded, and still get data integrity, if the changes are
> > spread out across more than one file.
>
> only if those multiple files all happen to live (along with their metadata) on
> the same track.

this is only a limitation for filesystems which do in-place data and
metadata updates.  this is why i mentioned the similarities to log
file systems (see rosenblum and ousterhout, 1991).  they observed an
order-of-magnitude increase in performance for such workloads on their
system.

> >> so any benchmark that shows more transactions then the media has
> >> revolutions is
> >> highly suspect (now if you have battery-backed cache, or the equivalent you
> >> can
> >> blow past these limits)
> >
> > not all workloads are completely serial, transactions themselves may
> > have no inter-dependencies at all.  so it depends on the benchmark,
> > and what workload you're measuring.  in cases like this, threading can
> > have a big advantage.
>
> in the real-world (and benchmarks that simulate it fairly) the data spans
> multiple tracks so your best case is considerably less then the max I listed
> becouse you frequently have to seek around a lot to do your writes to multiple
> places on disk. more threads running should mean that you are attempting to
> write to more places on disk, which will cause more seeks, dropping you further
> below the max.

postmark is very much real world.  reiser4 just doesn't always do
in-place writes.

NATE
