Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131672AbRBQODq>; Sat, 17 Feb 2001 09:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131691AbRBQOD0>; Sat, 17 Feb 2001 09:03:26 -0500
Received: from [62.172.234.2] ([62.172.234.2]:59436 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131672AbRBQODN>; Sat, 17 Feb 2001 09:03:13 -0500
Date: Sat, 17 Feb 2001 13:15:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: Keith Owens <kaos@ocs.com.au>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro
In-Reply-To: <3A8E3BA5.4B98E94E@yahoo.com>
Message-ID: <Pine.LNX.4.21.0102171200530.2029-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001, Paul Gortmaker wrote:
> I was poking around in a vmlinux the other day and was surprised at the 
> amount of repetitive crap text that was in there.  For example, try:
> 
> strings vmlinux|grep $PWD|wc -c
> 
> which gets some 70KB in my case - depends on strlen($PWD) obviously.  The 
> culprit is BUG() in a static inline that is in a header file.  In this 
> case cpp expands __FILE__ to the full path of the header file in question. 

Well done, dammit!  I've been sitting on that observation
for a couple of weeks, now you've beaten me to the patch.

gcc 2.97 (snapshot) does a much better job here, eliminating the
strings from the many objects in which those inline functions are not
used.  But that still leaves quite a lot of full pathnames of build
tree header files in the resultant vmlinux.  And it'll be quite some
while before gcc 3.0 becomes the choice for building the kernel.

> (IIRC there is a __BASEFILE__ that would be a better choice than __FILE__)

Not that I've found.

> There is also some 5 to 10k worth of "kernel BUG at %s:%d!\n" scattered 
> through a typical vmlinux.  Note that neither of these show up in [b]zImage 
> size since they compress to something like 99%, but they do cost memory once 
> the kernel is booted.

Indeed.

> Anyway this small patch makes sure there is only one "kernel BUG..." string,
> and dumps __FILE__ in favour of an address value since System.map data is 
> needed to make full use of the BUG() dump anyways.  The memory stats of two 
> otherwise identical kernels:

Well, in many cases, no System.map data is needed to decipher a BUG():
a particular problem can quickly become familiar just by its file:line;
which a reliance on System.map might sometimes obscure.

I was leaving BUG()'s printk format unchanged (though shared); but
inline functions in header files using INLINE_BUG() instead, its
format "kernel BUG inlined from header:%d!\n" i.e. no __FILE__, but
peculiarly __LINE__ even so to help identify familiar bugs quickly.

That never quite satisfied me.  I think the best would be to
combine approaches: keep BUG() as it was (though sharing format),
substitute INLINE_BUG() in inline functions, but use your macro
(with 0x%p address) for it instead of mine.  What do others think?
Keith, does the address format need adjusting to suit ksymoops?

These changes need not be kept to i386,
but like you I hadn't yet gone further.

I'd very much like to see some such changes go into Linus' tree.
I'm fortunate that I can afford the waste of memory: what bothers
me about those strings is, I'm interested in whether objects built
with different CONFIG options are equivalent or not, and those
strings make that hard to establish (I'm thinking particularly
of CONFIG_NOHIGHMEM v. CONFIG_HIGHMEM4G v. CONFIG_HIGHMEM64G,
which pull in different header files with inlined BUG()s).

Paul, I apologize if I seem to be trying to steal your thunder:
just a subject close to my heart right now!

Hugh

