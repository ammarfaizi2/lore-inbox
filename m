Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272209AbRIKAQV>; Mon, 10 Sep 2001 20:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272219AbRIKAQM>; Mon, 10 Sep 2001 20:16:12 -0400
Received: from quattro.sventech.com ([205.252.248.110]:22536 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S272209AbRIKAQH>; Mon, 10 Sep 2001 20:16:07 -0400
Date: Mon, 10 Sep 2001 20:16:28 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "David C. Hansen" <haveblue@us.ibm.com>
Cc: Peter.Pregler@risc.uni-linz.ac.at, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] broken locking in CPiA driver
Message-ID: <20010910201628.D32532@sventech.com>
In-Reply-To: <3B9D477F.CABAFD79@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3B9D477F.CABAFD79@us.ibm.com>; from haveblue@us.ibm.com on Mon, Sep 10, 2001 at 04:06:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001, David C. Hansen <haveblue@us.ibm.com> wrote:
> This patch fixes a locking issue with the CPiA driver, and cleans up the
> locking.  There is a potential race condition in cpia_pp_detach().  The
> REMOVE_FROM_LIST macro uses the BKL to provide protection for the
> cam_list.  However, the BKL is not held during the whole for loop, only
> during the macro.  
>  
> This patch does several things:
> 1.  rename REMOVE_FROM_LIST and ADD_TO_LIST to cpia_remove_from_list and
> cpia_add_to_list, respectively
> 2. make them "static inline" functions instead of #define macros. (take
> a look at this, they probably should be functions)
> 3.  add one static spinlock cam_list_lock_{pp|usb} for each of the pp
> and usb drivers to replace BKL
> 4.  do locking around all cam_list references to replace BKL locking
> from the macros
> 5.  fix race condition
> 6.  initialize cam_list to NULL in pp driver, just like the usb driver.

Technically this isn't a problem with USB since all connects and
disconnects are serialized, but it's probably worth the effort to
maintain consistency.

One lock for both PP and USB is probably sufficient.

They should also probably use the generic list.h routines.

JE

