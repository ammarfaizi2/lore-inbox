Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313712AbSDZIaw>; Fri, 26 Apr 2002 04:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313713AbSDZIav>; Fri, 26 Apr 2002 04:30:51 -0400
Received: from mons.uio.no ([129.240.130.14]:63650 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S313712AbSDZIau>;
	Fri, 26 Apr 2002 04:30:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo
To: Daniel Forrest <forrest@lmcg.wisc.edu>
Subject: Re: lockd hanging
Date: Fri, 26 Apr 2002 10:30:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204112333.SAA22343@radium.lmcg.wisc.edu> <shsk7rd8k9r.fsf@charged.uio.no> <200204242113.QAA29375@radium.lmcg.wisc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17117p-0002fH-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24. April 2002 23:13, Daniel Forrest wrote:
> The bug I have found is in fs/lockd/svclock.c and is caused by downing
> an already downed semaphore:
>
> ->nlmsvc_lock				calls down(&file->f_sema)

Just exactly what is f_sema protecting? I've looked at the code, and I just 
can't figure out why we need a semaphore there at all.

AFAICS, all we are using them for is to protect the 2 lists f_shares and 
f_blocks in struct nlm_file. Since we are already holding the BKL, I don't 
see why we need an extra lock. (Yes: nlmsvc_delete_block() can sleep, so we 
need to be careful with the loop in nlmsvc_traverse_blocks(), but that is 
trivial to cope with...)


As for calling nlmclnt_lookup_host() in nlmsvc_create_block(). Why not just 
pass the value that we looked up in nlmsvc_proc_lock()?

Cheers,
  Trond
