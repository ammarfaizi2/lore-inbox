Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVBCPKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVBCPKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVBCPKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:10:23 -0500
Received: from mout.perfora.net ([217.160.230.40]:54510 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S263212AbVBCPDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:03:04 -0500
Subject: Re: dm-crypt crypt_status reports key?
From: Christopher Warner <chris@servertogo.com>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: Matt Mackall <mpm@selenic.com>, Christophe Saout <christophe@saout.de>,
       christopher@kernelcode.com, linux-kernel <linux-kernel@vger.kernel.org>,
       dm-crypt@saout.de, Alasdair G Kergon <agk@redhat.com>
In-Reply-To: <1107440300.15236.58.camel@ghanima>
References: <20050202211916.GJ2493@waste.org>
	 <1107394381.10497.16.camel@server.cs.pocnet.net>
	 <20050203015236.GO2493@waste.org>
	 <1107398069.11826.16.camel@server.cs.pocnet.net>
	 <20050203040542.GQ2493@waste.org>  <1107440300.15236.58.camel@ghanima>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 05:15:48 -0500
Message-Id: <1107425749.9294.56.camel@linux-cw>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:d2cbd72fb1ab4860f78cabc62f71ec31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-03 at 15:18 +0100, Fruhwirth Clemens wrote:
> On Wed, 2005-02-02 at 20:05 -0800, Matt Mackall wrote:
> 
> > Dunno here, seems that having one tool that gave the kernel a key named
> > "foo" and then telling dm-crypt to use key "foo" is probably not a bad
> > way to go. Then we don't have stuff like "echo <key> | dmsetup create"
> > and the like and the key-handling smarts can all be put in one
> > separate place.
> > 
> > Getting from here to there might be interesting though. Perhaps we can
> > teach dm-crypt to understand keys of the form "keyname:<foo>"? in
> > addition to raw keys to keep compatibility. Might even be possible to
> > push this down into crypt_decode_key() (or a smarter variant of same).
> 
> Way too complicated. This is a crypto project, why does nobody think of
> crypto to solve the problem :). Here's the idea:
> 
> Keys are handed to dm-crypt regularly the first time. But when dm-crypt
> hands keys back to user space, it uses some sort of blinding to make the
> keys meaningless for user space. 
> 
> That can easily be done by generating a kernel internal secret after
> boot, and then before handing out the keys to user space, XOR-ing the
> kernel secret into the key. When these keys are handed back from user
> space to the kernel, the process is reversed. 
> 
> That's an effective blinding mechanism. The kernel has to remember
> nothing but a single secret. No special out-of-band setup of "keyname:"
> tokens, no additional management for these tokens and blinded key
> becomes useless after reboot.
> 
> Of course, the blinded keys need to be distinguished from regular keys.
> I propose to prepend "!" to the keys handed back to the user space, so
> we have "!<hex..key>", and add a simple conditional post processing to
> crypt_decode_key.
> 
> Of course, one can use encryption instead of XOR-ing with the kernel
> secret as blinding mechanism, as the kernel secret can easily be
> recovered by setting up a all-zero key. But the main intend of this
> approach is to protect against incompetent roots and user space
> programs, so I think this XOR OTP is sufficient, and further, trivially
> to implement. (Actually it's a Multi Time Pad.)

I've been following this thread and i'm clearly at a loss as to how any
of this will prevent someone from writing a util to get the key?
Currently i'm trying to figure out exactly how one would prevent the key
from being retrieved. This after stumbling into dm-crypt almost 24 hours
ago and applying it into a system. Albeit, I haven't been thinking about
it long, none of the above will stop incompetent roots from leaving a
machine open with root. Subsequently, allowing one who's far less
incompetent from taking advantage of the machine. The only logical
solution seems to be perceived threats idea. Why put something into
place that isn't going to make it any more difficult? How about, don't
leave yourself logged in as root and if you're using scripts, etc make
sure they have the proper permissions set etc.

--
Christopher Warner

