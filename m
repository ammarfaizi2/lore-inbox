Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbUK0CEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbUK0CEh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUKZThC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:37:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262218AbUKZTWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:22:20 -0500
Date: Fri, 26 Nov 2004 14:19:35 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       Alexandre Oliva <aoliva@redhat.com>, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041126141935.GA29035@parcelfarce.linux.theplanet.co.uk>
References: <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk> <19865.1101395592@redhat.com> <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br> <12983.1101470307@redhat.com> <1101470443.8191.9438.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101470443.8191.9438.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2004 at 12:00:43PM +0000, David Woodhouse wrote:
> On Fri, 2004-11-26 at 11:58 +0000, David Howells wrote:
> > How about calling the interface headers "kapi*/" instead of "user*/". In case
> > you haven't guessed, "kapi" would be short for "kernel-api".
> 
> I don't think that change really makes any difference. The nomenclature
> really isn't _that_ important.

Indeed.  We could also make this transparent to userspace by using a script
to copy the user-* headers to /usr/include.  Something like this:

install_user_headers:
	$(srctree)/scripts/install_user_headers.sh

#!/bin/bash
rm -rf /usr/include/asm /usr/include/linux /usr/include/asm-generic
mkdir /usr/include/asm /usr/include/linux /usr/include/asm-generic

to_user() {
	sed	-e 's,<user/,<linux/, \
		-e 's,<user-generic/,<asm-generic,' \
		-e 's,<user-[^/]*/,<asm,' \
		<$1 >$2
}

for src in include/user/*; do
	to_user $src /usr/include/linux/`basename $src`
done

for src in include/user-$ARCH/*; do
	to_user $src /usr/include/asm/`basename $src`
done

for src in include/user-generic/*; do
	to_user $src /usr/include/asm-generic/`basename $src`
done


If we really wanted to get fancy, we could also sed __u32 to uint32_t.
But that would probably cause more pain, confusion, hurt and bad feeling
than I'd ever want to be responsible for.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
