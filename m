Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318073AbSG2Ung>; Mon, 29 Jul 2002 16:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSG2Ung>; Mon, 29 Jul 2002 16:43:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22803 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318073AbSG2Une>;
	Mon, 29 Jul 2002 16:43:34 -0400
Date: Mon, 29 Jul 2002 21:46:56 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-ia64@linuxia64.org'" <linux-ia64@linuxia64.org>,
       "'hpl@cs.utk.edu'" <hpl@cs.utk.edu>
Subject: Re: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
Message-ID: <20020729214656.B3317@parcelfarce.linux.theplanet.co.uk>
References: <3FAD1088D4556046AEC48D80B47B478C0101F3AD@usslc-exch-4.slc.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F3AD@usslc-exch-4.slc.unisys.com>; from kevin.vanmaren@unisys.com on Mon, Jul 29, 2002 at 03:37:17PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 03:37:17PM -0500, Van Maren, Kevin wrote:
> I changed the code to allow the writer bit to remain set even if
> there is a reader.  By only allowing a single processor to set
> the writer bit, I don't have to worry about pending writers starving
> out readers.  The potential writer that was able to set the writer bit
> gains ownership of the lock when the current readers finish.  Since
> the retry for read_lock does not keep trying to increment the reader
> count, there are no other required changes.

however, this is broken.  linux relies on being able to do

read_lock(x);
func()
  -> func()
       -> func()
            -> read_lock(x);

if a writer comes between those two read locks, you're toast.

i suspect the right answer for the contention you're seeing is an improved
get_timeofday which is lockless.

-- 
Revolutions do not require corporate support.
