Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWCZW2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWCZW2G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWCZW2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:28:06 -0500
Received: from flex.com ([206.126.0.13]:39687 "EHLO flex.com")
	by vger.kernel.org with ESMTP id S1751164AbWCZW2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:28:05 -0500
From: Marr <marr@flex.com>
To: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com, drepper@redhat.com,
       Hans Reiser <reiser@namesys.com>
Subject: Re: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()'
Date: Sun, 26 Mar 2006 17:25:14 -0500
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Mark Lord <lkml@rtr.ca>,
       Linda Walsh <lkml@tlinx.org>, Bill Davidsen <davidsen@tmr.com>,
       Gerold Jury <gjury@inode.at>, Robert Hancock <hancockr@shaw.ca>,
       Al Boldi <a1426z@gawab.com>, Ingo Oeser <ioe-lkml@rameria.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, marr@flex.com
References: <200603131437.50461.a1426z@gawab.com> <200603131501.38803.marr@flex.com>
In-Reply-To: <200603131501.38803.marr@flex.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200603261725.15294.marr@flex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, Ulrich, Hans, et al,

*** Please CC: me on replies -- I'm not subscribed.

After some more testing and some input (off-list) from others, here is a 
summary of this problem and its various work-arounds to date....

On Monday 27 February 2006 4:53pm, Hans Reiser wrote:
> Andrew Morton wrote:
> >runs like a dog on 2.6's reiserfs.  libc is doing a (probably) 128k read
> >on every fseek.
> >
> >- There may be a libc stdio function which allows you to tune this
> >  behaviour.

It turns out that there is just such a function. Thanks to some sage 
(off-list) advice from Gerold Jury, this is an effective way to switch the 
file's stream to "unbuffered" mode:

   setvbuf( inp_fh, 0, _IONBF, 0 );

This results in incredible speedups on the ReiserFS+2.6.x setup, without the 
need to even use the 'nolargeio=1' mount option. Basically, we're going from 
128KB read-ahead on every 'fseek()' call to no read-ahead.

> >
> >- libc should probably be a bit more defensive about this anyway -
> >  plainly the filesystem is being silly.
>
> I really thank you for isolating the problem, but I don't see how you
> can do other than blame glibc for this.  The recommended IO size is only
> relevant to uncached data, and glibc is using it regardless of whether
> or not it is cached or uncached.   Do I misunderstand something myself
> here?

To date, I've not seen anyone address this implicit question/issue that Hans 
raised. To wit: Is the "recommended I/O size" only relevant to _uncached_ 
data???

If not, then anyone using ReiserFS on a 2.6.x kernel had best be well aware 
that 128KB read-aheads are going to occur with every 'fseek()' call, 
degrading performance drastically. This seems like a good reason for the 
ReiserFS folks to re-evaluate the use of 128KB as the default value for 
read-ahead.

Alternatively, if "recommended I/O size" _is_ (intended to be) only relevant 
to _uncached_ data, then the question becomes this: Is 'glibc' erroneously 
using that recommended size regardless of whether the data is cached or 
uncached?

Ulrich, we'd really appreciate your input on this matter. Please advise. Even 
a simple reply of "buzz off" would be useful at this point! ;^)

------------------------------

In summary, the problem still exists, but any of the following work-arounds 
are effective, ordered here from best to worst:

(A) Use a 'setvbuf()' call in the target application to disable (or reduce) 
buffering on the input stream. 

Under certain conditions, this should be useful even when not using ReiserFS 
and/or when not running a 2.6.x kernel. However, it's almost essential 
(currently) with ReiserFS and 2.6.x kernels, for apps which do a lot of file 
seeks using ANSI C file I/O (i.e. 'fseek()').

OR

(B) Use the `nolargeio=1' option when mounting a ReiserFS partition under 
2.6.x kernels. This effectively changes the recommended I/O read-ahead after 
each 'fseek()' call from 128KB to 4KB.

Unlike option (A) above, this is useful for situations where you don't have 
access to the source code of the target application(s).

However, Andrew Morton mentioned this possible negative side-effect:

>   This will alter the behaviour of every reiserfs filesystem in the
>   machine.  Even the already mounted ones.

OR

(C) Don't use ReiserFS (v3) under 2.6.x kernels (for apps which do a lot of 
file seeks using ANSI C file I/O).

For example, the 'ext2'/'ext3' filesystems seem to still use the 4KB 
read-ahead, resulting in _much_ better performance when performing multiple 
seeks (outside the range of the 'read-ahead' setting).

------------------------------

Of course, the unmentioned option (which basically bypasses the whole issue) 
is to convert the underlying application to use raw, unbuffered Unix file I/O 
(i.e. 'lseek() + read()' [or even just 'pread()', as suggested by Andrew 
Morton]) instead of ANSI C file I/O ('fseek() + fread()'), but that is 
considered out-of-scope for purposes of this discussion.

-----------------------------

Thanks to all who supplied input. Special thanks to Andrew Morton and Gerold 
Jury who supplied what effectively turned out to be the most-useful 
work-arounds.

*** Please CC: me on replies -- I'm not subscribed.

Bill Marr
