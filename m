Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUHNCWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUHNCWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 22:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUHNCWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 22:22:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54761 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267930AbUHNCWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 22:22:35 -0400
Message-ID: <411D775B.1050005@pobox.com>
Date: Fri, 13 Aug 2004 22:22:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
Subject: Re: [2.6.8-rc4-bk] NFS oops on x86-64
References: <411D65B4.4030208@pobox.com> <1092447909.4078.18.camel@lade.trondhjem.org>
In-Reply-To: <1092447909.4078.18.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> På fr , 13/08/2004 klokka 21:07, skreiv Jeff Garzik:
> 
>>See attached...   oops in BK-latest NFS client on x86-64.  The oops is 
>>100% reproducible, and occurs immediately (as soon as I access any 
>>portion of the mounted NFS filesystem; the mount itself succeeds).
>>
> 
> 
> Does reverting Willy's borken patch fix it? That patch was clearly never
> actually tested before Linus applied it.
> 
> I can see 2 problems in the NFS code alone:
> 
>   1) Replacing a test for whether or not O_APPEND and O_DIRECT are
> *both* set with one that checks whether either is set.
>   2) Adding a wonderful check in nfs_open() that causes it to return
> immediately if this new nfs_check_flags() returns 0 (i.e. OK).
> 
> GRRRR


Yep, reverting the following patch fixes the NFS oops on x86-64...

ChangeSet@1.1964, 2004-08-13 09:48:04-07:00, willy@debian.org
   [PATCH] Remove fcntl f_op

   The newly introduced ->fcntl file_operation is badly thought out,
   not to mention undocumented.  This patch replaces it with two better
   defined operations -- check_flags and dir_notify.  Any other fcntl()s
   that filesystems are interested in can have their own properly typed
   f_op method when they need it.

   Signed-off-by: Linus Torvalds <torvalds@osdl.org>

