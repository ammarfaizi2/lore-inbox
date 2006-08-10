Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWHJGQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWHJGQH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbWHJGQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:16:05 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:15261 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161071AbWHJGP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:15:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iAIy1Jp7L7V7taNo/qx0cTh6LBLIvUY4YDigaMwK/+jViqBILv8igFAnfcIrgmc80jp/RrsuukFXk9LoVqVndmFaLM+IDKxsTRg7lWI5q8F8vN7qVFhkC+oCSYmAqPccgpXxKloSsWs01JUF7wKEdRDrpT/psoCcprdf2igJGuM=
Message-ID: <4ae3c140608092315g3bedad97s33e8fac59a44a41@mail.gmail.com>
Date: Thu, 10 Aug 2006 02:15:57 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: Urgent help needed on an NFS question, please help!!!
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140608092304p5d3b0a83r186ebe5466369189@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
	 <17626.49136.384370.284757@cse.unsw.edu.au>
	 <4ae3c140608092304p5d3b0a83r186ebe5466369189@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found where the server checks the generation number. It's in fh_verify(). :)

Many thanks for your help, Neil!

-x

On 8/10/06, Xin Zhao <uszhaoxin@gmail.com> wrote:
> I think nfs_compare_fh() might do the file handle verification task.
> However, it is still possible that AFTER C1 gets a valid file handle,
> BUT BEFORE C1 sends out the getattr() request, C2 deletes file X and
> creates a different file X1 which has the same inode number. Looks
> like the server side must verify the generation number carried in the
> file handle. Unfortunately, I didn't find this code at the server
> side. Any further insight on this?
>
> Thanks,
> Xin
>
> On 8/10/06, Neil Brown <neilb@suse.de> wrote:
> > On Thursday August 10, uszhaoxin@gmail.com wrote:
> > > I just ran into a problem about NFS. It might be a fundmental problem
> > > of my current work. So please help!
> > >
> > > I am wondering how NFS guarantees a client didn't get wrong file
> > > attributes. Consider the following scenario:
> > >
> > > Suppose we have an NFS server S and two clients C1 and C2.
> > >
> > > Now C1 needs to access the file attributes of file X, it first does
> > > lookup() to get the file handle of file X.
> > >
> > > After C1 gets X's file handle and before C1 issues the getattr()
> > > request, C2 cuts in. Now C2 deletes file X and creates a new file X1,
> > > which has different name but the same inode number and device ID as
> > > the nonexistent file X.
> > >
> > > When C1 issues getattr() with the old file handle, it may get file
> > > attribute on wrong file X1. Is this true?
> > >
> > > If not, how NFS avoid this problem? Please direct me to the code that
> > > verifies this.
> >
> > Generation numbers.
> >
> > When the filesystem creates a new file it assigns a random number
> > as the 'generation' number and stores that in the inode.
> > This gets included in the filehandle, and checked when the filehandle
> > lookup is done.
> >
> > Look for references to 'i_generation' in fs/ext3/*
> >
> > Other files systems may approach this slightly differently, but the
> > filesystem is responsible for providing a unique-over-time filehandle,
> > and 'generation number' is the 'standard' way of doing this.
> >
> > NeilBrown
> >
>
