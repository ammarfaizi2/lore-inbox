Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265171AbUELSyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265171AbUELSyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUELSxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:53:48 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:64954 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S265172AbUELSv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:51:29 -0400
Date: Wed, 12 May 2004 12:52:24 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-ID: <20040512185224.GA2658@bounceswoosh.org>
Mail-Followup-To: Robert Hancock <hancockr@shaw.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <fa.jr282gn.1ni2t37@ifi.uio.no> <fa.cmd38j8.1tgg9ro@ifi.uio.no> <008201c437e7$b1a35160$6601a8c0@northbrook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <008201c437e7$b1a35160$6601a8c0@northbrook>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12 at  0:09, Robert Hancock wrote:
>If this is indeed the case, that those drives don't support the "flush write
>cache" command, I'd like to see Maxtor's excuse as to why.. I believe that
>Windows always powers down IDE drives before shutdown, maybe this is because
>of non-universal support for the "flush write cache" command?

The issue is a bit more subtle, and I'm not making an "excuse" per
say...

(Not speaking officially for Maxtor, but I'm just trying to help...)


As per the email I got from Bart, the drive in question doesn't
support 48-bit commands.  The wierdness is that it claims to support
the FLUSH CACHE EXT (0xEA) command.  Obviously, this combination
doesn't make it safe to issue FLUSH CACHE EXT since the drive will not
be able to properly report a failing location in the event of a
failure to flush due to a fatal write fault.  The drive knows a FLUSH
CACHE EXT command isn't safe, so it aborts that command which is the
error message you see.

The code that Bart showed me does a '&' on the feature word with the
required support bits, but uses the result in an 'if' conditional.  I
believe that means that in C, if either of the bits is set, then the
'if' will evaluate to true, which is causing the problem.

The solution (that should work for all drives) would be to test
properly to make sure the drive reports support for both 48-bit
commands and FLUSH CACHE EXT, with something like:

  if ((feature & bits) == bits)

then issue that command.  If *either* of these bits is false, then the
drive should be issued a normal FLUSH CACHE (0xE7) command (which is a
reasonably standard 28-bit command, and all Maxtor drives support,
including the models in question.)

Note that this only affects newer drives (last 18 months or so) that
are <120GB. (Yes, I know that is still a truckload)

There are a gazillion of these in the field (we sell ~60 million
drives/year?) so I don't believe a firmware "upgrade" or equivalent
simply is logistically possible, but this inconsistency is going to be
addressed in future products, I'm making sure of it.


If anyone has questions, please don't hesitate to email and I'll do my
best to help.

-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

