Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSG2Lmh>; Mon, 29 Jul 2002 07:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSG2Lmh>; Mon, 29 Jul 2002 07:42:37 -0400
Received: from pat.uio.no ([129.240.130.16]:8182 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315427AbSG2Lmf>;
	Mon, 29 Jul 2002 07:42:35 -0400
To: Jan Hudec <bulb@ucw.cz>
Cc: linux-fsdevel@vger.kerner.org, linux-kernel@vger.kernel.org
Subject: Re: Race in open(O_CREAT|O_EXCL) and network filesystem
References: <20020728165256.GA4631@vagabond>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 29 Jul 2002 13:45:52 +0200
In-Reply-To: <20020728165256.GA4631@vagabond>
Message-ID: <shsk7nezrin.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jan Hudec <bulb@ucw.cz> writes:

     > Hi all, maybe I'm blind, but I think there is a race featuring
     > open(O_CREAT|O_EXCL) and nfs or any other network fs.

     > 1) Is there some reason this can't happen that I overlooked?

No. It can indeed happen, and it is one of my pet peeves in the
current open_namei() layout. The VFS seems all too often to assume
that a semaphore suffices to ensure atomicity. This is obviously not
the case for networked filesystems.

     > 2) If it is a problem (comment in NFS suggest so), I can see
     >    two ways of
     > handling this. Either pass the flags to the create method, or
     > restart the open when create returns EEXISTS. Which one would
     > be prefered?

I'd rather like to see some method by which we could merge the
lookup() and create() calls.

Given its support for exclusive create, there is no reason why we
should be doing the lookup in the first place on NFSv3. It's just a
waste of an RPC call...
IIRC, the NFSv4 client actually has to work around the whole
open_namei() thingy with a new 'open()' method in order to conform to
the RFCs.

The minimum change I'd need, though, is for vfs_create() to actually
pass me the O_EXCL flag.

Cheers,
  Trond
