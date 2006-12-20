Return-Path: <linux-kernel-owner+w=401wt.eu-S964897AbWLTF45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWLTF45 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 00:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWLTF45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 00:56:57 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:62258 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964897AbWLTF44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 00:56:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k4qPkSM9X1vvEYUCkn5VvyzfKYfsTPsyp72LkPvRtq7fAd7PclHqfon70GtN/8aYdcZvd8a7buHMxaKRhP/TWdLh/+eamEH1FfNHdnBJNsp+anEH3WErV1LWqbm30sNVmMUVMJxo66ta0uioAwMZd/oR8z4EyPthjxcnPsmPZZk=
Message-ID: <b3f268590612192156oce50b07g379f312146c7389e@mail.gmail.com>
Date: Wed, 20 Dec 2006 14:56:55 +0900
From: "Jari Sundell" <sundell.software@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: 2.6.19 file content corruption on ext3
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Andrew Morton" <akpm@osdl.org>, andrei.popa@i-neo.ro,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Hugh Dickins" <hugh@veritas.com>, "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>,
       "Martin Michlmayr" <tbm@cyrius.com>
In-Reply-To: <Pine.LNX.4.64.0612191037291.3483@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1166314399.7018.6.camel@localhost> <45876C65.7010301@yahoo.com.au>
	 <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	 <45878BE8.8010700@yahoo.com.au>
	 <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
	 <4587B762.2030603@yahoo.com.au>
	 <Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>
	 <Pine.LNX.4.64.0612191037291.3483@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Tue, 19 Dec 2006, Linus Torvalds wrote:
> >
> >  here's a totally new tangent on this: it's possible that user code is
> > simply BUGGY.
>
> Btw, here's a simpler test-program that actually shows the difference
> between 2.6.18 and 2.6.19 in action, and why it could explain why a
> program like rtorrent might show corruption behavious that it didn't show
> before.

Kinda late to the discussion, but I guess I could summarize what
rtorrent actually does, or should be doing.

When downloading a new torrent, it will create the files and truncate
them to the final size. It will never call truncate after this and the
files will remain sparse until data is downloaded. A 'piece' is mapped
to memory using MAP_SHARED, which will be page aligned on single file
torrents but unlikely to be so on multi-file torrents.

So on multi-file torrents it'll often end up with two mappings
overlapping with one page, each of which only write to their own part
the page. These will then be sync'ed with MS_ASYNC, or MS_SYNC if low
on disk space. After that it might be unmapped, then mapped as
read-only.

I haven't thought of asking if single file torrents are ok.

Rakshasa
