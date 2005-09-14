Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbVINTBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVINTBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVINTBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:01:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45216 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932555AbVINTBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:01:48 -0400
Message-ID: <43287221.8020602@redhat.com>
Date: Wed, 14 Sep 2005 14:55:29 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Assar <assar@permabit.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>	<784q8qrsad.fsf@sober-counsel.permabit.com>	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>	<788xy2qas0.fsf@sober-counsel.permabit.com>	<20050913183948.GE14889@dmt.cnet>	<784q8okdfn.fsf@sober-counsel.permabit.com>	<20050913193539.GB17222@dmt.cnet> <784q8oivp4.fsf@sober-counsel.permabit.com>
In-Reply-To: <784q8oivp4.fsf@sober-counsel.permabit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assar wrote:

 >Peter Staubach <staubach@redhat.com> writes:
 >
 >>>Yes, but fs/nfs/nfs2xdr.c:nfs_xdr_readlinkres on 2.4.31 writes a 0 at
 >>>the end of string after having received it, which is what started this
 >>>thread.  Look at the end of nfs_xdr_readlinkres.
 >>>
 >>Yes, I know that.  For C purposes, the string must be null terminated.
 >
 >
 >Then I'm sorry but I don't understand what your point was.  Do you
 >believe there's a bug in nfs_xdr_readlinkres and if so, how do you
 >think it should work?
 >

Yes, I think that there is a bug in the boundary checking.  I think that:

        if (len > rcvbuf->page_len)

should be

        if (len >= rcvbuf->page_len - sizeof(u32) || len > 1024)

because the code puts the length in the first 4 bytes and then the
contents of the symbolic link is stored in the rest of the page.
The ">=" accounts for the null byte will be appended to the length.
The additional check for 1024 is due to the NFS Version 2 protocol
limiting the size of the contents of a symbolic link which can be
returned to 1024 bytes.

Also, the NFS Version 3, nfs3_xdr_readlinkres, is broken in the same
way and will need to be changed in the same fashion, except that
the NFS Version 3 protocol does not place an arbitrary limit on the
size of the contents of the symbolic which can be returned.  The
comparison against 1024 won't be needed here.

--

The 2.6 kernel code is also broken, but in a different, but once again,
similar fashions.

       ps
