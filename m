Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317426AbSGOKr4>; Mon, 15 Jul 2002 06:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSGOKrz>; Mon, 15 Jul 2002 06:47:55 -0400
Received: from mail.zmailer.org ([62.240.94.4]:29584 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S317426AbSGOKry>;
	Mon, 15 Jul 2002 06:47:54 -0400
Date: Mon, 15 Jul 2002 13:50:43 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Manik Raina <manik@cisco.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, 2.5] : Adding counters to BSD process accounting
Message-ID: <20020715135043.Q28720@mea-ext.zmailer.org>
References: <Pine.GSO.4.44.0207151154460.23890-100000@cbin2-xdm1.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0207151154460.23890-100000@cbin2-xdm1.cisco.com>; from manik@cisco.com on Mon, Jul 15, 2002 at 11:57:39AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 11:57:39AM +0530, Manik Raina wrote:
> This  patch  keeps account of the number of bytes read/written by a
> process in it's lifetime.
> 
> This may be a  good estimate of how IO bound a process is.
> This change is integrated with the BSD process accounting feature. Please
> review the changes and if you're ok with it, please apply to the 2.5 tree.

  Do have a deeper look into how the BSD ACCT works.

  Throwing in couple 8-byte scalars isn't quite right thing.
  The  pacct  file format (record size!) will change with this thing.

  There exist already fields:

        comp_t    ac_io;          /* Accounting Chars Transferred */
        comp_t    ac_rw;          /* Accounting Blocks Read or Written */

  Those are encoded with zero...


  If you comp_t encode the read/write data, you will be able to
  squeeze it into the reserved alignment bytes: ac_pad[].

  Well, that encoding counts up to 16 GB, only, but is better than 
  nothing.   The normal encoding routine handles "unsigned long"
  input value, not  __u64,  thus you would need to write a new
  encoder too.    Reading the existing  encode_comp_t()  shows,
  that its coder has mixed up EXPSIZE and EXPBASE concepts.


/* 
 *  comp_t is a 16-bit "floating" point number with a 3-bit base 8
 *  exponent and a 13-bit fraction. See linux/kernel/acct.c for the
 *  specific encoding system used.
 */

typedef __u16   comp_t;


  With 13 bits, the maximum fraction is thus  2^14 -1 = 16383
  With 3 bits, and base  8 the maximum exponent is:  8^7 =   2M
  With 3 bits, and base 16 the maximum exponent is: 16^7 = 256M

  Combined:
    Base8:  0 thru   16 GigaCounts  with 10-13 bit precission
    Base16: 0 thru 4096 GigaCounts  with  9-13 bit precission


> thanks,
> Manik
...

/Matti Aarnio
