Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWHAMeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWHAMeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 08:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWHAMeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 08:34:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:43753 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751389AbWHAMeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 08:34:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=exFfu1RGH0L7AGvHD4bX7+wpRq5mID19J4cE3SNbpRe5i/UjxkF6Q1xe7mG3S3Aauz31Ufa1HHcYPJrlUORbv/TyqfMNHDFq/8zOFXA555lHMWp668TaoLKhJHy4UfRqBJHjHRBBALrBmXC+jbFM7l8u860uNTErusmkigrbHF8=
Message-ID: <69304d110608010534p5ecbdef6ta94bfd4748c3aa6c@mail.gmail.com>
Date: Tue, 1 Aug 2006 14:34:17 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Jeremy Fitzhardinge" <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, "Chris Wright" <chrisw@sous-sol.org>,
       "Christian Limpach" <Christian.Limpach@cl.cam.ac.uk>,
       "Christoph Lameter" <clameter@sgi.com>,
       "Gerd Hoffmann" <kraxel@suse.de>,
       "Hollis Blanchard" <hollisb@us.ibm.com>,
       "Ian Pratt" <ian.pratt@xensource.com>,
       "Rusty Russell" <rusty@rustcorp.com.au>,
       "Zachary Amsden" <zach@vmware.com>
Subject: Re: [PATCH 1 of 13] Add apply_to_page_range() which applies a function to a pte range
In-Reply-To: <m1ejw0zmic.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <79a98a10911fc4e77dce.1154421372@ezr.goop.org>
	 <m1ejw0zmic.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Jeremy Fitzhardinge <jeremy@xensource.com> writes:
>
> > 2 files changed, 99 insertions(+)
> > include/linux/mm.h |    5 ++
> > mm/memory.c        |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >
> >
> > Add a new mm function apply_to_page_range() which applies a given
> > function to every pte in a given virtual address range in a given mm
> > structure. This is a generic alternative to cut-and-pasting the Linux
> > idiomatic pagetable walking code in every place that a sequence of
> > PTEs must be accessed.
> >
> > Although this interface is intended to be useful in a wide range of
> > situations, it is currently used specifically by several Xen
> > subsystems, for example: to ensure that pagetables have been allocated
> > for a virtual address range, and to construct batched special
> > pagetable update requests to map I/O memory (in ioremap()).
>
> - You don't handle huge pages.  For a generic function
>   that sounds like a problem.
> - I believe there is a reason the kernel doesn't already have
>   a function like this.  I seem to recall there being efficiency
>   and fast path arguments.

The proper trick for this is:

1. place you "for each page" code in a #define like so:

#define FOR_EACH_PAGE_INNER do{ ... code ... }while(0);

2. create your function in a separate .h file without the double-include guard

3. inside this code, exchange the indirect function call with your define name:

(*fn)(args); --> FOR_EACH_PAGE_INNER

4. document how the macro will receive certain variables from it's
outer scope, and should leave the "function result" in another one.

this in effect creates a different copy of the page walker for each
function, and inlines your code in it.. just like it would do with a
C++ template.

A place where you can see this technique working is the software
triangle filler from MESA.

The doubt is... is this acceptable regarding linux-kernel coding-style?


> - Placing this code in mm/memory.c without a common consumer is
>   pure kernel bloat for everyone who doesn't use this function,
>   which is just about everyone.
>


-- 
Greetz, Antonio Vargas aka winden of network

http://network.amigascne.org/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
