Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbUK2B31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUK2B31 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 20:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbUK2B31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 20:29:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:22694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261613AbUK2B3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 20:29:19 -0500
Date: Sun, 28 Nov 2004 17:28:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Nov 2004, Paul Mackerras wrote:
> 
> uint32_t is defined to be exactly 32 bits wide, so where's the problem
> in using it instead of __u32 in the headers that describe the
> user/kernel interface?  (Ditto for uint{8,16,64}_t, of course.

Ok, this discussion has gone on for too long anyway, but let's make it
easier for everybody. The kernel uses u8/u16/u32 because:

	- the kernel should not depend on, or pollute user-space naming.
	  YOU MUST NOT USE "uint32_t" when that may not be defined, and
	  user-space rules for when it is defined are arcane and totally
	  arbitrary.

	- since the kernel cannot use those types for anything that is 
	  visible to user space anyway, there has to be alternate names. 
	  The tradition is to prepend two underscores, so the kernel would 
	  have to use "__uint32_t" etc for its header files.

	- at that point, there's no longer any valid argument that it's a 
	  "standard type" (it ain't), and I personally find it a lot more 
	  readable to just use the types that the kernel has always used:  
	  __u8/__u16/__u32. For stuff that is only used for the kernel, 
	  the shorter "u8/u16/u32" versions may be used.

In short: having the kernel use the same names as user space is ACTIVELY 
BAD, exactly because those names have standards-defined visibility, which 
means that the kernel _cannot_ use them in all places anyway. So don't 
even _try_. 

On the bigger question of what to do with kernel headers in general, let's 
just make one thing clear: the kernel headers are for the kernel, and big 
and painful re-organizations that don't help _existing_ user space are not 
going to happen.

In particular, any re-organization that breaks _existing_ uses is totally
pointless. If you break existing uses, you might as well _not_ re-
organize, since if you consider kernel headers to be purely kernel-
internal (like they should be, but hey, reality trumps any wishes we might 
have), then the current organization is perfectly fine.

So I think this whole discussion has been largely pointless. We undeniably
have existing users of kernel headers. That's just a fact.  If we break
them, it doesn't _matter_ how the kernel headers look, and then "existing
practice" is about as good an organization as anything, and breaking
things just to break things is not something I'm in the least interested
in. "Beauty"  comes secondary to "usefulness".

So I would encourage people to think about ways to clean up some of the 
worst warts, but take into account:
 - testing it out with whatever random collection of old distributions and 
   special applications is almost impossible. So every single step of the 
   way should be (a) small and (b) obviously not break any current users.
 - cleanup just for the sake of cleanup always needs to take pain into 
   account. If you cannot make each small step "worth it", then just don't 
   do it. If the "cleanup" just adds another file and doesn't actually 
   _help_ anything that you can point to, it's not a cleanup, it's just an 
   exercise in wanking.

IOW, I seriously doubt any "let's reorganize header files just to make it
look good" _ever_ accomplished anything. But if there are _specific_
header files that have _specific_ problems, let's look at maybe solving
those. And if you cannot point to a specific problem with a suggested
specific solution, please don't cc me.

		Linus
