Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279783AbRKSHNz>; Mon, 19 Nov 2001 02:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280191AbRKSHNp>; Mon, 19 Nov 2001 02:13:45 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55009 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S279783AbRKSHNd>;
	Mon, 19 Nov 2001 02:13:33 -0500
Date: Mon, 19 Nov 2001 02:13:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: more fun with procfs (netfilter)
Message-ID: <Pine.GSO.4.21.0111190156140.17210-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

% cat /proc/net/ip_conntrack |od -c
0000000   t   c   p                           6       1   2   1   0   7
[snip]
0005137
% od -c </proc/net/ip_conntrack
0000000
% cat /proc/net/ip_tables_names | od -c -w8
0000000   n   a   t  \n   f   i   l   t
0000010   e   r  \n
0000013
% od -c -w8 </proc/net/ip_tables_names
0000000   n   a   t  \n
0000004

Reason: netfilter procfs files try to fit entire records into the user
buffer.  Do a read shorter than record size and you've got zero.  And
read() returning 0 means you-know-what...

BTW, from strace output in cpuinfo bug report SuSE bash does reads by 128
bytes.  Which means that while read i; do echo $i; done </proc/net/ip_conntrack
will come out empty (lots of lines are longer than 160 characters).

I'll try to see if seq_file is suitable there, but in any case something
needs to be done - read() should return 0 _only_ at EOF and 128 bytes
definitely counts as reasonable buffer size.

