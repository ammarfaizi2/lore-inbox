Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbTACCdb>; Thu, 2 Jan 2003 21:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTACCdb>; Thu, 2 Jan 2003 21:33:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61201 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267430AbTACCda>; Thu, 2 Jan 2003 21:33:30 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
Date: Fri, 3 Jan 2003 02:41:39 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <av2t93$14v$1@penguin.transmeta.com>
References: <20030102221210.GA7704@window.dhis.org> <1041549644.24829.66.camel@irongate.swansea.linux.org.uk> <20030102.151600.129375771.davem@redhat.com> <1041555419.24901.86.camel@irongate.swansea.linux.org.uk>
X-Trace: palladium.transmeta.com 1041561701 29186 127.0.0.1 (3 Jan 2003 02:41:41 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 3 Jan 2003 02:41:41 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1041555419.24901.86.camel@irongate.swansea.linux.org.uk>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>On Thu, 2003-01-02 at 23:16, David S. Miller wrote:    
>> 
>> With sendfile() all of this goes straight to the page cache directly
>> without a VMA lookup.
>
>With a nasty unpleasant splat the moment you do modification on the
>content at all. For static objects sendfile is certainly superior,

Oh, the "unpleasant splat" happens with the mmap approach too, there's
no avoiding it. It can happen with a regular "read()" loop too (if the
read happens at the wrong time).

Both mmap and sendfile have the issue that the "splat" can happen every
time, while a read() into a private area means that the splat can only
happen the first time the web server caches the content.  But the read
into a private area is also obviously the worst one from a performance
standpoint. 

There are two ways to avoid the splat:
 - lock the file some way before reading/writing to it.
 - do all updates to a temp-file, and move the temp-file to the new location.

Those two approaches will fix the "splat" problem _regardless_ of what
IO mechanism you use. With that in mind, sendfile() is clearly the one
that performs best by far, so..

		Linus
