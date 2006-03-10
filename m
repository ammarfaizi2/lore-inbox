Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWCJMu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWCJMu1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 07:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWCJMu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 07:50:27 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:16100 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750715AbWCJMu0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 07:50:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NMwkEMEToBeRT2Jt+P+63Rm7VbkIkA9RGXdrFt3LpVfpo+2U+aMCoBi1zH5hE2j8QkJWjSxdZ5MhpafQe07vPFHaDL9/oiWqgO+k3zos/9s1kldjfQCsKD697XYZUaVj4nmIt8SzBhQEVk5jIf1n/3SVsnJfvi2AosiJLfe62SA=
Message-ID: <ca8cd3800603100450j58a5432cr79135843fc0b5659@mail.gmail.com>
Date: Fri, 10 Mar 2006 17:50:25 +0500
From: "Ali Ahmed Thawerani" <aaht14@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM how to sync page cache ?
In-Reply-To: <ca8cd3800603082153j12b809ted85baad825bfb2a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ca8cd3800603080152t5495d42chda434f1256a59a1b@mail.gmail.com>
	 <ca8cd3800603082153j12b809ted85baad825bfb2a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/06, Ali Ahmed Thawerani <aaht14@gmail.com> wrote:
> On 3/8/06, Ali Ahmed Thawerani <aaht14@gmail.com> wrote:
> > i have written a wrapper for a block device. my wrapper is also
> > registered as a block device and i am obtaining the pointer bdev of
> > the wrapper block device by using the open_by_devnum function with
> > FMODE_READ | FMODE_WRITE
> >
> > i want to sync the memory pages that are in the page cache for this
> > particular wrapper block device
> >
> > what i am doing is using two functions filemap_fdatawrite and
> > filemap_fdatawait which take bdev->bd_inode->i_mapping as argument and
> > sync the data associated with a particular block device
> >
> > the return status of these two functions is 0 which i think means no success
> >
> > i have tried to figure out what can be the reason for this and i
> > followed the function calling that have been made
> >
> > some of the possible reasons were: when
> > i_mapping->backing_dev_info->memory_backed is 1 then these functions
> > return 0 i have checked that this value is not greater than 0 moreover
> > i have also checked that the i_mapping->nr_pages are also greater than
> > 0
> >
> > i was not able to go any further
> >
> > i am calling these two functions in a thread
> >
> > there was also another problem that when there is some request coming
> > to my wrapper block device and wake up the thread which tries to sync
> > the page cache my system gets stuck may be both the threads are trying
> > to modify the inodes at the same time and none is succeeding
> >
> > what i did to solve this problem that i used kernel timer if there is
> > no request in the request queue for jiffies + 30 then i wake up the
> > thread to sync the buffer cache and at the same time set a
> > flag........ as according to my assumption when buffer cache will sync
> > data will come to my wrapper block device and i have to requeue it to
> > avoid any sort of problem but the thing is no such thing happens that
> > is there is no new request in request queue at all
> >
> > can any one help me out in this
> >
> i want to add a few more things that i have tried
>
> i looked at the function filemap_fdatawrite and followed the function
> calling at got to do_writepages which was in turn calling either the
> i_mapping->a_ops->writepages or generic_writepages with the parameters
> mapping and wbc
>
> i copied do_writepages as it is in my code and gave i_mapping in place
> of mapping and defined a structure of struct writeback_control with
> syncmode = WB_SYNC_ALL, start = 0, end = 0, nr_to_write =
> i_mapping->nr_pages * 2 and non_blocking = 1 the values of start and
> end are given 0 in __filemap_fdatawrite and syncmode = WB_SYNC_ALL is
> given in filemap_fdatawrite so i just gave the same values
>
> i have seen that i_mapping->a_ops->writepages is assigned
> generic_writepages and generic_writepages calls mpage_writepages
>

one of my collegues said that there should be a way to set the page
cache mode to write through or there will be a proc entry which
specifies how much cache should be used for the disk and we can make
it small or 0
