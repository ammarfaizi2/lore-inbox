Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWDXU72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWDXU72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWDXU72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:59:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:34989 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751270AbWDXU71 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:59:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QWfuvu7pFENxaiVPeAeLdamZj5dodguFyDRnyAWcxDMbiLvSShf8ilA35nAdHInOUyen26D7ikZYHB1jOFn3fzDBMSQVtxHGCUmPmAI7wJfnnw9FRtPq7wGSWwVit1m3tN6JYgjBtV7vtO/C5BP2b0YSzUQ4nvMxz1DpovT37wg=
Message-ID: <a4403ff60604241359q408a6ea7je620cb05d3dafe8@mail.gmail.com>
Date: Mon, 24 Apr 2006 14:59:25 -0600
From: "David Wilk" <davidwilk@gmail.com>
To: "Hugh Dickins" <hugh@veritas.com>
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
Cc: "Chris Wright" <chrisw@sous-sol.org>, "Greg KH" <greg@kroah.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604231312450.2515@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com>
	 <20060419192803.GA19852@kroah.com>
	 <Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0604201706540.14395@blonde.wat.veritas.com>
	 <a4403ff60604211208gf64dfe2v7282a493f4853c@mail.gmail.com>
	 <20060421192743.GH3061@sorel.sous-sol.org>
	 <a4403ff60604211456j46a2f69fw39606ffec42ec95d@mail.gmail.com>
	 <Pine.LNX.4.64.0604231312450.2515@blonde.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/06, Hugh Dickins <hugh@veritas.com> wrote:
> On Fri, 21 Apr 2006, David Wilk wrote:
> > I finally got strace into the tomcat startup scripts properly and
> > grabbed the attached output.  I don't see any of the two lines you
> > propose.  I hope you guys can find this useful.
>
> Thanks for getting that, David.  As you observe, it doesn't involve
> shm at all, and the only mprotect is PROT_NONE.  Do the abbreviated
> messages in the final lines of the trace fit with the errors you
> were originally reporting?  (I think so.)  Or is this particular
> trace failing for some other reason, earlier than before, and we
> need to try something else to identify the problem?

I think this trace was taken while java was doing exactly what it was
doing before.  I actually restarted java many, many times with
2.6.16.9 and watched in amazement as it failed each and every time,
with the exact same error message.  This is tomcat, specifically, and
it would die immediately after startup and it was started the exact
same way with the init script.  So, yeah, I think this trace is
representative.  I have no idea why it doesn't contain what you would
consider relevant.  I'm no programmer, unfortunately.  However, I
would like to help out any way that I can.
>
> > mmap2(NULL, 872415232, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = -1 ENOMEM (Cannot allocate memory)
> > write(1, "Error occurred during initializa"..., 43) = 43
> > write(1, "Could not reserve enough space f"..., 46) = 46
> > write(1, "\n", 1)                       = 1
> > unlink("/tmp/hsperfdata_tomcat/12273")  = 0
> > write(2, "Could not create the Java virtua"..., 43) = 43
>
> To judge by this trace, I'd have to say that your problem has
> nothing whatever to do with the shm/mprotect fix in 2.6.16.6,
> and we've no evidence yet to complicate that fix.  Interestingly,
> nobody else has so far reported any problem with it.

bizaar.  I must say that this patch 'fixing' the problem just cannot
be coincidental.  Tomcat will never start without it, and never fails
with it.
>
> Judging by the mmap addresses throughout the trace (top down, from
> 0x37f2e000), it looks like you've got CONFIG_VMSPLIT_1G (not a good
> choice for a box with only 1G of RAM: whereas CONFIG_VMSPLIT_3G_OPT
> would maximize your userspace while avoiding the need for HIGHMEM);
> and with the above 832M mmap, the remaining hole in user address
> space is just too small to hold it.

well, this is just a test box for a system we deploy on a dual-cpu
server with 4GB of ram.

can you describe the CONFIG_VMSPLIT_3G_OPT and how I might find it in
'make menuconfig'?  is it the second option (3G/1G user/kernel)?  I"ve
got the first option selected which is 3G/1G user/kernel as well, but
different somehow.  As this is new to 2.6.16, I'm not familiar with
the options.  Perhaps my 1GB workstations would benefit from this
second 3G/1G option?
>
> But that leaves me quite unable to explain why you should have
> thought the shm/mprotect patch responsible, and why you should
> find the more complicated version works.  Stack randomization
> changes the numbers a little, but I think not enough to explain
> how it sometimes could fit 832M in there, sometimes not.

Unfortunately I cannot speculate as to the cause, but experimentally
(anecdotally anyway) the patch is 100% effective.
>
> Tell me I'm talking nonsense and we'll have another go:
> I guess adding some printks on top of the "replacement"
> patch, so it can tell us when it's having an effect.

I'd never accuse you of nonsense, but I cannot refute the evidence. ; )

if there is anything else you would like me todo to try to squeeze
more data from this thing, please let me know.
>
> Hugh
>
