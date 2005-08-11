Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVHKElW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVHKElW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVHKElW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:41:22 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:65255 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932247AbVHKElV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:41:21 -0400
References: <20050803063644.GD9812@redhat.com>
            <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
            <42F7A557.3000200@zabbo.net>
            <1123598983.10790.1.camel@haji.ri.fi>
            <20050810072121.GA2825@infradead.org>
            <courier.42F9AD38.000018F9@courier.cs.helsinki.fi>
            <20050810162618.GH21228@ca-server1.us.oracle.com>
            <courier.42FA3207.00002648@courier.cs.helsinki.fi>
            <20050810182155.GI21228@ca-server1.us.oracle.com>
            <courier.42FA6128.000009AE@courier.cs.helsinki.fi>
            <20050810220744.GJ21228@ca-server1.us.oracle.com>
In-Reply-To: <20050810220744.GJ21228@ca-server1.us.oracle.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Zach Brown <zab@zabbo.net>,
       David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Date: Thu, 11 Aug 2005 07:41:17 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42FAD6ED.00002E45@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On Wed, Aug 10, 2005 at 11:18:48PM +0300, Pekka J Enberg wrote:
> > You, however, don't maintain the same level of data consistency when reads
> > and writes are from other filesystems as they use ->nopage.

Mark Fasheh writes:
> I'm not sure what you mean here...

Reading and writing from other filesystems to a GFS2 mmap'd file
does not walk the vmas. Therefore, data consistency guarantees
are different: 

 - A GFS2 filesystem does a read that writes to a GFS2 mmap'd
  file -> we take all locks for the mmap'd buffer in order and
  release them after read() is done. 

 - A ext3 filesystem, for example, does a read that writes to
  a GFS2 mmap'd file -> we now take locks one page at the
  time releasing them before we exit ->nopage(). Other nodes
  are now free to write to the same GFS2 mmap'd file. 

Or am I missing something here? 

On Wed, Aug 10, 2005 at 11:18:48PM +0300, Pekka J Enberg wrote:
> > Fixing this requires a generic vma walk in every write() and read(), no?
> > That doesn't seem such an hot idea which brings us back to using ->nopage
> > for taking the locks (but now the deadlocks are back).

Mark Fasheh writes:
> Yeah if you look through mmap.c in ocfs2_fill_ctxt_from_buf() we do this...
> Or am I misunderstanding what you mean?

If are doing write() or read() from some other filesystem, we don't walk the 
vmas but instead rely on ->nopage for locking, right? 

                   Pekka 

