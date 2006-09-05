Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWIEKjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWIEKjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWIEKjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:39:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39372 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751299AbWIEKjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:39:16 -0400
Subject: Re: [PATCH 06/16] GFS2: dentry, export, super and vm operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609041832010.28823@yvahk01.tjqt.qr>
References: <1157031245.3384.795.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609041046380.11217@yvahk01.tjqt.qr>
	 <1157383622.3384.950.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609041832010.28823@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 05 Sep 2006 11:44:54 +0100
Message-Id: <1157453094.3384.994.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-09-04 at 18:35 +0200, Jan Engelhardt wrote:
> >> >+	switch (fh_type) {
> >> >+	case 10:
> >> >+		parent.no_formal_ino = ((uint64_t)be32_to_cpu(fh[4])) << 32;
> >> >+		parent.no_formal_ino |= be32_to_cpu(fh[5]);
> >> >+		parent.no_addr = ((uint64_t)be32_to_cpu(fh[6])) << 32;
> >> >+		parent.no_addr |= be32_to_cpu(fh[7]);
> >> >+		fh_obj.imode = be32_to_cpu(fh[8]);
> >> >+	case 4:
> >> 
> >> What do these constants specify? Would not it be better to have a #define or
> >> enum{} for them somewhere?
> >
> >The sizes of the NFS file handles in units of sizeof(u32). I've added a
> >couple of #defines as requested.
> 
> A #define/enum is only really useful if more than one place references it.
> If this is the only one, just add a comment.
> 
There are several places as its used on both the fh encoding and fh
decoding routines.

> >> >+	if (IS_ERR(inode))
> >> >+		return ERR_PTR(PTR_ERR(inode));
> >> 
> >> Just return inode.
> >
> >The function returns a dentry, so it would need to be casted and I
> >thought that would look "more odd" than this construction.
> 
> Yes, it is very odd indeed that you return an inode as a dentry at all. How is
> the caller supposed to know whether it was an inode or dentry that was actually
> returned?
> 
> 
> Jan Engelhardt

This is dealing with the error case only. If the function being called
returns an error (signaled by IS_ERR(inode) - hence an invalid pointer
value) then we need to return that error to the calling routing. Since
this function in question returns a dentry, we convert the invalid
pointer value from the function returning an inode into an integer and
then covert the integer into an invalid pointer value again, but this
time its an invalid pointer to a dentry and hence the correct return
type for this function.

So the caller of this function will get a pointer to a dentry which will
either be a valid dentry pointer or an error value testable with
IS_ERR().

Steve.


