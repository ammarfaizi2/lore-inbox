Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbRGJAYR>; Mon, 9 Jul 2001 20:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265133AbRGJAX5>; Mon, 9 Jul 2001 20:23:57 -0400
Received: from trout.hpc.CSIRO.AU ([138.194.72.10]:42222 "EHLO
	trout.hpc.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S265130AbRGJAXy>; Mon, 9 Jul 2001 20:23:54 -0400
Message-Id: <200107100023.KAA00261@trout.hpc.CSIRO.AU>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: trond.myklebust@fys.uio.no
cc: linux-kernel@vger.kernel.org, jeroen@trout.hpc.CSIRO.AU,
        smart@trout.hpc.CSIRO.AU
Subject: handling NFSERR_JUKEBOX
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 10 Jul 2001 10:23:40 +1000
From: Bob Smart <smart@hpc.CSIRO.AU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of unicos has started to return NFSERR_JUKEBOX
when it has to retrieve a file from tape. I found the following
relevant discussion on the netbsd list:
http://mail-index.netbsd.org/tech-kern/1999/03/16/0002.html
To save you looking the key point is:

  >Not sure. Is there a way that the server can say, "I got your request,
  >but I'm too busy now, try again in a little bit." ??

  Isn't this what NFSERR_JUKEBOX is for?

  AFAIK, the protocol goes something like this:

  Client sends a request.
  Server starts loading tape/optical disk/whatever.
  Client resends request.
  Server notices that this is a repeat of an earlier request which is already
  in the "slow queue", and replies NFSERR_JUKEBOX (= "be patient, I'll send
  the response eventually").
  Client shuts up and waits.
  Server completes request and sends response to client.

It seems that what the linux client is doing is returning error 528
to the user program (cp is giving this error message). From 
linux/errno.h:

#define EJUKEBOX  528     /* Request initiated, but will not complete 
                             before timeout */

This is wrong because the nfs file system is hard mounted in my case
- there is no timeout.

While it would be nice to do a perfect solution, it looks like
a quick fix is to just ignore NFSERR_JUKEBOX from the server.

Bob Smart
