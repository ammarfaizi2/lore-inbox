Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbULNPte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbULNPte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 10:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbULNPte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 10:49:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:36515 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261529AbULNPt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 10:49:28 -0500
Date: Tue, 14 Dec 2004 07:49:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Werner Almesberger <wa@almesberger.net>
cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <20041214025110.A28617@almesberger.net>
Message-ID: <Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <20041214025110.A28617@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Werner Almesberger wrote:
> 
> Hmm, so you're predicting problems if user space includes something
> that uses uint32_t ? Wouldn't either of these work (descriptive file
> names for clarity):
> 
>  1) include/linux-user/foo.h:
>     #include <stdint.h>
>     #include <linux-kernel-and-user-common/foo.h>

No. Because when you include <sys/ioctl.h> (which includes the 
<linux-user/foo.h>, the POSIX/SuS/whatever namespace rules say that YOU 
MUST NOT pollute the namespace with the names from stdint.h.

The user is supposed to see "int32_t" and friends _only_ if the user 
himself includes <stdint.h> or one of the very specific headers that is 
documented by the standard to include it.

Trust me. We are NOT going to use <stdint.h> in the kernel. 

This is a common issue with namespace pollution. For example, this program 
is perfectly valid afaik (well, except for being _stupid_, but that's 
another issue):

	#include <stdio.h>

	const char *int32_t(int i)
	{
		return i ? "non-zero" : "zero";
	}

	int main(int argc, char **argv)
	{
		return printf("argc is %s\n", int32_t(argc));
	}

Get the picture? The user may _use_ names that are defined for the 
standard - like "strlen()" or "uint32_t" - for his own nefarious purposes, 
because they are _only_ defined if you include the right header files.

And trust me, the rules are really arcane. Not only do you have several 
standards, and several versions, you have various local rules too, ie gcc 
and glibc make up their own rules about things that depend on compiler 
flags etc. 

And that is why a kernel header file must not define them, and by 
implication, cannot use these names.

Because the whole _point_ of having kernel header files that can be used 
in user-space is that they are helpers for things like <sys/ioctl.h> etc, 
that would just copy them.

If we are going to pollute the user-visible namespace in random ways, the
whole discussion is pointless. At that point, glibc (or any other libc)  
can't use those API headers anyway.

Remember: the _biggest_ reason to make kernel headers available is not to 
user programs that want them, but to libc and friends.

		Linus
