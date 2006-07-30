Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWG3Q26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWG3Q26 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWG3Q26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:28:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:48658 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932352AbWG3Q25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:28:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=qRhOM+aa0ch2A1HLiZeVVv+zW6vUcd6pierIn/oJu+AfMnzorDKCYU1Xxrf0pX+V5YJ56m3i1pe51h+dEYhDCXRpE7+mXsvC8H7ABxGBI6/aNWqZsETytAdHXZpuc3bYYpGnfHsvqVjvc00xnSzoAgDSZAK61s2E7jKAVsYhCps=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] making the kernel -Wshadow clean - The initial step
Date: Sun, 30 Jul 2006 18:30:01 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Nikita Danilov <nikita@clusterfs.com>,
       Joe Perches <joe@perches.com>, Martin Waitz <tali@admingilde.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Christoph Hellwig <hch@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
       Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607301830.01659.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here we go again...

This is a series of patches that try to be an initial step towards making
the kernel build -Wshadow clean.

Yeah, I'm persisting with this since I get the impression, from the feedback
I've been getting, that this effort is mostly looked upon favorably.

The reasons why we should do this should be obvious, but I'll list the main
reasons anyway.
In the end the compiler will help us prevent new (and hard to find bugs)
due to symbol shadowing.
It'll help us keep our namespaces separate.
We may find some bugs along the way - and even if it's just one it'll be
worth it :)

I have recieved a lot of useful feedback to the previous patches I've
posted and I've tried to incorporate all the feedback in this series.

There should be no change in behaviour from these patches and it's my hope
that they are acceptable for merging so that, going forward, I will have 
these 12 less to keep track of separately.

A patch to add -Wshadow to the toplevel Makefile is not included since it's
still a little early for that. There are still a lot of warnings that need 
to be fixed, this series is just the first step (but as I think the numbers
below will show, it's a pretty big first step).
I'm only able to work against i386 at the moment, so the results below
probably won't be as nice for other archs, but no need to worry, I do plan
to clean up other archs as well - I just need to get a bunch of
cross-compilers installed.
My plan is to keep submitting new series of patches against -mm (assuming
that these will get merged there) until we are down to less than 100 warnings
for all the standard configs for all archs and then at that point submit a
patch to add -Wshadow to the toplevel Makefile - if someone wants to help
out I'd appreciate it - there are still lots of warnings left to work on, some
of them I've just not gotten to yet, but some of them I'll definately need 
help with as well.


All of this is against 2.6.18-rc3.

Without the patches, adding -Wshadow to the makefile results in these 
warnings for a few different .config's :

allnoconfig
---
$ grep warning build.log.allno | grep shadow | wc -l
1267

allmodconfig
---
$ grep warning build.log.allmod | grep shadow | wc -l
39921

allyesconfig
---
$ grep warning build.log.allyes | grep shadow | wc -l
32477

with my normal workstation config
---
$ grep warning build.log.juhl | grep shadow | wc -l
5298


After applying the patches in this series, quite a different picture
emerges.

allnoconfig :	124 warnings	(~10%)
allmodconfig :	6508 warnings	(~16%)
allyesconfig :	6522 warnings (~20%)
my config :	958 warnings	(~18%)

So with just 12 small patches the number of -Wshadow related warnings is
reduced to between 10 and 20 percent of what they previously were. 
Personally I'd say that's a pretty good first step.

I've added a bunch of people to Cc: on this mail, trying to pick those that
have either responded to my previous attempts or whoes code I'm changing.
I may not have gotten it 100% right, so please bear with me.
I'll not be sending the actual patches to all of you guys - don't want to 
spam your inbox too much. Instead I'll send all 12 patches as a reply to
this email to LKML with just akpm cc.   I hope that's OK with everyone.


Patch series overview : 

[PATCH 00/12] making the kernel -Wshadow clean - The initial step
[PATCH 01/12] making the kernel -Wshadow clean - fix mconf
[PATCH 02/12] making the kernel -Wshadow clean - fix lxdialog
[PATCH 03/12] making the kernel -Wshadow clean - fix jiffies.h
[PATCH 04/12] making the kernel -Wshadow clean - warnings related to 'up'
[PATCH 05/12] making the kernel -Wshadow clean - warnings related to wbc and map_bh
[PATCH 06/12] making the kernel -Wshadow clean - fix checksum
[PATCH 07/12] making the kernel -Wshadow clean - fix vgacon
[PATCH 08/12] making the kernel -Wshadow clean - fix keyboard.c
[PATCH 09/12] making the kernel -Wshadow clean - neighbour.h and 'proc_handler'
[PATCH 10/12] making the kernel -Wshadow clean - mm/truncate.c
[PATCH 11/12] making the kernel -Wshadow clean - USB & completion
[PATCH 12/12] making the kernel -Wshadow clean - 'irq' shadows local and global


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

