Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbTDBDFo>; Tue, 1 Apr 2003 22:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbTDBDFo>; Tue, 1 Apr 2003 22:05:44 -0500
Received: from isp247n.hispeed.ch ([62.2.95.247]:62916 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id <S261384AbTDBDFm>;
	Tue, 1 Apr 2003 22:05:42 -0500
Message-ID: <3E8A5632.A025ACBE@bluewin.ch>
Date: Wed, 02 Apr 2003 05:17:06 +0200
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Compression for better down/upload performance (was: Deprecating .gz 
 format on kernel.org)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At some point it probably would make sense to start deprecating .gz
> format files from kernel.org.
> 
I guess "Deprecating .gz format on kernel.org" is not suggested because
of space consideration, I guess it's because of download/upload traffic
performance. IMO this could be rather easy solved in a completely
different manner, through compressing with traffic consideration in mind.

How does this work today? There is a patch from Rusty Russell which
makes gzip rsync'able aware, meaning if you download a .gz file with
rsync over an existing pervious version only the changed parts are
downloaded. My tests with the Debian packages file showed, if the
differences between the synched versions are below 10% a significant
reduction can be seen. Assumed that actual differences between kernel
versions are just a few %, a patched gzip and rsync will allow for more
than halving the traffic. Since I don't have a kernel mirror I can't
prove it but it should be really easy for any current mirror administrator.

How could this work in the future? Well Rusty Russell's patch showed a
simple fact: All the compression algorithm these days doesn't take into
account that the same (or just marginal different) compressed sources
are downloaded again and again. When you look at the gzip compression
you immediately see that a single change at the beginning of the source
might make the rest to the compressed part completely different. Rusty
Russell's patch tries to circumvent this with a deblocking algorithm.
But IMO it shouldn't be very difficult to design an algorithm which
circumvents this right from the start.

How can this work? Look at the gzip again. When a term is added to the
compression table it's just added to the end. The first difference
between versions produces a difference in this table from there on, so a
single change most likely produces almost completely different tables.
Now assume an added term is weighted and moved up in the table to the
place of its weight, a single change in the source might not at all or
just very minor influence in the compression tables. This means the
compressed source isn't much different between versions anymore. The
trick is to design a compression algorithm which keeps the compression
table as stable as possible between versions.

Why hasn't others come to the same conclusion? I really don't know,
maybe because nobody ever has studied the impact of compression on
traffic performance in the light of downloading the almost same again
and again.

O. Wyss
