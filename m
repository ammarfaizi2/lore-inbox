Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWFLWYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWFLWYj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWFLWYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:24:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:2271 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932623AbWFLWYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:24:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IkCFKAmcjYbSroHjXYryrUqxSEJqdNX3Ij4jiCz0tPQbEAjauLC24a/DQg7WNherUPu/Nn3xoXP1GJpxOO+6hRzkdqhU3N2OIsyb8SOI1bKA+hnYJV/gEBg7lP2snSDpX+T32q5MkNdAC9b3y6qnU4ORxT3BZ/n8apuzwnr+W4I=
Message-ID: <b0943d9e0606121524x1ee55e25rdfa41e5d1edf9dbc@mail.gmail.com>
Date: Mon, 12 Jun 2006 23:24:37 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Pekka J Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20060612192227.GA5497@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
	 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
	 <20060612105345.GA8418@elte.hu>
	 <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com>
	 <20060612192227.GA5497@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Catalin Marinas <catalin.marinas@gmail.com> wrote:
>
> > On 12/06/06, Ingo Molnar <mingo@elte.hu> wrote:
> > >What i'd like to see though are clear explanations about why an
> > >allocation is not considered a leak, in terms of comments added to the
> > >code. That will also help us reduce the number of annotations later on.
> >
> > I'll document them in both Documentation/kmemleak.txt and inside the
> > code. If I implement the "any pointer inside the block" method, all
> > the memleak_padding() false positives will disappear.
>
> i dont know - i feel uneasy about the 'any pointer' method - it has a
> high potential for false negatives, especially for structures that
> contain strings (or other random data), etc.

That's my concern as well. The advantage is that it simplifies
kmemleak but I can't tell how good the detection would be. I can add
some code to the current implementation to show how many values (32
bit aligned) found during scanning look like valid pointers (i.e.
PAGE_OFFSET < x < PAGE_OFFSET + ram_size) but cannot be found in the
radix_tree. It might not be that bad (I'll post tomorrow some
statistics).

> did you consider the tracking of the types of allocated blocks
> explicitly? I'd expect that most blocks dont have pointers embedded in
> them that point to allocated blocks. For the ones that do, the
> allocation could be extended with the type information. For each
> affected type, we could annotate the structures themselves with offset
> information. How intrusive would such a method be?

Do you mean that when scanning it should only consider at the pointer
members in a structure? I don't think this can be easily achieved
because of the amount of structures in the kernel. There are places
where a pointer is stored as a long. There is also no way in C to
quantify the type of an object (similar to "typeid" in C++). The
closest approximation I could get was the size.

-- 
Catalin
