Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbVJSVMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVJSVMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 17:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVJSVME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 17:12:04 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:40714 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751349AbVJSVMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 17:12:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=JZPVhtQT4+o6LJu8r7NfwG6FVXQOHfnZ2ODjPaLEoU6xgqhXjyOnL7MDsEm/Px1wGYRe1tj3Xd3DCt39jAyF7gf6FMINmWiAITXihmsnkQl/ubvTr6uVy6l82In8Gw+dTCzc+aXQTJiTidtj6FKHZq7VdQAvUxAlQ6sHj08gD5s=
Subject: Re: Is ext3 flush data to disk when files are closed?
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: uszhaoxin@gmail.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051019130010.28693db1.akpm@osdl.org>
References: <4ae3c140510190831j7530742aqc2b82e9e9cd6dde3@mail.gmail.com>
	 <1129737026.23632.113.camel@localhost.localdomain>
	 <20051019130010.28693db1.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 14:11:26 -0700
Message-Id: <1129756286.8716.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 13:00 -0700, Andrew Morton wrote:
> Badari Pulavarty <pbadari@gmail.com> wrote:
> >
> > On Wed, 2005-10-19 at 11:31 -0400, Xin Zhao wrote:
> > > As far as I know, if an application modifies a file on an ext3 file
> > > ssytem, it actually change the page cache, and the dirty pages will be
> > > flushed to disk by kupdate periodically.
> > > 
> > > My question is: if a file is to be closed, but some of its data pages
> > > are marked as dirty, will system block on close() and wait for dirty
> > > pages being flushed to disk? If so, it seems to decrease performance
> > > significantly if a lot of updates on many small files are involved.
> > > 
> > > Can someone point me to the right place to check how it works? Thanks!
> > 
> > On the last close() of the file, it should be flushed through ..
> > 
> > 	iput_final() -> generic_drop_inode() -> write_inode_now()
> > 		-> __writeback_single_inode() -> __sync_single_inode()
> > 			-> do_writepages()
> 
> The dcache's reference to the inode will prevent this from happening at
> close() time.
> 

I thought so too, till I wrote a kprobe/systemtap script to print 
the callers of generic_forget_inode() earlier and saw that most 
of my stacks are from exit() or close().

 0xffffffff801a0222 : generic_drop_inode+0x2/0x170 []
 0xffffffff8019eeb0 : iput+0x50/0x90 []
 0xffffffff8019c7bb : dput+0x1db/0x220 []
 0xffffffff80184461 : __fput+0x171/0x1e0 []
 0xffffffff801829ce : filp_close+0x6e/0x90 []
 0xffffffff801388eb : put_files_struct+0x6b/0xc0 []
 0xffffffff801392ef : do_exit+0x1ff/0xbb0 []
 


 0xffffffff801a0222 : generic_drop_inode+0x2/0x170 []
 0xffffffff8019eeb0 : iput+0x50/0x90 []
 0xffffffff8019c7bb : dput+0x1db/0x220 []
 0xffffffff80184461 : __fput+0x171/0x1e0 []
 0xffffffff801829ce : filp_close+0x6e/0x90 []
 0xffffffff80182a90 : sys_close+0xa0/0xd0 []
 0xffffffff8010dbc2 : system_call+0x1a/0x83 []


Thanks,
Badari

