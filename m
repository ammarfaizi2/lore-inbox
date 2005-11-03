Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbVKCAm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbVKCAm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbVKCAm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:42:26 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34014 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030225AbVKCAmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:42:25 -0500
Date: Wed, 2 Nov 2005 18:41:56 -0600 (CST)
Message-Id: <200511030041.jA30fu3a18715941@daisy-e236.americas.sgi.com>
From: Glen Overby <overby@sgi.com>
To: mikulas@artax.karlin.mff.cuni.cz
Cc: nathans@sgi.com, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS information leak during crash
In-Reply-To: message from Mikulas Patocka sent 3 November 2005
References: <20051102212722.GC6759@fi.muni.cz>
	<20051103101107.O6239737@wobbly.melbourne.sgi.com>
	<Pine.LNX.4.62.0511030116160.2023@artax.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 3, Mikulas Patocka wrote:
> BTW. Why does it sometimes overwrite files with zeros after crash and 
> journal replay then? I thought that this was because it tries to avoid 
> users seeing uninitialized data.

It doesn't overwrite the file with zeros.  You're getting an inode
that has a non-zero size, but no data in the file.  That is, a file
that is a single hole.  This happens because XFS logs metadata
quickly, but the data in the file gets written more slowly.

You'll see the same zeroing if you create a sparse file: write a
megabyte of data, lseek forward a megabyte, and write another megabyte
of data.  When reading the area you lseeked over, it will read as
zeros.

The same is done for files that were preallocated, but haven't been
written to (that is, the file has unwritten extents).

You can look at the files in question with xfs_bmap -v and see that
there's no extents there.

Glen Overby
